Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF9C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF6120861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF6120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeINCOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:14:42 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:36658 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbeINCOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:14:42 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g0Ylp-0001sy-NN; Thu, 13 Sep 2018 23:03:25 +0200
Date:   Thu, 13 Sep 2018 23:03:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     David Miller <davem@davemloft.net>
Cc:     fw@strlen.de, linux@stwm.de, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20180913210325.5usfj2rorvuvtyc7@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <3448099.9yk84El3Sa@stwm.de>
 <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
 <20180913.102305.939671149040995911.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913.102305.939671149040995911.davem@davemloft.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:
> From: Florian Westphal <fw@strlen.de>
> Date: Thu, 13 Sep 2018 18:38:48 +0200
> 
> > Wolfgang Walter <linux@stwm.de> wrote:
> >> What I can say is that it depends mainly on number of policy rules and SA.
> > 
> > Thats already a good hint, I guess we're hitting long hash chains in
> > xfrm_policy_lookup_bytype().
> 
> I don't really see how recent changes can influence that.

I don't think there is a recent change that did this.

Walter says < 4.14 is ok, so this is likely related to flow cache removal.

F.e. it looks like all prefixed policies end up in a linked list
(net->xfrm.policy_inexact) and are not even in a hash table.

I am staring at b58555f1767c9f4e330fcf168e4e753d2d9196e0
but can't figure out how to configure that away from the
'no hashing for prefixed policies' default or why we even have
policy_inexact in first place :/

I'll look at this again tomorrow.
