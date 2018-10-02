Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF9C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4701A2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4701A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeJCEVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:21:06 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:39054 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbeJCEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:21:05 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g7SKO-0006eK-V0; Tue, 02 Oct 2018 23:35:37 +0200
Date:   Tue, 2 Oct 2018 23:35:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Wolfgang Walter <linux@stwm.de>
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20181002213536.sgjansduqenps2md@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <4708967.r5gU1pxIcW@stwm.de>
 <20181002145616.pwdhbmafgsihbxvm@breakpoint.cc>
 <4327972.7bla238zOs@stwm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4327972.7bla238zOs@stwm.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Walter <linux@stwm.de> wrote:
> Am Dienstag, 2. Oktober 2018, 16:56:16 schrieb Florian Westphal:
> > I'm experimenting with per-dst inexact lists in an rbtree but
> > this will take time.
> 
> Hmm, I doubt that this is worth the effort. And certainly not that easy 

Well, I'm not going to send a revert of the flowcache removal.

I'm willing to experiment with alternatives to a full iteration of the
inexact list but thats it.

> correctly done, as it still would have to obey the original order of the rules 
> (their priority).

Except that neither the priority or the order in which it was added
matters in case the selector doesn't match.

I see no reason why we can't have inexact lists done per dst<->src pairs.

> You may have a lot of rules of the form say
> 
> 	10.0.0.0/16 <=> 10.1.0.0/29 encrypt ....
> 	10.0.0.0/16 <=> 10.1.0.8/29 encrypt ....

Sure.

> Also, you get something like that
> 
> 	10.0.1.0/24 <=> 10.0.2.0/29 allow
> 	10.0.0.0/16 <=> 10.0.2.0/24 encrypt
> 	0.0.0.0 <=> 10.0.2.0/16 block
> 
> And people may use source port and/or destination port or protocol 
> (tcp/udp/imcp) to further tailor there ruleset.

Yes. 0.0.0.0/0 handling will require some extra consideration.

So far I have not seen a show-stopper however.
