Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8068DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E0A2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfA1WxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:53:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1WxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:53:11 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A1EA1DFA;
        Mon, 28 Jan 2019 22:53:10 +0000 (UTC)
Date:   Mon, 28 Jan 2019 14:53:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: Re: [PATCH] mm,memory_hotplug: Fix scan_movable_pages for gigantic
 hugepages
Message-Id: <20190128145309.c7dcf075b469d6a54694327d@linux-foundation.org>
In-Reply-To: <20190125075830.6mqw2io4rwz7wxx5@d104.suse.de>
References: <20190122154407.18417-1-osalvador@suse.de>
        <5368e2b4-5aca-40dd-fe18-67d861a04a29@redhat.com>
        <20190125075830.6mqw2io4rwz7wxx5@d104.suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 08:58:33 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> On Wed, Jan 23, 2019 at 11:33:56AM +0100, David Hildenbrand wrote:
> > If you use {} for the else case, please also do so for the if case.
> 
> Diff on top:
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 25aee4f04a72..d5810e522b72 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1338,9 +1338,9 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  				struct page *head = compound_head(page);
>  
>  				if (hugepage_migration_supported(page_hstate(head)) &&
> -				    page_huge_active(head))
> +				    page_huge_active(head)) {
>  					return pfn;
> -				else {
> +				} else {
>  					unsigned long skip;
>  
>  					skip = (1 << compound_order(head)) - (page - head);
> 

The indenting is getting a bit deep also, so how about this?

static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
{
	unsigned long pfn;

	for (pfn = start; pfn < end; pfn++) {
		struct page *page, *head;
	
		if (!pfn_valid(pfn))
			continue;
		page = pfn_to_page(pfn);
		if (PageLRU(page))
			return pfn;
		if (__PageMovable(page))
			return pfn;

		if (!PageHuge(page))
			continue;
		head = compound_head(page);
		if (hugepage_migration_supported(page_hstate(head)) &&
		    page_huge_active(head)) {
			return pfn;
		} else {
			unsigned long skip;

			skip = (1 << compound_order(head)) - (page - head);
			pfn += skip - 1;
		}
	}
	return 0;
}


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mmmemory_hotplug-fix-scan_movable_pages-for-gigantic-hugepages-fix

fix brace layout, per David.  Also reduce indentation

Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory_hotplug.c |   38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

--- a/mm/memory_hotplug.c~mmmemory_hotplug-fix-scan_movable_pages-for-gigantic-hugepages-fix
+++ a/mm/memory_hotplug.c
@@ -1305,27 +1305,29 @@ int test_pages_in_a_zone(unsigned long s
 static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 {
 	unsigned long pfn;
-	struct page *page;
+
 	for (pfn = start; pfn < end; pfn++) {
-		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-			if (PageLRU(page))
-				return pfn;
-			if (__PageMovable(page))
-				return pfn;
-			if (PageHuge(page)) {
-				struct page *head = compound_head(page);
+		struct page *page, *head;
+	
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		if (PageLRU(page))
+			return pfn;
+		if (__PageMovable(page))
+			return pfn;
 
-				if (hugepage_migration_supported(page_hstate(head)) &&
-				    page_huge_active(head))
-					return pfn;
-				else {
-					unsigned long skip;
+		if (!PageHuge(page))
+			continue;
+		head = compound_head(page);
+		if (hugepage_migration_supported(page_hstate(head)) &&
+		    page_huge_active(head)) {
+			return pfn;
+		} else {
+			unsigned long skip;
 
-					skip = (1 << compound_order(head)) - (page - head);
-					pfn += skip - 1;
-				}
-			}
+			skip = (1 << compound_order(head)) - (page - head);
+			pfn += skip - 1;
 		}
 	}
 	return 0;
_

