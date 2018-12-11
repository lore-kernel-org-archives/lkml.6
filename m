Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C78C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3DA2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544539017;
	bh=IzvH8yP63RIekSWqCQZI3r7xwGN0GbzCyIukRGB+NYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tfSSJl+qWSKv/GD5O4RMx4GsJfJULs+MUEdq6w9Vqa7kr1dJQFk1X5OKNKyI2hPMP
	 T/2GnKLm1Q5UiBQp5F8Zo1vvTnv8O/MdRJqFcQXgH6S4n0MZrG/CzkCYcEqrPzFHwA
	 i137eSHOkIAHuNj9GngzH2Fx8ZsY0329yurOLJuo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3DA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeLKOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:36:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43265 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeLKOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:36:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so12692888eds.10;
        Tue, 11 Dec 2018 06:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yn8BR9+lOdEHj+S5k9LAQxa/vCvc2yI6zMn2XkSMhkk=;
        b=pR89bcGcyyslirRnRp4PTkTq/iOj0Kwf31Im4sOzpJcSnZWKnpsQf1ZC76pFxZWsPA
         f18dtA4kzSVbN87ef5ALmCvdhoJoS0aDnBefgMa7MswofZk5CAMJfak1E49QPWTWbsN/
         mYb3VWVjR9ImcxvbuGzZ+B9bhLWZ2kybcWcEOc6B0Zk5Ai8LFMYOSrdg4mURBzXSxDRR
         qXxhDbjJ1tBS14PS+CyR3BRsJsfZ13Bma+GEkPutABE9RSbFTYGz+gj2dnggg9ixySzc
         v5eQYDKlHhSqydi6vAwMog5iByqo1GKHYmBMkD+x8VKnvS5eUxlGuOIKTbq+oTmEe3QV
         7aRQ==
X-Gm-Message-State: AA+aEWY294LWMeAuIU7foMVnZr1LUYV93IRCfzBghJW6A4lSCFC1XO+0
        XlBJlkxTUkxIrFwnsP5X4fQ=
X-Google-Smtp-Source: AFSGD/XQtXKp80kyJgHG6zCu7EpQG1LyRcH24eBYdiHl4bEw5TigaHZwZOfm+qG1WuSdxmWMS2ZO4w==
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr12587443ejc.126.1544539011161;
        Tue, 11 Dec 2018 06:36:51 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z40sm4017084edz.86.2018.12.11.06.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:36:50 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/3] mm, thp, proc: report THP eligibility for each vma
Date:   Tue, 11 Dec 2018 15:36:40 +0100
Message-Id: <20181211143641.3503-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211143641.3503-1-mhocko@kernel.org>
References: <20181211143641.3503-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Userspace falls short when trying to find out whether a specific memory
range is eligible for THP. There are usecases that would like to know
that
http://lkml.kernel.org/r/alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com
: This is used to identify heap mappings that should be able to fault thp
: but do not, and they normally point to a low-on-memory or fragmentation
: issue.

The only way to deduce this now is to query for hg resp. nh flags and
confronting the state with the global setting. Except that there is
also PR_SET_THP_DISABLE that might change the picture. So the final
logic is not trivial. Moreover the eligibility of the vma depends on
the type of VMA as well. In the past we have supported only anononymous
memory VMAs but things have changed and shmem based vmas are supported
as well these days and the query logic gets even more complicated
because the eligibility depends on the mount option and another global
configuration knob.

Simplify the current state and report the THP eligibility in
/proc/<pid>/smaps for each existing vma. Reuse transparent_hugepage_enabled
for this purpose. The original implementation of this function assumes
that the caller knows that the vma itself is supported for THP so make
the core checks into __transparent_hugepage_enabled and use it for
existing callers. __show_smap just use the new transparent_hugepage_enabled
which also checks the vma support status (please note that this one has
to be out of line due to include dependency issues).

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/filesystems/proc.txt |  3 +++
 fs/proc/task_mmu.c                 |  2 ++
 include/linux/huge_mm.h            | 13 ++++++++++++-
 mm/huge_memory.c                   | 12 +++++++++++-
 mm/memory.c                        |  4 ++--
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 2a4e63f5122c..cd465304bec4 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -425,6 +425,7 @@ SwapPss:               0 kB
 KernelPageSize:        4 kB
 MMUPageSize:           4 kB
 Locked:                0 kB
+THPeligible:           0
 VmFlags: rd ex mr mw me dw
 
 the first of these lines shows the same information as is displayed for the
@@ -462,6 +463,8 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
 "SwapPss" shows proportional swap share of this mapping. Unlike "Swap", this
 does not take into account swapped out page of underlying shmem objects.
 "Locked" indicates whether the mapping is locked in memory or not.
+"THPeligible" indicates whether the mapping is eligible for THP pages - 1 if
+true, 0 otherwise.
 
 "VmFlags" field deserves a separate description. This member represents the kernel
 flags associated with the particular virtual memory area in two letter encoded
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 47c3764c469b..c9f160eb9fbc 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -790,6 +790,8 @@ static int show_smap(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss);
 
+	seq_printf(m, "THPeligible:    %d\n", transparent_hugepage_enabled(vma));
+
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
 	show_smap_vma_flags(m, vma);
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4663ee96cf59..381e872bfde0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -93,7 +93,11 @@ extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
 
 extern unsigned long transparent_hugepage_flags;
 
-static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
+/*
+ * to be used on vmas which are known to support THP.
+ * Use transparent_hugepage_enabled otherwise
+ */
+static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & VM_NOHUGEPAGE)
 		return false;
@@ -117,6 +121,8 @@ static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
+bool transparent_hugepage_enabled(struct vm_area_struct *vma);
+
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
@@ -257,6 +263,11 @@ static inline bool thp_migration_supported(void)
 
 #define hpage_nr_pages(x) 1
 
+static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	return false;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 55478ab3c83b..f64733c23067 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -62,6 +62,16 @@ static struct shrinker deferred_split_shrinker;
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 
+bool transparent_hugepage_enabled(struct vm_area_struct *vma)
+{
+	if (vma_is_anonymous(vma))
+		return __transparent_hugepage_enabled(vma);
+	if (shmem_mapping(vma->vm_file->f_mapping) && shmem_huge_enabled(vma))
+		return __transparent_hugepage_enabled(vma);
+
+	return false;
+}
+
 static struct page *get_huge_zero_page(void)
 {
 	struct page *zero_page;
@@ -1303,7 +1313,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 	get_page(page);
 	spin_unlock(vmf->ptl);
 alloc:
-	if (transparent_hugepage_enabled(vma) &&
+	if (__transparent_hugepage_enabled(vma) &&
 	    !transparent_hugepage_debug_cow()) {
 		huge_gfp = alloc_hugepage_direct_gfpmask(vma, haddr);
 		new_page = alloc_pages_vma(huge_gfp, HPAGE_PMD_ORDER, vma,
diff --git a/mm/memory.c b/mm/memory.c
index 4ad2d293ddc2..3c2716ec7fbd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3830,7 +3830,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	vmf.pud = pud_alloc(mm, p4d, address);
 	if (!vmf.pud)
 		return VM_FAULT_OOM;
-	if (pud_none(*vmf.pud) && transparent_hugepage_enabled(vma)) {
+	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -3856,7 +3856,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	vmf.pmd = pmd_alloc(mm, vmf.pud, address);
 	if (!vmf.pmd)
 		return VM_FAULT_OOM;
-	if (pmd_none(*vmf.pmd) && transparent_hugepage_enabled(vma)) {
+	if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
 		ret = create_huge_pmd(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
-- 
2.19.2

