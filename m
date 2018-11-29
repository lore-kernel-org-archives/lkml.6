Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B079205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC0sWipX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B079205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbeK3Bat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731565AbeK3Bas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7D9205C9;
        Thu, 29 Nov 2018 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501516;
        bh=Fyo6NhVPfWvk/rDtcmtmDaQkIdt0Utiu7fkHa9hXILs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uC0sWipX0oFwVTbC0x56hX5TcqlRZt7fa9FDi93KhqvnA/wMWYDsucQB1Tdau/KXz
         HtFpfrkwLhNWFdOIkQ+k4R0o0nxTDVzBrScMze2DUTrbHX7CGbIMdWx1JedGMnzHR+
         ZsbO6o4B+OgfLwmt/GDcFL4cN8FadZgfe4We/Tl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Ido Schimmel <idosch@idosch.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 029/100] mm/memory.c: recheck page table entry with page table lock held
Date:   Thu, 29 Nov 2018 15:11:59 +0100
Message-Id: <20181129140101.264750396@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit ff09d7ec9786be4ad7589aa987d7dc66e2dd9160 upstream.

We clear the pte temporarily during read/modify/write update of the pte.
If we take a page fault while the pte is cleared, the application can get
SIGBUS.  One such case is with remap_pfn_range without a backing
vm_ops->fault callback.  do_fault will return SIGBUS in that case.

cpu 0		 				cpu1
mprotect()
ptep_modify_prot_start()/pte cleared.
.
.						page fault.
.
.
prep_modify_prot_commit()

Fix this by taking page table lock and rechecking for pte_none.

[aneesh.kumar@linux.ibm.com: fix crash observed with syzkaller run]
  Link: http://lkml.kernel.org/r/87va6bwlfg.fsf@linux.ibm.com
Link: http://lkml.kernel.org/r/20180926031858.9692-1-aneesh.kumar@linux.ibm.com
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3697,10 +3697,36 @@ static int do_fault(struct vm_fault *vmf
 	struct vm_area_struct *vma = vmf->vma;
 	int ret;
 
-	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
-	if (!vma->vm_ops->fault)
-		ret = VM_FAULT_SIGBUS;
-	else if (!(vmf->flags & FAULT_FLAG_WRITE))
+	/*
+	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
+	 */
+	if (!vma->vm_ops->fault) {
+		/*
+		 * If we find a migration pmd entry or a none pmd entry, which
+		 * should never happen, return SIGBUS
+		 */
+		if (unlikely(!pmd_present(*vmf->pmd)))
+			ret = VM_FAULT_SIGBUS;
+		else {
+			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
+						       vmf->pmd,
+						       vmf->address,
+						       &vmf->ptl);
+			/*
+			 * Make sure this is not a temporary clearing of pte
+			 * by holding ptl and checking again. A R/M/W update
+			 * of pte involves: take ptl, clearing the pte so that
+			 * we don't have concurrent modification by hardware
+			 * followed by an update.
+			 */
+			if (unlikely(pte_none(*vmf->pte)))
+				ret = VM_FAULT_SIGBUS;
+			else
+				ret = VM_FAULT_NOPAGE;
+
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
+		}
+	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);
 	else if (!(vma->vm_flags & VM_SHARED))
 		ret = do_cow_fault(vmf);


