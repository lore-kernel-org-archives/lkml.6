Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA70C206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeLNOfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:35:47 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:57406 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729766AbeLNOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:35:46 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gXoYu-0008Ku-1v; Fri, 14 Dec 2018 15:35:32 +0100
Date:   Fri, 14 Dec 2018 15:35:32 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Wolfgang Walter <linux@stwm.de>
Cc:     Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        christophe.gouault@6wind.com
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
Message-ID: <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc>
References: <00000000000075fe86057ca6367e@google.com>
 <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
 <20181210.095856.580441946779980596.davem@davemloft.net>
 <2559562.n5nkmlqv4s@stwm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2559562.n5nkmlqv4s@stwm.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Walter <linux@stwm.de> wrote:

[ CCing Christophe ]

> Am Montag, 10. Dezember 2018, 09:58:56 schrieb David Miller:
> > From: Florian Westphal <fw@strlen.de>
> > Date: Mon, 10 Dec 2018 13:47:24 +0100
> > 
> > > After recent tree conversion, we could probably make the exact policies
> > > part of the 'inexact tree' (which would be renamed to 'policy tree' or
> > > some such).
> > > 
> > > Special-casing the exact policies made a lot of sense when we had
> > > a single list for the inexact policies (to keep its length down).
> > > 
> > > But now I think we could try to unify all of this and only maintain
> > > the existing tree-based storage.
> > > 
> > > Would also remove the need to do lookups in two different
> > > data structures (bydst-hash-then-inexact-tree).
> > > 
> > > What do you think?
> > 
> > I think this makes a lot of sense.
> 
> Sites mainly using tunnel mode this certainly makes sense.

Ok.  An alternative would be to remove the support for
policy hash table thresholds (which decide what kinds of policies
go to exact table and which ones go into inexact ones), i.e.
partially revert 880a6fab8f6ba5b5abe59ea6
("xfrm: configure policy hash table thresholds by netlink").

This would remove the need for the rehashing support that
re-sorts the policies into either exact/inexact lists) when the
those tunables are changed.

We could also easily convert the exact table to an rhashtable
then if we wanted to.

I guess we should probably wait to get some operational feedback on the
inexact storage first to see if it really improves things enough to
make threshold tuning unneccessary.

Christophe, whats your take?
