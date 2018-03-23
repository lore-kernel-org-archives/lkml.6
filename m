Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeCWOeu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:34:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCWOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:34:49 -0400
Date: Fri, 23 Mar 2018 07:34:35 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-mm@kvack.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] mm: Add free()
Message-ID: <20180323143435.GB5624@bombadil.infradead.org>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
 <1e95ce64-828b-1214-a930-1ffaedfa00b8@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e95ce64-828b-1214-a930-1ffaedfa00b8@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 09:04:10AM +0100, Rasmus Villemoes wrote:
> On 2018-03-22 20:58, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > free() can free many different kinds of memory.
> 
> I'd be a bit worried about using that name. gcc very much knows about
> the C standard's definition of that function, as can be seen on
> godbolt.org by compiling
> 
> void free(const void *);
> void f(void)
> {
>     free((void*)0);
> }
> 
> with -O2 -Wall -Wextra -c. Anything from 4.6 onwards simply compiles this to
> 
> f:
>  repz retq
> 
> And sure, your free() implementation obviously also has that property,
> but I'm worried that they might one day decide to warn about the
> prototype mismatch (actually, I'm surprised it doesn't warn now, given
> that it obviously pretends to know what free() function I'm calling...),
> or make some crazy optimization that will break stuff in very subtle ways.
> 
> Also, we probably don't want people starting to use free() (or whatever
> name is chosen) if they do know the kind of memory they're freeing?
> Maybe it should not be advertised that widely (i.e., in kernel.h).

All that you've said I see as an advantage, not a disadvantage.
Maybe I should change the prototype to match the userspace
free(), although gcc is deliberately lax about the constness of
function arguments when determining compatibility with builtins.
See match_builtin_function_types() if you're really curious.

gcc already does some nice optimisations around free().  For example, it
can eliminate dead stores:

#include <stdlib.h>

void f(char *foo)
{
	foo[1] = 3;
	free(foo);
}

becomes:

0000000000000000 <f>:
   0:	e9 00 00 00 00       	jmpq   5 <f+0x5>
			1: R_X86_64_PLT32	free-0x4

You can see more things it knows about free() by grepping for
BUILT_IN_FREE.  

I absolutely do want to see people using free() instead of kfree()
if it's not important that the memory was kmalloced.  I wouldn't go
through and change existing code, but I do want to see
#define malloc(x) kvmalloc((x), GFP_KERNEL)
