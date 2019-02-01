Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A10C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E0F218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549025134;
	bh=60ttvc1IA2ogoklQanaHYV3Dn8D+1W56VxIE5aEbHfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h/RijtsdYamlPL+IGxEyrANPizS3L4oFnoZa30mKQQhPcz/9MtkmNeoIiygpAj9Va
	 qxxkiIeCP5RX9kZaG6KVgPffzR/LcTTydVRNGw941VLijLzQzaBptA7cdRcucASsPX
	 jJ4+HQ7aqwhsPAs7iQLNCGZglu3yKycHQmZSOQy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfBAMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:45:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:60520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726450AbfBAMpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:45:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A07E4ACD4;
        Fri,  1 Feb 2019 12:45:29 +0000 (UTC)
Date:   Fri, 1 Feb 2019 13:45:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] mm/vmalloc: convert vmap_lazy_nr to atomic_long_t
Message-ID: <20190201124528.GN11599@dhcp22.suse.cz>
References: <20190131162452.25879-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131162452.25879-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-01-19 17:24:52, Uladzislau Rezki (Sony) wrote:
> vmap_lazy_nr variable has atomic_t type that is 4 bytes integer
> value on both 32 and 64 bit systems. lazy_max_pages() deals with
> "unsigned long" that is 8 bytes on 64 bit system, thus vmap_lazy_nr
> should be 8 bytes on 64 bit as well.

But do we really need 64b number of _pages_? I have hard time imagine
that we would have that many lazy pages to accumulate.

> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index abe83f885069..755b02983d8d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -632,7 +632,7 @@ static unsigned long lazy_max_pages(void)
>  	return log * (32UL * 1024 * 1024 / PAGE_SIZE);
>  }
>  
> -static atomic_t vmap_lazy_nr = ATOMIC_INIT(0);
> +static atomic_long_t vmap_lazy_nr = ATOMIC_LONG_INIT(0);
>  
>  /*
>   * Serialize vmap purging.  There is no actual criticial section protected
> @@ -650,7 +650,7 @@ static void purge_fragmented_blocks_allcpus(void);
>   */
>  void set_iounmap_nonlazy(void)
>  {
> -	atomic_set(&vmap_lazy_nr, lazy_max_pages()+1);
> +	atomic_long_set(&vmap_lazy_nr, lazy_max_pages()+1);
>  }
>  
>  /*
> @@ -658,10 +658,10 @@ void set_iounmap_nonlazy(void)
>   */
>  static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  {
> +	unsigned long resched_threshold;
>  	struct llist_node *valist;
>  	struct vmap_area *va;
>  	struct vmap_area *n_va;
> -	int resched_threshold;
>  
>  	lockdep_assert_held(&vmap_purge_lock);
>  
> @@ -681,16 +681,16 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  	}
>  
>  	flush_tlb_kernel_range(start, end);
> -	resched_threshold = (int) lazy_max_pages() << 1;
> +	resched_threshold = lazy_max_pages() << 1;
>  
>  	spin_lock(&vmap_area_lock);
>  	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
> -		int nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> +		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>  
>  		__free_vmap_area(va);
> -		atomic_sub(nr, &vmap_lazy_nr);
> +		atomic_long_sub(nr, &vmap_lazy_nr);
>  
> -		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
> +		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
>  			cond_resched_lock(&vmap_area_lock);
>  	}
>  	spin_unlock(&vmap_area_lock);
> @@ -727,10 +727,10 @@ static void purge_vmap_area_lazy(void)
>   */
>  static void free_vmap_area_noflush(struct vmap_area *va)
>  {
> -	int nr_lazy;
> +	unsigned long nr_lazy;
>  
> -	nr_lazy = atomic_add_return((va->va_end - va->va_start) >> PAGE_SHIFT,
> -				    &vmap_lazy_nr);
> +	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> +				PAGE_SHIFT, &vmap_lazy_nr);
>  
>  	/* After this point, we may free va at any time */
>  	llist_add(&va->purge_list, &vmap_purge_list);
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
