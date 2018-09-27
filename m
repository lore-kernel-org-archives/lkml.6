Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C37AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1E7216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1E7216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeI1BIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:08:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeI1BIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:08:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RImXqp129646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:48:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RImXh8129643;
        Thu, 27 Sep 2018 11:48:33 -0700
Date:   Thu, 27 Sep 2018 11:48:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-5c280cf6081ff99078e28b51172d78359f194fd9@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        bin.yang@intel.com, mark.gross@intel.com, hpa@zytor.com,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, bin.yang@intel.com,
          linux-kernel@vger.kernel.org, dave.hansen@intel.com,
          hpa@zytor.com, mingo@kernel.org, mark.gross@intel.com
In-Reply-To: <20180917143546.160867778@linutronix.de>
References: <20180917143546.160867778@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Add large page preservation statistics
Git-Commit-ID: 5c280cf6081ff99078e28b51172d78359f194fd9
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

Commit-ID:  5c280cf6081ff99078e28b51172d78359f194fd9
Gitweb:     https://git.kernel.org/tip/5c280cf6081ff99078e28b51172d78359f194fd9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:12 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:38 +0200

x86/mm/cpa: Add large page preservation statistics

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
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143546.160867778@linutronix.de

---
 arch/x86/Kconfig       |  8 ++++
 arch/x86/mm/pageattr.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..65728bb1182c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1491,6 +1491,14 @@ config X86_DIRECT_GBPAGES
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
 
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 1f2519055b30..cdf52eb86f3a 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -101,6 +101,95 @@ void arch_report_meminfo(struct seq_file *m)
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
@@ -664,10 +753,12 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
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
@@ -732,14 +823,16 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
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
@@ -752,6 +845,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	new_pte = pfn_pte(old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);
 	cpa->flags |= CPA_FLUSHTLB;
+	cpa_inc_lp_preserved(level);
 	return 0;
 }
 
@@ -1341,6 +1435,7 @@ repeat:
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
+		cpa_inc_4k_install();
 		new_prot = static_protections(new_prot, address, pfn, 1,
 					      CPA_PROTECT);
 
