Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B23D208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B23D208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeGNFSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 01:18:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:40757 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeGNFSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 01:18:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 22:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,350,1526367600"; 
   d="scan'208";a="72663942"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2018 21:59:59 -0700
Subject: [PATCH v6 06/13] mm,
 dev_pagemap: Do not clear ->mapping on final put
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Jul 2018 21:50:01 -0700
Message-ID: <153154380137.34503.3754023882460956800.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MEMORY_DEVICE_FS_DAX relies on typical page semantics whereby ->mapping
is only ever cleared by truncation, not final put.

Without this fix dax pages may forget their mapping association at the
end of every page pin event.

Move this atypical behavior that HMM wants into the HMM ->page_free()
callback.

Cc: <stable@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: d2c997c0f145 ("fs, dax: use page->mapping...")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |    1 -
 mm/hmm.c          |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5857267a4af5..62603634a1d2 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -339,7 +339,6 @@ void __put_devmap_managed_page(struct page *page)
 		__ClearPageActive(page);
 		__ClearPageWaiters(page);
 
-		page->mapping = NULL;
 		mem_cgroup_uncharge(page);
 
 		page->pgmap->page_free(page, page->pgmap->data);
diff --git a/mm/hmm.c b/mm/hmm.c
index de7b6bf77201..f9d1d89dec4d 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -963,6 +963,8 @@ static void hmm_devmem_free(struct page *page, void *data)
 {
 	struct hmm_devmem *devmem = data;
 
+	page->mapping = NULL;
+
 	devmem->ops->free(devmem, page);
 }
 

