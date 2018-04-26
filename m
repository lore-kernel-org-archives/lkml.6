Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeDZTBJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:01:09 -0400
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:44080 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751128AbeDZTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:01:07 -0400
Date: Thu, 26 Apr 2018 14:01:06 -0500 (CDT)
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
In-Reply-To: <alpine.LRH.2.02.1804251917460.2429@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1804261354230.6674@nuc-kabylake>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211226350.3174@nuc-kabylake> <alpine.LRH.2.02.1803211425330.26409@file01.intranet.prod.int.rdu2.redhat.com> <20c58a03-90a8-7e75-5fc7-856facfb6c8a@suse.cz>
 <20180413151019.GA5660@redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com> <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com> <20180416144638.GA22484@redhat.com>
 <alpine.LRH.2.02.1804161530360.19492@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804170940340.17557@nuc-kabylake> <alpine.LRH.2.02.1804171454020.26973@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804180952580.1334@nuc-kabylake>
 <alpine.LRH.2.02.1804251702250.9428@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.1804251917460.2429@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfFhw0NcBtSZELLVtU2zw7fG1G1fihAClbsw5cnuXoBZznAUV0kLor5TRforWpw/ItJfzgfNVNcW6dG1SI5R0RG6PJeFfQIh4ywRhtXMUFmVbGsPt1lVd
 GdQjxhxofIBE7n0VUt+CYSZ7S/cnRV4MZWDlEN3SX6qt1f9QKV9mgQ63IB2D4jlEWU1S9LM6nRwhYVPUVlfSDurqLAAtW4v3kTU7weXmwGofJqBlJ+OBhd/s
 lpI0rXOb+rwvKKKMRuN3JF/sjcM+65qm2rQBAvgDng007EUBK7TjWjHtabob8S266CsWkj/BxTAyhK0HIqmXTmhubXcrKP383upl3NiZ7DJ8AD5LOxA9VCM+
 QDogp6OHtpSsE7NYMYW+NqZqswwe6x2NsALwfOtRPIbOqAF2FVFJ47vmUDv/AEyy8avQ/a13qFrkHfswL8FXMC7N+2yqvaaWVGA9TPzzLC+YvHfQ3WGVdYjG
 OW6GZVheSYfzDU6c
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Mikulas Patocka wrote:

> Do you want this? It deletes slab_order and replaces it with the
> "minimize_waste" logic directly.

Well yes that looks better. Now we need to make it easy to read and less
complicated. Maybe try to keep as much as possible of the old code
and also the names of variables to make it easier to review?

> It simplifies the code and it is very similar to the old algorithms, most
> slab caches have the same order, so it shouldn't cause any regressions.
>
> This patch changes order of these slabs:
> TCPv6: 3 -> 4
> sighand_cache: 3 -> 4
> task_struct: 3 -> 4

Hmmm... order 4 for these caches may cause some concern. These should stay
under costly order I think. Otherwise allocations are no longer
guaranteed.

> @@ -3269,35 +3245,35 @@ static inline int calculate_order(unsign
>  	max_objects = order_objects(slub_max_order, size, reserved);
>  	min_objects = min(min_objects, max_objects);
>
> -	while (min_objects > 1) {
> -		unsigned int fraction;
> +	/* Get the minimum acceptable order for one object */
> +	order = get_order(size + reserved);
> +
> +	for (test_order = order + 1; test_order < MAX_ORDER; test_order++) {
> +		unsigned order_obj = order_objects(order, size, reserved);
> +		unsigned test_order_obj = order_objects(test_order, size, reserved);
> +
> +		/* If there are too many objects, stop searching */
> +		if (test_order_obj > MAX_OBJS_PER_PAGE)
> +			break;
>
> -		fraction = 16;
> -		while (fraction >= 4) {
> -			order = slab_order(size, min_objects,
> -					slub_max_order, fraction, reserved);
> -			if (order <= slub_max_order)
> -				return order;
> -			fraction /= 2;
> -		}
> -		min_objects--;
> +		/* Always increase up to slub_min_order */
> +		if (test_order <= slub_min_order)
> +			order = test_order;

Well that is a significant change. In our current scheme the order
boundart wins.


> +
> +		/* If we are below min_objects and slub_max_order, increase order */
> +		if (order_obj < min_objects && test_order <= slub_max_order)
> +			order = test_order;
> +
> +		/* Increase order even more, but only if it reduces waste */
> +		if (test_order_obj <= 32 &&

Where does the 32 come from?

> +		    test_order_obj > order_obj << (test_order - order))

Add more () to make the condition better readable.

> +			order = test_order;

Can we just call test_order order and avoid using the long variable names
here? Variable names in functions are typically short.
