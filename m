Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69750C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CE120665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CE120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbeK2GIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:08:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:46574 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeK2GIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:08:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 11:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="278381767"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2018 11:06:11 -0800
Subject: [4.19-stable PATCH] dax: Avoid losing wakeup in
 dax_lock_mapping_entry
From:   Dan Williams <dan.j.williams@intel.com>
To:     stable@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 28 Nov 2018 10:53:44 -0800
Message-ID: <154343119877.981933.9776503138356369421.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20181126142743.GA25618@bombadil.infradead.org>
References: <20181126142743.GA25618@bombadil.infradead.org>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <willy@infradead.org>

commit 25bbe21bf427a81b8e3ccd480ea0e1d940256156 upstream.

After calling get_unlocked_entry(), you have to call
put_unlocked_entry() to avoid subsequent waiters losing wakeups.

Fixes: c2a7d2a11552 ("filesystem-dax: Introduce dax_lock_mapping_entry()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Passes the nvdimm unit test suite which exercises the lock path.

 fs/dax.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 0fb270f0a0ef..b0cd1364c68f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -217,6 +217,9 @@ static inline void *unlock_slot(struct address_space *mapping, void **slot)
 	return (void *)entry;
 }
 
+static void put_unlocked_mapping_entry(struct address_space *mapping,
+				       pgoff_t index, void *entry);
+
 /*
  * Lookup entry in radix tree, wait for it to become unlocked if it is
  * exceptional entry and return it. The caller must call
@@ -256,8 +259,10 @@ static void *__get_unlocked_mapping_entry(struct address_space *mapping,
 		revalidate = wait_fn();
 		finish_wait(wq, &ewait.wait);
 		xa_lock_irq(&mapping->i_pages);
-		if (revalidate)
+		if (revalidate) {
+			put_unlocked_mapping_entry(mapping, index, entry);
 			return ERR_PTR(-EAGAIN);
+		}
 	}
 }
 

