Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 82BFBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38668208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38668208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756125AbeFOJ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:27:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:46957 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755645AbeFOJ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:27:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0725BAC3B;
        Fri, 15 Jun 2018 09:27:55 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id DC271A09E2; Fri, 15 Jun 2018 11:27:53 +0200 (CEST)
Date:   Fri, 15 Jun 2018 11:27:53 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc:     Yuchung Cheng <ycheng@google.com>, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
Message-ID: <20180615092753.lmxqh65moc33rzbq@unicorn.suse.cz>
References: <20180613164802.99B89A09E2@unicorn.suse.cz>
 <20180613165543.0F92DA09E2@unicorn.suse.cz>
 <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com>
 <alpine.DEB.2.20.1806141045430.29120@whs-18.cs.helsinki.fi>
 <20180614093408.5e34ijwhome4t5yn@unicorn.suse.cz>
 <alpine.DEB.2.20.1806141409150.29120@whs-18.cs.helsinki.fi>
 <20180614131801.hd474jgrhmtqzhag@unicorn.suse.cz>
 <alpine.DEB.2.20.1806151048000.29120@whs-18.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1806151048000.29120@whs-18.cs.helsinki.fi>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:05:03AM +0300, Ilpo Järvinen wrote:
> On Thu, 14 Jun 2018, Michal Kubecek wrote:
> > The trace wouldn't look so nice but it can be reproduced even with more
> > data to send. I've copied an example below. I couldn't find a really
> > nice one quickly so that first few retransmits (17:22:13.865105 through
> > 17:23:05.841105) are without new data but starting at 17:23:58.189150,
> > you can see that sending new (previously unsent) data may not suffice to
> > break the loop.
> 
> My point was that the new data segment bursts that occur if the sender 
> isn't application limited indicate that there's something going wrong
> with FRTO. And that wrong is also what is causing that RTO loop because
> the sender doesn't see the previous FRTO recovery on second RTO. With 
> my FRTO undo fix, (new_recovery || icsk->icsk_retransmits) will be false
> and that will prevent the RTO loop.

Yes, it would prevent the loop in this case (except it would be a bit
later, after second RTO rather than after first). But I'm not convinced
the logic of the patch is correct. If I understand it correctly, it
essentially changes "presumption of innocence" (if we get an ack past
what we retransmitted, we assume it was received earlier - i.e. would
have been sacked before if SACK was in use) to "presumption of guilt"
(whenever a retransmitted segment is acked, we assume nothing else acked
with it was received earlier). Or that you trade false negatives for
false positives.

Maybe I understand it wrong but it seems that you de facto prevent
Step (3b) from ever happening in non-SACK case.

> > > No! The window should not update window on ACKs the receiver intends to 
> > > designate as "duplicate ACKs". That is not without some potential cost 
> > > though as it requires delaying window updates up to the next cumulative 
> > > ACK. In the non-SACK series one of the changes is fixing this for
> > > non-SACK Linux TCP flows.
> > 
> > That sounds like a reasonable change (at least at the first glance,
> > I didn't think about it too deeply) but even if we fix Linux stack to
> > behave like this, we cannot force everyone else to do the same.
> 
> Unfortunately I don't know what the other stacks besides Linux do. But 
> for Linux, the cause for the changing receiver window is the receiver 
> window auto-tuning and I'm not sure if other stacks have a similar 
> feature (or if that affects (almost) all ACKs like in Linux).

The capture from my previous e-mail and some others I have seen indicate
that at least some implementations do not take care to never change
window size when responding to an out-of-order segment.  That means that
even if we change linux TCP this way (we might still need to send
a separate window update in some cases), we still cannot rely on others
doing the same.

I checked the capture attached to my previous e-mail again and there is
one thing where our F-RTO implementation (in 4.4, at least) is wrong,
IMHO. While the first ACK after "new data" (sent in (2b)) was a window
update (and therefore not dupack by definition) so that we could take
neither (3a) nor (3b), in some iterations there were further acks which
did not change window size. The text just before Step 1 says

  The F-RTO algorithm does not specify actions for receiving
  a segment that neither acknowledges new data nor is a duplicate
  acknowledgment.  The TCP sender SHOULD ignore such segments and
  wait for a segment that either acknowledges new data or is
  a duplicate acknowledgment.

My understanding is that this means that while the first ack after new
data is correctly ignored, the following ack which preserves window size
should be recognized as a dupack and (3a) should be taken.

Michal Kubecek
