Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD6AECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F7220693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F7220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeGRFpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:45:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:52092 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbeGRFpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:45:04 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 747EEC009; Wed, 18 Jul 2018 07:09:01 +0200 (CEST)
Date:   Wed, 18 Jul 2018 07:08:46 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        viro@ZenIV.linux.org.uk, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [V9fs-developer] [PATCH] p9_parse_header() validate PDU length
Message-ID: <20180718050846.GA16605@nautica>
References: <20180712110211.25535-1-tomasbortoli@gmail.com>
 <20180712114304.GB17774@nautica>
 <fed36388-4e18-49f4-ec26-2b6b3d08ef54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fed36388-4e18-49f4-ec26-2b6b3d08ef54@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Thu, Jul 12, 2018:
> + Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> On 07/12/2018 01:43 PM, Dominique Martinet wrote:
> > Tomas Bortoli wrote on Thu, Jul 12, 2018:
> >> This patch adds checks to the p9_parse_header() function to
> >> verify that the length found within the header coincides with the actual
> >> length of the PDU. Furthermore, it checks that the length stays within the
> >> acceptable range. To do this the patch brings the actual length of the PDU
> >> from the different transport layers (rdma and virtio). For TCP (trans_fd.c)
> >> the length is not know before, so we get it from the header but we check it
> >> anyway that it's within the valid range.
> 
> Still for TCP it you could read "garbage" pre-allocated memory but I
> don't know how much it is a risk, it might be a good idea to zero it
> post allocation (I mean pdu->sdata). Allocated at:
> 
> https://github.com/torvalds/linux/blob/master/net/9p/client.c#L236
> 
> > Just a note on transports here, I totally had forgotten about trans_xen
> > when we discussed this earlier as it is fairly new, but it looks like it
> > sets the length in the fcall properly so it should work without any
> > change.
> >
> > I however cannot test trans=xen, so if someone could either point me to
> > how to set that up (I couldn't find any decent documentation) or do some
> > very basic tests that would be great.
> 
> >> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> >> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
> > Looks good to me, as the rdma/virtio part come from my suggestion:
> > Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> 
> True
> >
> >> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> >> index 3d414acb7015..002badbcc9c0 100644
> >> --- a/net/9p/trans_rdma.c
> >> +++ b/net/9p/trans_rdma.c
> >> @@ -319,7 +319,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
> >>  
> >>  	if (wc->status != IB_WC_SUCCESS)
> >>  		goto err_out;
> >> -
> >> +	c->rc->size = wc->byte_len;
> > (nitpick, I'd keep the empty line here. If you don't mind I'll add it
> > back in my tree; this doesn't warrant a v2)
> >
> 
> Sure,
> 
> Tomas
> 
