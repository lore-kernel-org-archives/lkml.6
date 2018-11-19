Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96668C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68755206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68755206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeKSUkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:40:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeKSUkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:40:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F26A307D842;
        Mon, 19 Nov 2018 10:17:22 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6B8105706D;
        Mon, 19 Nov 2018 10:17:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        David Hildenbrand <david@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v1 8/8] PM / Hibernate: exclude all PageOffline() pages
Date:   Mon, 19 Nov 2018 11:16:16 +0100
Message-Id: <20181119101616.8901-9-david@redhat.com>
In-Reply-To: <20181119101616.8901-1-david@redhat.com>
References: <20181119101616.8901-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 19 Nov 2018 10:17:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The content of pages that are marked PG_offline is not of interest
(e.g. inflated by a balloon driver), let's skip these pages.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/power/snapshot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 87e6dd57819f..8d7b4d458842 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 	BUG_ON(!PageHighMem(page));
 
 	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) ||
-	    PageReserved(page))
+	    PageReserved(page) || PageOffline(page))
 		return NULL;
 
 	if (page_is_guard(page))
@@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
 		return NULL;
 
+	if (PageOffline(page))
+		return NULL;
+
 	if (PageReserved(page)
 	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
 		return NULL;
-- 
2.17.2

