Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08660C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B6D208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B6D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbeKPKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:17:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPKRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:17:22 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DAD84AD2;
        Fri, 16 Nov 2018 00:07:17 +0000 (UTC)
Date:   Thu, 15 Nov 2018 16:07:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     <linux-mm@kvack.org>, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 5/5] mm, memory_hotplug: be more verbose for memory
 offline failures
Message-Id: <20181115160716.18b9956ee64932abe9428ef1@linux-foundation.org>
In-Reply-To: <20181107101830.17405-6-mhocko@kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
        <20181107101830.17405-6-mhocko@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 11:18:30 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> There is only very limited information printed when the memory offlining
> fails:
> [ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed due to signal backoff
> 
> This tells us that the failure is triggered by the userspace
> intervention but it doesn't tell us much more about the underlying
> reason. It might be that the page migration failes repeatedly and the
> userspace timeout expires and send a signal or it might be some of the
> earlier steps (isolation, memory notifier) takes too long.
> 
> If the migration failes then it would be really helpful to see which
> page that and its state. The same applies to the isolation phase. If we
> fail to isolate a page from the allocator then knowing the state of the
> page would be helpful as well.
> 
> Dump the page state that fails to get isolated or migrated. This will
> tell us more about the failure and what to focus on during debugging.
> 
> ...
>
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1388,10 +1388,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  						    page_is_file_cache(page));
>  
>  		} else {
> -#ifdef CONFIG_DEBUG_VM
> -			pr_alert("failed to isolate pfn %lx\n", pfn);
> +			pr_warn("failed to isolate pfn %lx\n", pfn);
>  			dump_page(page, "isolation failed");
> -#endif
>  			put_page(page);
>  			/* Because we don't have big zone->lock. we should
>  			   check this again here. */
> @@ -1411,8 +1409,14 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		/* Allocate a new page from the nearest neighbor node */
>  		ret = migrate_pages(&source, new_node_page, NULL, 0,
>  					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> -		if (ret)
> +		if (ret) {
> +			list_for_each_entry(page, &source, lru) {
> +				pr_warn("migrating pfn %lx failed ",
> +				       page_to_pfn(page), ret);
> +				dump_page(page, NULL);
> +			}

./include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^
./include/linux/kern_levels.h:12:22: note: in expansion of macro ‘KERN_SOH’
 #define KERN_WARNING KERN_SOH "4" /* warning conditions */
                      ^~~~~~~~
./include/linux/printk.h:310:9: note: in expansion of macro ‘KERN_WARNING’
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~~~~~
./include/linux/printk.h:311:17: note: in expansion of macro ‘pr_warning’
 #define pr_warn pr_warning
                 ^~~~~~~~~~
mm/memory_hotplug.c:1414:5: note: in expansion of macro ‘pr_warn’
     pr_warn("migrating pfn %lx failed ",
     ^~~~~~~

--- a/mm/memory_hotplug.c~mm-memory_hotplug-be-more-verbose-for-memory-offline-failures-fix
+++ a/mm/memory_hotplug.c
@@ -1411,7 +1411,7 @@ do_migrate_range(unsigned long start_pfn
 					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
-				pr_warn("migrating pfn %lx failed ",
+				pr_warn("migrating pfn %lx failed: %d",
 				       page_to_pfn(page), ret);
 				dump_page(page, NULL);
 			}

