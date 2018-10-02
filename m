Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD66CC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DE72083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DE72083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeJBUNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbeJBUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:04 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C54CB2F;
        Tue,  2 Oct 2018 13:29:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.18 159/228] filesystem-dax: Fix use of zero page
Date:   Tue,  2 Oct 2018 06:24:16 -0700
Message-Id: <20181002132509.643706157@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <willy@infradead.org>

commit b90ca5cc32f59bb214847c6855959702f00c6801 upstream.

Use my_zero_pfn instead of ZERO_PAGE(), and pass the vaddr to it instead
of zero so it works on MIPS and s390 who reference the vaddr to select a
zero page.

Cc: <stable@vger.kernel.org>
Fixes: 91d25ba8a6b0 ("dax: use common 4k zero page for dax mmap reads")
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dax.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1007,21 +1007,12 @@ static vm_fault_t dax_load_hole(struct a
 {
 	struct inode *inode = mapping->host;
 	unsigned long vaddr = vmf->address;
-	vm_fault_t ret = VM_FAULT_NOPAGE;
-	struct page *zero_page;
-	pfn_t pfn;
+	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	vm_fault_t ret;
 
-	zero_page = ZERO_PAGE(0);
-	if (unlikely(!zero_page)) {
-		ret = VM_FAULT_OOM;
-		goto out;
-	}
-
-	pfn = page_to_pfn_t(zero_page);
 	dax_insert_mapping_entry(mapping, vmf, entry, pfn, RADIX_DAX_ZERO_PAGE,
 			false);
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
-out:
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }


