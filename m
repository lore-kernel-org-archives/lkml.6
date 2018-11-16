Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE748C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D07208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D07208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbeKPRcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:32:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:42190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeKPRcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:32:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31FB4ADF4;
        Fri, 16 Nov 2018 07:21:24 +0000 (UTC)
Date:   Fri, 16 Nov 2018 08:21:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] mm, memory_hotplug: be more verbose for memory
 offline failures
Message-ID: <20181116072123.GA14706@dhcp22.suse.cz>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-6-mhocko@kernel.org>
 <20181115160716.18b9956ee64932abe9428ef1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181115160716.18b9956ee64932abe9428ef1@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 16:07:16, Andrew Morton wrote:
> On Wed,  7 Nov 2018 11:18:30 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > There is only very limited information printed when the memory offlining
> > fails:
> > [ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed due to signal backoff
> > 
> > This tells us that the failure is triggered by the userspace
> > intervention but it doesn't tell us much more about the underlying
> > reason. It might be that the page migration failes repeatedly and the
> > userspace timeout expires and send a signal or it might be some of the
> > earlier steps (isolation, memory notifier) takes too long.
> > 
> > If the migration failes then it would be really helpful to see which
> > page that and its state. The same applies to the isolation phase. If we
> > fail to isolate a page from the allocator then knowing the state of the
> > page would be helpful as well.
> > 
> > Dump the page state that fails to get isolated or migrated. This will
> > tell us more about the failure and what to focus on during debugging.
> > 
> > ...
> >
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1388,10 +1388,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> >  						    page_is_file_cache(page));
> >  
> >  		} else {
> > -#ifdef CONFIG_DEBUG_VM
> > -			pr_alert("failed to isolate pfn %lx\n", pfn);
> > +			pr_warn("failed to isolate pfn %lx\n", pfn);
> >  			dump_page(page, "isolation failed");
> > -#endif
> >  			put_page(page);
> >  			/* Because we don't have big zone->lock. we should
> >  			   check this again here. */
> > @@ -1411,8 +1409,14 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> >  		/* Allocate a new page from the nearest neighbor node */
> >  		ret = migrate_pages(&source, new_node_page, NULL, 0,
> >  					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> > -		if (ret)
> > +		if (ret) {
> > +			list_for_each_entry(page, &source, lru) {
> > +				pr_warn("migrating pfn %lx failed ",
> > +				       page_to_pfn(page), ret);
> > +				dump_page(page, NULL);
> > +			}
> 
> ./include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
>  #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                   ^
> ./include/linux/kern_levels.h:12:22: note: in expansion of macro ‘KERN_SOH’
>  #define KERN_WARNING KERN_SOH "4" /* warning conditions */
>                       ^~~~~~~~
> ./include/linux/printk.h:310:9: note: in expansion of macro ‘KERN_WARNING’
>   printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>          ^~~~~~~~~~~~
> ./include/linux/printk.h:311:17: note: in expansion of macro ‘pr_warning’
>  #define pr_warn pr_warning
>                  ^~~~~~~~~~
> mm/memory_hotplug.c:1414:5: note: in expansion of macro ‘pr_warn’
>      pr_warn("migrating pfn %lx failed ",
>      ^~~~~~~

yeah, 0day already complained and I've posted a follow up fix
http://lkml.kernel.org/r/20181108081231.GN27423@dhcp22.suse.cz

Let me post a version 2 with all the fixups.
 
Thanks!

> --- a/mm/memory_hotplug.c~mm-memory_hotplug-be-more-verbose-for-memory-offline-failures-fix
> +++ a/mm/memory_hotplug.c
> @@ -1411,7 +1411,7 @@ do_migrate_range(unsigned long start_pfn
>  					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>  		if (ret) {
>  			list_for_each_entry(page, &source, lru) {
> -				pr_warn("migrating pfn %lx failed ",
> +				pr_warn("migrating pfn %lx failed: %d",
>  				       page_to_pfn(page), ret);
>  				dump_page(page, NULL);
>  			}
> 

-- 
Michal Hocko
SUSE Labs
