Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A7EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBEA217B4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBEA217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeHVFj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 01:39:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:55543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeHVFj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 01:39:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 19:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,272,1531810800"; 
   d="scan'208";a="68089377"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2018 19:16:46 -0700
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.163])
        by linux.intel.com (Postfix) with ESMTP id CD74A5802E1;
        Tue, 21 Aug 2018 19:16:42 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, jglisse@redhat.com,
        yi.z.zhang@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [PATCH V4 1/4] kvm: remove redundant reserved page check
Date:   Wed, 22 Aug 2018 18:55:37 +0800
Message-Id: <26f79872e78cc643937059003763b5cfc1333167.1534934405.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534934405.git.yi.z.zhang@linux.intel.com>
References: <cover.1534934405.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageReserved() is already checked inside kvm_is_reserved_pfn(),
remove it from kvm_set_pfn_dirty().

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Pankaj Gupta <pagupta@redhat.com>
---
 virt/kvm/kvm_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507f..c44c406 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1690,12 +1690,8 @@ EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
 
 void kvm_set_pfn_dirty(kvm_pfn_t pfn)
 {
-	if (!kvm_is_reserved_pfn(pfn)) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (!PageReserved(page))
-			SetPageDirty(page);
-	}
+	if (!kvm_is_reserved_pfn(pfn))
+		SetPageDirty(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
 
-- 
2.7.4

