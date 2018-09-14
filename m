Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1FFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DF320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DF320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeINLHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:07:34 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:37948 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbeINLHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:07:34 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g0h3t-00048m-7s; Fri, 14 Sep 2018 07:54:37 +0200
Date:   Fri, 14 Sep 2018 07:54:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>, linux@stwm.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20180914055437.77pffp2jrbfnykbp@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <3448099.9yk84El3Sa@stwm.de>
 <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
 <20180913.102305.939671149040995911.davem@davemloft.net>
 <20180913210325.5usfj2rorvuvtyc7@breakpoint.cc>
 <20180914050651.GD23674@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914050651.GD23674@gauss3.secunet.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> On Thu, Sep 13, 2018 at 11:03:25PM +0200, Florian Westphal wrote:
> > David Miller <davem@davemloft.net> wrote:
> > > From: Florian Westphal <fw@strlen.de>
> > > Date: Thu, 13 Sep 2018 18:38:48 +0200
> > > 
> > > > Wolfgang Walter <linux@stwm.de> wrote:
> > > >> What I can say is that it depends mainly on number of policy rules and SA.
> > > > 
> > > > Thats already a good hint, I guess we're hitting long hash chains in
> > > > xfrm_policy_lookup_bytype().
> > > 
> > > I don't really see how recent changes can influence that.
> > 
> > I don't think there is a recent change that did this.
> > 
> > Walter says < 4.14 is ok, so this is likely related to flow cache removal.
> > 
> > F.e. it looks like all prefixed policies end up in a linked list
> > (net->xfrm.policy_inexact) and are not even in a hash table.
> > 
> > I am staring at b58555f1767c9f4e330fcf168e4e753d2d9196e0
> > but can't figure out how to configure that away from the
> > 'no hashing for prefixed policies' default or why we even have
> > policy_inexact in first place :/
> 
> The hash threshold can be configured like this:
> 
> ip x p set hthresh4 0 0
> 
> This sets the hash threshold to local /0 and remote /0 netmasks.
> With this configuration, all policies should go to the hashtable.

Yes, but won't they all be hashed to same bucket?

[ jhash(addr & 0, addr & 0) ] ?

> Default hash thresholds are local /32 and remote /32 netmasks, so
> all prefixed policies go to the inexact list.

Yes.

Wolfgang, before having to work on getting perf into your router image
can you perhaps share a bit of info about the policies you're using?

How many are there?  Are they prefixed or not ("10.1.2.1")?
