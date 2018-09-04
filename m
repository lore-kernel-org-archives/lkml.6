Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0EEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1874020867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/qTy49P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1874020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeIDScB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:32:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:32:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so4098454wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k44p/2t3M6djuNOIuMNp7Z1rfFkVTVVlv9PQFvFUfSw=;
        b=S/qTy49PvBajAe00G0AWIcSF3D0JXhao2ExRjVDKBcJb/XLQTwvLUqfFoMqwPJC4aJ
         Rkh7QKswfvo8burTY7p/xHSua1+Os3PYrfnf7/XYild3YYVVzMWmkNjcgSevGf7Shd7D
         hOzlYcoGTZlBbvl+AOBL6cMhuHmdWbdhteZMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k44p/2t3M6djuNOIuMNp7Z1rfFkVTVVlv9PQFvFUfSw=;
        b=qpUUwGbzwDmX+XXGKs/nDqWwb8Qx/RpYtAdfBqDj/ohQR5V7K2jklg6CE//2W2CSvq
         dbcgYg/Dj6vinglYOCa47oP82lQvUeR5QcvqeFH2sxxEuagmqxbyJ05e2NAEckrQZmA/
         6V9VYHdJmR+448UeEfr4shmUXT6VGaYDFsvKBOpx3kuJfS1gG9MW++KTQIXcHl3dwO2q
         293lHMGrjgo/SqaKBMbYXHr8/MslONk8GD/ATQxOrQ8HHZxMLKXChMpLxu8kaw0bbp8V
         JxNxSXKRk+A3NXVsUbgzFzG1j/2QgiivYuJTCpS/hhtErTbFjbnc47Dx6OUdW2ehu+ZF
         UsJQ==
X-Gm-Message-State: APzg51Akhy/b9n6AAooyTN9IhNaNlv3dzjndIzWs5UEFs7j22syq57Bv
        5UMmvpIPPpo5ZY6Mrq+ri7UJwQ==
X-Google-Smtp-Source: ANB0VdaprQc5H0V847MMSG5HObf05oM/x/bD5UluA3tfj6FrQzurE66RfIovjO7BX8N1BU3irpO6rw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr1776002wrs.137.1536070004344;
        Tue, 04 Sep 2018 07:06:44 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id h82-v6sm11471808wme.11.2018.09.04.07.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 07:06:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2] irqchip/gic-v3: Add quirk for msm8996 secured registers
Date:   Tue,  4 Sep 2018 15:05:38 +0100
Message-Id: <20180904140538.16602-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
Its been more than 2 years of wait for this to be fixed, which has
no hopes to be fixed. This change was introduced for the "lead device"
on msm8996 platform. It looks like all publicly available msm8996
devices have this implementation.

So add a quirk to not access this register on msm8996.

With this quirk MSM8996 can at least boot out of mainline,
which can help community to work with boards based on MSM8996.

Without this patch Qualcomm DB820c board reboots when GICR_WAKER
is accessed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Marc,

There is no errata associated with this quirk, so I could not add
any entries into Documentation/arm64/silicon-errata.txt Or add
any number to the quirk description.

Changes since v1:
- renamed gic_v3 references to gic
- added full mask for iidr register match

thanks,
srini

 drivers/irqchip/irq-gic-v3.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d5912f1ec884..406d4a44c887 100644
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
@@ -1068,13 +1074,31 @@ static const struct irq_domain_ops partition_domain_ops = {
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
+		.iidr	= 0x00001070,	/* MSM8996 */
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_msm8996,
+	},
+};
+
 static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
 				 u64 redist_stride,
 				 struct fwnode_handle *handle)
 {
-	u32 typer;
+	u32 typer, iidr;
 	int gic_irqs;
 	int err;
 
@@ -1130,6 +1154,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 
+	iidr = readl_relaxed(dist_base + GICD_IIDR);
+	gic_enable_quirks(iidr, gic_quirks, &gic_data);
+
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
-- 
2.18.0

