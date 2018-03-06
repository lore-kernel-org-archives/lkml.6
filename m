Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELskLrLKv2M/uj//IHng9OIHtHqixXhvsEegx31DrEsgdVw41kWDv1M8MtrpDbBCke2HyWas
ARC-Seal: i=1; a=rsa-sha256; t=1520296011; cv=none;
        d=google.com; s=arc-20160816;
        b=bXSbpuWsDWHK8g8GYHB+dskCPfP9lvYAdLIOzCF/LoHba9V4CPN9dJ433RnaGSmPye
         aNu6JWCjJULcFUWjOioZr/vCOGuf0r8n84VZQW2J7tIiIW7KHXQ8aOirX1tOngQv1L/D
         IJBvk9LJvVDQZkiqBCiqwUSG7UZYCrwG5kbQxPaU2rRkCryr1PWoZO5abVp9VzFjFtkZ
         YcUFi9YMJ7sDrVwk5yKjYG98sNpPDjcdlQQtanDFoNbc/Iv7SieKZ8DyroiZhVJz3DIx
         r1tXXm6dMY4wnM73T4qBnlB8E6WZoI+r3cHh21RVD8BqlelfQHyAxnozTPkTK2gzUUar
         shoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=7COaSwNHM8GwD2NOErSCYZCtyklx2L6JRnEBSdfk9CY=;
        b=irZ8LANm+G3kF6eh2pquRkfP4cxVfQX4QnpUZWo+zrwU7YTbcDkCb9QgSSV0wuVumu
         fXlliwA9CvxR0HixGOciuC5Uw1VI47JE1BnU781drOLUCWMvna/eaUma/Af+8C4CAuA0
         k6KVejRtFA0b+q6KOQ9jdKWOzhkpqtKyZcmDbVLdXwXRdUt+QBpSb3iKp5s6zLtCmTBg
         yp/4ZFBiTFl3EANTa5piLdE5Mc9p65Fu03JZkwH7VNR3jZMRXJEyZn170SIn9BdBGccG
         vSDwQQHZXkmb/CRPlWqgllhvKBg4dDrUEezvHWJdbkHpH+Av2NwV/psTcTMyURBYcnu1
         pBPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=JUNqkWs+;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=JUNqkWs+;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 56/65] kaiser: kaiser_flush_tlb_on_return_to_user() check PCID
Date: Mon,  5 Mar 2018 19:25:29 -0500
Message-Id: <20180306002538.1761-57-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=815
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145911343590116?=
X-GMAIL-MSGID: =?utf-8?q?1594145911343590116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Let kaiser_flush_tlb_on_return_to_user() do the X86_FEATURE_PCID
check, instead of each caller doing it inline first: nobody needs
to optimize for the noPCID case, it's clearer this way, and better
suits later changes.  Replace those no-op X86_CR3_PCID_KERN_FLUSH lines
by a BUILD_BUG_ON() in load_new_mm_cr3(), in case something changes.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 8eaca4c7d9f167209a9cc568ff028c0a3b0deb2d)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h | 4 ++--
 arch/x86/mm/kaiser.c            | 6 +++---
 arch/x86/mm/tlb.c               | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6fdc8c399601..73865b174090 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -157,7 +157,7 @@ static inline void __native_flush_tlb(void)
 	 * back:
 	 */
 	preempt_disable();
-	if (kaiser_enabled && this_cpu_has(X86_FEATURE_PCID))
+	if (kaiser_enabled)
 		kaiser_flush_tlb_on_return_to_user();
 	native_write_cr3(native_read_cr3());
 	preempt_enable();
@@ -216,7 +216,7 @@ static inline void __native_flush_tlb_single(unsigned long addr)
 	 */
 
 	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE)) {
-		if (kaiser_enabled && this_cpu_has(X86_FEATURE_PCID))
+		if (kaiser_enabled)
 			kaiser_flush_tlb_on_return_to_user();
 		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 		return;
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index c64bfef99ee8..9d6b7517fca5 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -436,12 +436,12 @@ void kaiser_setup_pcid(void)
 
 /*
  * Make a note that this cpu will need to flush USER tlb on return to user.
- * Caller checks whether this_cpu_has(X86_FEATURE_PCID) before calling:
- * if cpu does not, then the NOFLUSH bit will never have been set.
+ * If cpu does not have PCID, then the NOFLUSH bit will never have been set.
  */
 void kaiser_flush_tlb_on_return_to_user(void)
 {
-	this_cpu_write(x86_cr3_pcid_user,
+	if (this_cpu_has(X86_FEATURE_PCID))
+		this_cpu_write(x86_cr3_pcid_user,
 			X86_CR3_PCID_USER_FLUSH | KAISER_SHADOW_PGD_OFFSET);
 }
 EXPORT_SYMBOL(kaiser_flush_tlb_on_return_to_user);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5539d613c263..5939c549905f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -39,7 +39,7 @@ static void load_new_mm_cr3(pgd_t *pgdir)
 {
 	unsigned long new_mm_cr3 = __pa(pgdir);
 
-	if (kaiser_enabled && this_cpu_has(X86_FEATURE_PCID)) {
+	if (kaiser_enabled) {
 		/*
 		 * We reuse the same PCID for different tasks, so we must
 		 * flush all the entries for the PCID out when we change tasks.
@@ -50,10 +50,10 @@ static void load_new_mm_cr3(pgd_t *pgdir)
 		 * do it here, but can only be used if X86_FEATURE_INVPCID is
 		 * available - and many machines support pcid without invpcid.
 		 *
-		 * The line below is a no-op: X86_CR3_PCID_KERN_FLUSH is now 0;
-		 * but keep that line in there in case something changes.
+		 * If X86_CR3_PCID_KERN_FLUSH actually added something, then it
+		 * would be needed in the write_cr3() below - if PCIDs enabled.
 		 */
-		new_mm_cr3 |= X86_CR3_PCID_KERN_FLUSH;
+		BUILD_BUG_ON(X86_CR3_PCID_KERN_FLUSH);
 		kaiser_flush_tlb_on_return_to_user();
 	}
 
-- 
2.16.2
