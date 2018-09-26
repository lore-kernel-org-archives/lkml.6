Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F0AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61AE2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61AE2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeI0BbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:31:09 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25069 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbeI0B3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:29:38 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 26 Sep 2018 12:15:05 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8FB3DB0E86;
        Wed, 26 Sep 2018 15:15:09 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 07/20] vmw_balloon: treat all refused pages equally
Date:   Wed, 26 Sep 2018 12:13:23 -0700
Message-ID: <20180926191336.101885-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when the hypervisor rejects a page during lock operation, the
VM treats pages differently according to the error-code: in certain
cases the page is immediately freed, and in others it is put on a
rejection list and only freed later.

The behavior does not make too much sense. If the page is freed
immediately it is very likely to be used again in the next batch of
allocations, and be rejected again.

In addition, for support of compaction and OOM notifiers, we wish to
separate the logic that communicates with the hypervisor (as well as
analyzes the status of each page) from the logic that allocates or free
pages.

Treat all errors the same way, queuing the pages on the refuse list.
Move to the next allocation size (4k) when too many pages are refused.
Free the refused pages when moving to the next size to avoid situations
in which too much memory is waiting to be freed on the refused list.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 52 +++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 96dde120bbd5..4e067d269706 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -543,29 +543,13 @@ static int vmballoon_lock(struct vmballoon *b, unsigned int num_pages,
 		/* Error occurred */
 		STATS_INC(b->stats.refused_alloc[is_2m_pages]);
 
-		switch (status) {
-		case VMW_BALLOON_ERROR_PPN_PINNED:
-		case VMW_BALLOON_ERROR_PPN_INVALID:
-			/*
-			 * Place page on the list of non-balloonable pages
-			 * and retry allocation, unless we already accumulated
-			 * too many of them, in which case take a breather.
-			 */
-			if (page_size->n_refused_pages
-					< VMW_BALLOON_MAX_REFUSED) {
-				list_add(&p->lru, &page_size->refused_pages);
-				page_size->n_refused_pages++;
-				break;
-			}
-			/* Fallthrough */
-		case VMW_BALLOON_ERROR_RESET:
-		case VMW_BALLOON_ERROR_PPN_NOTNEEDED:
-			vmballoon_free_page(p, is_2m_pages);
-			break;
-		default:
-			/* This should never happen */
-			WARN_ON_ONCE(true);
-		}
+		/*
+		 * Place page on the list of non-balloonable pages
+		 * and retry allocation, unless we already accumulated
+		 * too many of them, in which case take a breather.
+		 */
+		list_add(&p->lru, &page_size->refused_pages);
+		page_size->n_refused_pages++;
 	}
 
 	return batch_status == VMW_BALLOON_SUCCESS ? 0 : -EIO;
@@ -712,9 +696,31 @@ static void vmballoon_inflate(struct vmballoon *b)
 
 		vmballoon_add_page(b, num_pages++, page);
 		if (num_pages == b->batch_max_pages) {
+			struct vmballoon_page_size *page_size =
+					&b->page_sizes[is_2m_pages];
+
 			error = vmballoon_lock(b, num_pages, is_2m_pages);
 
 			num_pages = 0;
+
+			/*
+			 * Stop allocating this page size if we already
+			 * accumulated too many pages that the hypervisor
+			 * refused.
+			 */
+			if (page_size->n_refused_pages >=
+			    VMW_BALLOON_MAX_REFUSED) {
+				if (!is_2m_pages)
+					break;
+
+				/*
+				 * Release the refused pages as we move to 4k
+				 * pages.
+				 */
+				vmballoon_release_refused_pages(b, true);
+				is_2m_pages = true;
+			}
+
 			if (error)
 				break;
 		}
-- 
2.17.1

