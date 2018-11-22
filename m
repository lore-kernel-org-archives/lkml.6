Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1881DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C4520684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C4520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393827AbeKVUqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:46:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387821AbeKVUqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:46:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3BD3C057F9A;
        Thu, 22 Nov 2018 10:07:19 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-206.ams2.redhat.com [10.36.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76DED28552;
        Thu, 22 Nov 2018 10:07:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        David Hildenbrand <david@redhat.com>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Freche <jfreche@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 6/8] vmw_balloon: mark inflated pages PG_offline
Date:   Thu, 22 Nov 2018 11:06:25 +0100
Message-Id: <20181122100627.5189-7-david@redhat.com>
In-Reply-To: <20181122100627.5189-1-david@redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 22 Nov 2018 10:07:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark inflated and never onlined pages PG_offline, to tell the world that
the content is stale and should not be dumped.

Cc: Xavier Deguillard <xdeguillard@vmware.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julien Freche <jfreche@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Acked-by: Nadav Amit <namit@vmware.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/misc/vmw_balloon.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index e6126a4b95d3..877611b5659b 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -556,6 +556,36 @@ vmballoon_page_in_frames(enum vmballoon_page_size_type page_size)
 	return 1 << vmballoon_page_order(page_size);
 }
 
+/**
+ * vmballoon_mark_page_offline() - mark a page as offline
+ * @page: pointer for the page.
+ * @page_size: the size of the page.
+ */
+static void
+vmballoon_mark_page_offline(struct page *page,
+			    enum vmballoon_page_size_type page_size)
+{
+	int i;
+
+	for (i = 0; i < vmballoon_page_in_frames(page_size); i++)
+		__SetPageOffline(page + i);
+}
+
+/**
+ * vmballoon_mark_page_online() - mark a page as online
+ * @page: pointer for the page.
+ * @page_size: the size of the page.
+ */
+static void
+vmballoon_mark_page_online(struct page *page,
+			   enum vmballoon_page_size_type page_size)
+{
+	int i;
+
+	for (i = 0; i < vmballoon_page_in_frames(page_size); i++)
+		__ClearPageOffline(page + i);
+}
+
 /**
  * vmballoon_send_get_target() - Retrieve desired balloon size from the host.
  *
@@ -612,6 +642,7 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
 					 ctl->page_size);
 
 		if (page) {
+			vmballoon_mark_page_offline(page, ctl->page_size);
 			/* Success. Add the page to the list and continue. */
 			list_add(&page->lru, &ctl->pages);
 			continue;
@@ -850,6 +881,7 @@ static void vmballoon_release_page_list(struct list_head *page_list,
 
 	list_for_each_entry_safe(page, tmp, page_list, lru) {
 		list_del(&page->lru);
+		vmballoon_mark_page_online(page, page_size);
 		__free_pages(page, vmballoon_page_order(page_size));
 	}
 
-- 
2.17.2

