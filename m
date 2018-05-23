Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeEWJIx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:08:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754378AbeEWJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:08:52 -0400
Date: Wed, 23 May 2018 11:08:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
Message-ID: <20180523090840.GU12217@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
 <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
 <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com>
 <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com>
 <58df7ae3-8ef0-4f42-9ab2-b551d2ffff00@embeddedor.com>
 <161a0513-1029-a76c-f967-1e606081599d@embeddedor.com>
 <CAPcyv4i6zOJZakNVW=y8NyUFB1EzOxBtoOGVhWCwysuTi6grvg@mail.gmail.com>
 <112349fb-837c-7b91-e256-a1c443710150@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112349fb-837c-7b91-e256-a1c443710150@embeddedor.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for being late to the party..

On Wed, May 23, 2018 at 12:03:57AM -0500, Gustavo A. R. Silva wrote:

> +#define validate_index_nospec(index, size)                            \
> +({                                                                    \
> +       bool ret = true;                                               \
> +       typeof(index) *ptr = &(index);                                 \
> +       typeof(size) _s = (size);                                      \
> +                                                                      \
> +       BUILD_BUG_ON(sizeof(*ptr) > sizeof(long));                     \
> +       BUILD_BUG_ON(sizeof(_s) > sizeof(long));                       \
> +                                                                      \
> +       if (*ptr >= size)                                              \
> +               ret = false;                                           \
> +                                                                      \
> +       *ptr = array_index_nospec(*ptr, _s);                           \
> +                                                                      \
> +       ret;                                                           \
> +})

Would not something like:

	bool ret = false;

	....

	if (*ptr < _s) {
		*ptr = array_index_nospec(*ptr, _s);
		ret = true;
	}

	ret;

be more obvious?
