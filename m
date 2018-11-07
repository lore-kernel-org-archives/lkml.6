Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8052C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDAC20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eUjygNn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDAC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeKGVnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:43:04 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:39538 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeKGVnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:43:04 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6AD6624E08C0;
        Wed,  7 Nov 2018 04:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541592777; bh=yR843m6vL0pXhhayWnDu07VSpOEDMWpoF12HcchvL1k=;
        h=From:To:Cc:Subject:Date:From;
        b=eUjygNn9uBfN4I07ttFrd2Z+hpRhLSyfSygkcREKcfamFZeVoUMdiasE4IkYeHys7
         Ya/D9LNLzyQRG67ra+VC3rysO6E+wFE+UgfKDqNLgBDAX22JrHPEO91QMlSnIso2li
         L5Qg7b7k3Nz1nzpPd1cEDP4plP0p1spDP29CeEFTXSe5jMS7LcZvMwDwOfOCOG1Wvr
         qVQ9HMy6SDQjdyh3taqjKooEtP56AQI5IKnpdQk/hnnLWn1kZVWpDYu1DXFFjZm7eZ
         qGEKYRBPX4K6tFV9DMrBETHOehkzk4+Pe2Zq+Q0ejz5aIfYl7un8ON4q8ZAJbL+/iO
         4xuK+3ldB0MBw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id A9E163AB5;
        Wed,  7 Nov 2018 04:12:53 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: MM: fix UB and kernel resourse leak in do_page_fault
Date:   Wed,  7 Nov 2018 15:12:49 +0300
Message-Id: <20181107121249.6657-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 15773ae938d8 ("signal/arc: Use force_sig_fault where
appropriate") adds undefined behaviour and kernel resource leak
to userspace in ARC do_page_fault() implementation.

This happens because we don't initialize si_code variable after we
switch to force_sig_fault using. si_code (as a part of siginfo_t
structure) was previously initialized by clear_siginfo(&info) call
which was removed.

Undefined behaviour path:
-------------------->8---------------------------
}}} a/arch/arc/mm/fault.c
!! -67,6 +67,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
        struct task_struct *tsk = current;
        struct mm_struct *mm = tsk->mm;
+       /// >>> si_code - uninitialized
        int si_code;
        int ret;
        vm_fault_t fault;
        int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
!! -81,8 +82,10 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
         * only copy the information from the master page table,
         * nothing more.
         */
+       /// >>> take true branch
        if (address >= VMALLOC_START) {
                ret = handle_kernel_vaddr_fault(address);
+               /// >>> take true branch
                if (unlikely(ret))
+                       /// >>> jump to label "bad_area_nosemaphore"
                        goto bad_area_nosemaphore;
                else
!! -193,10 +196,13 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 bad_area:
        up_read(&mm->mmap_sem);

+       /// >>> reach label "bad_area_nosemaphore"
 bad_area_nosemaphore:
        /* User mode accesses just cause a SIGSEGV */
+       /// >>> take true branch
        if (user_mode(regs)) {
                tsk->thread.fault_address = address;
+               /// >>> Ooops:
+               /// >>> use uninitialized value "si_code"
+               /// >>> when calling "force_sig_fault"
                force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
                return;
        }
-------------------->8---------------------------

Fixes: 15773ae938d8 ("signal/arc: Use force_sig_fault where appropriate")
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index c9da6102eb4f..e2d9fc3fea01 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -66,7 +66,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	int si_code;
+	int si_code = 0;
 	int ret;
 	vm_fault_t fault;
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
-- 
2.14.5

