Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF494C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539B214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7539B214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeHVJKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:10:45 -0400
Received: from nautica.notk.org ([91.121.71.147]:59924 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbeHVJKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:10:45 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 12A97C009; Wed, 22 Aug 2018 07:47:22 +0200 (CEST)
Date:   Wed, 22 Aug 2018 07:47:07 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>
Cc:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180822054707.GA13455@nautica>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
 <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
 <20180821225113.GA6515@nautica>
 <20180821233549.GA96607@doronrk-mbp.dhcp.thefacebook.com>
 <20180822004647.GA10656@nautica>
 <20180822023308.GA5970@doronrk-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822023308.GA5970@doronrk-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doron Roberts-Kedes wrote on Tue, Aug 21, 2018:
> > strparser logic in that case -- it might work to pull in the parser
> > function but it might not work in rcv for all I know, or the next user
> > might think that since pull is ok some other operation on the skb is as
> > well...
> 
> Just to make sure I understand, is it possible you meant to say that the
> other way around? Surely the rcv callback can do whatever it wants with
> the skb. Its the parse callback that may need to be a little more
> careful with the skb.

Hmm, right, when we call the rcv callback we remove the skb from
strp->skb_head, and by the next iteration we have a new clone of the
orig_skb so it looks safe, but that's not something that's obvious at
first glance; it works because the skb was cloned at the start of the
loop.


> For the parse case, why not just clone and pull? 

Hmm, if we clone I guess there is no side effect to fear, that could be
acceptable... It feels that we're just pushing more overhead on to
kcm/sockmap though; in strparser's __strp_recv we know we can pull
safely so doing it there feels simpler to me.

After testing the overhead doesn't seem to be bad though, it looks like
it's less than the noise level on my laptop on performance governor; the
only thing to pay attention to is that if we clone here I'll need to
also add another pull in sockmap's rcv function
(smap_read_sock_strparser) that doesn't handle offset either.

If we only pull just before parsing I think rcv is also guaranteed to
have no offset, it has to start with the same offset as the parsing
unless the user changed it, right?



Anyway there's progress, we're down to these two-ish choices if I
followed correctly:
 - add a flag in strp_callbacks that says offsets are ok or not for
parsing, and just pull if it's set.
Now we're back to that I'd be moving the pull just before parsing like I
did in v0, as that's easier to follow.
 or
 - add a (clone?+)pull in kcm_rcv_strparser and smap_parse_func_strparser
(+ in smap_read_sock_strparser if clone)


(As a side note, I noticed this patch is bugged, orig_offset/eaten
shouldn't be reset to zero after the pull (and thus orig_len doesn't
need changing either); that's what I get for trying to "simplify"
something that was simpler in the v0 to me...)


> > As I wrote above, I think it should not be possible, so we're not
> > even talking about a small percentage here.
> > The reason I didn't use skb_pull (the head-only variant) is that I'd
> > rather have the overhead than a BUG() if I'm wrong on this...
> 
> A printk in that section when (orig_offset + eaten > skb_headlen(head)) 
> confirms that this case is not uncommon or impossible. Would have to do
> more work to see how many hundreds of times per second, but it is not a
> philosophical concern.

Hmm, right, it does happen if I force two bigger packets in a single
write() on my reproducer; I guess my workload didn't exhibit that
behaviour with a 9p client...

I've tried measuring that overhead as well by writing a more complex bpf
program that would fetch the offset in the skb but for some reason I'm
reading a 0 offset when it's not zero... well, not like there's much
choice for this at this point anyway; I don't think we'll do this
without pull, I'll put that on background.

-- 
Dominique

