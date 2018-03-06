Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvVZiFbPBMvFv+/AioUe1A+IuVhrhCA21zxTSCzi/P6PyIRHq8DT2ZH3gyTssdnQZ5t1kSO
ARC-Seal: i=1; a=rsa-sha256; t=1520295961; cv=none;
        d=google.com; s=arc-20160816;
        b=0lhHnT2OjZvL+sYZAwKHS5y7fh1yUSLacuagcbIb9zB8MRT1BF/nKWf1+4+8VYIzE4
         S7oPX3UT7RSpoKWuiS+HgPC72MKcF2CGM+fEjubOdj8QN3uXVjYhDfjrTASTfYj77iAP
         iEzbwhigzUEPiYdGIG6sZVrgJQa/l2Z/DSLF/fRGFEHa055nyp/oJo6wAqdYZ/zpZIAv
         7Nk6nyEvZR94maBhPTkqMmEyqSvS4hO3Lg8hjC2dtNKstkzJZCnqb+nOoavbNHlmlDfy
         PPgTN6wMTmfM8YfIDvPlA+D2tX83o34a8aiOAGzlwaKgnmktaKdEEkX75f7AfVLriw03
         j9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=j/xUg9Pel3D+OY1q+CzCfCXs2LDA5NFVvcjGpCg+b4s=;
        b=cmI+b7SWPsNafC4NeN4j9fwIdOxxyLQ1AG822ucILoU0osfwXzU6n+FMqZRyQY0jZe
         HYkuSW0gWEssUrDdkFttx96a4y4FcPRFViAtcSfDr4ywuxt6nsuc8mX3MJZmeo5zhIrE
         fzGtqP6pYEK8bNMkDWPwu00qaWXyPpy/Hfb0UMfxn+EavYrXJIxQ0YRiQcgBZhP3nTPb
         tOEqaA18zrttO2F+UGzSIU1XPF1DFP9f1uM1veyDIdmm31HM4gTvt6Fg4oC5UKuHxmRw
         9MUAY46qVM0P7QTpbmAeSNOHSl3kCWQ3AsMLI70Icwgl/Qm5jniashSAVHLiUcwXWSLn
         Q/RA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=N+z8Ngk0;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=N+z8Ngk0;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 01/65] x86/mm: Add INVPCID helpers
Date: Mon,  5 Mar 2018 19:24:34 -0500
Message-Id: <20180306002538.1761-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145858030279147?=
X-GMAIL-MSGID: =?utf-8?q?1594145858030279147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit 060a402a1ddb551455ee410de2eadd3349f2801b upstream.

This adds helpers for each of the four currently-specified INVPCID
modes.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/8a62b23ad686888cee01da134c91409e22064db9.1454096309.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit becf292446e9f2dc8842c448836bbe8005e24db0)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 7e459b7ee708..995937999e1f 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -7,6 +7,54 @@
 #include <asm/processor.h>
 #include <asm/special_insns.h>
 
+static inline void __invpcid(unsigned long pcid, unsigned long addr,
+			     unsigned long type)
+{
+	u64 desc[2] = { pcid, addr };
+
+	/*
+	 * The memory clobber is because the whole point is to invalidate
+	 * stale TLB entries and, especially if we're flushing global
+	 * mappings, we don't want the compiler to reorder any subsequent
+	 * memory accesses before the TLB flush.
+	 *
+	 * The hex opcode is invpcid (%ecx), %eax in 32-bit mode and
+	 * invpcid (%rcx), %rax in long mode.
+	 */
+	asm volatile (".byte 0x66, 0x0f, 0x38, 0x82, 0x01"
+		      : : "m" (desc), "a" (type), "c" (desc) : "memory");
+}
+
+#define INVPCID_TYPE_INDIV_ADDR		0
+#define INVPCID_TYPE_SINGLE_CTXT	1
+#define INVPCID_TYPE_ALL_INCL_GLOBAL	2
+#define INVPCID_TYPE_ALL_NON_GLOBAL	3
+
+/* Flush all mappings for a given pcid and addr, not including globals. */
+static inline void invpcid_flush_one(unsigned long pcid,
+				     unsigned long addr)
+{
+	__invpcid(pcid, addr, INVPCID_TYPE_INDIV_ADDR);
+}
+
+/* Flush all mappings for a given PCID, not including globals. */
+static inline void invpcid_flush_single_context(unsigned long pcid)
+{
+	__invpcid(pcid, 0, INVPCID_TYPE_SINGLE_CTXT);
+}
+
+/* Flush all mappings, including globals, for all PCIDs. */
+static inline void invpcid_flush_all(void)
+{
+	__invpcid(0, 0, INVPCID_TYPE_ALL_INCL_GLOBAL);
+}
+
+/* Flush all mappings for all PCIDs except globals. */
+static inline void invpcid_flush_all_nonglobals(void)
+{
+	__invpcid(0, 0, INVPCID_TYPE_ALL_NON_GLOBAL);
+}
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
-- 
2.16.2
