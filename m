Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeC0KzU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:55:20 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37867 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeC0KzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:55:18 -0400
X-Google-Smtp-Source: AG47ELvrP4+ZsA9UhYwtNX3sK1d9Vm2ua5+kwiU+So5toqnLTEvwd1w44qACwMLqDby161jKuPTlXw==
Subject: Re: [PATCH 1/6] rhashtable: improve documentation for
 rhashtable_walk_peek()
To: NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718418.11435.11573013181393548255.stgit@noble>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <558e628a-ebd2-c4fa-dc26-0217a0f60433@cogentembedded.com>
Date: Tue, 27 Mar 2018 13:55:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152210718418.11435.11573013181393548255.stgit@noble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/27/2018 2:33 AM, NeilBrown wrote:

> The documentation for rhashtable_walk_peek() wrong.  It claims to
> return the *next* entry, whereas it in fact returns the *previous*
> entry.
> However if no entries have yet been returned - or if the iterator
> was reset due to a resize event, then rhashtable_walk_peek()
> *does* return the next entry, but also advances the iterator.
> 
> I suspect that this interface should be discarded and the one user
> should be changed to not require it.  Possibly this patch should be
> seen as a first step in that conversation.
> 
> This patch mostly corrects the documentation, but does make a
> small code change so that the documentation can be correct without
> listing too many special cases.  I don't think the one user will
> be affected by the code change.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>   lib/rhashtable.c |   17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 3825c30aaa36..24a57ca494cb 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -853,13 +853,17 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
>   EXPORT_SYMBOL_GPL(rhashtable_walk_next);
>   
>   /**
> - * rhashtable_walk_peek - Return the next object but don't advance the iterator
> + * rhashtable_walk_peek - Return the previously returned object without advancing the iterator
>    * @iter:	Hash table iterator
>    *
> - * Returns the next object or NULL when the end of the table is reached.
> + * Returns the last object returned,

    Sounds somewhat tautological. :-)

> or NULL if no object has yet been returned.
> + * If the previously returned object has since been removed, then some other arbitrary
> + * object maybe returned, or possibly NULL will be returned.  In that case, the
> + * iterator might be advanced.
>    *
>    * Returns -EAGAIN if resize event occurred.  Note that the iterator
> - * will rewind back to the beginning and you may continue to use it.
> + * will rewind back to the beginning and rhashtable_walk_next() should be
> + * used to get the next object.
>    */
>   void *rhashtable_walk_peek(struct rhashtable_iter *iter)
>   {
> @@ -880,7 +884,12 @@ void *rhashtable_walk_peek(struct rhashtable_iter *iter)
>   		 * the table hasn't changed.
>   		 */
>   		iter->skip--;
> -	}
> +	} else
> +		/* ->skip is only zero after rhashtable_walk_start()
> +		 * or when the iterator is reset.  In this case there
> +		 * is no previous object to return.
> +		 */
> +		return NULL;

    CodingStyle: need {} on the *else* branch if the 1st branch has them.

>   
>   	return __rhashtable_walk_find_next(iter);
>   }

MBR, Sergei
