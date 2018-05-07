Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeEGJ3u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:29:50 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:50140 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbeEGJ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:29:43 -0400
Date: Mon, 7 May 2018 17:29:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] rhashtable: don't hold lock on first table
 throughout insertion.
Message-ID: <20180507092939.vhps3uf2vdckf7ky@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605444.18473.9591316658457316578.stgit@noble>
 <20180505094117.pl7b6bbk6mtyri6d@gondor.apana.org.au>
 <87sh75dapa.fsf@notabene.neil.brown.name>
 <20180506052000.7yehd5lke3smccoj@gondor.apana.org.au>
 <878t8wcthy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t8wcthy.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 08:24:41AM +1000, NeilBrown wrote:
>
> This is true, but I don't see how it is relevant.
> At some point, each thread will find that the table they have just
> locked for their search key, has a NULL 'future_tbl' pointer.
> At the point, the thread can know that the key is not in any table,
> and that no other thread can add the key until the lock is released.

The updating of future_tbl is not synchronised with insert threads.
Therefore it is entirely possible that two inserters end up on
different tables as their "latest" table.  This must not be allowed
to occur.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
