Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD7FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CACF223C6
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKrEMERx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CACF223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbeKLIS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbeKLISZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E214C21707;
        Sun, 11 Nov 2018 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975310;
        bh=roPN1qjXR5r0ii4knkn98wx1D6rJ9gaNcb+5cVSMLk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKrEMERxqBnbgSa0yJpGOvqP4FETv9Umu4051/UCnhVxdyrOYvLq+b9mxOHD5V2t1
         w35wfcW+2iHjdLr3zk4HFi1cpPSitFgy3TBxI86qZmXW0dKYyGWGjzNG1Xo1BGgTxp
         nNV7IEjQCBVQ2UnIH7n0l7/7LVopHc6KV1ENgR8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 253/361] mm/rmap: map_pte() was not handling private ZONE_DEVICE page properly
Date:   Sun, 11 Nov 2018 14:20:00 -0800
Message-Id: <20181111221653.349434356@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Campbell <rcampbell@nvidia.com>

commit aab8d0520e6e7c2a61f71195e6ce7007a4843afb upstream.

Private ZONE_DEVICE pages use a special pte entry and thus are not
present.  Properly handle this case in map_pte(), it is already handled in
check_pte(), the map_pte() part was lost in some rebase most probably.

Without this patch the slow migration path can not migrate back to any
private ZONE_DEVICE memory to regular memory.  This was found after stress
testing migration back to system memory.  This ultimatly can lead to the
CPU constantly page fault looping on the special swap entry.

Link: http://lkml.kernel.org/r/20181019160442.18723-3-jglisse@redhat.com
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_vma_mapped.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -21,7 +21,29 @@ static bool map_pte(struct page_vma_mapp
 			if (!is_swap_pte(*pvmw->pte))
 				return false;
 		} else {
-			if (!pte_present(*pvmw->pte))
+			/*
+			 * We get here when we are trying to unmap a private
+			 * device page from the process address space. Such
+			 * page is not CPU accessible and thus is mapped as
+			 * a special swap entry, nonetheless it still does
+			 * count as a valid regular mapping for the page (and
+			 * is accounted as such in page maps count).
+			 *
+			 * So handle this special case as if it was a normal
+			 * page mapping ie lock CPU page table and returns
+			 * true.
+			 *
+			 * For more details on device private memory see HMM
+			 * (include/linux/hmm.h or mm/hmm.c).
+			 */
+			if (is_swap_pte(*pvmw->pte)) {
+				swp_entry_t entry;
+
+				/* Handle un-addressable ZONE_DEVICE memory */
+				entry = pte_to_swp_entry(*pvmw->pte);
+				if (!is_device_private_entry(entry))
+					return false;
+			} else if (!pte_present(*pvmw->pte))
 				return false;
 		}
 	}


