Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeCWIER (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:04:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41191 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeCWIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:04:15 -0400
X-Google-Smtp-Source: AG47ELstyviGHoq0x4CM4o8O6D/0jRPswWYwVZZyEQeK//EXXGRfa4/Mn+dwvb7wudqNfiUgAk7hDg==
Subject: Re: [PATCH 3/4] mm: Add free()
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1e95ce64-828b-1214-a930-1ffaedfa00b8@rasmusvillemoes.dk>
Date: Fri, 23 Mar 2018 09:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322195819.24271-4-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-22 20:58, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> free() can free many different kinds of memory.

I'd be a bit worried about using that name. gcc very much knows about
the C standard's definition of that function, as can be seen on
godbolt.org by compiling

void free(const void *);
void f(void)
{
    free((void*)0);
}

with -O2 -Wall -Wextra -c. Anything from 4.6 onwards simply compiles this to

f:
 repz retq

And sure, your free() implementation obviously also has that property,
but I'm worried that they might one day decide to warn about the
prototype mismatch (actually, I'm surprised it doesn't warn now, given
that it obviously pretends to know what free() function I'm calling...),
or make some crazy optimization that will break stuff in very subtle ways.

Also, we probably don't want people starting to use free() (or whatever
name is chosen) if they do know the kind of memory they're freeing?
Maybe it should not be advertised that widely (i.e., in kernel.h).

Rasmus
