Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BB9C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40FC21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40FC21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeGLQDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:03:09 -0400
Received: from www.osadl.org ([62.245.132.105]:42974 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeGLQDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:03:09 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6CFnXJ8002391;
        Thu, 12 Jul 2018 17:49:33 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@st.com>
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ARM: STi: at least warn if of_iomap fails
Date:   Thu, 12 Jul 2018 17:48:50 +0200
Message-Id: <1531410530-24163-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_iomap() is unchecked but scu_enable(), which the returned
address is passed on to, assumes a valid mapping. If the mapping is
invalid this could probably lead to undefined system state so at least
a warning should be issued.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 65ebcc115889 ("ARM: sti: Add STiH415 SOC support")
---
Problem was found by an experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies
CONFIG_ARCH_STI=y, CONFIG_SMP=y)

Patch is against 4.18-rc3 (localversion-next is next-20180712)

 arch/arm/mach-sti/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 231f19e..89ae76f 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -109,6 +109,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 
 	if (np) {
 		scu_base = of_iomap(np, 0);
+		WARN_ON(!scu_base);
 		scu_enable(scu_base);
 		of_node_put(np);
 	}
-- 
2.1.4

