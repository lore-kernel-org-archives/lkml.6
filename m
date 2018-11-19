Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12065C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16E4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16E4206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeKSUjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:39:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:39:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAGL0L2524174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:16:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAGLo02524171;
        Mon, 19 Nov 2018 02:16:21 -0800
Date:   Mon, 19 Nov 2018 02:16:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-6cdce951f7a1d8161910d5cd9bd9e6197bf5cc97@git.kernel.org>
Cc:     bp@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          bp@suse.de, tglx@linutronix.de
In-Reply-To: <20181107170218.7596-8-bp@alien8.de>
References: <20181107170218.7596-8-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Simplify patch family
 detection
Git-Commit-ID: 6cdce951f7a1d8161910d5cd9bd9e6197bf5cc97
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6cdce951f7a1d8161910d5cd9bd9e6197bf5cc97
Gitweb:     https://git.kernel.org/tip/6cdce951f7a1d8161910d5cd9bd9e6197bf5cc97
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 19 Jul 2018 15:47:07 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:51:05 +0100

x86/microcode/AMD: Simplify patch family detection

Instead of traversing the equivalence table, compute the family a patch
is for, from the processor revision ID in the microcode header.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-8-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 8f012a7f88c4..b4450374f4b1 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -540,20 +540,6 @@ static u16 __find_equiv_id(unsigned int cpu)
 	return find_equiv_id(equiv_cpu_table, uci->cpu_sig.sig);
 }
 
-static u32 find_cpu_family_by_equiv_cpu(u16 equiv_cpu)
-{
-	int i = 0;
-
-	BUG_ON(!equiv_cpu_table);
-
-	while (equiv_cpu_table[i].equiv_cpu != 0) {
-		if (equiv_cpu == equiv_cpu_table[i].equiv_cpu)
-			return equiv_cpu_table[i].installed_cpu;
-		i++;
-	}
-	return 0;
-}
-
 /*
  * a small, trivial cache of per-family ucode patches
  */
@@ -732,7 +718,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	struct microcode_header_amd *mc_hdr;
 	unsigned int patch_size, crnt_size;
 	struct ucode_patch *patch;
-	u32 proc_fam;
+	u8 patch_fam;
 	u16 proc_id;
 
 	patch_size = verify_patch(family, fw, leftover, false);
@@ -746,15 +732,8 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
-	proc_fam = find_cpu_family_by_equiv_cpu(proc_id);
-	if (!proc_fam) {
-		pr_err("No patch family for equiv ID: 0x%04x\n", proc_id);
-		return crnt_size;
-	}
-
-	/* check if patch is for the current family */
-	proc_fam = ((proc_fam >> 8) & 0xf) + ((proc_fam >> 20) & 0xff);
-	if (proc_fam != family)
+	patch_fam = 0xf + (proc_id >> 12);
+	if (patch_fam != family)
 		return crnt_size;
 
 	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
