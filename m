Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BEEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wPq+CKvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0085A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeGZFDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:03:52 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42521 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeGZFDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:03:52 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6FB548365F;
        Thu, 26 Jul 2018 15:49:03 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532576943;
        bh=98jP5YHVHAjqI3Oq91Op9KVY+xbxTdaiIWi2O+5j7QA=;
        h=From:To:Cc:Subject:Date;
        b=wPq+CKvg7x5mjoAe8PyLRRx2G3q/Z69IzR4MbnhkEjNLMW9P+SU6JT1vL03SeR4tc
         QbTQ0ysguSV8IZzcXX0OaQlVlwa/+mFo5uLUiTwC6kaibZwosu408D6TEtmNmpJ++d
         Gshu/yUldZICag3Wil1dtsu3K67JpXgtIGvvTWVA=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5944af0000>; Thu, 26 Jul 2018 15:49:03 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 6481B13ED1C;
        Thu, 26 Jul 2018 15:49:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 04CEA1E262C; Thu, 26 Jul 2018 15:49:02 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
        ylefloch@online.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5] ARM: mvebu: use dt_fixup to provide fallback for enable-method
Date:   Thu, 26 Jul 2018 15:48:56 +1200
Message-Id: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to maintain backwards compatibility with device trees that don't
define an enable method. At the same time we want the device tree to be
able to specify an enable-method and have it stick.

Previously by having smp assigned in the DT_MACHINE definition this
would be picked up by setup_arch() and override whatever
arm_dt_init_cpu_maps() had configured. Now we move the initial
assignment of default smp_ops to a dt_fixup and let
arm_dt_init_cpu_maps() override that if the device tree defines an
enable-method.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Pervious versions

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300182.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300480.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302945.html
v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303899.html

Changes since v4:
- drop "RFC"

 arch/arm/mach-mvebu/board-v7.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index ccca95173e17..5bbde5e5258e 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -145,6 +145,11 @@ static void __init mvebu_dt_init(void)
 		i2c_quirk();
 }
 
+static void __init armada_370_xp_dt_fixup(void)
+{
+	smp_set_ops(smp_ops(armada_xp_smp_ops));
+}
+
 static const char * const armada_370_xp_dt_compat[] __initconst = {
 	"marvell,armada-370-xp",
 	NULL,
@@ -153,17 +158,12 @@ static const char * const armada_370_xp_dt_compat[] __initconst = {
 DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-/*
- * The following field (.smp) is still needed to ensure backward
- * compatibility with old Device Trees that were not specifying the
- * cpus enable-method property.
- */
-	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= mvebu_dt_init,
 	.init_irq       = mvebu_init_irq,
 	.restart	= mvebu_restart,
 	.reserve        = mvebu_memblock_reserve,
 	.dt_compat	= armada_370_xp_dt_compat,
+	.dt_fixup	= armada_370_xp_dt_fixup,
 MACHINE_END
 
 static const char * const armada_375_dt_compat[] __initconst = {
-- 
2.18.0

