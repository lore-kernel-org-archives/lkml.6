Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAD_ENC_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59805C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F9320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F9320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeIMS7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:59:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbeIMS7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:59:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 566ADD1B;
        Thu, 13 Sep 2018 13:50:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 099/115] mm: Fix devm_memremap_pages() collision handling
Date:   Thu, 13 Sep 2018 15:31:59 +0200
Message-Id: <20180913131829.501010565@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
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

From: Jan H. Schönherr <jschoenh@amazon.de>

commit 77dd66a3c67c93ab401ccc15efff25578be281fd upstream.

If devm_memremap_pages() detects a collision while adding entries
to the radix-tree, we call pgmap_radix_release(). Unfortunately,
the function removes *all* entries for the range -- including the
entries that caused the collision in the first place.

Modify pgmap_radix_release() to take an additional argument to
indicate where to stop, so that only newly added entries are removed
from the tree.

Cc: <stable@vger.kernel.org>
Fixes: 9476df7d80df ("mm: introduce find_dev_pagemap()")
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/memremap.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -248,13 +248,16 @@ int device_private_entry_fault(struct vm
 EXPORT_SYMBOL(device_private_entry_fault);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
-static void pgmap_radix_release(struct resource *res)
+static void pgmap_radix_release(struct resource *res, unsigned long end_pgoff)
 {
 	unsigned long pgoff, order;
 
 	mutex_lock(&pgmap_lock);
-	foreach_order_pgoff(res, order, pgoff)
+	foreach_order_pgoff(res, order, pgoff) {
+		if (pgoff >= end_pgoff)
+			break;
 		radix_tree_delete(&pgmap_radix, PHYS_PFN(res->start) + pgoff);
+	}
 	mutex_unlock(&pgmap_lock);
 
 	synchronize_rcu();
@@ -309,7 +312,7 @@ static void devm_memremap_pages_release(
 	mem_hotplug_done();
 
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
-	pgmap_radix_release(res);
+	pgmap_radix_release(res, -1);
 	dev_WARN_ONCE(dev, pgmap->altmap && pgmap->altmap->alloc,
 			"%s: failed to free all reserved pages\n", __func__);
 }
@@ -459,7 +462,7 @@ void *devm_memremap_pages(struct device
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
  err_pfn_remap:
  err_radix:
-	pgmap_radix_release(res);
+	pgmap_radix_release(res, pgoff);
 	devres_free(page_map);
 	return ERR_PTR(error);
 }


