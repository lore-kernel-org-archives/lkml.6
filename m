Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0279C2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n06HdEpP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FAUw3g1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0279C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJCQof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:44:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeJCQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:44:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EAE1601D4; Wed,  3 Oct 2018 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538560614;
        bh=8zrPfprDYpGCsjOqbJaOpliZGYJ4Ef6rpRefu+vcqkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n06HdEpPYdUgwOYDS3j/D5cBNhC4YQ2RgvN49M2JIGgxsy+JL3TZtD33YtseEWmiY
         U02OHw8xt74hKESIe8j1EV3VDI2D/55LFfr8/SidMA2buREysfSWPdLGI9CL5aC6ay
         fM5D5GWmninj+kr7TSAiwYEz1c8Vv8MBxDCMZgOo=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05D2E60275;
        Wed,  3 Oct 2018 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538560613;
        bh=8zrPfprDYpGCsjOqbJaOpliZGYJ4Ef6rpRefu+vcqkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAUw3g1YLDHjZM9S2gEwIHuc/Spa0oP9FJ+yixT+y7uZAPP30ZhbuDteT1dXfM0VZ
         1hliRTTe5NgHdmvXtT5GXj7P3xEp+89vP/GmfYwgy4kNWXkuH3LYiaUGDD71oB0AYJ
         pc9MAWawzA2NegDEXS3BAT7pb4enmiH+MZwhZDB8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05D2E60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 2/2] drivers: qcom: rpmh: write PDC data
Date:   Wed,  3 Oct 2018 15:26:35 +0530
Message-Id: <1538560595-6275-3-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538560595-6275-1-git-send-email-rplsssn@codeaurora.org>
References: <1538560595-6275-1-git-send-email-rplsssn@codeaurora.org>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/soc/qcom/rpmh-internal.h |  4 +++-
 drivers/soc/qcom/rpmh-rsc.c      | 35 +++++++++++++++++++++++++++++------
 drivers/soc/qcom/rpmh.c          | 28 ++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  7 +++++++
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index a7bbbb6..8c316b4 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -85,6 +85,7 @@ struct rpmh_ctrlr {
  * Resource State Coordinator controller (RSC)
  *
  * @name:       controller identifier
+ * @base:       start address of the RSC's DRV registers
  * @tcs_base:   start address of the TCS registers in this controller
  * @id:         instance id in the controller (Direct Resource Voter)
  * @num_tcs:    number of TCSes in this DRV
@@ -95,6 +96,7 @@ struct rpmh_ctrlr {
  */
 struct rsc_drv {
 	const char *name;
+	void __iomem *base;
 	void __iomem *tcs_base;
 	int id;
 	int num_tcs;
@@ -108,7 +110,7 @@ struct rsc_drv {
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 int rpmh_rsc_invalidate(struct rsc_drv *drv);
-
+int rpmh_rsc_write_pdc_data(struct rsc_drv *drv, const struct tcs_request *msg);
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 6cc7f21..73d5b98 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -61,6 +61,11 @@
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
@@ -552,6 +557,25 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
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
@@ -564,21 +588,20 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
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
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index c7beb68..71a76ea 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -413,6 +413,34 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write_batch);
 
+/**
+ * rpmh_write_pdc_data: Write PDC data to the controller
+ *
+ * @dev: the device making the request
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * Write PDC data to the controller. The messages are always sent async.
+ *
+ * May be called from atomic contexts.
+ */
+int rpmh_write_pdc_data(const struct device *dev,
+			const struct tcs_cmd *cmd, u32 n)
+{
+	DEFINE_RPMH_MSG_ONSTACK(dev, 0, NULL, rpm_msg);
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	if (!n || n > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
+	rpm_msg.msg.num_cmds = n;
+	rpm_msg.msg.wait_for_compl = false;
+
+	return rpmh_rsc_write_pdc_data(ctrlr_to_drv(ctrlr), &rpm_msg.msg);
+}
+EXPORT_SYMBOL(rpmh_write_pdc_data);
+
 static int is_req_valid(struct cache_req *req)
 {
 	return (req->sleep_val != UINT_MAX &&
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 619e07c..b05e31a 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -24,6 +24,9 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 int rpmh_invalidate(const struct device *dev);
 
+int rpmh_write_pdc_data(const struct device *dev,
+			const struct tcs_cmd *cmd, u32 n);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -46,6 +49,10 @@ static inline int rpmh_flush(const struct device *dev)
 static inline int rpmh_invalidate(const struct device *dev)
 { return -ENODEV; }
 
+static inline int rpmh_write_pdc_data(const struct device *dev,
+				      const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
+
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

