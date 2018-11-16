Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5032EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1622E208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1622E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbeKPLGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:06:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeKPLGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:06:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30A1A307DAA9;
        Fri, 16 Nov 2018 00:56:37 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8330A1001F53;
        Fri, 16 Nov 2018 00:56:36 +0000 (UTC)
Date:   Fri, 16 Nov 2018 08:56:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 2/5] mm: lower the printk loglevel for __dump_page
 messages
Message-ID: <20181116005634.GT2653@MiWiFi-R3L-srv>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107101830.17405-3-mhocko@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 16 Nov 2018 00:56:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/18 at 11:18am, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> __dump_page messages use KERN_EMERG resp. KERN_ALERT loglevel (this is
> the case since 2004). Most callers of this function are really detecting
> a critical page state and BUG right after. On the other hand the
> function is called also from contexts which just want to inform about
> the page state and those would rather not disrupt logs that much (e.g.
> some systems route these messages to the normal console).
> 
> Reduce the loglevel to KERN_WARNING to make dump_page easier to reuse
> for other contexts while those messages will still make it to the kernel
> log in most setups. Even if the loglevel setup filters warnings away
> those paths that are really critical already print the more targeted
> error or panic and that should make it to the kernel log.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/debug.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index a33177bfc856..d18c5cea3320 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -54,7 +54,7 @@ void __dump_page(struct page *page, const char *reason)
>  	 * dump_page() when detected.
>  	 */
>  	if (page_poisoned) {
> -		pr_emerg("page:%px is uninitialized and poisoned", page);
> +		pr_warn("page:%px is uninitialized and poisoned", page);
>  		goto hex_only;
>  	}
>  
> @@ -65,27 +65,27 @@ void __dump_page(struct page *page, const char *reason)
>  	 */
>  	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
>  
> -	pr_emerg("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
> +	pr_warn("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
	pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx",

Better print it as refcount since we have renamed it. 

>  		  page, page_ref_count(page), mapcount,
>  		  page->mapping, page_to_pgoff(page));
>  	if (PageCompound(page))
>  		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
>  	pr_cont("\n");
>  	if (PageAnon(page))
> -		pr_emerg("anon ");
> +		pr_warn("anon ");
>  	else if (PageKsm(page))
> -		pr_emerg("ksm ");
> +		pr_warn("ksm ");
>  	else if (mapping) {
> -		pr_emerg("%ps ", mapping->a_ops);
> +		pr_warn("%ps ", mapping->a_ops);
>  		if (mapping->host->i_dentry.first) {
>  			struct dentry *dentry;
>  			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
> -			pr_emerg("name:\"%*s\" ", dentry->d_name.len, dentry->d_name.name);
> +			pr_warn("name:\"%*s\" ", dentry->d_name.len, dentry->d_name.name);
>  		}
>  	}
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>  
> -	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  
>  hex_only:
>  	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
> @@ -93,11 +93,11 @@ void __dump_page(struct page *page, const char *reason)
>  			sizeof(struct page), false);
>  
>  	if (reason)
> -		pr_alert("page dumped because: %s\n", reason);
> +		pr_warn("page dumped because: %s\n", reason);
>  
>  #ifdef CONFIG_MEMCG
>  	if (!page_poisoned && page->mem_cgroup)
> -		pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
> +		pr_warn("page->mem_cgroup:%px\n", page->mem_cgroup);
>  #endif
>  }
>  
> -- 
> 2.19.1
> 
