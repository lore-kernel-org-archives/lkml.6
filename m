Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33970C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007A7217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498411;
	bh=aFjieyZYYwveOPYqSr/9Es57ygI1lunuUOj0vtRubAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MjGiRTwemYJtRpC0bp2f9bU2qJeS3c3peb/CWkVEw+c/5f0VGdTis1Ius1EU6nVoN
	 RrQBJmfWAPNUFmONsvxvhokvC7nhF+yDFMeG6lKj584EkS89pICRdGDZnQcv8M+g+C
	 aGXYAgAgx288M+4+zoa39QjtKIvThPypCWVswyio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbfBROAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388729AbfBROAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:00:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEED21901;
        Mon, 18 Feb 2019 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498403;
        bh=aFjieyZYYwveOPYqSr/9Es57ygI1lunuUOj0vtRubAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwpgX1lTtQK4iR969mMI814Fxsr7g5XFfyxQer7Y3qtkJv3von0+f1Gvq640x7DCr
         777mxTpY8yvE0LLAgjhZpW4HjHqJk7BDzazZq/9ONu4hmAQ+sA1sVCy0ScUQwB9IaV
         NkrsjMDoi3ysW3jKOjlEJ8NVlDGYzCikqmYKR6uA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 4.9 58/58] mm: stop leaking PageTables
Date:   Mon, 18 Feb 2019 14:44:19 +0100
Message-Id: <20190218133512.824952794@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

commit b0b9b3df27d100a975b4e8818f35382b64a5e35c upstream.

4.10-rc loadtest (even on x86, and even without THPCache) fails with
"fork: Cannot allocate memory" or some such; and /proc/meminfo shows
PageTables growing.

Commit 953c66c2b22a ("mm: THP page cache support for ppc64") that got
merged in rc1 removed the freeing of an unused preallocated pagetable
after do_fault_around() has called map_pages().

This is usually a good optimization, so that the followup doesn't have
to reallocate one; but it's not sufficient to shift the freeing into
alloc_set_pte(), since there are failure cases (most commonly
VM_FAULT_RETRY) which never reach finish_fault().

Check and free it at the outer level in do_fault(), then we don't need
to worry in alloc_set_pte(), and can restore that to how it was (I
cannot find any reason to pte_free() under lock as it was doing).

And fix a separate pagetable leak, or crash, introduced by the same
change, that could only show up on some ppc64: why does do_set_pmd()'s
failure case attempt to withdraw a pagetable when it never deposited
one, at the same time overwriting (so leaking) the vmf->prealloc_pte?
Residue of an earlier implementation, perhaps? Delete it.

Fixes: 953c66c2b22a ("mm: THP page cache support for ppc64")
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3329,15 +3329,24 @@ static int do_fault(struct fault_env *fe
 {
 	struct vm_area_struct *vma = fe->vma;
 	pgoff_t pgoff = linear_page_index(vma, fe->address);
+	int ret;
 
 	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
 	if (!vma->vm_ops->fault)
-		return VM_FAULT_SIGBUS;
-	if (!(fe->flags & FAULT_FLAG_WRITE))
-		return do_read_fault(fe, pgoff);
-	if (!(vma->vm_flags & VM_SHARED))
-		return do_cow_fault(fe, pgoff);
-	return do_shared_fault(fe, pgoff);
+		ret = VM_FAULT_SIGBUS;
+	else if (!(fe->flags & FAULT_FLAG_WRITE))
+		ret = do_read_fault(fe, pgoff);
+	else if (!(vma->vm_flags & VM_SHARED))
+		ret = do_cow_fault(fe, pgoff);
+	else
+		ret = do_shared_fault(fe, pgoff);
+
+	/* preallocated pagetable is unused: free it */
+	if (fe->prealloc_pte) {
+		pte_free(vma->vm_mm, fe->prealloc_pte);
+		fe->prealloc_pte = 0;
+	}
+	return ret;
 }
 
 static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,


