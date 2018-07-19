Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C5B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fpq0O+BI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m10jb1XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C5B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeGSKCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:02:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40620 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbeGSKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:02:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0AC9060B83; Thu, 19 Jul 2018 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531992025;
        bh=V73DGjblX1Bdr3plxo+rkZp44vIltFyE/OEcn/ONd3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpq0O+BI5JQCBsSgMRSNwTvKhw0aEJqGUQkTc3niug30qTf0DJWiGYjKtz4XB1phE
         bXMno4VfI0IXmijXfHdiAB8gZSXHo3s2tUGXchx1l5Y3fwOoQrydwxmN8WKNwl1hxD
         9RTx5akfKpdzr5d05281wIj5nmlGkZDBc10rpGoo=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01C5260B72;
        Thu, 19 Jul 2018 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531992006;
        bh=V73DGjblX1Bdr3plxo+rkZp44vIltFyE/OEcn/ONd3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m10jb1XQh59ILOyMZEGchWYYUSuBOna8RvK7e7l7yuwgAIt0gETCYXfYXwjEPijKp
         5N/2Oy822oqepmxlNtntGQlNVzO0D7nf+ERszTAaOe32IhEoeUBa0PV5jtNWTkqYG4
         V+wdjHTd6QOD2twwYUTjIeJZC95Fxv6aQNui9Qd8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01C5260B72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH 5/6] drivers: qcom: rpmh-rsc: write PDC data
Date:   Thu, 19 Jul 2018 14:49:34 +0530
Message-Id: <1531991975-23665-6-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
References: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

The Power Domain Controller can be programmed to wakeup the RSC and
setup the resources back in the active state, before the processor is
woken up by a timer interrupt. The wakeup value from the timer hardware
can be copied to the PDC which has its own timer and is in an always-on
power domain. Programming the wakeup value is done through a separate
register on the RSC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  3 +++
 drivers/soc/qcom/rpmh-rsc.c      | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 6cd2f78..f5359be 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -87,6 +87,7 @@ struct rpmh_ctrlr {
  * Resource State Coordinator controller (RSC)
  *
  * @name:       controller identifier
+ * @base:       start address of the RSC's DRV registers
  * @tcs_base:   start address of the TCS registers in this controller
  * @id:         instance id in the controller (Direct Resource Voter)
  * @num_tcs:    number of TCSes in this DRV
@@ -97,6 +98,7 @@ struct rpmh_ctrlr {
  */
 struct rsc_drv {
 	const char *name;
+	void __iomem *base;
 	void __iomem *tcs_base;
 	int id;
 	int num_tcs;
@@ -111,6 +113,7 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 int rpmh_rsc_invalidate(struct rsc_drv *drv);
 bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv);
+int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 8eff7cf..13b1dbc 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -60,6 +60,11 @@
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+/* PDC wakeup */
+#define RSC_PDC_DATA_SIZE		2
+#define RSC_PDC_DRV_DATA		0x38
+#define RSC_PDC_DATA_OFFSET		0x08
+
 static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
 	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
@@ -570,6 +575,26 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	return tcs_ctrl_write(drv, msg);
 }
 
+int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	int i;
+	void __iomem *addr = drv->base + RSC_PDC_DRV_DATA;
+
+	if (!msg || !msg->cmds || msg->num_cmds != RSC_PDC_DATA_SIZE)
+		return -EINVAL;
+
+	for (i = 0; i < msg->num_cmds; i++) {
+		/* Only data is write capable */
+		writel_relaxed(msg->cmds[i].data, addr);
+		trace_rpmh_send_msg(drv, RSC_PDC_DRV_DATA, i, 0,
+				    &msg->cmds[i]);
+		addr += RSC_PDC_DATA_OFFSET;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(rpmh_rsc_write_pdc_data);
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv)
 {
@@ -582,21 +607,20 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	int i, ret, n, st = 0;
 	struct tcs_group *tcs;
 	struct resource *res;
-	void __iomem *base;
 	char drv_id[10] = {0};
 
 	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, drv_id);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	drv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drv->base))
+		return PTR_ERR(drv->base);
 
 	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
 	if (ret)
 		return ret;
-	drv->tcs_base = base + offset;
+	drv->tcs_base = drv->base + offset;
 
-	config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
+	config = readl_relaxed(drv->base + DRV_PRNT_CHLD_CONFIG);
 
 	max_tcs = config;
 	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

