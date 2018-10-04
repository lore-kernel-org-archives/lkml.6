Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFCC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004F52084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004F52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeJDUvT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:51:19 -0400
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:43500 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbeJDUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:51:19 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 42Qvbh5BgdzMkyt;
        Thu,  4 Oct 2018 15:57:52 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Thu, 04 Oct 2018 15:57:52 +0200
Message-ID: <1729915.dWWxddREcQ@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.14.61-debian64.all+1.1; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20181002213536.sgjansduqenps2md@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc> <4327972.7bla238zOs@stwm.de> <20181002213536.sgjansduqenps2md@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 2. Oktober 2018, 23:35:36 schrieb Florian Westphal:
> Wolfgang Walter <linux@stwm.de> wrote:
> > Am Dienstag, 2. Oktober 2018, 16:56:16 schrieb Florian Westphal:
> > > I'm experimenting with per-dst inexact lists in an rbtree but
> > > this will take time.
> > 
> > Hmm, I doubt that this is worth the effort. And certainly not that easy
> 
> Well, I'm not going to send a revert of the flowcache removal.
> 
> I'm willing to experiment with alternatives to a full iteration of the
> inexact list but thats it.

If this brings performance back to pre-removal, I'm fine with that. I'm even 
fine if it is slower by a factor of 2.

I think it is a serious regression, and there is no workaround, and therefor 
it cannot stay like that.

So I still hope that reverting is an option if no acceptable solution can be 
found.

> 
> > correctly done, as it still would have to obey the original order of the
> > rules (their priority).
> 
> Except that neither the priority or the order in which it was added
> matters in case the selector doesn't match.

To match a packet one has to find all matching rules and chose that one with 
the lowest priority.

"indexing" by dst will not help much if you have a ruleset where a lot of 
rules sharing a dst. You also have to replicate rules with dsts that have a 
prefix oft another dst as they may habe a higher priority even if they are 
less specific.

Every such entry may again have such an "indexing" by dst. Only then this 
would be efficient.

> 
> I see no reason why we can't have inexact lists done per dst<->src pairs.
> 
> > You may have a lot of rules of the form say
> > 
> > 	10.0.0.0/16 <=> 10.1.0.0/29 encrypt ....
> > 	10.0.0.0/16 <=> 10.1.0.8/29 encrypt ....
> 

<=> means (in the forwarding case) that the rule set contains the inverted 
rule (at least if you use it in usually ways). So 

	10.0.0.0/16 <=> 10.1.0.0/29 encrypt ....

means

	10.0.0.0/16 => 10.1.0.0/29
	10.1.0.0/29 => 10.0.0.0/16

> Sure.
> 
> > Also, you get something like that
> > 
> > 	10.0.1.0/24 <=> 10.0.2.0/29 allow
> > 	10.0.0.0/16 <=> 10.0.2.0/24 encrypt
> > 	0.0.0.0 <=> 10.0.2.0/16 block
> > 
> > And people may use source port and/or destination port or protocol
> > (tcp/udp/imcp) to further tailor there ruleset.
> 
> Yes. 0.0.0.0/0 handling will require some extra consideration.
> 

There may also be rulesets like

	10.0.1.0/24 => 10.1.0.0/29 encrypt X
	10.0.0.0/16 => 10.1.0.0/29 encrypt Y

Or

	10.0.0.0/16 *  => 10.1.0.0/24 80 encrypt Y
	10.0.1.0/24 * => 10.1.0.0/17 * encrypt X
	10.0.0.0/16 *  => 10.1.0.0/20 * encrypt Z

> So far I have not seen a show-stopper however.

I wonder why there is no such thing for netfilter or the rules list in 
routing. nf does not have such a thing, either. This is the reason why I think 
that this is not that easy and for longterm kernel 4.14 the best solution will 
be a revert anyway.

Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
