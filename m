Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0431AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29822081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29822081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLCTZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:25:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:5026 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLCTZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:25:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 11:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="97705143"
Received: from ahduyck-desk1.amr.corp.intel.com ([10.7.198.76])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2018 11:25:36 -0800
Subject: [PATCH RFC 3/3] kvm: Add additional check to determine if a page is
 refcounted
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     dan.j.williams@intel.com, pbonzini@redhat.com,
        yi.z.zhang@linux.intel.com, brho@google.com, kvm@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.jiang@intel.com, yu.c.zhang@intel.com, pagupta@redhat.com,
        david@redhat.com, jack@suse.cz, hch@lst.de, rkrcmar@redhat.com,
        jglisse@redhat.com
Date:   Mon, 03 Dec 2018 11:25:36 -0800
Message-ID: <154386513636.27193.9038916677163713072.stgit@ahduyck-desk1.amr.corp.intel.com>
In-Reply-To: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kvm_is_refcounted_page is used primarily to determine if KVM
is allowed to take a reference on the page. It was using the PG_reserved
flag to determine this previously, however in the case of DAX the page has
the PG_reserved flag set, but supports pinning by taking a reference on
the page. As such I have updated the check to add a special case for
ZONE_DEVICE pages that have the new support_refcount_pinning flag set.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 virt/kvm/kvm_main.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5e666df5666d..2e7e9fbb67bf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -148,8 +148,20 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 
 bool kvm_is_refcounted_pfn(kvm_pfn_t pfn)
 {
-	if (pfn_valid(pfn))
-		return !PageReserved(pfn_to_page(pfn));
+	if (pfn_valid(pfn)) {
+		struct page *page = pfn_to_page(pfn);
+
+		/*
+		 * The reference count for MMIO pages are not updated.
+		 * Previously this was being tested for with just the
+		 * PageReserved check, however now ZONE_DEVICE pages may
+		 * also allow for the refcount to be updated for the sake
+		 * of pinning the pages so use the additional check provided
+		 * to determine if the reference count on the page can be
+		 * used to pin it.
+		 */
+		return !PageReserved(page) || is_device_pinnable_page(page);
+	}
 
 	return false;
 }

