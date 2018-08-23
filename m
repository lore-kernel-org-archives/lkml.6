Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA7BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98123208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98123208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeHWEcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:32:08 -0400
Received: from nautica.notk.org ([91.121.71.147]:49627 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbeHWEcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:32:07 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id EE414C009; Thu, 23 Aug 2018 03:04:57 +0200 (CEST)
Date:   Thu, 23 Aug 2018 03:04:42 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dave Watson <davejwatson@fb.com>
Cc:     Doron Roberts-Kedes <doronrk@fb.com>,
        Tom Herbert <tom@quantonium.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180823010442.GA6244@nautica>
References: <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
 <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
 <20180821225113.GA6515@nautica>
 <20180821233549.GA96607@doronrk-mbp.dhcp.thefacebook.com>
 <20180822004647.GA10656@nautica>
 <20180822023308.GA5970@doronrk-mbp.dhcp.thefacebook.com>
 <20180822054707.GA13455@nautica>
 <20180822183852.jnwlxnz54gbbf6po@davejwatson-mba.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822183852.jnwlxnz54gbbf6po@davejwatson-mba.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Watson wrote on Wed, Aug 22, 2018:
> > I've tried measuring that overhead as well by writing a more complex bpf
> > program that would fetch the offset in the skb but for some reason I'm
> > reading a 0 offset when it's not zero... well, not like there's much
> > choice for this at this point anyway; I don't think we'll do this
> > without pull, I'll put that on background.
> 
> For what it is worth we checked the offset in bpf, something
> along the lines of

Oh, thanks!

> 	  > struct kcm_rx_msg {   int full_len;  int offset;};
> static inline struct kcm_rx_msg *kcm_rx_msg(struct __sk_buff *skb)
>       { return (struct kcm_rx_msg *)skb->cb;}
> 
> int decode_framing(struct __sk_buff *skb)
> { return load_word(skb, kcm_rx_msg(skb)->offset);}

So you're taking directly the address at skb->cb but the linux code has
this function:
static inline struct strp_msg *strp_msg(struct sk_buff *skb)
{
        return (struct strp_msg *)((void *)skb->cb +
                offsetof(struct qdisc_skb_cb, data));
}
and qdisc_skb_cb.data is another 8 bytes in, that would explain I had
different results (and now I'm trying your snippet it does work), but
I'll have to admit I fail to understand this....

Ok, so 'cb' in __sk_buff is 48 bytes in but 'cb' in sk_buff is 40 bytes
in -- I might just start getting annoyed over this, is there a reason
for the different offset?!


> Although it did puzzle me for a while figuring that out when I ran in
> to it.

Well, at least it means some people were aware of the problem and worked
around it in their own way -- what do you think of pulling instead?
I mean, we could just document that "really well" and provide the
get-offset function in some header that would be made include-able from
bpf.. But right now this isn't really the case.


FWIW now I have this version I also don't notice any performance change
with the pull on my example, it actually looks like the bpf load_word is
slightly slower than pull to access data that is not in the head, but
the noise level is pretty bad.


Thanks,
-- 
Dominique
