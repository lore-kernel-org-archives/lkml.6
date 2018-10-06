Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D3AC67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949322064E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949322064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJGBSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:18:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:9906 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbeJGBSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:18:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2018 11:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,349,1534834800"; 
   d="scan'208";a="80430520"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 06 Oct 2018 11:13:40 -0700
Subject: [PATCH] filesystem-dax: Fix dax_layout_busy_page() livelock
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ross Zwisler <zwisler@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Date:   Sat, 06 Oct 2018 11:01:52 -0700
Message-ID: <153884891237.3128209.14619968108312095820.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the presence of multi-order entries the typical
pagevec_lookup_entries() pattern may loop forever:

	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
				min(end - index, (pgoff_t)PAGEVEC_SIZE),
				indices)) {
		...
		for (i = 0; i < pagevec_count(&pvec); i++) {
			index = indices[i];
			...
		}
		index++; /* BUG */
	}

The loop updates 'index' for each index found and then increments to the
next possible page to continue the lookup. However, if the last entry in
the pagevec is multi-order then the next possible page index is more
than 1 page away. Fix this locally for the filesystem-dax case by
checking for dax-multi-order entries. Going forward new users of
multi-order entries need to be similarly careful, or we need a generic
way to report the page increment in the radix iterator.

Fixes: 5fac7408d828 ("mm, fs, dax: handle layout changes to pinned dax...")
Cc: <stable@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4becbf168b7f..c1472eede1f7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -666,6 +666,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
 				min(end - index, (pgoff_t)PAGEVEC_SIZE),
 				indices)) {
+		pgoff_t nr_pages = 1;
+
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *pvec_ent = pvec.pages[i];
 			void *entry;
@@ -680,8 +682,11 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 
 			xa_lock_irq(&mapping->i_pages);
 			entry = get_unlocked_mapping_entry(mapping, index, NULL);
-			if (entry)
+			if (entry) {
 				page = dax_busy_page(entry);
+				/* account for multi-order entries */
+				nr_pages = 1UL << dax_radix_order(entry);
+			}
 			put_unlocked_mapping_entry(mapping, index, entry);
 			xa_unlock_irq(&mapping->i_pages);
 			if (page)
@@ -696,7 +701,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 		 */
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-		index++;
+		index += nr_pages;
 
 		if (page)
 			break;

