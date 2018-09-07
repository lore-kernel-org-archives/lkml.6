Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF66C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BB420844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BB420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeIHMrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 08:47:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33508 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIHMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 08:47:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27655AA6;
        Sat,  8 Sep 2018 08:02:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 09/89] readahead: stricter check for bdi io_pages
Date:   Fri,  7 Sep 2018 23:09:03 +0200
Message-Id: <20180907210853.681731380@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Stockhausen <stockhausen@collogia.de>

commit dc30b96ab6d569060741572cf30517d3179429a8 upstream.

ondemand_readahead() checks bdi->io_pages to cap the maximum pages
that need to be processed. This works until the readit section. If
we would do an async only readahead (async size = sync size) and
target is at beginning of window we expand the pages by another
get_next_ra_size() pages. Btrace for large reads shows that kernel
always issues a doubled size read at the beginning of processing.
Add an additional check for io_pages in the lower part of the func.
The fix helps devices that hard limit bio pages and rely on proper
handling of max_hw_read_sectors (e.g. older FusionIO cards). For
that reason it could qualify for stable.

Fixes: 9491ae4a ("mm: don't cap request size based on read-ahead setting")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Stockhausen stockhausen@collogia.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/readahead.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -380,6 +380,7 @@ ondemand_readahead(struct address_space
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages = ra->ra_pages;
+	unsigned long add_pages;
 	pgoff_t prev_offset;
 
 	/*
@@ -469,10 +470,17 @@ readit:
 	 * Will this read hit the readahead marker made by itself?
 	 * If so, trigger the readahead marker hit now, and merge
 	 * the resulted next readahead window into the current one.
+	 * Take care of maximum IO pages as above.
 	 */
 	if (offset == ra->start && ra->size == ra->async_size) {
-		ra->async_size = get_next_ra_size(ra, max_pages);
-		ra->size += ra->async_size;
+		add_pages = get_next_ra_size(ra, max_pages);
+		if (ra->size + add_pages <= max_pages) {
+			ra->async_size = add_pages;
+			ra->size += add_pages;
+		} else {
+			ra->size = max_pages;
+			ra->async_size = max_pages >> 1;
+		}
 	}
 
 	return ra_submit(ra, mapping, filp);


