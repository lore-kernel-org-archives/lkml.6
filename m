Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D9C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 07:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686492075C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 07:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfBJHlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 02:41:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:58102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfBJHlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 02:41:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82894AE83;
        Sun, 10 Feb 2019 07:40:59 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        linux@eikelenboom.it, torvalds@linux-foundation.org,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86: make set_pmd_at() paravirt aware
Date:   Sun, 10 Feb 2019 08:40:56 +0100
Message-Id: <20190210074056.11842-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_pmd_at() calls native_set_pmd() unconditionally on x86. This was
fine as long as only huge page entries were written via set_pmd_at(),
as Xen pv guests don't support those.

Commit 2c91bd4a4e2e53 ("mm: speed up mremap by 20x on large regions")
introduced a usage of set_pmd_at() possible on pv guests, leading to
failures like:

[17035.016433] BUG: unable to handle kernel paging request at ffff888023e26778
[17035.025887] #PF error: [PROT] [WRITE]
[17035.035146] PGD 2a2a067 P4D 2a2a067 PUD 2a2b067 PMD 7fe01067 PTE 8010000023e26065
[17035.044371] Oops: 0003 [#1] SMP NOPTI
[17035.053720] CPU: 3 PID: 28310 Comm: apt-get Not tainted 5.0.0-rc5-20190208-thp-net-florian-rtl8169-eric-doflr+ #1
[17035.063440] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
[17035.072635] RIP: e030:move_page_tables+0x7c1/0xae0
[17035.081585] Code: ce 00 48 8b 03 31 ff 48 89 44 24 20 e8 9e 72 e4 ff 66 90 48 89 c6 48 89 df e8 8b 89 e4 ff 66 90 48 8b 44 24 20 b9 0c 00 00 00 <48> 89 45 00 41 f6 46 52 40 0f 85 3f 02 00 00 49 8b 7e 40 45 31 c0
[17035.100225] RSP: e02b:ffffc90000f2bd40 EFLAGS: 00010282
[17035.109208] RAX: 0000000475e42067 RBX: ffff888023e267e0 RCX: 000000000000000c
[17035.118332] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000201
[17035.127378] RBP: ffff888023e26778 R08: aaaaaaaaaaaaaaaa R09: 000000051c1d9000
[17035.136310] R10: deadbeefdeadf00d R11: ffff88807fc17000 R12: 00007fc59fa00000
[17035.145433] R13: ffffea00008f89a8 R14: ffff88801c2286c0 R15: 00007fc59f800000
[17035.154171] FS:  00007fc5a5591100(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
[17035.162730] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[17035.171180] CR2: ffff888023e26778 CR3: 000000001c3f6000 CR4: 0000000000000660
[17035.179545] Call Trace:
[17035.187736]  move_vma.isra.3+0xd1/0x2d0
[17035.195837]  __se_sys_mremap+0x3c6/0x5b0
[17035.203986]  do_syscall_64+0x49/0x100
[17035.212109]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[17035.219971] RIP: 0033:0x7fc5a453527a
[17035.227558] Code: 73 01 c3 48 8b 0d 1e fc 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ee fb 2a 00 f7 d8 64 89 01 48
[17035.243255] RSP: 002b:00007ffda22d96f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
[17035.251121] RAX: ffffffffffffffda RBX: 0000557d40923a30 RCX: 00007fc5a453527a
[17035.258986] RDX: 0000000001a00000 RSI: 0000000001900000 RDI: 00007fc59f7ff000
[17035.267127] RBP: 0000000001a00000 R08: 0000000000000020 R09: 0000000000000040
[17035.275259] R10: 0000000000000001 R11: 0000000000000246 R12: 00007fc59f7ff060
[17035.282681] R13: 00007fc59f7ff000 R14: 0000557d40923a30 R15: 0000557d40829aa0
[17035.290322] Modules linked in:
[17035.297875] CR2: ffff888023e26778
[17035.305405] ---[ end trace 6ff49f09286816b6 ]---

Make set_pmd_at() paravirt aware by just letting it use set_pmd().

Fixes: 2c91bd4a4e2e53 ("mm: speed up mremap by 20x on large regions")
Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 40616e805292..2779ace16d23 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1065,7 +1065,7 @@ static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
-	native_set_pmd(pmdp, pmd);
+	set_pmd(pmdp, pmd);
 }
 
 static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
-- 
2.16.4

