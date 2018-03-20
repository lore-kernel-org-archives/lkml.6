Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeCTLGK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:06:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeCTLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:33 -0400
Date: Tue, 20 Mar 2018 04:05:25 -0700
From: tip-bot for Boris Ostrovsky <tipbot@zytor.com>
Message-ID: <tip-31ad7f8e7dc94d3b85ccf9b6141ce6dfd35a1781@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, hpa@zytor.com, jgross@suse.com,
        boris.ostrovsky@oracle.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com
In-Reply-To: <20180319143154.3742-1-boris.ostrovsky@oracle.com>
References: <20180319143154.3742-1-boris.ostrovsky@oracle.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/vsyscall/64: Use proper accessor to update P4D
 entry
Git-Commit-ID: 31ad7f8e7dc94d3b85ccf9b6141ce6dfd35a1781
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  31ad7f8e7dc94d3b85ccf9b6141ce6dfd35a1781
Gitweb:     https://git.kernel.org/tip/31ad7f8e7dc94d3b85ccf9b6141ce6dfd35a1781
Author:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
AuthorDate: Mon, 19 Mar 2018 10:31:54 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 12:00:53 +0100

x86/vsyscall/64: Use proper accessor to update P4D entry

Writing to it directly does not work for Xen PV guests.

Fixes: 49275fef986a ("x86/vsyscall/64: Explicitly set _PAGE_USER in the pagetable hierarchy")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180319143154.3742-1-boris.ostrovsky@oracle.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 8560ef68a9d6..317be365bce3 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -347,7 +347,7 @@ void __init set_vsyscall_pgtable_user_bits(pgd_t *root)
 	set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
 	p4d = p4d_offset(pgd, VSYSCALL_ADDR);
 #if CONFIG_PGTABLE_LEVELS >= 5
-	p4d->p4d |= _PAGE_USER;
+	set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
 #endif
 	pud = pud_offset(p4d, VSYSCALL_ADDR);
 	set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
