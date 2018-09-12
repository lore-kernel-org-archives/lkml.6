Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D382C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB58620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB58620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeILKju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:39:50 -0400
Received: from nautica.notk.org ([91.121.71.147]:41477 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeILKju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:39:50 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id F040BC009; Wed, 12 Sep 2018 07:36:57 +0200 (CEST)
Date:   Wed, 12 Sep 2018 07:36:42 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20180912053642.GA2912@nautica>
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Tue, Sep 11, 2018:
> Hmm, while trying to benchmark this, I sometimes got hangs in
> kcm_wait_data() for the last packet somehow?
> The sender program was done (exited (zombie) so I assumed the sender
> socket flushed), but the receiver was in kcm_wait_data in kcm_recvmsg
> indicating it parsed a header but there was no skb to peek at?
> But the sock is locked so this shouldn't be racy...
> 
> I can get it fairly often with this patch and small messages with an
> offset, but I think it's just because the pull changes some timing - I
> can't hit it with just the clone, and I can hit it with a pull without
> clone as well.... And I don't see how pulling a cloned skb can impact
> the original socket, but I'm a bit fuzzy on this.

This is weird, I cannot reproduce at all without that pull, even if I
add another delay there instead of the pull, so it's not just timing...

I was confusing kcm_recvmsg and kcm_rcv_strparser but I still think
there is a race in kcm_wait_data between the peek and the wait. I have
confirmed on a hang that the sock's sk_receive_queue is not empty so
skb_peek would return something at this point, but it is waiting in
kcm_wait_data's sk_wait_data.. And no event would be coming at this
point since the sender is done.

kcm_wait_data does have the socket lock but the enqueuing counterpart
(kcm_queue_rcv_skb) is apparently called without lock most of the time
(at least, sk->sk_lock.owned is not set most of the times) ; but if I
add a lock_sock() here it can deadlock when a kfree_skb triggers
kcm_rcv_ready if that kfree_skb was done with the lock... ugh.

I thought the mux rx lock would be taken all the time but that appear
not to be the case either, and even if it were I don't see how to make
sk_wait_data with another lock in the first place.


So meh, I'm not sure why the pull messes up with this, I'm tempted to
say this is an old problem but I'm quite annoyed I do not seem to be
able to reproduce it.
I'm really out of time now so unless someone cares it'll wait for a few
more weeks.


(As an unrelated note, wrt to the patch, it might be nice to add a new
kcm socket option so users could say "my bpf program handles offsets,
don't bother with this")
-- 
Dominique
