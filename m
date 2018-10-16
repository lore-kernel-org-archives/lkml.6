Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7364C5ACC8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E88421476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyejWFpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E88421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeJQBHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbeJQBHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:07:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA102098A;
        Tue, 16 Oct 2018 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710187;
        bh=sGJWfwQgKCWgJoO5oPMTZRhEEQeivGN24h4iap2Op/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OyejWFpBQ1JtYl6Lz4XhEPidkOVBlYP5PA3DZfSlOAAJoK/aVUkR5E2LfniLd55ek
         wkDawr0GgDfe6VYH2ndJU1wt8LVmF2rBLzqcxtEl44OKtKAB9z3PiWFnaGBfkUr6gw
         ifFR0LYtfVg92Fye9/8M1gXpsjnkc5Scs8RBxz2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.18 133/135] filesystem-dax: Fix dax_layout_busy_page() livelock
Date:   Tue, 16 Oct 2018 19:06:03 +0200
Message-Id: <20181016170524.437414404@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit d7782145e1ad537df4ce74e58c50f1f732a1462d upstream.

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
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dax.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -558,6 +558,8 @@ struct page *dax_layout_busy_page(struct
 	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
 				min(end - index, (pgoff_t)PAGEVEC_SIZE),
 				indices)) {
+		pgoff_t nr_pages = 1;
+
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *pvec_ent = pvec.pages[i];
 			void *entry;
@@ -571,8 +573,15 @@ struct page *dax_layout_busy_page(struct
 
 			xa_lock_irq(&mapping->i_pages);
 			entry = get_unlocked_mapping_entry(mapping, index, NULL);
-			if (entry)
+			if (entry) {
 				page = dax_busy_page(entry);
+				/*
+				 * Account for multi-order entries at
+				 * the end of the pagevec.
+				 */
+				if (i + 1 >= pagevec_count(&pvec))
+					nr_pages = 1UL << dax_radix_order(entry);
+			}
 			put_unlocked_mapping_entry(mapping, index, entry);
 			xa_unlock_irq(&mapping->i_pages);
 			if (page)
@@ -580,7 +589,7 @@ struct page *dax_layout_busy_page(struct
 		}
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
-		index++;
+		index += nr_pages;
 
 		if (page)
 			break;


