Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51DEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D73420831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D73420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393744AbeKVUp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387821AbeKVUp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:45:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3286D81F10;
        Thu, 22 Nov 2018 10:06:41 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-206.ams2.redhat.com [10.36.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A09E16BE8;
        Thu, 22 Nov 2018 10:06:37 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/8] mm: balloon: update comment about isolation/migration/compaction
Date:   Thu, 22 Nov 2018 11:06:20 +0100
Message-Id: <20181122100627.5189-2-david@redhat.com>
In-Reply-To: <20181122100627.5189-1-david@redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 22 Nov 2018 10:06:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
feature") reworked balloon handling to make use of the general
non-lru movable page feature. The big comment block in
balloon_compaction.h contains quite some outdated information. Let's fix
this.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 53051f3d8f25..cbe50da5a59d 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -4,15 +4,18 @@
  *
  * Common interface definitions for making balloon pages movable by compaction.
  *
- * Despite being perfectly possible to perform ballooned pages migration, they
- * make a special corner case to compaction scans because balloon pages are not
- * enlisted at any LRU list like the other pages we do compact / migrate.
+ * Balloon page migration makes use of the general non-lru movable page
+ * feature.
+ *
+ * page->private is used to reference the responsible balloon device.
+ * page->mapping is used in context of non-lru page migration to reference
+ * the address space operations for page isolation/migration/compaction.
  *
  * As the page isolation scanning step a compaction thread does is a lockless
  * procedure (from a page standpoint), it might bring some racy situations while
  * performing balloon page compaction. In order to sort out these racy scenarios
  * and safely perform balloon's page compaction and migration we must, always,
- * ensure following these three simple rules:
+ * ensure following these simple rules:
  *
  *   i. when updating a balloon's page ->mapping element, strictly do it under
  *      the following lock order, independently of the far superior
@@ -21,19 +24,8 @@
  *	      +--spin_lock_irq(&b_dev_info->pages_lock);
  *	            ... page->mapping updates here ...
  *
- *  ii. before isolating or dequeueing a balloon page from the balloon device
- *      pages list, the page reference counter must be raised by one and the
- *      extra refcount must be dropped when the page is enqueued back into
- *      the balloon device page list, thus a balloon page keeps its reference
- *      counter raised only while it is under our special handling;
- *
- * iii. after the lockless scan step have selected a potential balloon page for
- *      isolation, re-test the PageBalloon mark and the PagePrivate flag
- *      under the proper page lock, to ensure isolating a valid balloon page
- *      (not yet isolated, nor under release procedure)
- *
- *  iv. isolation or dequeueing procedure must clear PagePrivate flag under
- *      page lock together with removing page from balloon device page list.
+ *  ii. isolation or dequeueing procedure must remove the page from balloon
+ *      device page list under b_dev_info->pages_lock.
  *
  * The functions provided by this interface are placed to help on coping with
  * the aforementioned balloon page corner case, as well as to ensure the simple
-- 
2.17.2

