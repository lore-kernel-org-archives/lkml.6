Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965A620849
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965A620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeGPOS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:18:58 -0400
Received: from www.osadl.org ([62.245.132.105]:33222 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbeGPOS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:18:58 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6GDleKf013440;
        Mon, 16 Jul 2018 15:47:40 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@st.com>
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] ARM: STi: warn if scu mapping fails
Date:   Mon, 16 Jul 2018 15:46:49 +0200
Message-Id: <1531748809-12540-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 If the device node is not found or the of_iomap() failed, calling
scu_enable would not be safe and could lead to an undefined system
state. So warn in both failure paths before returning.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Link: http://lkml.org/lkml/2018/7/16/219
Fixes: commit 65ebcc115889 ("ARM: sti: Add STiH415 SOC support")
---

V2: replacement of WARN_ON() by a meaningful pr_err as suggested by
    Patrice CHOTARD <patrice.chotard@st.com>.

Problem was found by an experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies
CONFIG_ARCH_STI=y, CONFIG_SMP=y)
(with one sparse warning unrelated to the proposed change)

Patch is against 4.18-rc4 (localversion-next is next-20180716)

 arch/arm/mach-sti/platsmp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 231f19e..530e9a5 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -107,12 +107,22 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 
-	if (np) {
-		scu_base = of_iomap(np, 0);
-		scu_enable(scu_base);
-		of_node_put(np);
+	if (!np) {
+		pr_err("SCU not found at %s:%s():%d\n",
+		       __FILE__, __func__, __LINE__);
+		return;
 	}
 
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base) {
+		pr_err("SCU remap failed at %s:%s():%d\n",
+		       __FILE__, __func__, __LINE__);
+		return;
+	}
+
+	scu_enable(scu_base);
+
 	if (max_cpus <= 1)
 		return;
 
-- 
2.1.4

