Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 92419C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49097208B4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvnFWiGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49097208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935415AbeFMLqX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:46:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51203 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935106AbeFMLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:46:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so4199031wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hw6HcYrdBerBBzG8uUXVQFTjHBZcYlLTZR+2jAaINrw=;
        b=PvnFWiGp7ZEbq+NRZpMp6yuU4pimBsYbJvip7zGswUtUrk+Ap9Ka82ruRE94nAGOm1
         Dzf1Cz6e9hv+XwZ5/FQYeE2gkA9gSXZicNSjQ0mHR5heDCGyb1XNng/B/XnESfNOXW0R
         fB56jnLPfdKwswvhMhgxYocJiOrtjgwZK0vQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hw6HcYrdBerBBzG8uUXVQFTjHBZcYlLTZR+2jAaINrw=;
        b=A1OLyji3rl3+lpOy8ZlwphJvx/grb/eXtr+otpy9Z415Vgv2PfqHsb/u35k3Qwrqmo
         la8bCwCyRqnaQZQbso3E5/cat5HKW3xvySF1fxE4Pu0uJI1qA3G0eXZg9ZgGXecejbqc
         wlWzft1SbEJ2He6/4O/vx4z0pzqnirOcyE9C7j2prAkdVCZnew39ep+jgGfmdM1nj/PR
         91glEUc7jwznnso7Sud+Fepg1CNlrhSo4WYK+cflz84XYw9BeiOhwAm3Pxg25QRnjiRO
         HLAtVOHX7IJHk+c3EwqkfSTs2ulJCIJyHRgLDj+95e19iTs50O3RXUqSXvaL+luO3B8H
         Wc4Q==
X-Gm-Message-State: APt69E0NF1EsOwabZBbYxfVNUGzjMj/OeH1+U1EBWtr3QpQ+YLL6fJ/T
        VrL3o5YfSIkOoSuo8WuG7M1VhvRa8Yk=
X-Google-Smtp-Source: ADUXVKKSdJxNu0y8satYh2ur3pGDrvif8fZGuPA1nF3FY/j3JEohJfD2Oq9drOyD0Z5X5aZyysQPvQ==
X-Received: by 2002:a1c:bfce:: with SMTP id o75-v6mr3064515wmi.122.1528890379960;
        Wed, 13 Jun 2018 04:46:19 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g11-v6sm3099215wrr.46.2018.06.13.04.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:46:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com, sudeep.holla@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, nicolas.dechesne@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] irqchip/gic-v3: Add quirk for msm8996 secured registers
Date:   Wed, 13 Jun 2018 12:43:40 +0100
Message-Id: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to GICR_WAKER is restricted on msm8996 SoC. Its been more
than 2 years of wait for this to be fixed in firmware which is
not going anywhere. So add a quirk to not write to this register.
With this quirk MSM8996 can atleast boot out of mainline,
which can help community to work with boards based on MSM8996.

Without this patch Qualcomm DB820c board reboots when GICR_WAKER
is written to.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 76ea56d779a1..d1bb2c0cce02 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -47,6 +47,8 @@ struct redist_region {
 	bool			single_redist;
 };
 
+#define GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER	(1ULL << 0)
+
 struct gic_chip_data {
 	struct fwnode_handle	*fwnode;
 	void __iomem		*dist_base;
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
 
+	if (gic_data.flags & GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER)
+		return;
+
 	rbase = gic_data_rdist_rd_base();
 
 	val = readl_relaxed(rbase + GICR_WAKER);
@@ -1064,6 +1070,31 @@ static const struct irq_domain_ops partition_domain_ops = {
 	.select = gic_irq_domain_select,
 };
 
+static bool __maybe_unused gicv3_enable_quirk_msm8996(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER;
+
+	return true;
+}
+
+static const struct gic_quirk gicv3_quirks[] = {
+	{
+		.desc	= "GICV3: Qualcomm MSM8996 WAKER IW",
+		.iidr	= 0x00001070,	/* MSM8996 */
+		.mask	= 0x0000ffff,
+		.init	= gicv3_enable_quirk_msm8996,
+	},
+};
+
+static void gic_v3_enable_quirks(struct gic_chip_data *gic_data)
+{
+	u32 iidr = readl_relaxed(gic_data->dist_base + GICD_IIDR);
+
+	gic_enable_quirks(iidr, gicv3_quirks, gic_data);
+}
+
 static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
@@ -1126,6 +1157,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 
+	gic_v3_enable_quirks(&gic_data);
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
-- 
2.16.2

