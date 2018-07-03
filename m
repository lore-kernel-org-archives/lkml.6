Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04132C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FF720C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KIEqysPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FF720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932208AbeGCMjc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:39:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbeGCMj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qpR175dH0b8mSDZMh4NGSB2TmMAnlxiIqkDNzRt2jT8=; b=KIEqysPUAjyYrty+5Rstd2b6D
        jHv9RNT//sS7OkwySREpQZ0qeCH+xM5kwvJ+O8ccx39007vjqwoaikj5pVTS+NjxPLyPxAwFgmZyc
        6tfA/FyHmAUsgB2rc3zxot0NJfKzw5p/GlIxu3NjDNfGonAzEWKVemzC+a/JTguNhV9HRzGEp0mu+
        da2oUKpFwd1kzef3ouWdOUzQ3qVtmkImn1AEHH3kzetCZFGvopWvEr30o1Syz5mIBtAgpHxNH8dim
        tof/I2bGMQ1l9mthwSLyYmEUexlQM9ZDNv0fMZ4SDCmp53b+lm/SdKYKz5h/fAFswhEBAkGLOTIUj
        qW2YdcsGg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faKaS-0000aN-Kg; Tue, 03 Jul 2018 12:39:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Subject: [PATCH 1/3] mm: Introduce vmf_insert_pfn_prot
Date:   Tue,  3 Jul 2018 05:39:08 -0700
Message-Id: <20180703123910.2180-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like vm_insert_pfn_prot(), but returns a vm_fault_t instead of an errno.
Also unexport vm_insert_pfn_prot as it has no modular users.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 47 ++++++++++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1a9d6bd97f00..3cb763a38642 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2441,6 +2441,8 @@ int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
+vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot);
 int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
diff --git a/mm/memory.c b/mm/memory.c
index b9ebd883e27c..caecb4d995ac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1852,21 +1852,6 @@ int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_pfn);
 
-/**
- * vm_insert_pfn_prot - insert single pfn into user vma with specified pgprot
- * @vma: user vma to map to
- * @addr: target user address of this page
- * @pfn: source kernel pfn
- * @pgprot: pgprot flags for the inserted page
- *
- * This is exactly like vm_insert_pfn, except that it allows drivers to
- * to override pgprot on a per-page basis.
- *
- * This only makes sense for IO mappings, and it makes no sense for
- * cow mappings.  In general, using multiple vmas is preferable;
- * vm_insert_pfn_prot should only be used if using multiple VMAs is
- * impractical.
- */
 int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot)
 {
@@ -1893,7 +1878,37 @@ int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	return ret;
 }
-EXPORT_SYMBOL(vm_insert_pfn_prot);
+
+/**
+ * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @pgprot: pgprot flags for the inserted page
+ *
+ * This is exactly like vmf_insert_pfn(), except that it allows drivers to
+ * to override pgprot on a per-page basis.
+ *
+ * This only makes sense for IO mappings, and it makes no sense for
+ * COW mappings.  In general, using multiple vmas is preferable;
+ * vm_insert_pfn_prot should only be used if using multiple VMAs is
+ * impractical.
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot)
+{
+	int err = vm_insert_pfn_prot(vma, addr, pfn, pgprot);
+
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
 static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 {
-- 
2.18.0

