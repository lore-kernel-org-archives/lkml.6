Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227nHz2HmiH7mJ0Eu2eJHv60t2MUMUA2rLAR+4tTCdPxgGyYpMU1H6O/W5ml5sutL6qbLybu
ARC-Seal: i=1; a=rsa-sha256; t=1519218458; cv=none;
        d=google.com; s=arc-20160816;
        b=v0T/5D6FkQekaOsGZ0om9ClVxgQ2yGnSeDbhvOBvz23ZSISqfEf3ed9VnsY58j5E5J
         mo3Jf6JL4if9Shlo0P9WTAYX/fkZ+xe6hNyBRtEhCP5rvYNH7738QB0vIhZjMRJq4qCo
         WPIG+coPEaZbenmIbhuTfq9bmDo/dopa/v/Be15OCF7cc1OMzElommymO3Gp5IhwWRXT
         n13EGcPZxcuVz9tzVsrDzQJxJGAgOOz8Lx13gJBff8jt214cxWkcD16RU3nFldGEsgvB
         D7aAhNLT2/lV+VqgccnqpAiDi7M6k7Ol9cLwjsMFRptw/2jlr3BR/i0DP1hD5o3AfNlo
         TNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IAGLG0aDXSp1tJ434D2e9ZwN9b3bdhqQxw0kPjBkhX0=;
        b=Vn9T/StlTvhls5B2MFL+TjQghkmUJpbq7Y1gxSoDg1YaF+4hlMSYWGLHs4JWQ9Mo6V
         u2TxBLgMLS5QhVVd3cAdK5pELlLwSAOcAaGC6Dnpb8eNnhIdmrJx26dMqTAL7HnBerKL
         +ven23lveCW0c19KvImZC4SvwgvbK+1RrUnqusTFI9nzrWjUZmCQ7igcXekODZJKcQVT
         lq0UGv2RpT72VOtvkkqNwnSp57DPCLz+UzHHLbKtoXXm3cI6X3KHlzxOO2vBJLF6Jhtg
         +08q9+nPkytcAsdCahdNdcRIDZQnkkkgUZ+me/SStfMC0y8WhcVBRoS+U615yv1StO0s
         NG0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 046/163] powerpc/mm/radix: Split linear mapping on hot-unplug
Date: Wed, 21 Feb 2018 13:47:55 +0100
Message-Id: <20180221124532.939396545@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015510974851849?=
X-GMAIL-MSGID: =?utf-8?q?1593016014987807219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Balbir Singh <bsingharora@gmail.com>

commit 4dd5f8a99e791a8c6500e3592f3ce81ae7edcde1 upstream.

This patch splits the linear mapping if the hot-unplug range is
smaller than the mapping size. The code detects if the mapping needs
to be split into a smaller size and if so, uses the stop machine
infrastructure to clear the existing mapping and then remap the
remaining range using a smaller page size.

The code will skip any region of the mapping that overlaps with kernel
text and warn about it once. We don't want to remove a mapping where
the kernel text and the LMB we intend to remove overlap in the same
TLB mapping as it may affect the currently executing code.

I've tested these changes under a kvm guest with 2 vcpus, from a split
mapping point of view, some of the caveats mentioned above applied to
the testing I did.

Fixes: 4b5d62ca17a1 ("powerpc/mm: add radix__remove_section_mapping()")
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Tweak change log to match updated behaviour]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pgtable-radix.c |   95 +++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 21 deletions(-)

--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -17,6 +17,7 @@
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
+#include <linux/stop_machine.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -671,6 +672,30 @@ static void free_pmd_table(pmd_t *pmd_st
 	pud_clear(pud);
 }
 
+struct change_mapping_params {
+	pte_t *pte;
+	unsigned long start;
+	unsigned long end;
+	unsigned long aligned_start;
+	unsigned long aligned_end;
+};
+
+static int stop_machine_change_mapping(void *data)
+{
+	struct change_mapping_params *params =
+			(struct change_mapping_params *)data;
+
+	if (!data)
+		return -1;
+
+	spin_unlock(&init_mm.page_table_lock);
+	pte_clear(&init_mm, params->aligned_start, params->pte);
+	create_physical_mapping(params->aligned_start, params->start);
+	create_physical_mapping(params->end, params->aligned_end);
+	spin_lock(&init_mm.page_table_lock);
+	return 0;
+}
+
 static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 			     unsigned long end)
 {
@@ -699,6 +724,52 @@ static void remove_pte_table(pte_t *pte_
 	}
 }
 
+/*
+ * clear the pte and potentially split the mapping helper
+ */
+static void split_kernel_mapping(unsigned long addr, unsigned long end,
+				unsigned long size, pte_t *pte)
+{
+	unsigned long mask = ~(size - 1);
+	unsigned long aligned_start = addr & mask;
+	unsigned long aligned_end = addr + size;
+	struct change_mapping_params params;
+	bool split_region = false;
+
+	if ((end - addr) < size) {
+		/*
+		 * We're going to clear the PTE, but not flushed
+		 * the mapping, time to remap and flush. The
+		 * effects if visible outside the processor or
+		 * if we are running in code close to the
+		 * mapping we cleared, we are in trouble.
+		 */
+		if (overlaps_kernel_text(aligned_start, addr) ||
+			overlaps_kernel_text(end, aligned_end)) {
+			/*
+			 * Hack, just return, don't pte_clear
+			 */
+			WARN_ONCE(1, "Linear mapping %lx->%lx overlaps kernel "
+				  "text, not splitting\n", addr, end);
+			return;
+		}
+		split_region = true;
+	}
+
+	if (split_region) {
+		params.pte = pte;
+		params.start = addr;
+		params.end = end;
+		params.aligned_start = addr & ~(size - 1);
+		params.aligned_end = min_t(unsigned long, aligned_end,
+				(unsigned long)__va(memblock_end_of_DRAM()));
+		stop_machine(stop_machine_change_mapping, &params, NULL);
+		return;
+	}
+
+	pte_clear(&init_mm, addr, pte);
+}
+
 static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 			     unsigned long end)
 {
@@ -714,13 +785,7 @@ static void remove_pmd_table(pmd_t *pmd_
 			continue;
 
 		if (pmd_huge(*pmd)) {
-			if (!IS_ALIGNED(addr, PMD_SIZE) ||
-			    !IS_ALIGNED(next, PMD_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
-				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pmd);
+			split_kernel_mapping(addr, end, PMD_SIZE, (pte_t *)pmd);
 			continue;
 		}
 
@@ -745,13 +810,7 @@ static void remove_pud_table(pud_t *pud_
 			continue;
 
 		if (pud_huge(*pud)) {
-			if (!IS_ALIGNED(addr, PUD_SIZE) ||
-			    !IS_ALIGNED(next, PUD_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
-				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pud);
+			split_kernel_mapping(addr, end, PUD_SIZE, (pte_t *)pud);
 			continue;
 		}
 
@@ -777,13 +836,7 @@ static void remove_pagetable(unsigned lo
 			continue;
 
 		if (pgd_huge(*pgd)) {
-			if (!IS_ALIGNED(addr, PGDIR_SIZE) ||
-			    !IS_ALIGNED(next, PGDIR_SIZE)) {
-				WARN_ONCE(1, "%s: unaligned range\n", __func__);
-				continue;
-			}
-
-			pte_clear(&init_mm, addr, (pte_t *)pgd);
+			split_kernel_mapping(addr, end, PGDIR_SIZE, (pte_t *)pgd);
 			continue;
 		}
 
