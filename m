Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeFAQyl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:54:41 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:58094 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeFAQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:54:35 -0400
Date: Sat, 2 Jun 2018 00:54:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] rhashtable: clean up dereference of ->future_tbl.
Message-ID: <20180601165428.gtefyay2dlus754p@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824957.30340.14092720576731091742.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152782824957.30340.14092720576731091742.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
> Using rht_dereference_bucket() to dereference
> ->future_tbl looks like a type error, and could be confusing.
> Using rht_dereference_rcu() to test a pointer for NULL
> adds an unnecessary barrier - rcu_access_pointer() is preferred
> for NULL tests when no lock is held.
> 
> This uses 3 different ways to access ->future_tbl.
> - if we know the mutex is held, use rht_dereference()
> - if we don't hold the mutex, and are only testing for NULL,
>   use rcu_access_pointer()
> - otherwise (using RCU protection for true dereference),
>   use rht_dereference_rcu().
> 
> Note that this includes a simplification of the call to
> rhashtable_last_table() - we don't do an extra dereference
> before the call any more.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
