Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FDAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE8922419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhlEwHfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE8922419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbeKLU3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:29:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46410 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeKLU3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:29:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so8704957wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSzyRYCj+DB3PSpFskdzVkVAIM/Xjweh2bjnaCEiMfA=;
        b=XhlEwHfg3LEQdDgBsTAmCd705FSzwvTzZdEZ5wEnOU8ssVJqg5FlJn1ZIADgseYXLz
         KWflbNRYE7srjfF2oyiURxKYqTwBETX/cwfAebAtbsKLezI3YUqtAFJ4D3TQCtNQB1VO
         vmYbmbhlDutGw0BIiqSJENHGJpaaniZssIEdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSzyRYCj+DB3PSpFskdzVkVAIM/Xjweh2bjnaCEiMfA=;
        b=FnqYpCHRseLpvGUUYdzRD+oZ5PWClI313HeLETUeTgfyy4THS3yNTgHd41EE27qh2L
         Yr9B4U9XocTueiGOqYejurSVRvruOgjCPX5AEfOnHEMSZC89IWVtCPEG0siIyFLhCvJf
         FHc8PiEtvWo8BrZIxpAu7uu1R9V0/TTz0TZJkpSCUbuvF2shCSObxPOwaqaBqFVVFWpQ
         q5kRI5PxJvXVrmPTFIqvq7ww6mcRTYHZAn4leD+lXKST7NtVlY6TI1jSSzV2Ll676GHE
         cuyS58a1REZgktcmZHhYCmvZwXz81QikJFMtKNqM0T1e5HuLoifK+0DhcIXbAKMREccx
         y6ag==
X-Gm-Message-State: AGRZ1gJ9AKnwCWrifBL7eTobQC5gZJRTU1MFcJw68r1OdTfBLmZq64i0
        eVoXainRUyPeI5Jf24VOtAZyNg==
X-Google-Smtp-Source: AJdET5ePCPHnC8H/tyeuPjgtzdwJd0KcNcFSgv2zTzVJoe2tao4LlsGAuMAv6u1iYueKv0g1y0WCKQ==
X-Received: by 2002:adf:ebd2:: with SMTP id v18-v6mr440722wrn.109.1542019020776;
        Mon, 12 Nov 2018 02:37:00 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id z17-v6sm13747187wrm.65.2018.11.12.02.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:37:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v3 3/4] irqchip: gic-v3: Add quirk for msm8996 secured registers
Date:   Mon, 12 Nov 2018 10:33:39 +0000
Message-Id: <20181112103340.24702-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
References: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
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
other qcom SoCs have this implementation.

So add a quirk to not access this register on msm8996.

With this quirk MSM8996 can at least boot out of mainline,
which can help community to work with boards based on MSM8996 and other
SoCs with have this restrictions. This Quirk is based on device tree
compatible string.

Without this patch Qualcomm DB820c board reboots when GICR_WAKER
is accessed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8f87f40c9460..4bd3bbe1b7ce 100644
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
@@ -1067,6 +1073,23 @@ static const struct irq_domain_ops partition_domain_ops = {
 	.select = gic_irq_domain_select,
 };
 
+static bool __maybe_unused gic_enable_quirk_msm8996(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_GICR_WAKER_MSM8996;
+
+	return true;
+}
+
+static const struct gic_quirk gic_quirks[] = {
+	{
+		.desc	= "GICv3: Qualcomm MSM8996 skip GICR_WAKER Read/Write",
+		.compatible = "qcom,msm8996-gic-v3", /* MSM8996 */
+		.init	= gic_enable_quirk_msm8996,
+	},
+};
+
 static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
@@ -1126,6 +1149,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_vlpi_properties();
 
+	if (is_of_node(handle))
+		gic_enable_of_quirks(to_of_node(handle), gic_quirks, &gic_data);
+
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
-- 
2.19.1

