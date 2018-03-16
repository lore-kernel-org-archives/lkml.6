Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeCPOyo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:54:44 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59188 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbeCPOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:54:06 -0400
Date: Fri, 16 Mar 2018 22:53:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Megha Dey <megha.dey@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Message-ID: <20180316145351.GA6231@gondor.apana.org.au>
References: <1515542948-24041-1-git-send-email-megha.dey@linux.intel.com>
 <1515542948-24041-2-git-send-email-megha.dey@linux.intel.com>
 <20180118113905.GA19904@gondor.apana.org.au>
 <1516322661.2526.3.camel@megha-Z97X-UD7-TH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516322661.2526.3.camel@megha-Z97X-UD7-TH>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 04:44:21PM -0800, Megha Dey wrote:
>
> > So the mcryptd template is in fact completely superfluous.  You
> > can remove it and just have all the main encrypt/decrypt functions
> > invoke the underlying encrypt/decrypt function directly and achieve
> > the same result.
> > 
> > Am I missing something?
> 
> Hi Herbert,
> 
> After discussing with Tim, it seems like the mcryptd is responsible for
> queuing up the encrypt requests and dispatching them to the actual
> multi-buffer raw algorithm.  It also flushes the queue
> if we wait too long without new requests coming in to force dispatch of
> the requests in queue.
> 
> Its function is analogous to cryptd but it has its own multi-lane twists
> so we haven't reused the cryptd interface.

I have taken a deeper look and I'm even more convinced now that
mcryptd is simply not needed in your current model.

The only reason you would need mcryptd is if you need to limit
the rate of requests going into the underlying mb algorithm.

However, it doesn't do that all.  Even though it seems to have a
batch size of 10, but because it immediately reschedules itself
after the batch runs out, it's essentially just dumping all requests
at the underlying algorithm as fast as they're coming in.  The
underlying algorithm doesn't have need throttling anyway because
it'll do the work when the queue is full synchronously.

So why not just get rid of mcryptd completely and expose the
underlying algorithm as a proper async skcipher/hash?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
