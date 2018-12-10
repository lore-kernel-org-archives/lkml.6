Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425852082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSn5vvXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425852082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeLJKXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:23:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42774 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeLJKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:23:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so9846462wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJ2Cn4k6E7T0u8595f7z3MaJbxaC6NuPtJSaZjeLi0E=;
        b=dSn5vvXEXYOsHlKdEyF5XjlnYlMqVpFj/xfnKbODR8yt0ol1TPKP1Gag+cM/GaExEU
         YV23Bf9307NEYI9EA89w3gGCY+kYPBArXFeiOXPRjWW8f1utg/b3bgER/3X1LwLEmzIS
         2BQqUkJCA892pSR2RIqYFR1ajXcfunAt8oiu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJ2Cn4k6E7T0u8595f7z3MaJbxaC6NuPtJSaZjeLi0E=;
        b=TP/uT5zGrdyjtYnWh89EJZbG5atK/cwLcJfEqTfYXijQgoKOTMLzEEcKZnThO02tyN
         /MWy/fS7QSZUjwnMDtQdtiCU85xK7XU62LHBzFccHFCg1Hv+dWOsKPxXU0dL4KnsDjn3
         MWAy8GAy/3YzmdHssIj84AjCbnJwe0vt9zADvdHeTtq/YSE92y/tJf4Ro+vZhFmwZJKe
         DhJkqD5BTmv9NPk2e5rGRm7o/e1g2T/AuTcyDiHQTcOnzCKV/9/5cayFPu+efNnMNU3q
         qkS8DV6Qw2X0MNZKmUVBZEB0Kaq6Daz+DLrPB8gwLxa/Gvl6vUBtcqMzSNN1vIlG8TEF
         p9IQ==
X-Gm-Message-State: AA+aEWaDUm+pFbANE83xlibvPyoEdHXoVkovYvk8xRy++Zjjdd4F/Mur
        NJmnI21hU6mx96DjnmS/on2cCg==
X-Google-Smtp-Source: AFSGD/UuAcaooG0Hy8e5nPy+3b85gkaxIClzF+LJwBkcrXDc8/RPuf9Ld5/mZZonAbs/fRnnrXBk3Q==
X-Received: by 2002:adf:d4c9:: with SMTP id w9mr9258048wrk.119.1544437398603;
        Mon, 10 Dec 2018 02:23:18 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id r64sm12266664wmg.5.2018.12.10.02.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 02:23:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 3/4] irqchip: gic-v3: Add quirk for msm8996 secured registers
Date:   Mon, 10 Dec 2018 10:23:08 +0000
Message-Id: <20181210102309.8207-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
References: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
Its been more than 2+ years of wait for this to be fixed, which has
no hopes to be fixed. This change was introduced for the "lead device"
on msm8996 platform. It looks like all publicly available msm8996 and
other Qualcomm SoCs have this implementation.

So add a quirk to not access this register on msm8996.

With this quirk MSM8996 can at least boot out of mainline,
which can help community to work with boards based on MSM8996 and other
SoCs with have this restrictions. This Quirk is based on device tree
compatible string.

Without this patch Qualcomm DB820c board reboots when GICR_WAKER
is accessed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c95796fa4de6..1a2fa62a52f0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -41,6 +41,8 @@
 
 #include "irq-gic-common.h"
 
+#define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -55,6 +57,7 @@ struct gic_chip_data {
 	struct irq_domain	*domain;
 	u64			redist_stride;
 	u32			nr_redist_regions;
+	u64			flags;
 	bool			has_rss;
 	unsigned int		irq_nr;
 	struct partition_desc	*ppi_descs[16];
@@ -139,6 +142,9 @@ static void gic_enable_redist(bool enable)
 	u32 count = 1000000;	/* 1s! */
 	u32 val;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
+		return;
+
 	rbase = gic_data_rdist_rd_base();
 
 	val = readl_relaxed(rbase + GICR_WAKER);
@@ -1067,6 +1073,15 @@ static const struct irq_domain_ops partition_domain_ops = {
 	.select = gic_irq_domain_select,
 };
 
+static bool gic_enable_quirk_msm8996(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_GICR_WAKER_MSM8996;
+
+	return true;
+}
+
 static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
@@ -1272,6 +1287,11 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 }
 
 static const struct gic_quirk gic_quirks[] = {
+	{
+		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
+		.compatible = "qcom,msm8996-gic-v3",
+		.init	= gic_enable_quirk_msm8996,
+	}
 };
 
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
-- 
2.19.2

