Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeCMRUB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:20:01 -0400
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:59012 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752431AbeCMRT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:19:59 -0400
Date: Tue, 13 Mar 2018 12:19:56 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Shakeel Butt <shakeelb@google.com>
cc: Suleiman Souhlal <suleiman@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab, slub: remove size disparity on debug kernel
In-Reply-To: <20180313165428.58699-1-shakeelb@google.com>
Message-ID: <alpine.DEB.2.20.1803131217200.9367@nuc-kabylake>
References: <20180313165428.58699-1-shakeelb@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfDdbdPP1WxYGakki9wc8rhD3URHN9u0G7rv6e0MBjMfViurbRWTd+z46PAwehEANjNICRhU+iz3HMiqIqb3wgK219thwM1aR+DbG45MlIACVlMcyiOPA
 SspaW4JjuITVnbgoOrqfhAgL4Ci0dpcavgna6TdnJHFq+7NC1al1APNKnGb4kYmc2vezqFaUdXUGt19afysoxKy+2VEuHIU2bHtH6+9R9E0FPEmP/3NYI62s
 sMfnzK+brwbS6rZHWS9/JwMWYM12KqtNAFKTynGIBWGHhgyZIimtlPFC3G5h+UPVjNWAjdVgDIfdsQ6FPpYydJ5pC3LOuP7DrRyGyfAIEX6Y9/2EWSdqASjw
 BJ5KdcB6dVzY6ztlgfSQg72le271qyErrWYYzKjJdY6RhL25mySnrBeTd5DcdkWq1bJkG5ra
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018, Shakeel Butt wrote:

> However for SLUB in debug kernel, the sizes were same. On further
> inspection it is found that SLUB always use kmem_cache.object_size to
> measure the kmem_cache.size while SLAB use the given kmem_cache.size. In
> the debug kernel the slab's size can be larger than its object_size.
> Thus in the creation of non-root slab, the SLAB uses the root's size as
> base to calculate the non-root slab's size and thus non-root slab's size
> can be larger than the root slab's size. For SLUB, the non-root slab's
> size is measured based on the root's object_size and thus the size will
> remain same for root and non-root slab.

Note that the object_size and size may differ for SLUB based on kernel
parameters and slab configuration. For SLAB these are compilation options.

> @@ -379,7 +379,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  }
>
>  static struct kmem_cache *create_cache(const char *name,
> -		unsigned int object_size, unsigned int size, unsigned int align,
> +		unsigned int object_size, unsigned int align,
>  		slab_flags_t flags, unsigned int useroffset,

Why was both the size and object_size passed during cache creation in the
first place? From the flags etc the slab logic should be able to compute
the actual bytes required for each object and its metadata.
