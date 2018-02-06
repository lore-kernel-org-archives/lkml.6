Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeBFQt4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:49:56 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:1704 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeBFQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:49:49 -0500
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="721409896"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Kees Cook <keescook@google.com>, Willy Tarreau <w@1wt.eu>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: Always print RLIMIT_DATA warning
Date: Tue,  6 Feb 2018 16:45:05 +0000
Message-Id: <1517935505-9321-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for ignore_rlimit_data says that it will print a warning
at first misuse. Yet it doesn't seem to do that. Fix the code to print
the warning even when we allow the process to continue.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
We should probably also do what Linus suggested in 
https://lkml.org/lkml/2016/9/16/585

 mm/mmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9efdc021..dd76ea3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3184,13 +3184,15 @@ bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags, unsigned long npages)
 		if (rlimit(RLIMIT_DATA) == 0 &&
 		    mm->data_vm + npages <= rlimit_max(RLIMIT_DATA) >> PAGE_SHIFT)
 			return true;
-		if (!ignore_rlimit_data) {
-			pr_warn_once("%s (%d): VmData %lu exceed data ulimit %lu. Update limits or use boot option ignore_rlimit_data.\n",
-				     current->comm, current->pid,
-				     (mm->data_vm + npages) << PAGE_SHIFT,
-				     rlimit(RLIMIT_DATA));
+
+		pr_warn_once("%s (%d): VmData %lu exceed data ulimit %lu. Update limits%s.\n",
+			     current->comm, current->pid,
+			     (mm->data_vm + npages) << PAGE_SHIFT,
+			     rlimit(RLIMIT_DATA),
+			     ignore_rlimit_data ? "" : " or use boot option ignore_rlimit_data");
+
+		if (!ignore_rlimit_data)
 			return false;
-		}
 	}
 
 	return true;
-- 
2.7.4
