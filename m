Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBB0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AF32089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AF32089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeGIX3i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:29:38 -0400
Received: from nautica.notk.org ([91.121.71.147]:59294 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754502AbeGIX3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:29:37 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7FFDFC009; Tue, 10 Jul 2018 01:29:35 +0200 (CEST)
Date:   Tue, 10 Jul 2018 01:29:20 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, lucho@ionkov.net,
        ericvh@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, rminnich@sandia.gov,
        davem@davemloft.net
Subject: Re: [V9fs-developer] [PATCH] Integer underflow in pdu_read()
Message-ID: <20180709232920.GA19917@nautica>
References: <20180709192651.28095-1-tomasbortoli@gmail.com>
 <20180709193151.GI30522@ZenIV.linux.org.uk>
 <bc857171-8abb-765c-d722-908ab743cd6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc857171-8abb-765c-d722-908ab743cd6e@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Tue, Jul 10, 2018:
> > What does cause the calls of pdu_read() in such conditions and shouldn't *that*
> > be dealt with?
>
> Mmh I think that's caused by p9_parse_header(). That function reads the
> first 7 bytes of a PDU regardless of the current offset. It then sets
> the PDU length to the one read and then it restores the original offset.
> Therefore, it's possible to set a size < offset here.
> (to be 100% sure I'd need more debugging)

It doesn't always restore the original offset; but if the packet lied
and said its size is < 7 it doesn't even need to.

I think as things stand it should be enough to fix it there, once the
state machine is runnning there don't seem to be any way of making
offset jump over size; but I'm not fussy either way, protecting in
pdu_read is probably just as good.
Note that there is another "min_t(uint32_t, *count, pdu->size -
pdu->offset)" that needs a similar check below in the file if you want
to go this way.

On the other hand, pdu_write() calls come from the system so hopefully
these are a bit more trustworthy, but I guess the extra check could
protect against a programming error.
I'm not sure what the linux kernel policy about these "redundant"
low-level checks is as this is technically in the fast path.

 
> We can prevent it in p9_parse_header(), but if the invariant offset <
> size gets broken elsewhere we fall back to the underflow. Enforcing it
> in pdu_read() should be the safest thing to do as it would detect *any*
> bad read.

The main problem is that 9p is just too trusty of what is sent to it.
To further extent what was said in the other thread ("[PATCH] KASAN:
slab-out-of-bounds Read in pdu_read") the extra check on pdu->size that
must be smaller than actual read size holds for p9_check_zc_error as
well so should probably be moved to p9_parse_header() ; but a packet
that says its size is < 7 is also wrong : for trans_fd, we are guaranted
to have read as much by the transport, so once again size didn't match
up.
Ideally, pdu->size should only ever be set by the transport who know
what they have read, and p9_parse_header should check that r_size ==
pdu->size and error if not.


Also, as TCP is a stream protocol, once we've had a single packet lie
about its size we're lost in the stream with no chance of recovering so
the connection should probably be aborted.
For rdma/virtio there is a notion of packet so they could recover, but
TCP is not as forgiving...

-- 
Dominique Martinet | Asmadeus
