Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD01C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AD520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEyYX0GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AD520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeLJN4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:56:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54361 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeLJN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:56:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so3595947wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcqzNhK37A8PsauAg3JtU8lMxDR18aEHWGkU2JQ1rE0=;
        b=FEyYX0GKa7zyo+R0sR4Al5ZZHyAtV+pGZEqp4CiUepxHiYZqEBsXFlR1TYmcTrnVZw
         8lg8RNseo7ueCBO4fPikaa03osiOzSFs5JvQb0VtPRQMTi9lN+AOYlegr2jN2MjgGgP9
         XdtDj+BwrdDcwXtJJ/rVJDO5fAweLc3T5NdWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcqzNhK37A8PsauAg3JtU8lMxDR18aEHWGkU2JQ1rE0=;
        b=rVTEqyDpAaEDr+xhw44E4Y3ymy7jd/i5O+COkhCdQFBPQ7tq4WpCni5Mqc5jZEeNAt
         PW59pAgdrm8R52ayhak2Vmm0qD6EzQa3N1H+HT6JlXtEc1B2a+6d7DtJwX4qHHZO+pPv
         b2EWRejNGlea1mZtOfIHXR0TCEL6Z8a9BQ1sdi+21psLcAHmm43qAHY5/QMwG1ke2vnk
         Cwk1Fj1KfhpqHxh4rGxAFx2FBqMqQH3UdnxL9MjgFUw9290CRl0CtgEbvfH3E1XJ7KPP
         HYPCiLaqpMykhV4sbYVXiM3p3tpp0vd/LSSpSU5yqKrRiIx+2SL/KC98d4e5gl5h00r6
         zJ+w==
X-Gm-Message-State: AA+aEWZWUsVccaAMdjH+yKOuPql9tajrxMKfELXeMrvw2wV1bduBq4/W
        FunQS8QPqpL6eS7nPeXhgFY9Uw==
X-Google-Smtp-Source: AFSGD/UAhoaUzrzABSkxsTQP8wDF89XRQSNUqiPAohZeQqVxSzPc0C9g1axSaOG4i5JBd/XmiyJVtg==
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr10129357wmg.100.1544450200855;
        Mon, 10 Dec 2018 05:56:40 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c14sm8612506wme.13.2018.12.10.05.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:56:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 3/4] irqchip: gic-v3: Add quirk for msm8996 secured registers
Date:   Mon, 10 Dec 2018 13:56:32 +0000
Message-Id: <20181210135633.30283-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
References: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
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
index df1ff3b5836a..0868a9d81c3c 100644
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
+	},
 	{
 	}
 };
-- 
2.19.2

