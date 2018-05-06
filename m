Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeEFFUF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 01:20:05 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:36350 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeEFFUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 01:20:03 -0400
Date: Sun, 6 May 2018 13:20:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] rhashtable: don't hold lock on first table
 throughout insertion.
Message-ID: <20180506052000.7yehd5lke3smccoj@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605444.18473.9591316658457316578.stgit@noble>
 <20180505094117.pl7b6bbk6mtyri6d@gondor.apana.org.au>
 <87sh75dapa.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh75dapa.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 08:00:49AM +1000, NeilBrown wrote:
>
> The insert function must (and does) take the lock on the bucket before
> testing if there is a "next" table.
> If one inserter finds that it has locked the "last" table (because there
> is no next) and successfully inserts, then the other inserter cannot
> have locked that table yet, else it would have inserted.  When it does,
> it will find what the first inserter inserted. 

If you release the lock to the first table then it may be deleted
by the resize thread.  Hence the other inserter may not have even
started from the same place.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
