Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1297C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292AA21486
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292AA21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeHVCNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 22:13:37 -0400
Received: from nautica.notk.org ([91.121.71.147]:52194 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeHVCNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 22:13:37 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 6E98CC009; Wed, 22 Aug 2018 00:51:28 +0200 (CEST)
Date:   Wed, 22 Aug 2018 00:51:13 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>
Cc:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180821225113.GA6515@nautica>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
 <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doron Roberts-Kedes wrote on Tue, Aug 21, 2018:
> On Tue, Aug 21, 2018 at 09:36:55PM +0200, Dominique Martinet wrote:
> > One of the solutions I had suggested was adding a flag at strparser
> > setup time to only do that pull for users which cannot handle offset,
> > but nobody seemed interested two weeks ago. I can still do that.
> 
> This seems overly complicated. 

That sounds much simpler than adding a similar feature to bpf if it
doesn't already support it -- we already have an user-provided struct at
strparser init timer (strp->cb) in which it would be easy to add a flag
saying whether the callbacks support offset or not.

That's maybe three more lines than the current patch, which is also
pretty simple, I'm not sure what you're expecting from alternative
solutions to call that overly complicated...


> It seems like we mainly agree that the proposed patch is suboptimal for
> existing clients of the library that use offset correctly (tls). 
> 
> It also seems like you've identified that the proper fix is in bpf. 

I don't think bpf itself needs to be changed here -- the offset is
stored in a strparser specific struct so short of such a skb_pull I
think we'd need to change the type of the bpf function, pass it it the
extra parameter, and make it a user visible change breaking the kcm
API... And I have no idea for sockmap but probably something similar.

I can't think of that as better than adding a flag to strparser.

(Also, note that pskb_pull will not copy any data or allocate memory
unless we're pulling past the end of the skb, which seems pretty
unlikely in that situation as we should have consumed any fully "eaten"
skb before getting to a new one here -- so in practice this patch just
adds a skb->data += offset with safety guards "just in case")


> As an aside, I would recommend reaching the netdev FAQ page:
> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> 
> It contains helpful hints about how to format email subjects (specifying
> net vs. net-next) and determining when trees are closed (currently
> closed). 

Thank you for pointing out to that document.
While this bug has been around from day one of kcm it is still a bug fix
so I'd rather let maintainers decide which tree it goes to.

I wasn't aware that net-next closes during the Linus merge window, but
if you want to split hairs, the FAQ says "do not send new net-next
content to netdev [while closed]" and this isn't new content as the v0
of the patch was mostly the same and sent before the 4.18 release, (and,
ironically, did not get any comment).
Anyway, sure, I'll wait until next week for a v2 if that matters.


Thanks,
-- 
Dominique
