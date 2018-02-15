Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163776AbeBOVjW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:39:22 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44498 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162541AbeBOVjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:39:18 -0500
X-Google-Smtp-Source: AH8x227+F09syYgRAkuhXzjxxgADUFB9b3cYGBx6WOGwVhzmTRXQbE6A0rlXpPpD05eSzORtqM17kg==
Date: Thu, 15 Feb 2018 13:39:09 -0800
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Christoph Lameter <cl@linux.com>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] percpu: add __GFP_NORETRY semantics to the percpu
 balancing path
Message-ID: <20180215213909.GU695913@devbig577.frc2.facebook.com>
References: <cover.1518668149.git.dennisszhou@gmail.com>
 <d51c5dc100f0d7423bbf5bb32760f91646097b9f.1518668149.git.dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51c5dc100f0d7423bbf5bb32760f91646097b9f.1518668149.git.dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 15, 2018 at 10:08:15AM -0600, Dennis Zhou wrote:
> -static struct pcpu_chunk *pcpu_create_chunk(void)
> +static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
>  {
>  	const int nr_pages = pcpu_group_sizes[0] >> PAGE_SHIFT;
>  	struct pcpu_chunk *chunk;
>  	struct page *pages;
>  	int i;
>  
> -	chunk = pcpu_alloc_chunk();
> +	chunk = pcpu_alloc_chunk(gfp);
>  	if (!chunk)
>  		return NULL;
>  
> -	pages = alloc_pages(GFP_KERNEL, order_base_2(nr_pages));
> +	pages = alloc_pages(gfp | GFP_KERNEL, order_base_2(nr_pages));

Is there a reason to set GFP_KERNEL in this function?  I'd prefer
pushing this to the callers.

> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 9158e5a..ea9906a 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -37,7 +37,7 @@ static struct page **pcpu_get_pages(void)
>  	lockdep_assert_held(&pcpu_alloc_mutex);
>  
>  	if (!pages)
> -		pages = pcpu_mem_zalloc(pages_size);
> +		pages = pcpu_mem_zalloc(pages_size, 0);
                                                  ^^^^
						  because this is confusing
>  static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
> -			    struct page **pages, int page_start, int page_end)
> +			    struct page **pages, int page_start, int page_end,
> +			    gfp_t gfp)
>  {
> -	const gfp_t gfp = GFP_KERNEL | __GFP_HIGHMEM;
>  	unsigned int cpu, tcpu;
>  	int i;
>  
> +	gfp |=  GFP_KERNEL | __GFP_HIGHMEM;
              ^^
	      double space

So, setting __GFP_HIGHMEM unconditionally here makes sense because
it's indicating the types of pages we can use (we also accept high
pages); however, I'm not sure GFP_KERNEL makes sense.  That's about
"how to allocate" and looks like it should be left to the caller.

Thanks.

-- 
tejun
