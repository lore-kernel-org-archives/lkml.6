Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1170C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DD220870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFnvTzf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DD220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeLJKXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:23:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45065 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeLJKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:23:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id b14so9830306wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1U/Akwho1DZJNINiBcRb/GlKX5Bkx4IZu/rr43WS9yo=;
        b=XFnvTzf3n6/EloQ2lQISSe9HFxQTNcsFS8nR+0lBOtx/RTIvrIKN/unT409luQoHDg
         PEy2eMc39+pmCZhfm8BS/N3Tv1xt9pDDMmLcd62wfSCJgHS770F9fAyXdwTOEpzV198H
         OBjCwdcW5USPSQtG664gQ51gjqE/QObph4O08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1U/Akwho1DZJNINiBcRb/GlKX5Bkx4IZu/rr43WS9yo=;
        b=WK3CgRenZn1PTcSZj+BAj+tzyPA/jTWHIf5FN7mjCyF+5Zyfe1e6mN4y4+fs7+vvJG
         4Yrh81gLlD1U6zWE4ZUI84/qo5VdqNCmvv5Z4AbgvXg2o1b9eSvzy+A5AiMOCGm4H+42
         n722/1PEpPXTspHRf7tSNLIaFxB5LttPmQOZDa0YIRx92i97L9zeyv+KkQVY9v8U8VFk
         YIHn/685StZBFYVSmlRihgGTetGwrhWzmbAKontRmiF57USqt0AUQB0jvG3IVZGUVSeN
         PMR7Jrzv3gpjvPfnCKtKoBdVkcf+jGjqkXw3PI/ZTF+60RPmpM+M75R3HmeLHBR45SBQ
         xivQ==
X-Gm-Message-State: AA+aEWY3OGFQ3u2VnIbbqVUTrRTl4XWVLxTMX0OUo+6t16lIaKcWboC2
        GS1rkri3qdXObM5p0w/GQFy+XiagkoI=
X-Google-Smtp-Source: AFSGD/X8IWYWRMlU12DSvutyhT+XNYsm3MmeD62/RY0g5HnSaAkyVKEmFZe1n5yC8L7qYWe2P84J0w==
X-Received: by 2002:adf:8c09:: with SMTP id z9mr9378346wra.301.1544437397282;
        Mon, 10 Dec 2018 02:23:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id r64sm12266664wmg.5.2018.12.10.02.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 02:23:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 2/4] irqchip/gic: common: add support to device tree based quirks
Date:   Mon, 10 Dec 2018 10:23:07 +0000
Message-Id: <20181210102309.8207-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
References: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to device tree based quirks based on
device tree compatible string.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/irqchip/irq-gic-common.c | 12 ++++++++++++
 drivers/irqchip/irq-gic-common.h |  3 +++
 drivers/irqchip/irq-gic-v3.c     |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 01e673c680cd..3c93c6f4d1f1 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -36,6 +36,18 @@ void gic_set_kvm_info(const struct gic_kvm_info *info)
 	gic_kvm_info = info;
 }
 
+void gic_enable_of_quirks(const struct device_node *np,
+			  const struct gic_quirk *quirks, void *data)
+{
+	for (; quirks->desc; quirks++) {
+		if (!of_device_is_compatible(np, quirks->compatible))
+			continue;
+		if (quirks->init(data))
+			pr_info("GIC: enabling workaround for %s\n",
+				quirks->desc);
+	}
+}
+
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3919cd7c5285..97e58fb6c232 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -23,6 +23,7 @@
 
 struct gic_quirk {
 	const char *desc;
+	const char *compatible;
 	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
@@ -35,6 +36,8 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
+void gic_enable_of_quirks(const struct device_node *np,
+			  const struct gic_quirk *quirks, void *data);
 
 void gic_set_kvm_info(const struct gic_kvm_info *info);
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 29e9d47be97d..c95796fa4de6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1271,6 +1271,9 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
+static const struct gic_quirk gic_quirks[] = {
+};
+
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
@@ -1318,6 +1321,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
 		redist_stride = 0;
 
+	gic_enable_of_quirks(node, gic_quirks, &gic_data);
+
 	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
 			     redist_stride, &node->fwnode);
 	if (err)
-- 
2.19.2

