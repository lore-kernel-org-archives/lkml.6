Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF13C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E818520855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E818520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeIHB6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeIHB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9582F07;
        Fri,  7 Sep 2018 21:15:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Niestroj <m.niestroj@grinn-global.com>,
        Tony Lindgren <tony@atomide.com>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.18 074/145] rtc: omap: fix potential crash on power off
Date:   Fri,  7 Sep 2018 23:09:00 +0200
Message-Id: <20180907210910.546988472@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 5c8b84f410b3819d14cb1ebf32e4b3714b5a6e0b upstream.

Do not set the system power-off callback and omap power-off rtc pointer
until we're done setting up our device to avoid leaving stale pointers
around after a late probe error.

Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
Cc: stable <stable@vger.kernel.org>     # 4.9
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Marcin Niestroj <m.niestroj@grinn-global.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-omap.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -861,13 +861,6 @@ static int omap_rtc_probe(struct platfor
 			goto err;
 	}
 
-	if (rtc->is_pmic_controller) {
-		if (!pm_power_off) {
-			omap_rtc_power_off_rtc = rtc;
-			pm_power_off = omap_rtc_power_off;
-		}
-	}
-
 	/* Support ext_wakeup pinconf */
 	rtc_pinctrl_desc.name = dev_name(&pdev->dev);
 
@@ -884,6 +877,13 @@ static int omap_rtc_probe(struct platfor
 
 	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
 
+	if (rtc->is_pmic_controller) {
+		if (!pm_power_off) {
+			omap_rtc_power_off_rtc = rtc;
+			pm_power_off = omap_rtc_power_off;
+		}
+	}
+
 	return 0;
 
 err_deregister_pinctrl:


