Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3CEDFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E508A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E508A208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756132AbeFOMaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:30:00 -0400
Received: from www.osadl.org ([62.245.132.105]:56213 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755749AbeFOM37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:29:59 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5FCSOgB008437;
        Fri, 15 Jun 2018 14:28:24 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Anders Berg <anders.berg@lsi.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ARM: add missing of_node_put()
Date:   Fri, 15 Jun 2018 14:28:08 +0200
Message-Id: <1529065688-2692-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_find_compatible_node() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage. (see drivers/of/base.c:of_find_compatible_node())

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with an experimental coccinelle script

Patch was compile tested with: axm55xx_defconfig
(with some sparse warnings - not related to the proposed change though)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/arm/mach-axxia/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
index 502e3df..c706a11 100644
--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -40,10 +40,11 @@ static int axxia_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	syscon_np = of_find_compatible_node(NULL, NULL, "lsi,axxia-syscon");
 	if (!syscon_np)
 		return -ENOENT;
 
 	syscon = of_iomap(syscon_np, 0);
+	of_node_put(syscon_np);
 	if (!syscon)
 		return -ENOMEM;
 
 	tmp = readl(syscon + SC_RST_CPU_HOLD);
 	writel(0xab, syscon + SC_CRIT_WRITE_KEY);
-- 
2.1.4

