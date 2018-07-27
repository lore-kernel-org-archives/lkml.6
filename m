Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E87C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677D220897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ivLK/vkX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oQFl+T1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677D220897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbeG0L0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbeG0L03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B83B60AD8; Fri, 27 Jul 2018 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685918;
        bh=AWlzHpxCyRNs8hW3hy9P+OeRkDJE+u3SIVRKvtqMvmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivLK/vkXs1Ch3irrmzYrhgGIsOARbd9ZnhzY8S/4tF2rZ8YdVVqpfS1S+4igFOKkV
         jFcpCdhSToFeERgvbRLgObUad+9Ptt/RImSYItFrzRPILbKuB06450y0xJ+E5cvPNv
         2pBvF2NHZdmjYAs8BIlnBMIIZX+2DPPVhFsep9m4=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 104C2605BD;
        Fri, 27 Jul 2018 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685917;
        bh=AWlzHpxCyRNs8hW3hy9P+OeRkDJE+u3SIVRKvtqMvmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQFl+T1gmyyfaDQ01MDTDjLs9gg5GLDWScSU7eilXJnOAZta205fsPf8Tfkl30YuG
         X0HVL/USz8kk+vuUvyAexJqCWZERHY57rJih3iYzdEafexiRzkOVPXrgONmNp8KArY
         HTkrPxiuC2mdn5cB+nw7HTAJy+RzC0T5VcTARNSQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 104C2605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2 5/6] drivers: qcom: rpmh-rsc: write PDC data
Date:   Fri, 27 Jul 2018 15:34:48 +0530
Message-Id: <1532685889-31345-6-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
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
Changes in v2:
   - Remove unnecessary EXPORT_SYMBOL
---
 drivers/soc/qcom/rpmh-internal.h |  3 +++
 drivers/soc/qcom/rpmh-rsc.c      | 35 +++++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

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
index 19616c9..c870477 100644
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
@@ -569,6 +574,25 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
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
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv)
 {
@@ -581,21 +605,20 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
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

