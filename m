Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAFDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EED620824
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeKQOhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 09:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbeKQOhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 09:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 052133001A49;
        Sat, 17 Nov 2018 04:22:14 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 040AE608E8;
        Sat, 17 Nov 2018 04:22:10 +0000 (UTC)
Date:   Sat, 17 Nov 2018 12:22:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181117042208.GB18471@MiWiFi-R3L-srv>
References: <20181115051034.GK2653@MiWiFi-R3L-srv>
 <20181115073052.GA23831@dhcp22.suse.cz>
 <20181115075349.GL2653@MiWiFi-R3L-srv>
 <20181115083055.GD23831@dhcp22.suse.cz>
 <20181115131211.GP2653@MiWiFi-R3L-srv>
 <20181115131927.GT23831@dhcp22.suse.cz>
 <20181115133840.GR2653@MiWiFi-R3L-srv>
 <20181115143204.GV23831@dhcp22.suse.cz>
 <20181116012433.GU2653@MiWiFi-R3L-srv>
 <20181116091409.GD14706@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116091409.GD14706@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 17 Nov 2018 04:22:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 at 10:14am, Michal Hocko wrote:
> Could you try to apply this debugging patch on top please? It will dump
> stack trace for each reference count elevation for one page that fails
> to migrate after multiple passes.

Thanks, applied and fixed two code issues. The dmesg has been sent to
you privately, please check. The dmesg is overflow, if you need the
earlier message, I will retest.

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index b64ebf253381..f76e2c498f31 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -72,7 +72,7 @@ static inline int page_count(struct page *page)
        return atomic_read(&compound_head(page)->_refcount);
 }
 
-struct page *page_to_track;
+extern struct page *page_to_track;
 static inline void set_page_count(struct page *page, int v)
 {
        atomic_set(&page->_refcount, v);
diff --git a/mm/migrate.c b/mm/migrate.c
index 9b2e395a3d68..42c7499c43b9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1339,6 +1339,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 }
 
 struct page *page_to_track;
+EXPORT_SYMBOL_GPL(page_to_track);
 
 /*
  * migrate_pages - migrate the pages specified in a list, to the free pages

> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 14d14beb1f7f..b64ebf253381 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -72,9 +72,12 @@ static inline int page_count(struct page *page)
>  	return atomic_read(&compound_head(page)->_refcount);
>  }
>  
> +struct page *page_to_track;
>  static inline void set_page_count(struct page *page, int v)
>  {
>  	atomic_set(&page->_refcount, v);
> +	if (page == page_to_track)
> +		dump_stack();
>  	if (page_ref_tracepoint_active(__tracepoint_page_ref_set))
>  		__page_ref_set(page, v);
>  }
> @@ -91,6 +94,8 @@ static inline void init_page_count(struct page *page)
>  static inline void page_ref_add(struct page *page, int nr)
>  {
>  	atomic_add(nr, &page->_refcount);
> +	if (page == page_to_track)
> +		dump_stack();
>  	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
>  		__page_ref_mod(page, nr);
>  }
> @@ -105,6 +110,8 @@ static inline void page_ref_sub(struct page *page, int nr)
>  static inline void page_ref_inc(struct page *page)
>  {
>  	atomic_inc(&page->_refcount);
> +	if (page == page_to_track)
> +		dump_stack();
>  	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
>  		__page_ref_mod(page, 1);
>  }
> @@ -129,6 +136,8 @@ static inline int page_ref_inc_return(struct page *page)
>  {
>  	int ret = atomic_inc_return(&page->_refcount);
>  
> +	if (page == page_to_track)
> +		dump_stack();
>  	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_return))
>  		__page_ref_mod_and_return(page, 1, ret);
>  	return ret;
> @@ -156,6 +165,8 @@ static inline int page_ref_add_unless(struct page *page, int nr, int u)
>  {
>  	int ret = atomic_add_unless(&page->_refcount, nr, u);
>  
> +	if (page == page_to_track)
> +		dump_stack();
>  	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_unless))
>  		__page_ref_mod_unless(page, nr, ret);
>  	return ret;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f7e4bfdc13b7..9b2e395a3d68 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1338,6 +1338,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  	return rc;
>  }
>  
> +struct page *page_to_track;
> +
>  /*
>   * migrate_pages - migrate the pages specified in a list, to the free pages
>   *		   supplied as the target for the page migration
> @@ -1375,6 +1377,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	if (!swapwrite)
>  		current->flags |= PF_SWAPWRITE;
>  
> +	page_to_track = NULL;
>  	for(pass = 0; pass < 10 && retry; pass++) {
>  		retry = 0;
>  
> @@ -1417,6 +1420,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				goto out;
>  			case -EAGAIN:
>  				retry++;
> +				if (pass > 1 && !page_to_track)
> +					page_to_track = page;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
>  				nr_succeeded++;
> -- 
> Michal Hocko
> SUSE Labs
