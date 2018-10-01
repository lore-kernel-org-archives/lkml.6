Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6625E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6625E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeJAS6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:58:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40013 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbeJAS6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:58:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42P1bN2fYwz9ttBw;
        Mon,  1 Oct 2018 14:21:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id t48jS16Cu-_L; Mon,  1 Oct 2018 14:21:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42P1bN22sqz9ttBl;
        Mon,  1 Oct 2018 14:21:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B8638B96B;
        Mon,  1 Oct 2018 14:21:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RSRckGY-HKbw; Mon,  1 Oct 2018 14:21:11 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43CE78B968;
        Mon,  1 Oct 2018 14:21:11 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 13FB46F36D; Mon,  1 Oct 2018 12:21:10 +0000 (UTC)
Message-Id: <6acad0a13b7f6c2845b2022737c6a11a445ed3c2.1538394860.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/lib: fix book3s/32 boot failure due to code patching
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  1 Oct 2018 12:21:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 51c3c62b58b3 ("powerpc: Avoid code patching freed init
sections") accesses 'init_mem_is_free' flag too early, before the
kernel is relocated. This provokes early boot failure (before the
console is active).

As it is not necessary to do this verification that early, this
patch moves the test into patch_instruction() instead of
__patch_instruction().

This modification also has the advantage of avoiding unnecessary
remappings.

Fixes: 51c3c62b58b3 ("powerpc: Avoid code patching freed init sections")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/code-patching.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 6ae2777c220d..5ffee298745f 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -28,12 +28,6 @@ static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
 {
 	int err;
 
-	/* Make sure we aren't patching a freed init section */
-	if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
-		pr_debug("Skipping init section patching addr: 0x%px\n", exec_addr);
-		return 0;
-	}
-
 	__put_user_size(instr, patch_addr, 4, err);
 	if (err)
 		return err;
@@ -148,7 +142,7 @@ static inline int unmap_patch_area(unsigned long addr)
 	return 0;
 }
 
-int patch_instruction(unsigned int *addr, unsigned int instr)
+static int do_patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
 	unsigned int *patch_addr = NULL;
@@ -188,12 +182,22 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
 }
 #else /* !CONFIG_STRICT_KERNEL_RWX */
 
-int patch_instruction(unsigned int *addr, unsigned int instr)
+static int do_patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	return raw_patch_instruction(addr, instr);
 }
 
 #endif /* CONFIG_STRICT_KERNEL_RWX */
+
+int patch_instruction(unsigned int *addr, unsigned int instr)
+{
+	/* Make sure we aren't patching a freed init section */
+	if (init_mem_is_free && init_section_contains(addr, 4)) {
+		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
+		return 0;
+	}
+	return do_patch_instruction(addr, instr);
+}
 NOKPROBE_SYMBOL(patch_instruction);
 
 int patch_branch(unsigned int *addr, unsigned long target, int flags)
-- 
2.13.3

