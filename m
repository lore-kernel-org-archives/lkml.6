Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A937C20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZFnUNmwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A937C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeGCMjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:39:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeGCMj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/WrCVkY4uikGf3ndz9P0gIt116EBsok0tjwC9qaUdnU=; b=ZFnUNmwSG3KwQKlYivQyZI1mR
        UpM2DFMR+a8GYeTvV1eeL3VOMgc9u0h3SGndcehXB0QAs0LV4pm2TncDbQZEoxhEoBpe0kFQxhSS2
        Xsc5n+ykS6zQmC1BeyqUPuc7WTUtiU7yVUVd7AvHxfqP3k8/Q1mM1EIyYkInUWhmCMhhGDOQMOCg+
        2D80NxVRWpLPnkiVRRfSM0BsErkGgyQQnDzppTdVXCL1VvM8L+EKQ3YGf5ykFs1tF7iuOnRT7I4Fo
        1VFrj5IPD3gFT+Bv7WgppSYoyEfhQP0X6QzvcXxY8TnHKoei7BGzfuLQts5sr3JamuRhW3rHR8QS8
        ugEEfdqjQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faKaS-0000aQ-RS; Tue, 03 Jul 2018 12:39:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Subject: [PATCH 2/3] x86: Convert vdso to use vm_fault_t
Date:   Tue,  3 Jul 2018 05:39:09 -0700
Message-Id: <20180703123910.2180-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703123910.2180-1-willy@infradead.org>
References: <20180703123910.2180-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return vm_fault_t codes directly from the appropriate mm routines instead
of converting from errnos ourselves.  Fixes a minor bug where we'd return
SIGBUS instead of the correct OOM code if we ran out of memory allocating
page tables.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 arch/x86/entry/vdso/vma.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556dbb12..d1daa53215a4 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -39,7 +39,7 @@ void __init init_vdso_image(const struct vdso_image *image)
 
 struct linux_binprm;
 
-static int vdso_fault(const struct vm_special_mapping *sm,
+static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
@@ -84,12 +84,11 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static int vvar_fault(const struct vm_special_mapping *sm,
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
 	long sym_offset;
-	int ret = -EFAULT;
 
 	if (!image)
 		return VM_FAULT_SIGBUS;
@@ -108,29 +107,24 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 		return VM_FAULT_SIGBUS;
 
 	if (sym_offset == image->sym_vvar_page) {
-		ret = vm_insert_pfn(vma, vmf->address,
-				    __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
+		return vmf_insert_pfn(vma, vmf->address,
+				__pa_symbol(&__vvar_page) >> PAGE_SHIFT);
 	} else if (sym_offset == image->sym_pvclock_page) {
 		struct pvclock_vsyscall_time_info *pvti =
 			pvclock_get_pvti_cpu0_va();
 		if (pvti && vclock_was_used(VCLOCK_PVCLOCK)) {
-			ret = vm_insert_pfn_prot(
-				vma,
-				vmf->address,
-				__pa(pvti) >> PAGE_SHIFT,
-				pgprot_decrypted(vma->vm_page_prot));
+			return vmf_insert_pfn_prot(vma, vmf->address,
+					__pa(pvti) >> PAGE_SHIFT,
+					pgprot_decrypted(vma->vm_page_prot));
 		}
 	} else if (sym_offset == image->sym_hvclock_page) {
 		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
 
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
-			ret = vm_insert_pfn(vma, vmf->address,
-					    vmalloc_to_pfn(tsc_pg));
+			return vmf_insert_pfn(vma, vmf->address,
+					vmalloc_to_pfn(tsc_pg));
 	}
 
-	if (ret == 0 || ret == -EBUSY)
-		return VM_FAULT_NOPAGE;
-
 	return VM_FAULT_SIGBUS;
 }
 
-- 
2.18.0

