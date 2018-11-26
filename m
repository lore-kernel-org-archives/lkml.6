Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7072820989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7072820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeKZVTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:19:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbeKZVS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:18:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE90ED3D07ABD;
        Mon, 26 Nov 2018 18:25:15 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 18:25:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <giometti@enneenne.com>,
        <richardcochran@gmail.com>, <sudipm.mukherjee@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pps: using ERR_PTR instead of NULL while pps_register_source fails
Date:   Mon, 26 Nov 2018 18:24:22 +0800
Message-ID: <20181126102422.24028-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pps_register_source() has keeps error codes in a local variable,
but it does not make use of the code. This patch let it return
the errcode in case of failure.

Suggested-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pps/clients/pps-gpio.c    | 4 ++--
 drivers/pps/clients/pps-ktimer.c  | 4 ++--
 drivers/pps/clients/pps-ldisc.c   | 4 ++--
 drivers/pps/clients/pps_parport.c | 2 +-
 drivers/pps/kapi.c                | 5 +++--
 drivers/ptp/ptp_clock.c           | 4 ++--
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 333ad7d..dd5d110 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -158,10 +158,10 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	if (data->capture_clear)
 		pps_default_params |= PPS_CAPTURECLEAR | PPS_OFFSETCLEAR;
 	data->pps = pps_register_source(&data->info, pps_default_params);
-	if (data->pps == NULL) {
+	if (IS_ERR(data->pps)) {
 		dev_err(&pdev->dev, "failed to register IRQ %d as PPS source\n",
 			data->irq);
-		return -EINVAL;
+		return PTR_ERR(data->pps);
 	}
 
 	/* register IRQ interrupt handler */
diff --git a/drivers/pps/clients/pps-ktimer.c b/drivers/pps/clients/pps-ktimer.c
index 0473564..728818b 100644
--- a/drivers/pps/clients/pps-ktimer.c
+++ b/drivers/pps/clients/pps-ktimer.c
@@ -80,9 +80,9 @@ static int __init pps_ktimer_init(void)
 {
 	pps = pps_register_source(&pps_ktimer_info,
 				PPS_CAPTUREASSERT | PPS_OFFSETASSERT);
-	if (pps == NULL) {
+	if (IS_ERR(pps)) {
 		pr_err("cannot register PPS source\n");
-		return -ENOMEM;
+		return PTR_ERR(pps);
 	}
 
 	timer_setup(&ktimer, pps_ktimer_event, 0);
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 73bd3bb..00f6c46 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -72,9 +72,9 @@ static int pps_tty_open(struct tty_struct *tty)
 
 	pps = pps_register_source(&info, PPS_CAPTUREBOTH | \
 				PPS_OFFSETASSERT | PPS_OFFSETCLEAR);
-	if (pps == NULL) {
+	if (IS_ERR(pps)) {
 		pr_err("cannot register PPS source \"%s\"\n", info.path);
-		return -ENOMEM;
+		return PTR_ERR(pps);
 	}
 	pps->lookup_cookie = tty;
 
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 4db824f..7226e39 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -179,7 +179,7 @@ static void parport_attach(struct parport *port)
 
 	device->pps = pps_register_source(&info,
 			PPS_CAPTUREBOTH | PPS_OFFSETASSERT | PPS_OFFSETCLEAR);
-	if (device->pps == NULL) {
+	if (IS_ERR(device->pps)) {
 		pr_err("couldn't register PPS source\n");
 		goto err_release_dev;
 	}
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index 805c749..a1c3cd3 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -72,7 +72,8 @@ static void pps_echo_client_default(struct pps_device *pps, int event,
  * source is described by info's fields and it will have, as default PPS
  * parameters, the ones specified into default_params.
  *
- * The function returns, in case of success, the PPS device. Otherwise NULL.
+ * The function returns, in case of success, the PPS device. Otherwise
+ * ERR_PTR(errno).
  */
 
 struct pps_device *pps_register_source(struct pps_source_info *info,
@@ -135,7 +136,7 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 pps_register_source_exit:
 	pr_err("%s: unable to register source\n", info->name);
 
-	return NULL;
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(pps_register_source);
 
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 8a81eec..48f3594 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -265,8 +265,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 		pps.mode = PTP_PPS_MODE;
 		pps.owner = info->owner;
 		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
-		if (!ptp->pps_source) {
-			err = -EINVAL;
+		if (IS_ERR(ptp->pps_source)) {
+			err = PTR_ERR(ptp->pps_source);
 			pr_err("failed to register pps source\n");
 			goto no_pps;
 		}
-- 
2.7.0


