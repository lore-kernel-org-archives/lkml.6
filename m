Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94727C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54258206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54258206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeKUHxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:53:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57488 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeKUHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:53:30 -0500
Received: from 79.184.254.110.ipv4.supernova.orange.pl (79.184.254.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 7659ddb1d131c21d; Tue, 20 Nov 2018 22:22:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devel@linuxdriverproject.org,
        linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 8/8] PM / Hibernate: exclude all PageOffline() pages
Date:   Tue, 20 Nov 2018 22:22:21 +0100
Message-ID: <2319019.tUtE8Aovqd@aspire.rjw.lan>
In-Reply-To: <20181119101616.8901-9-david@redhat.com>
References: <20181119101616.8901-1-david@redhat.com> <20181119101616.8901-9-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 19, 2018 11:16:16 AM CET David Hildenbrand wrote:
> The content of pages that are marked PG_offline is not of interest
> (e.g. inflated by a balloon driver), let's skip these pages.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/power/snapshot.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e6dd57819f..8d7b4d458842 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
>  	BUG_ON(!PageHighMem(page));
>  
>  	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) ||
> -	    PageReserved(page))
> +	    PageReserved(page) || PageOffline(page))
>  		return NULL;
>  
>  	if (page_is_guard(page))
> @@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
>  	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
>  		return NULL;
>  
> +	if (PageOffline(page))
> +		return NULL;
> +
>  	if (PageReserved(page)
>  	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>  		return NULL;
> 


