Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71687C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 00:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2DD217BE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 00:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2DD217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeHVEJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 00:09:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:52803 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbeHVEJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 00:09:32 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 2C020C009; Wed, 22 Aug 2018 02:47:02 +0200 (CEST)
Date:   Wed, 22 Aug 2018 02:46:47 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>
Cc:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180822004647.GA10656@nautica>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
 <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
 <20180821225113.GA6515@nautica>
 <20180821233549.GA96607@doronrk-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821233549.GA96607@doronrk-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doron Roberts-Kedes wrote on Tue, Aug 21, 2018:
> On Wed, Aug 22, 2018 at 12:51:13AM +0200, Dominique Martinet wrote:
> > That's maybe three more lines than the current patch, which is also
> > pretty simple, I'm not sure what you're expecting from alternative
> > solutions to call that overly complicated...
> 
> The line count is not the source of the complexity. The undue complexity
> is having strparser operate in two modes: one for clients that properly
> use the API by respecting the value of offset, and another for clients 
> that do not. 

I might sound stubborn at this point but that still does not sound
complex compared to the alternatives I can think of.


> > I don't think bpf itself needs to be changed here -- the offset is
> > stored in a strparser specific struct so short of such a skb_pull I
> > think we'd need to change the type of the bpf function, pass it it the
> > extra parameter, and make it a user visible change breaking the kcm
> > API... And I have no idea for sockmap but probably something similar.
> 
> I'm not sure I follow you here. Any rcv_msg callback implementation
> receives an skb. Calling strp_msg() on the skb gives you the strp_msg
> which has the offset value. Can you explain why passing an extra
> parameter is necessary to get the offset?


Yes, the rcv_msg callback itself can get the offset easily, and it's not
that which needs an extra parameter but the bpf function kcm/sockmap are
calling which would need either an extra parameter or changing to get
that value themselves -- the later is probably not very difficult and
won't break the API, but at the same time pushes the responsability to
kcm/sockmap users who will get that wrong and waste time trying to
understand how kcm works like I did.

Breaking the API has the advantage that users will get an error telling
them to update their bpf program instead of randomly failing when tcp
aggregation happens.

For what it's worth, I don't think either are acceptable solutions, I'm
just stating what would a "fix in bpf" would be.


A "fix in kcm/sockmap" would be to pull just before calling the bpf
program, which could be a middle ground, but I think that's more
perverse than adding a flag to strparser for new users because we'd
basically be saying users should modify the skb that strparser users
under its feet, and there is no guarantee what would happen to the
strparser logic in that case -- it might work to pull in the parser
function but it might not work in rcv for all I know, or the next user
might think that since pull is ok some other operation on the skb is as
well...


> > (Also, note that pskb_pull will not copy any data or allocate memory
> > unless we're pulling past the end of the skb, which seems pretty
> > unlikely in that situation as we should have consumed any fully "eaten"
> > skb before getting to a new one here -- so in practice this patch just
> > adds a skb->data += offset with safety guards "just in case")
> 
> Yes, no data will be copied if the you don't pull beyond the linear
> buffer. Adding overhead even in a small percentage of cases still
> requires a good justification.

As I wrote above, I think it should not be possible, so we're not
even talking about a small percentage here.
The reason I didn't use skb_pull (the head-only variant) is that I'd
rather have the overhead than a BUG() if I'm wrong on this...

> In this particular case, I think a good justification would be
> demonstrating that it is impractical for the buggy strparser users
> you've pointed out to use the existing API and respect the value of
> offset.

That's what the previous paragraph about changing the API intended to
do.

> You have indicated that you are not super familiar with the bpf code,
> which is fine (I'm not either), but this isn't a good reason to make a
> change to strparser instead of bpf. 

I didn't even know kcm/strparser existed a few weeks ago, not being
familiar doesn't mean I didn't look at how it works.

I'd be glad to be proven wrong here but I really do not think there is a
possibility within the bpf framework to give a fake skb with an external
offset to the bpf program transparently.

Assuming there is, it would have to be more expensive than a pull (it'd
basically need to do a pull then restore the original data somehow)...

And if there isn't I certainly do not want to add one, not because I
don't want to mess with something I'm not too familiar with (that'd
actually be an argument to do it that way to me), but because I do not
think it belongs there; bpf should not need to know what a skb is or how
it works.


All being said I'm still convinced having two modes in strparser is the
simplest solution.

-- 
Dominique
