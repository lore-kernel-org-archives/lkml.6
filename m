Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1963C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707C820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707C820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeJaLxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:53:19 -0400
Received: from nautica.notk.org ([91.121.71.147]:48536 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbeJaLxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:53:19 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 3F696C009; Wed, 31 Oct 2018 03:57:12 +0100 (CET)
Date:   Wed, 31 Oct 2018 03:56:57 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Miller <davem@davemloft.net>
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20181031025657.GA17861@nautica>
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica>
 <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180918015723.GA26300@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Tue, Sep 18, 2018:
> David Miller wrote on Mon, Sep 17, 2018:
> > From: Dominique Martinet <asmadeus@codewreck.org>
> > Date: Wed, 12 Sep 2018 07:36:42 +0200
> > > Dominique Martinet wrote on Tue, Sep 11, 2018:
> > >> Hmm, while trying to benchmark this, I sometimes got hangs in
> > >> kcm_wait_data() for the last packet somehow?
> > >> The sender program was done (exited (zombie) so I assumed the sender
> > >> socket flushed), but the receiver was in kcm_wait_data in kcm_recvmsg
> > >> indicating it parsed a header but there was no skb to peek at?
> > >> But the sock is locked so this shouldn't be racy...
> > >> 
> > >> I can get it fairly often with this patch and small messages with an
> > >> offset, but I think it's just because the pull changes some timing - I
> > >> can't hit it with just the clone, and I can hit it with a pull without
> > >> clone as well.... And I don't see how pulling a cloned skb can impact
> > >> the original socket, but I'm a bit fuzzy on this.
> > > 
> > > This is weird, I cannot reproduce at all without that pull, even if I
> > > add another delay there instead of the pull, so it's not just timing...
> > 
> > I really can't apply this patch until you resolve this.
> > 
> > It is weird, given your description, though...
> 
> Thanks for the reminder! I totally agree with you here and did not
> expect this to be merged as it is (in retrospect, I probably should have
> written something to that extent in the subject, "RFC"?)

Found the issue after some trouble reproducing on other VM, long story
short:
 - I was blaming kcm_wait_data's sk_wait_data to wait while there was
something in sk->sk_receive_queue, but after adding a fake timeout and
some debug messages I can see the receive queue is empty.
However going back up from the kcm_sock to the kcm_mux to the kcm_psock,
there are things in the psock's socket's receive_queue... (If I'm
following the code correctly, that would be the underlying tcp socket)

 - that psock's strparser contains some hints: the interrupted and
stopped bits are set. strp->interrupted looks like it's only set if
kcm_parse_msg returns something < 0. . .
And surely enough, the skb_pull returns NULL iff there's such a hang...!

I might be tempted to send a patch to strparser to add a pr_debug
message in strp_abort_strp...

Anyway, that probably explains I have no problem with bigger VM
(uselessly more memory available) or without KASAN (I guess there's
overhead?), but I'm sending at most 300k of data and the VM has a 1.5GB
of ram, so if there's an allocation failure there I think there's a
problem ! . . .

So, well, I'm not sure on the way forward. Adding a bpf helper and
document that kcm users should mind the offset?

Thanks,
-- 
Dominique
