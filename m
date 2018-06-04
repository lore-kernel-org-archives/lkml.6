Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeFDSQP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:16:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53615 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeFDSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:16:13 -0400
X-Google-Smtp-Source: ADUXVKKi7k5vj2bF17elcO1LI5LP6cZODv3RFrPY7Q8Pr+fN0hoG5VOk3Slp2Juy5fLs3f8Fy8k9bw==
Date: Mon, 4 Jun 2018 20:16:10 +0200
From: Simon Horman <simon.horman@netronome.com>
To: NeilBrown <neilb@suse.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 15a/18] rhashtables: add lockdep tracking to bucket
 bit-spin-locks.
Message-ID: <20180604181609.sssd4ao6wfwj3il6@netronome.com>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824984.30340.1634082820568216846.stgit@noble>
 <20180602050322.liesw324q5kawcue@gondor.apana.org.au>
 <9bea77df-e7db-677a-31b2-710dc6d956ee@gmail.com>
 <871sdnqty4.fsf@notabene.neil.brown.name>
 <87po17p8jd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87po17p8jd.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 12:52:54PM +1000, NeilBrown wrote:
> 
> Native bit_spin_locks are not tracked by lockdep.
> 
> The bit_spin_locks used for rhashtable buckets are local
> to the rhashtable implementation, so there is little opportunity
> for the sort of misuse that lockdep might detect.
> However locks are held while a hash function or compare
> function is called, and if one of these took a lock,
> a misbehaviour is possible.
> 
> As it is quite easy to add lockdep support this unlikely
> possibility see to be enough justification.

nit: s/see/seems/

> 
> So create a lockdep class for bucket bit_spin_lock as attach
> through a lockdep_map in each bucket_table.
> 
> With the 'nested' annotation in rhashtable_rehash_one(), lockdep
> correctly reports a possible problem as this lock it taken
> while another bucket lock (in another table) is held.  This
> confirms that the added support works.
> With the correct nested annotation in place, lockdep reports
> no problems.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
