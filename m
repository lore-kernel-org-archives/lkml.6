Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELv60gsyUJrnDTzKyiEpHbEt3YUHaoNQ7O1lDQwnwisPaNn8Nb8KmAraF+pkNOcyw3KYDfz9
ARC-Seal: i=1; a=rsa-sha256; t=1520295966; cv=none;
        d=google.com; s=arc-20160816;
        b=TI8EamALTx1fyeo4kSXLiRq/S4T1eJYS6gqdNvt9O8IP9lEQnhrQpU1QBr+AQFxYEV
         qo5vmIVsSlOxwBDFO3drII3TyxzJrNpy7iLnM8Bbu82tQ8bRKJxYibSPetQ2QHr1dHBC
         AE85uX+naRdmvd3u6uweCFlOq5U1MNRhZqTaSwHiOurF2fmZ4hE3F9GtiYlvGxG+0QsD
         s/A4KpGnvjh9YWU+6PtArh/DH9xg8GtsAJxv0jJ+KKX6/hSSkFj9ac++430/eIBbbWGA
         S2dt7CcdIAnTK8h64PCYKkfTvedBWx/SXvLVGQXVwGRDEnjklNHcaAHGFCoisLxcCPWb
         OtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=8uaeY7VVV2WAyKE3bAx1MtEhAk8ueaA2hzkbsEkt94g=;
        b=os32Tz3hLZpY0lbbrlFlCNK6ljA7OwUMIrpKii1OXEfMbH2zZtStpzX1DIsz9lKug1
         nN7bZcMdUQf1uqkuWw1AgefZBEB2gRJK/wIMFjON/7nY8w9m9rl0ey4SQPSG5Rlwp8d6
         lNcnANJYYO2yI+5l6VVG891zAvUZHYZUCEjjcMs+nT4zKAbiUecql2opRuPv5lMtd3+s
         ehmzzO5Q2FWQGA6tMv5nK3tYp5Sz4HP0OUAcvasImHRXJJsA2qU1Qw2btbtLMTjSqBBJ
         j67yDaDex+/ZZUzd91zQHuDf41QjOdc0no/ZIMNbeRBh/ZYCeZ4SWMfyyxOcJfuZo/Hf
         WjYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Br4GL93I;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Br4GL93I;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 07/65] x86/mm: Build arch/x86/mm/tlb.c even on !SMP
Date: Mon,  5 Mar 2018 19:24:40 -0500
Message-Id: <20180306002538.1761-8-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145862964741657?=
X-GMAIL-MSGID: =?utf-8?q?1594145862964741657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit e1074888c326038340a1ada9129d679e661f2ea6 upstream.

Currently all of the functions that live in tlb.c are inlined on
!SMP builds.  One can debate whether this is a good idea (in many
respects the code in tlb.c is better than the inlined UP code).

Regardless, I want to add code that needs to be built on UP and SMP
kernels and relates to tlb flushing, so arrange for tlb.c to be
compiled unconditionally.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/f0d778f0d828fc46e5d1946bca80f0aaf9abf032.1461688545.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 83cc4b50e3a977915666ade0b951ba446e7181bd)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/Makefile | 3 +--
 arch/x86/mm/tlb.c    | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index a482d105172b..d893640d5c68 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -1,5 +1,5 @@
 obj-y	:=  init.o init_$(BITS).o fault.o ioremap.o extable.o pageattr.o mmap.o \
-	    pat.o pgtable.o physaddr.o gup.o setup_nx.o
+	    pat.o pgtable.o physaddr.o gup.o setup_nx.o tlb.o
 
 # Make sure __phys_addr has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
@@ -9,7 +9,6 @@ CFLAGS_setup_nx.o		:= $(nostackp)
 CFLAGS_fault.o := -I$(src)/../include/asm/trace
 
 obj-$(CONFIG_X86_PAT)		+= pat_rbtree.o
-obj-$(CONFIG_SMP)		+= tlb.o
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 061e0114005e..a1aa5f59e3ad 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -28,6 +28,8 @@
  *	Implement flush IPI by CALL_FUNCTION_VECTOR, Alex Shi
  */
 
+#ifdef CONFIG_SMP
+
 struct flush_tlb_info {
 	struct mm_struct *flush_mm;
 	unsigned long flush_start;
@@ -346,3 +348,5 @@ static int __init create_tlb_single_page_flush_ceiling(void)
 	return 0;
 }
 late_initcall(create_tlb_single_page_flush_ceiling);
+
+#endif /* CONFIG_SMP */
-- 
2.16.2
