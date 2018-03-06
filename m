Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvmu9AdEgl1DIaZJZMmf9fB3AzSnXYtKlfkVrRT1ENcxb2pnxWyE7UQSS5vnJJ+U7nxI0/P
ARC-Seal: i=1; a=rsa-sha256; t=1520295973; cv=none;
        d=google.com; s=arc-20160816;
        b=vplHrD9DpBR6UzhIJzY2x4j2aucCHtBA0Kfl3zBI4itOXiq3T5g6FUR4i/OyXNIgVG
         csONcULKQxmivg9opP3Zt09SkHHBIHzRwIZiiRcU/ZH5aMRVIDzGBWn53oXyTwmx+Qyk
         QolnKk7pcwm2ytNP8rjjb43EZwE88RqGzJ8shc6KPqfHrn/r6i4Lkz4JhnRaK1d1A9aJ
         8JHpLNotk6O4BB1FqZ0plZLn9gha6p3ts7+AkGdfUo1J8zq797O8irnjqdLWHjzH51EP
         /ia003JE3axt1Jkm/nShLu793nTSen2S8hb6ak3ikP4/pgkvi1ETW0rY1wNrkpCTLLJ4
         TMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=Q+ufNThHBu+wgxR6EICVZyufyKyfGhPqMc9d1GhjYxo=;
        b=TxBAHaDPhkWlb66q3w6shss7Fa4oxjE1QLNFfaIk7D4iOKh7xF+tz1xzds9umTN1gW
         7Y3t1qDPQbcWdx26YixWg5j93XeftJnHq0OMPN/vQCA0m3t3UCVhRbSI57OzTDDM4QHP
         dMX5YtqQAPLS2KhsdYdo6oQN/o58uDh2B3v79DXfSQAyYVR+hzfyzNMd9RZX50zGGyrp
         RNbqapyLIoFNX3QmKvHWFNCx00I3MYjnMhcAU8pwZb6bVu5BKiv/3rUfo8es21fO/ADG
         bFSP1/FC9aPS5AaH+CVsjASp589cp1xUbpICITHXzRXdJVcuSLvPLWl6PHuUzoos6pv6
         ahEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jt38k7fg;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jt38k7fg;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 15/65] x86/mm: Make flush_tlb_mm_range() more predictable
Date: Mon,  5 Mar 2018 19:24:48 -0500
Message-Id: <20180306002538.1761-16-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145870827682603?=
X-GMAIL-MSGID: =?utf-8?q?1594145870827682603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit ce27374fabf553153c3f53efcaa9bfab9216bd8c upstream.

I'm about to rewrite the function almost completely, but first I
want to get a functional change out of the way.  Currently, if
flush_tlb_mm_range() does not flush the local TLB at all, it will
never do individual page flushes on remote CPUs.  This seems to be
an accident, and preserving it will be awkward.  Let's change it
first so that any regressions in the rewrite will be easier to
bisect and so that the rewrite can attempt to change no visible
behavior at all.

The fix is simple: we can simply avoid short-circuiting the
calculation of base_pages_to_flush.

As a side effect, this also eliminates a potential corner case: if
tlb_single_page_flush_ceiling == TLB_FLUSH_ALL, flush_tlb_mm_range()
could have ended up flushing the entire address space one page at a
time.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/4b29b771d9975aad7154c314534fec235618175a.1492844372.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 9f4d1ba1d407e56dac833aa0b11c60f952939e1c)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/tlb.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 262abde154eb..95d5b4fff799 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -285,6 +285,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	unsigned long base_pages_to_flush = TLB_FLUSH_ALL;
 
 	preempt_disable();
+
+	if ((end != TLB_FLUSH_ALL) && !(vmflag & VM_HUGETLB))
+		base_pages_to_flush = (end - start) >> PAGE_SHIFT;
+	if (base_pages_to_flush > tlb_single_page_flush_ceiling)
+		base_pages_to_flush = TLB_FLUSH_ALL;
+
 	if (current->active_mm != mm) {
 		/* Synchronize with switch_mm. */
 		smp_mb();
@@ -301,15 +307,11 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 		goto out;
 	}
 
-	if ((end != TLB_FLUSH_ALL) && !(vmflag & VM_HUGETLB))
-		base_pages_to_flush = (end - start) >> PAGE_SHIFT;
-
 	/*
 	 * Both branches below are implicit full barriers (MOV to CR or
 	 * INVLPG) that synchronize with switch_mm.
 	 */
-	if (base_pages_to_flush > tlb_single_page_flush_ceiling) {
-		base_pages_to_flush = TLB_FLUSH_ALL;
+	if (base_pages_to_flush == TLB_FLUSH_ALL) {
 		count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 		local_flush_tlb();
 	} else {
-- 
2.16.2
