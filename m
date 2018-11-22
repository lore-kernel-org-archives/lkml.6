Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7C7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FBE20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FBE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393795AbeKVUpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:45:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387821AbeKVUpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:45:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B36DC04FF86;
        Thu, 22 Nov 2018 10:07:08 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-206.ams2.redhat.com [10.36.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C32B16BE8;
        Thu, 22 Nov 2018 10:07:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        David Hildenbrand <david@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 4/8] xen/balloon: mark inflated pages PG_offline
Date:   Thu, 22 Nov 2018 11:06:23 +0100
Message-Id: <20181122100627.5189-5-david@redhat.com>
In-Reply-To: <20181122100627.5189-1-david@redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 22 Nov 2018 10:07:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark inflated and never onlined pages PG_offline, to tell the world that
the content is stale and should not be dumped.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 12148289debd..14dd6b814db3 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -425,6 +425,7 @@ static int xen_bring_pgs_online(struct page *pg, unsigned int order)
 	for (i = 0; i < size; i++) {
 		p = pfn_to_page(start_pfn + i);
 		__online_page_set_limits(p);
+		__SetPageOffline(p);
 		__balloon_append(p);
 	}
 	mutex_unlock(&balloon_mutex);
@@ -493,6 +494,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 		xenmem_reservation_va_mapping_update(1, &page, &frame_list[i]);
 
 		/* Relinquish the page back to the allocator. */
+		__ClearPageOffline(page);
 		free_reserved_page(page);
 	}
 
@@ -519,6 +521,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 			state = BP_EAGAIN;
 			break;
 		}
+		__SetPageOffline(page);
 		adjust_managed_page_count(page, -1);
 		xenmem_reservation_scrub_page(page);
 		list_add(&page->lru, &pages);
-- 
2.17.2

