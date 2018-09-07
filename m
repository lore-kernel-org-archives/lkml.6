Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909EDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BA72077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BA72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbeIGUY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:24:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36657 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbeIGUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIur-00055v-HG; Fri, 07 Sep 2018 17:43:25 +0200
Message-Id: <20180907152054.818570060@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 05/10] x86/mm/cpa: Add large page preservation statistics
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Add-large-page-preservation-statistics.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The large page preservation mechanism is just magic and provides no
information at all. Add optional statistic output in debugfs so the magic can
be evaluated. Defaults is off.

Output:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800770
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig       |    8 +++
 arch/x86/mm/pageattr.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 2 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1495,6 +1495,14 @@ config X86_DIRECT_GBPAGES
 	  supports them), so don't confuse the user by printing
 	  that we have them enabled.
 
+config X86_CPA_STATISTICS
+	bool "Enable statistic for Change Page Attribute"
+	depends on DEBUG_FS
+	---help---
+	  Expose statistics about the Change Page Attribute mechanims, which
+	  helps to determine the effectivness of preserving large and huge
+	  page mappings when mapping protections are changed.
+
 config ARCH_HAS_MEM_ENCRYPT
 	def_bool y
 
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -101,6 +101,95 @@ void arch_report_meminfo(struct seq_file
 static inline void split_page_count(int level) { }
 #endif
 
+#ifdef CONFIG_X86_CPA_STATISTICS
+
+static unsigned long cpa_1g_checked;
+static unsigned long cpa_1g_sameprot;
+static unsigned long cpa_1g_preserved;
+static unsigned long cpa_2m_checked;
+static unsigned long cpa_2m_sameprot;
+static unsigned long cpa_2m_preserved;
+static unsigned long cpa_4k_checked;
+static unsigned long cpa_4k_install;
+
+static inline void cpa_inc_1g_checked(void)
+{
+	cpa_1g_checked++;
+}
+
+static inline void cpa_inc_2m_checked(void)
+{
+	cpa_2m_checked++;
+}
+
+static inline void cpa_inc_4k_checked(void)
+{
+	cpa_4k_checked++;
+}
+
+static inline void cpa_inc_4k_install(void)
+{
+	cpa_4k_install++;
+}
+
+static inline void cpa_inc_lp_sameprot(int level)
+{
+	if (level == PG_LEVEL_1G)
+		cpa_1g_sameprot++;
+	else
+		cpa_2m_sameprot++;
+}
+
+static inline void cpa_inc_lp_preserved(int level)
+{
+	if (level == PG_LEVEL_1G)
+		cpa_1g_preserved++;
+	else
+		cpa_2m_preserved++;
+}
+
+static int cpastats_show(struct seq_file *m, void *p)
+{
+	seq_printf(m, "1G pages checked:     %16lu\n", cpa_1g_checked);
+	seq_printf(m, "1G pages sameprot:    %16lu\n", cpa_1g_sameprot);
+	seq_printf(m, "1G pages preserved:   %16lu\n", cpa_1g_preserved);
+	seq_printf(m, "2M pages checked:     %16lu\n", cpa_2m_checked);
+	seq_printf(m, "2M pages sameprot:    %16lu\n", cpa_2m_sameprot);
+	seq_printf(m, "2M pages preserved:   %16lu\n", cpa_2m_preserved);
+	seq_printf(m, "4K pages checked:     %16lu\n", cpa_4k_checked);
+	seq_printf(m, "4K pages set-checked: %16lu\n", cpa_4k_install);
+	return 0;
+}
+
+static int cpastats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpastats_show, NULL);
+}
+
+static const struct file_operations cpastats_fops = {
+	.open		= cpastats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init cpa_stats_init(void)
+{
+	debugfs_create_file("cpa_stats", S_IRUSR, arch_debugfs_dir, NULL,
+			    &cpastats_fops);
+	return 0;
+}
+late_initcall(cpa_stats_init);
+#else
+static inline void cpa_inc_1g_checked(void) { }
+static inline void cpa_inc_2m_checked(void) { }
+static inline void cpa_inc_4k_checked(void) { }
+static inline void cpa_inc_4k_install(void) { }
+static inline void cpa_inc_lp_sameprot(int level) { }
+static inline void cpa_inc_lp_preserved(int level) { }
+#endif
+
+
 static inline int
 within(unsigned long addr, unsigned long start, unsigned long end)
 {
@@ -660,10 +749,12 @@ static int __should_split_large_page(pte
 	case PG_LEVEL_2M:
 		old_prot = pmd_pgprot(*(pmd_t *)kpte);
 		old_pfn = pmd_pfn(*(pmd_t *)kpte);
+		cpa_inc_2m_checked();
 		break;
 	case PG_LEVEL_1G:
 		old_prot = pud_pgprot(*(pud_t *)kpte);
 		old_pfn = pud_pfn(*(pud_t *)kpte);
+		cpa_inc_1g_checked();
 		break;
 	default:
 		return -EINVAL;
@@ -728,14 +819,16 @@ static int __should_split_large_page(pte
 	for (i = 0, addr = lpaddr; i < numpages; i++, addr += PAGE_SIZE, pfn++) {
 		pgprot_t chk_prot = static_protections(req_prot, addr, pfn, 1,
 						       CPA_DETECT);
-
+		cpa_inc_4k_checked();
 		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
 			return 1;
 	}
 
 	/* If there are no changes, return. */
-	if (pgprot_val(new_prot) == pgprot_val(old_prot))
+	if (pgprot_val(new_prot) == pgprot_val(old_prot)) {
+		cpa_inc_lp_sameprot(level);
 		return 0;
+	}
 
 	/*
 	 * Verify that the address is aligned and the number of pages
@@ -748,6 +841,7 @@ static int __should_split_large_page(pte
 	new_pte = pfn_pte(old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);
 	cpa->flags |= CPA_FLUSHTLB;
+	cpa_inc_lp_preserved(level);
 	return 0;
 }
 
@@ -1337,6 +1431,7 @@ static int __change_page_attr(struct cpa
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
+		cpa_inc_4k_install();
 		new_prot = static_protections(new_prot, address, pfn, 1,
 					      CPA_PROTECT);
 


