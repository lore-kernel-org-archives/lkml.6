Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED242ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8765D20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Al3PxtWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8765D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=runbox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGUVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:35:09 -0400
Received: from aibo.runbox.com ([91.220.196.211]:60998 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeGUVfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:35:09 -0400
X-Greylist: delayed 3068 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Jul 2018 17:35:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Message-Id:Date:Subject:Cc:To:From;
        bh=yJzZ9gLv2sxmtxViNKulEFvVXBJ3d0WY5DXgjGelhBc=; b=Al3PxtWc2v+4GLvTcj46dycpE4
        Xt6C7sgqCM1NzCDk5rHojegwQ1DCha06jugStaOlYPmQLXh/02MVEDw5uKfiXLwqL9+SN9nbXoA4h
        NR2v8ITVyKQx38iVrZfu2BG07Ye2bOG9D/dR2XCE8XdmEPqasAIQR/hSop5Q+3T13Td84dsyOE0Je
        OJI2PWxzD12qG+kwNTcnDrE4bvbql3HuqgUdbCX6AdIOXGyGF/9jgiwtt4O/1XHHtEGiqHO8DbSeK
        bJteQkCxHzOhbgm65JWgoLpvX/YVwjF4TctBeHr4Z+UDN8vSgSwQpK0LsYTc4H41uAOB3xtQ0xA6r
        e7oGp4mA==;
Received: from [10.9.9.210] (helo=mailfront10.runbox.com)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1fgxtB-0002TV-TQ; Sat, 21 Jul 2018 21:50:02 +0200
Received: by mailfront10.runbox.com with esmtpsa  (uid:769847 )  (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        id 1fgxsz-0007pF-8j; Sat, 21 Jul 2018 21:49:50 +0200
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
To:     linux-kernel@vger.kernel.org
Cc:     "M . Vefa Bicakci" <m.v.b@runbox.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] x86/entry/64: Do not clear %rbx under Xen
Date:   Sat, 21 Jul 2018 15:49:08 -0400
Message-Id: <20180721194909.23903-1-m.v.b@runbox.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
exceptions/interrupts, to reduce speculation attack surface") unintendedly
broke Xen PV virtual machines by clearing the %rbx register at the end of
xen_failsafe_callback before the latter jumps to error_exit.
error_exit expects the %rbx register to be a flag indicating whether
there should be a return to kernel mode.

This commit makes sure that the %rbx register is not cleared by
the PUSH_AND_CLEAR_REGS macro, when the macro in question is instantiated
by xen_failsafe_callback, to avoid the issue.

The impact of this bug includes (and most likely is not limited to) kernel
BUGs when wine is run in Xen PV virtual machines. One example is included
below. This example depicts the bug when wine is used to run TeamViewer
version 13's portable version under a Xen PV virtual machine using an
up-to-date version of Qubes OS R3.2.

  [...........] kernel tried to execute NX-protected page - exploit attempt? (uid: 1000)
  [  +0.000021] BUG: unable to handle kernel paging request at ffffffff82012480
  [  +0.000020] IP: init_task+0x0/0x2ac0
  [  +0.000009] PGD 200e067 P4D 200e067 PUD 200f067 PMD 2d5e067 PTE 8010000002012067
  [  +0.000019] Oops: 0011 [#1] SMP DEBUG_PAGEALLOC NOPTI
  [  +0.000015] Modules linked in: fuse bluetooth ecdh_generic rfkill ip6table_filter ip6_tables xt_conntrack ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c intel_rapl x86_pkg_temp_thermal crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel xen_netfront intel_rapl_perf pcspkr binfmt_misc dummy_hcd udc_core xen_gntdev xen_gntalloc u2mfn(O) xen_blkback xenfs xen_evtchn xen_privcmd xen_blkfront
  [  +0.000091] CPU: 0 PID: 1350 Comm: TeamViewer.exe Tainted: G           O        4.14.20-11.d10d0bb86d #15
  [  +0.000018] task: ffff8800042fda00 task.stack: ffffc900006f8000
  [  +0.000015] RIP: e030:init_task+0x0/0x2ac0
  [  +0.000009] RSP: e02b:ffffffff82003df8 EFLAGS: 00010002
  [  +0.000012] RAX: 0000000000000040 RBX: 0000000000000004 RCX: 0000000000000000
  [  +0.000015] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffffffff810011aa
  [  +0.000015] RBP: 000000000033eb88 R08: 0000000000000000 R09: 0000000000000000
  [  +0.000015] R10: 0000000000000000 R11: ffff88000d772600 R12: 0000000000000000
  [  +0.000015] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  [  +0.000027] FS:  000000007ffd8000(0063) GS:ffff88000f400000(006b) knlGS:0000000000000000
  [  +0.000016] CS:  e033 DS: 002b ES: 002b CR0: 0000000080050033
  [  +0.000014] CR2: ffffffff82012480 CR3: 0000000004880000 CR4: 0000000000042660
  [  +0.000025] Call Trace:
  [  +0.000007] Code: ff ff ff d0 5a 1e 81 ff ff ff ff 00 00 00 00 00 00 00 00 e0 d7 04 82 ff ff ff ff e8 98 c0 0d 00 88 ff ff 01 80 00 00 00 00 00 00 <00> 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  [  +0.000068] RIP: init_task+0x0/0x2ac0 RSP: ffffffff82003df8
  [  +0.000011] CR2: ffffffff82012480
  [  +0.000010] ---[ end trace 7fb0075d4247b2a2 ]---

The commit that introduces this bug was found with git-bisect in conjunction with
some scripts and Qubes OS's cross-VM RPCs for automation, and the correction was
prepared after a manual inspection of the changes introduced by the commit in
question.

To the best of my recollection, this issue is also reproducible in an Ubuntu
18.04 LTS dom0 instance with the version of the Xen hypervisor in Ubuntu's
package repositories.

Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: x86@kernel.org
Cc: stable@vger.kernel.org # for v4.14 and up
Fixes: 3ac6d8c787b8 ("x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface")
---
 arch/x86/entry/calling.h  | 4 +++-
 arch/x86/entry/entry_64.S | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 20d0885b00fb..71795767da94 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0 clear_rbx=1
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -127,7 +127,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %r11		/* pt_regs->r11 */
 	xorl	%r11d, %r11d	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
+	.if \clear_rbx
 	xorl    %ebx, %ebx	/* nospec   rbx*/
+	.endif
 	pushq	%rbp		/* pt_regs->rbp */
 	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c7449f377a77..96e8ff34129e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1129,7 +1129,7 @@ ENTRY(xen_failsafe_callback)
 	addq	$0x30, %rsp
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
-	PUSH_AND_CLEAR_REGS
+	PUSH_AND_CLEAR_REGS clear_rbx=0
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
-- 
2.17.1

