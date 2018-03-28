Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeC1GEo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:04:44 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46528 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeC1GEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:04:43 -0400
Date: Wed, 28 Mar 2018 14:04:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
Message-ID: <20180328060432.GA16291@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718434.11435.6551477417902631683.stgit@noble>
 <20180327155610.GD14001@gondor.apana.org.au>
 <87y3id42zo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3id42zo.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 08:34:19AM +1100, NeilBrown wrote:
>
> It is easy to get an -EBUSY insertion failure when .disable_count is
> enabled, and I did get that.  Blindly propagating that up caused lustre
> to get terribly confused - not too surprising really.

Right, so this failure mode is specific to your patch 6.

I think I see the problem.  As it currently stands, we never
need growing when we hit the bucket length limit.  We only do
rehashes.

With your patch, you must change it so that we actually try to
grow the table if necessary when we hit the bucket length limit.

Otherwise it will result in the EBUSY that you're seeing.

I laso think that we shouldn't make this a toggle.  If we're going
to do disable_count then it should be unconditionally done for
everyone.

However, I personally would prefer a percpu elem count instead of
disabling it completely.  Would that be acceptable to your use-case?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
