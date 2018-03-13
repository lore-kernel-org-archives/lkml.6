Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCMOmB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:42:01 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:45786 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeCMOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:42:00 -0400
X-Google-Smtp-Source: AG47ELu9BoORkFhgN7+PFgDyqCe6YBZlmcx9TaWVuDXkf8wefUV2herjRXdsAH4dzMZ2FbdrUYyBsA==
Subject: Re: [PATCH] test_rhashtable: avoid gcc-8 -Wformat-overflow warning
To: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Blakey <paulb@mellanox.com>
Cc: Martin Sebor <msebor@gcc.gnu.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, Tom Herbert <tom@quantonium.net>,
        linux-kernel@vger.kernel.org
References: <20180313132155.203220-1-arnd@arndb.de>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0ab7c9f6-e677-3bc9-df05-9895870a3c32@rasmusvillemoes.dk>
Date: Tue, 13 Mar 2018 15:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313132155.203220-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-13 14:21, Arnd Bergmann wrote:
> gcc-8 warns about a code pattern that is used in the newly added
> test_rhashtable code:
> 
> lib/test_rhashtable.c: In function 'print_ht':
> lib/test_rhashtable.c:511:21: error: '
> bucket[' directive writing 8 bytes into a region of size between 1 and 512 [-Werror=format-overflow=]
>     sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
>                      ^~~~~~~~~
> lib/test_rhashtable.c:511:4: note: 'sprintf' output between 15 and 536 bytes into a destination of size 512
>     sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The problem here is using the same fixed-length buffer as input and output
> of snprintf(), which for an unbounded loop has an actual potential to
> overflow the buffer. The '512' byte length was apparently chosen to
> be "long enough" to prevent that in practice, but without any specific
> guarantees of being the smallest safe size.

well, 1024 would certainly be enough, because the result is anyway
passed to printk() which formats into a buffer of that size, so anything
more would certainly just be thrown away...

> I can see three possible ways to avoid this warning:
> 
> - rewrite the code to use pointer arithmetic to forward the buffer,
>   rather than copying the buffer itself. This is a more conventional
>   use of sprintf(), and it avoids the warning, but is not any more
>   safe than the original code.
> - Rewrite the function in a safe way that avoids both the potential
>   overflow and the warning.
> - Ask the gcc developers to not warn for this pattern if we consider
>   the warning to be inappropriate.
> 
> This patch implements the first of the above, as an illustration of
> the problem, and the simplest workaround.

If you use scnprintf() and forward the printed length you can get rid of
the potential buffer overrun:

len = 0;
...
len += scnprintf(buf + len, sizeof(buf) - len, fmt, args...)

scnprintf has the property that if you pass in a positive value, you get
back something that is strictly less, so with the above pattern, we
might eventually have sizeof(buf)-len==1, so all subsequent scnprintfs
return 0, but we never overflow the buffer. The effect is thus the same
as if you had done all the formatting with a single snprintf() call.

FWIW, I sent an RFC [1] two years ago trying to get rid of all
snprintf(buf, ..., "%s...", buf, ...), because I think it's too fragile
(it obviously breaks horribly if anything precedes the %s with buf as
its argument), but others disagreed and said that the kernel's
vsnprintf() instead should be documented to support that special case of
overlapping src and dst. I don't really recall what happened with the
patches, perhaps some got applied, but if not, maybe gcc-8 will now warn
about those places.

[1]
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1096481.html


> Fixes: 499ac3b60f65 ("test_rhashtable: add test case for rhltable with duplicate objects")
> Cc: Martin Sebor <msebor@gcc.gnu.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> My patch is untested, please try it out before applying.
> ---
>  lib/test_rhashtable.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> index f4000c137dbe..a0f4fb03d2de 100644
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c
> @@ -496,6 +496,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
>  	struct rhashtable *ht;
>  	const struct bucket_table *tbl;
>  	char buff[512] = "";
> +	char *buffp = buff;
>  	unsigned int i, cnt = 0;
>  
>  	ht = &rhlt->ht;
> @@ -508,18 +509,18 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
>  		next = !rht_is_a_nulls(pos) ? rht_dereference(pos->next, ht) : NULL;
>  
>  		if (!rht_is_a_nulls(pos)) {
> -			sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
> +			buffp += sprintf(buffp, "\nbucket[%d] -> ", i);
>  		}
>  
>  		while (!rht_is_a_nulls(pos)) {
>  			struct rhlist_head *list = container_of(pos, struct rhlist_head, rhead);
> -			sprintf(buff, "%s[[", buff);
> +			buffp += sprintf(buffp, "[[");
>  			do {
>  				pos = &list->rhead;
>  				list = rht_dereference(list->next, ht);
>  				p = rht_obj(ht, pos);
>  
> -				sprintf(buff, "%s val %d (tid=%d)%s", buff, p->value.id, p->value.tid,
> +				buffp += sprintf(buffp, "val %d (tid=%d)%s", p->value.id, p->value.tid,
>  					list? ", " : " ");

this removes a space before val, not sure that was intended?

>  				cnt++;
>  			} while (list);
> @@ -528,7 +529,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
>  			next = !rht_is_a_nulls(pos) ?
>  				rht_dereference(pos->next, ht) : NULL;
>  
> -			sprintf(buff, "%s]]%s", buff, !rht_is_a_nulls(pos) ? " -> " : "");
> +			buffp += sprintf(buffp, "]]%s", !rht_is_a_nulls(pos) ? " -> " : "");
>  		}
>  	}
>  	printk(KERN_ERR "\n---- ht: ----%s\n-------------\n", buff);
> 
