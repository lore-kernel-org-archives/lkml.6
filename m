Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeDWIH6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:07:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39388 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754162AbeDWIHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:07:54 -0400
Date: Mon, 23 Apr 2018 16:07:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] rhashtable: add rhashtable_walk_prev()
Message-ID: <20180423080749.qw4tpeqvzjjin4dv@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
 <152403402206.16895.14563720960374849428.stgit2@noble>
 <20180418143501.kzvknyvgnjo7v75k@gondor.apana.org.au>
 <87bmegqfjc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmegqfjc.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:08:07AM +1000, NeilBrown wrote:
> 
> The need is essentially the same as the need for
> rhashtable_walk_peek().  The difference is that the actual behaviour can
> be documented briefly (and so understood easily) without enumerating
> multiple special cases.
> rhashtable_walk_peek() is much the same as
>  rhashtable_walk_prev() ?: rhashtable_walk_next()
> 
> The need arises when you need to "stop" a walk and then restart at the
> same object, not the next one. i.e. the last object returned before the
> "stop" wasn't acted on.
> This happens with seq_file if the buffer space for ->show() is not
> sufficient to format an object.  In the case, seq_file will stop() the
> iteration, make more space available (either by flushing or by
> reallocing) and will start again at the same location.
> If the seq_file client stored the rhashtable_iter in the seq_file
> private data, it can use rhasthable_walk_prev() to recover its position
> if that object is still in the hash table.  If it isn't still present,
> rhashtable_walk_next() can be used to get the next one.  In some cases
> it can be useful for the client to know whether it got the previous one
> or not.

I see.  I'm OK with this provided that you will also remove/convert
users of rhashtable_walk_peek.

I don't think we need two functions that do almost the same thing.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
