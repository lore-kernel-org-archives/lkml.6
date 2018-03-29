Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeC2Fub (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:50:31 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47894 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeC2Fua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:50:30 -0400
Date: Thu, 29 Mar 2018 13:50:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rhashtable: improve rhashtable_walk stability when
 stop/start used.
Message-ID: <20180329055020.GC21028@gondor.apana.org.au>
References: <152228607974.16370.14544827502467836789.stgit@noble>
 <152228634999.16370.13957181774415446375.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152228634999.16370.13957181774415446375.stgit@noble>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 12:19:10PM +1100, NeilBrown wrote:
> When a walk of an rhashtable is interrupted with rhastable_walk_stop()
> and then rhashtable_walk_start(), the location to restart from is based
> on a 'skip' count in the current hash chain, and this can be incorrect
> if insertions or deletions have happened.  This does not happen when
> the walk is not stopped and started as iter->p is a placeholder which
> is safe to use while holding the RCU read lock.
> 
> In rhashtable_walk_start() we can revalidate that 'p' is still in the
> same hash chain.  If it isn't then the current method is still used.
> 
> With this patch, if a rhashtable walker ensures that the current
> object remains in the table over a stop/start period (possibly by
> elevating the reference count if that is sufficient), it can be sure
> that a walk will not miss objects that were in the hashtable for the
> whole time of the walk.
> 
> rhashtable_walk_start() may not find the object even though it is
> still in the hashtable if a rehash has moved it to a new table.  In
> this case it will (eventually) get -EAGAIN and will need to proceed
> through the whole table again to be sure to see everything at least
> once.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Very nice!

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
