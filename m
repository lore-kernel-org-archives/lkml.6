Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9260EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1984520896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1984520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helsinki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965694AbeFOKfy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:35:54 -0400
Received: from smtp-rs2-vallila1.fe.helsinki.fi ([128.214.173.73]:60906 "EHLO
        smtp-rs2-vallila1.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965577AbeFOKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:35:52 -0400
Received: from whs-18.cs.helsinki.fi (whs-18.cs.helsinki.fi [128.214.166.46])
        by smtp-rs2.it.helsinki.fi (8.14.7/8.14.7) with ESMTP id w5FAZjWT023352;
        Fri, 15 Jun 2018 13:35:45 +0300
Received: by whs-18.cs.helsinki.fi (Postfix, from userid 1070048)
        id 37D903601A6; Fri, 15 Jun 2018 13:35:45 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by whs-18.cs.helsinki.fi (Postfix) with ESMTP id 363E0360045;
        Fri, 15 Jun 2018 13:35:45 +0300 (EEST)
Date:   Fri, 15 Jun 2018 13:35:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@whs-18.cs.helsinki.fi
To:     Michal Kubecek <mkubecek@suse.cz>
cc:     Yuchung Cheng <ycheng@google.com>, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
In-Reply-To: <20180615092753.lmxqh65moc33rzbq@unicorn.suse.cz>
Message-ID: <alpine.DEB.2.20.1806151230340.29120@whs-18.cs.helsinki.fi>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz> <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com> <alpine.DEB.2.20.1806141045430.29120@whs-18.cs.helsinki.fi> <20180614093408.5e34ijwhome4t5yn@unicorn.suse.cz>
 <alpine.DEB.2.20.1806141409150.29120@whs-18.cs.helsinki.fi> <20180614131801.hd474jgrhmtqzhag@unicorn.suse.cz> <alpine.DEB.2.20.1806151048000.29120@whs-18.cs.helsinki.fi> <20180615092753.lmxqh65moc33rzbq@unicorn.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-4507525-1529057656=:29120"
Content-ID: <alpine.DEB.2.20.1806151315540.29120@whs-18.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-4507525-1529057656=:29120
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.20.1806151315541.29120@whs-18.cs.helsinki.fi>

On Fri, 15 Jun 2018, Michal Kubecek wrote:

> On Fri, Jun 15, 2018 at 11:05:03AM +0300, Ilpo Järvinen wrote:
> > On Thu, 14 Jun 2018, Michal Kubecek wrote:
> > 
> > My point was that the new data segment bursts that occur if the sender 
> > isn't application limited indicate that there's something going wrong
> > with FRTO. And that wrong is also what is causing that RTO loop because
> > the sender doesn't see the previous FRTO recovery on second RTO. With 
> > my FRTO undo fix, (new_recovery || icsk->icsk_retransmits) will be false
> > and that will prevent the RTO loop.
> 
> Yes, it would prevent the loop in this case (except it would be a bit
> later, after second RTO rather than after first).

Hmm, I'm actually wrong about the new data missing bit I think. After
reading more code I'm quite sure conventional RTO recovery is triggered 
right away (as long as that bogus undo that ends the recovery wouldn't
occur first like it does without my fix). So no second RTO would be 
needed.

> But I'm not convinced
> the logic of the patch is correct. If I understand it correctly, it
> essentially changes "presumption of innocence" (if we get an ack past
> what we retransmitted, we assume it was received earlier - i.e. would
> have been sacked before if SACK was in use) to "presumption of guilt"
> (whenever a retransmitted segment is acked, we assume nothing else acked
> with it was received earlier). Or that you trade false negatives for
> false positives.

FRTO depends on knowing for sure what packet (original pre-RTO one or 
something that was transmitted post-RTO) triggered the ACK. If FRTO
isn't sure that the ACK was generated by a post-RTO packet, it must
not assume innocence! This change in practice affects just the time while 
the segment rexmitted by RTO is still there, that is, processing in step 2 
(if we get a cumulative ACK beyond it because the next loss is not for the 
subsequent segment but for some later segment, FLAG_ORIG_SACK_ACKED is set 
and we'll incorrectly do step 3b while still in FRTO has only reached step 
2 for real; this is fixed by my patch). ...The decision about 
positive/negative only occurs _after_ that in step 3.

> Maybe I understand it wrong but it seems that you de facto prevent
> Step (3b) from ever happening in non-SACK case.

Only if any of skb that was ACKed had been retransmitted. There shouldn't 
be any in step 3 because the RTO rexmit was ACKed (and also because 
of how new_recovery variable works wrt. earlier recoveries). Thus, in
step 3 the fix won't clear FLAG_ORIG_SACK_ACKED flag allowing FRTO to 
detect spurious RTOs using step 3b.

> > > > No! The window should not update window on ACKs the receiver intends to 
> > > > designate as "duplicate ACKs". That is not without some potential cost 
> > > > though as it requires delaying window updates up to the next cumulative 
> > > > ACK. In the non-SACK series one of the changes is fixing this for
> > > > non-SACK Linux TCP flows.
> > > 
> > > That sounds like a reasonable change (at least at the first glance,
> > > I didn't think about it too deeply) but even if we fix Linux stack to
> > > behave like this, we cannot force everyone else to do the same.
> > 
> > Unfortunately I don't know what the other stacks besides Linux do. But 
> > for Linux, the cause for the changing receiver window is the receiver 
> > window auto-tuning and I'm not sure if other stacks have a similar 
> > feature (or if that affects (almost) all ACKs like in Linux).
> 
> The capture from my previous e-mail and some others I have seen indicate
> that at least some implementations do not take care to never change
> window size when responding to an out-of-order segment.  That means that
> even if we change linux TCP this way (we might still need to send
> a separate window update in some cases), we still cannot rely on others
> doing the same.

Those implementations ignore what is a duplicate ACK (RFC5681, which
is also pointed into by RFC5682 for its defination):
  DUPLICATE ACKNOWLEDGMENT: An acknowledgment is considered a
      "duplicate" ... (e)
      the advertised window in the incoming acknowledgment equals the
      advertised window in the last incoming acknowledgment.

Not sending duplicate ACKs also means that fast recovery will not work
for those flows but that may not show up performance wise as long as you 
have enough capacity for any unnecessary rexmits the forced RTO recovery 
is going to do. RTO recovery may actually improve completion times for 
non-SACK flows as NewReno recovers only one lost pkt/RTT where as RTO 
recovery needs log(outstanding packets) RTTs at worst. For a large number 
of losses in a window, the log is going to win.

> I checked the capture attached to my previous e-mail again and there is
> one thing where our F-RTO implementation (in 4.4, at least) is wrong,
> IMHO. While the first ACK after "new data" (sent in (2b)) was a window
> update (and therefore not dupack by definition) so that we could take
> neither (3a) nor (3b), in some iterations there were further acks which
> did not change window size. The text just before Step 1 says
> 
>   The F-RTO algorithm does not specify actions for receiving
>   a segment that neither acknowledges new data nor is a duplicate
>   acknowledgment.  The TCP sender SHOULD ignore such segments and
>   wait for a segment that either acknowledges new data or is
>   a duplicate acknowledgment.
> 
> My understanding is that this means that while the first ack after new
> data is correctly ignored, the following ack which preserves window size
> should be recognized as a dupack and (3a) should be taken.

Linux FRTO never gets that far (without my fix) if the ACK in step 2
covers beyond the RTO rexmit because 3b is prematurely invoked, that's 
why you never see what would occur if 3a is taken. TCP thinks it's not 
recovering anymore and therefore can send only new data (if there's some 
available).

This is what I tried to tell earlier, with new data there you see there's 
something else wrong too with FRTO besides the RTO loop.


-- 
 i.
--8323329-4507525-1529057656=:29120--
