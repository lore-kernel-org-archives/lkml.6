Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4AF20857
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546118580;
	bh=cmHfbjUMxbFPdqvJm4raOFYnk/TTu2Vdgwn+HxO11Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OhVmm5ehwPZ+O5PGGEgJ0dzxWFsOwkxAKLyySs2SPvAb7DGDGT54F5mM4/1OdeZ8D
	 jWo/NrdWzotfIFuh1rRdNKoRXqBRJAnq65VVgEhAx5EF2NwUr2+8yEkssOCsAFoyhU
	 RgAbE6z5Dzr+WUoqBQr2z4wI+2poUwsIvt53z7TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeL2VW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 16:22:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40813 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeL2VW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 16:22:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so11837299pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 13:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nwuhrmz5IcIYhoBQwFbEx5hqZw47Y5FctvTTgIb39ro=;
        b=iLYDfJDKZHksMY97/p+MhiRk6s9RnTaX60iLOvJJOmKPE5oje1bhVMk/rM0Iwt0ZDK
         5c7/ByXCBsUrlOFmcUfzKUX1xVLkGUsYpBKIj+wIxVeyk/Xz8GvNrAhH++/HZsr/YkM3
         scqTBqLfwDDwPUGHnX5qONZdD9pqIrwLZi763UZM5W060IhMWrhNTqKIWXDDjsQYBvrm
         93+TbC65dmNm0phfmJga2jboHtDxXfcQYv/jovw59GOR45z510fy+AnI4ZTdAWQPsxC1
         03qjsF4z3TPvta9vIhgFIvIM74vbGeVtqHMRe9QSYlRpGJXXlu5l77XIfI/27oAtlcaO
         4T6Q==
X-Gm-Message-State: AJcUukc5cKgwyIUZtP2W74rZKafaFq0Q6R2Wso26KPoklJImf0Rm27ql
        N2ZU4ISlveAARIiap0X45rc=
X-Google-Smtp-Source: ALg8bN5X8T1bStXUjG2/NakUKl6h+R6KPx1G4Fr4YO9zahEOI2VyZYt52Djmga8CHjiVejYAR5Vr/g==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr2756129pgl.186.1546118577065;
        Sat, 29 Dec 2018 13:22:57 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c090:180::1:8c74])
        by smtp.gmail.com with ESMTPSA id e9sm56383696pff.5.2018.12.29.13.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 13:22:56 -0800 (PST)
Date:   Sat, 29 Dec 2018 15:22:53 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: plumb gfp flag to pcpu_get_pages
Message-ID: <20181229212253.GA73871@dennisz-mbp>
References: <20181229013147.211079-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229013147.211079-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On Fri, Dec 28, 2018 at 05:31:47PM -0800, Shakeel Butt wrote:
> __alloc_percpu_gfp() can be called from atomic context, so, make
> pcpu_get_pages use the gfp provided to the higher layer.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/percpu-vm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index d8078de912de..4f42c4c5c902 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -21,6 +21,7 @@ static struct page *pcpu_chunk_page(struct pcpu_chunk *chunk,
>  
>  /**
>   * pcpu_get_pages - get temp pages array
> + * @gfp: allocation flags passed to the underlying allocator
>   *
>   * Returns pointer to array of pointers to struct page which can be indexed
>   * with pcpu_page_idx().  Note that there is only one array and accesses
> @@ -29,7 +30,7 @@ static struct page *pcpu_chunk_page(struct pcpu_chunk *chunk,
>   * RETURNS:
>   * Pointer to temp pages array on success.
>   */
> -static struct page **pcpu_get_pages(void)
> +static struct page **pcpu_get_pages(gfp_t gfp)
>  {
>  	static struct page **pages;
>  	size_t pages_size = pcpu_nr_units * pcpu_unit_pages * sizeof(pages[0]);
> @@ -37,7 +38,7 @@ static struct page **pcpu_get_pages(void)
>  	lockdep_assert_held(&pcpu_alloc_mutex);
>  
>  	if (!pages)
> -		pages = pcpu_mem_zalloc(pages_size, GFP_KERNEL);
> +		pages = pcpu_mem_zalloc(pages_size, gfp);
>  	return pages;
>  }
>  
> @@ -278,7 +279,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>  {
>  	struct page **pages;
>  
> -	pages = pcpu_get_pages();
> +	pages = pcpu_get_pages(gfp);
>  	if (!pages)
>  		return -ENOMEM;
>  
> @@ -316,7 +317,7 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
>  	 * successful population attempt so the temp pages array must
>  	 * be available now.
>  	 */
> -	pages = pcpu_get_pages();
> +	pages = pcpu_get_pages(GFP_KERNEL);
>  	BUG_ON(!pages);
>  
>  	/* unmap and free */
> -- 
> 2.20.1.415.g653613c723-goog
> 

Sorry, I'm travelling today and was hoping to respond to this later
tonight.

So percpu memory is a little different as it's an intermediary. When you 
call __alloc_percpu_gfp() and it does not contain GFP_KERNEL, it is
considered atomic. So, we only service requests out of already
populated memory. pcpu_get_pages() is only called when we need to
populate/depopulate a chunk and will not be called if we need an atomic
allocation. Also, in all but the first case, it won't make an allocation
as pages is a static variable.

Furthermore, percpu only plumbs through certain gfp as not all make
sense [1].

[1] https://lore.kernel.org/lkml/cover.1518668149.git.dennisszhou@gmail.com/

Thanks,
Dennis
