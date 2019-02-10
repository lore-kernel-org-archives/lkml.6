Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C41BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0AB20818
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 07:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfBJHwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 02:52:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfBJHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 02:52:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1A7q9We2988643
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 23:52:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1A7q9Jl2988640;
        Sat, 9 Feb 2019 23:52:09 -0800
Date:   Sat, 9 Feb 2019 23:52:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-20e55bc17dd01f13cec0eb17e76e9511b23963ef@git.kernel.org>
Cc:     linux@eikelenboom.it, jgross@suse.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: jgross@suse.com, mingo@kernel.org, tglx@linutronix.de,
          linux@eikelenboom.it, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190210074056.11842-1-jgross@suse.com>
References: <20190210074056.11842-1-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Make set_pmd_at() paravirt aware
Git-Commit-ID: 20e55bc17dd01f13cec0eb17e76e9511b23963ef
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

Commit-ID:  20e55bc17dd01f13cec0eb17e76e9511b23963ef
Gitweb:     https://git.kernel.org/tip/20e55bc17dd01f13cec0eb17e76e9511b23963ef
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Sun, 10 Feb 2019 08:40:56 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Feb 2019 08:47:12 +0100

x86/mm: Make set_pmd_at() paravirt aware

set_pmd_at() calls native_set_pmd() unconditionally on x86. This was
fine as long as only huge page entries were written via set_pmd_at(),
as Xen pv guests don't support those.

Commit 2c91bd4a4e2e53 ("mm: speed up mremap by 20x on large regions")
introduced a usage of set_pmd_at() possible on pv guests, leading to
failures like:

BUG: unable to handle kernel paging request at ffff888023e26778
#PF error: [PROT] [WRITE]
RIP: e030:move_page_tables+0x7c1/0xae0
move_vma.isra.3+0xd1/0x2d0
__se_sys_mremap+0x3c6/0x5b0
 do_syscall_64+0x49/0x100
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Make set_pmd_at() paravirt aware by just letting it use set_pmd().

Fixes: 2c91bd4a4e2e53 ("mm: speed up mremap by 20x on large regions")
Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com
Cc: sstabellini@kernel.org
Cc: hpa@zytor.com
Cc: bp@alien8.de
Cc: torvalds@linux-foundation.org
Link: https://lkml.kernel.org/r/20190210074056.11842-1-jgross@suse.com

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
