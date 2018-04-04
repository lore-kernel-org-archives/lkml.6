Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeDDAkb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 20:40:31 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:45359 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeDDAka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 20:40:30 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: iamjoonsoo.kim@lge.com
X-Original-SENDERIP: 10.177.220.142
X-Original-MAILFROM: iamjoonsoo.kim@lge.com
Date: Wed, 4 Apr 2018 09:40:27 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, cl@linux.com, mm-commits@vger.kernel.org,
        penberg@kernel.org, rientjes@google.com, sunnyddayss@gmail.com
Subject: Re: + mm-slabc-remove-duplicated-check-of-colour_next.patch added to
 -mm tree
Message-ID: <20180404004027.GB6628@js1304-desktop>
References: <20180312221333.aYPvPxhxp%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312221333.aYPvPxhxp%akpm@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:13:33PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: mm/slab.c: remove duplicated check of colour_next
> has been added to the -mm tree.  Its filename is
>      mm-slabc-remove-duplicated-check-of-colour_next.patch
> 
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/mm-slabc-remove-duplicated-check-of-colour_next.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/mm-slabc-remove-duplicated-check-of-colour_next.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
> 
> ------------------------------------------------------
> From: Roman Lakeev <sunnyddayss@gmail.com>
> Subject: mm/slab.c: remove duplicated check of colour_next
> 
> Remove check that offset greater than cachep->colour bacause this is
> already checked in previous lines.
> 
> Link: http://lkml.kernel.org/r/877eqilr71.fsf@gmail.com
> Signed-off-by: Roman Lakeev <sunnyddayss@gmail.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/slab.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff -puN mm/slab.c~mm-slabc-remove-duplicated-check-of-colour_next mm/slab.c
> --- a/mm/slab.c~mm-slabc-remove-duplicated-check-of-colour_next
> +++ a/mm/slab.c
> @@ -2674,11 +2674,7 @@ static struct page *cache_grow_begin(str
>  	if (n->colour_next >= cachep->colour)
>  		n->colour_next = 0;
>  
> -	offset = n->colour_next;
> -	if (offset >= cachep->colour)
> -		offset = 0;
> -
> -	offset *= cachep->colour_off;
> +	offset = n->colour_next * cachep->colour_off;
>  
>  	/* Get slab management. */
>  	freelist = alloc_slabmgmt(cachep, page, offset,

Hello, all.

This n->colour_next can be update at the other cpu since
there is no lock to protect it. So, removing this one
another check can make the offset overflow.

Andrew, could you drop this patch?

Thanks.
