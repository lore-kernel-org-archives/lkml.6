Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeDROzf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:55:35 -0400
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:48032 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751520AbeDROze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:55:34 -0400
Date: Wed, 18 Apr 2018 09:55:31 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Mike Snitzer <snitzer@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] slab: introduce the flag SLAB_MINIMIZE_WASTE
In-Reply-To: <alpine.LRH.2.02.1804171454020.26973@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1804180952580.1334@nuc-kabylake>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211024220.2175@nuc-kabylake> <alpine.LRH.2.02.1803211153320.16017@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211226350.3174@nuc-kabylake>
 <alpine.LRH.2.02.1803211425330.26409@file01.intranet.prod.int.rdu2.redhat.com> <20c58a03-90a8-7e75-5fc7-856facfb6c8a@suse.cz> <20180413151019.GA5660@redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com>
 <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com> <20180416144638.GA22484@redhat.com> <alpine.LRH.2.02.1804161530360.19492@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804170940340.17557@nuc-kabylake>
 <alpine.LRH.2.02.1804171454020.26973@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfJIbBmtwaC84OzRwukLpY4FU6v2BVCj6ygV+ot+D2DoJw8aDlnMDNoT7/DK1qc6viwQivtFkS2K/TOxh1O6ACpNWDzC6lCyJQvNtUqrOmpohBcqQCu2n
 kdoCBMamu6Kq/E+ATTnIb9ww5spH5W8dmclWeuTuX+U8S7vmq3Sb2UXsJNr8zWpMFxqy8YcCwlNt6F16N/yL2pd14O4sMH+Tn1nNcG3RDZnSjyDBs2Zeh5+G
 m+3jLh8aKRLKLtzMV834qRZp0skgfSBHYBIctdbepQ+3QkWuezHJhUq8ZsFKZmNSA0ME9t4uQwpBIkHDmr7BUytpqpkAmGWaHjq88qhjNLzhtoRGHtnwD73y
 qh+E8I5AHzv8SoVHZLKkrwmMOD2c2rHTDLJAm91eiSl0XMegX6l5gBmVtqvpnNb2SM6rYqFOYO0Rr19/q7W/65Zl1tr+xlT1BpClTRO7CqamR8Q3/JjT2Q7U
 SDmoiRgdJvigCnln
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018, Mikulas Patocka wrote:

> I can make a slub-only patch with no extra flag (on a freshly booted
> system it increases only the order of caches "TCPv6" and "sighand_cache"
> by one - so it should not have unexpected effects):
>
> Doing a generic solution for slab would be more comlpicated because slab
> assumes that all slabs have the same order, so it can't fall-back to
> lower-order allocations.

Well again SLAB uses compound pages and thus would be able to detect the
size of the page. It may be some work but it could be done.

>
> Index: linux-2.6/mm/slub.c
> ===================================================================
> --- linux-2.6.orig/mm/slub.c	2018-04-17 19:59:49.000000000 +0200
> +++ linux-2.6/mm/slub.c	2018-04-17 20:58:23.000000000 +0200
> @@ -3252,6 +3252,7 @@ static inline unsigned int slab_order(un
>  static inline int calculate_order(unsigned int size, unsigned int reserved)
>  {
>  	unsigned int order;
> +	unsigned int test_order;
>  	unsigned int min_objects;
>  	unsigned int max_objects;
>
> @@ -3277,7 +3278,7 @@ static inline int calculate_order(unsign
>  			order = slab_order(size, min_objects,
>  					slub_max_order, fraction, reserved);
>  			if (order <= slub_max_order)
> -				return order;
> +				goto ret_order;
>  			fraction /= 2;
>  		}
>  		min_objects--;
> @@ -3289,15 +3290,25 @@ static inline int calculate_order(unsign
>  	 */
>  	order = slab_order(size, 1, slub_max_order, 1, reserved);

The slab order is determined in slab_order()

>  	if (order <= slub_max_order)
> -		return order;
> +		goto ret_order;
>
>  	/*
>  	 * Doh this slab cannot be placed using slub_max_order.
>  	 */
>  	order = slab_order(size, 1, MAX_ORDER, 1, reserved);
> -	if (order < MAX_ORDER)
> -		return order;
> -	return -ENOSYS;
> +	if (order >= MAX_ORDER)
> +		return -ENOSYS;
> +
> +ret_order:
> +	for (test_order = order + 1; test_order < MAX_ORDER; test_order++) {
> +		unsigned long order_objects = ((PAGE_SIZE << order) - reserved) / size;
> +		unsigned long test_order_objects = ((PAGE_SIZE << test_order) - reserved) / size;
> +		if (test_order_objects > min(32, MAX_OBJS_PER_PAGE))
> +			break;
> +		if (test_order_objects > order_objects << (test_order - order))
> +			order = test_order;
> +	}
> +	return order;

Could yo move that logic into slab_order()? It does something awfully
similar.
