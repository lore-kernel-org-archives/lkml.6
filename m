Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEEJ1f (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:27:35 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35396 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeEEJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:27:33 -0400
Date: Sat, 5 May 2018 17:27:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] rhashtable: use cmpxchg() to protect ->future_tbl.
Message-ID: <20180505092725.rlwn77d3yhknspdw@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605430.18473.11758878046224478232.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605430.18473.11758878046224478232.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> Rather than borrowing one of the bucket locks to
> protect ->future_tbl updates, use cmpxchg().
> This gives more freedom to change how bucket locking
> is implemented.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

This looks nice.

> -	spin_unlock_bh(old_tbl->locks);
> +	rcu_assign_pointer(tmp, new_tbl);

Do we need this barrier since cmpxchg is supposed to provide memory
barrier semantics?

> +	if (cmpxchg(&old_tbl->future_tbl, NULL, tmp) != NULL)
> +		return -EEXIST;

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
