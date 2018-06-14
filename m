Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDAA2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856FB208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856FB208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helsinki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755096AbeFNLv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:51:27 -0400
Received: from smtp-rs2-vallila1.fe.helsinki.fi ([128.214.173.73]:41592 "EHLO
        smtp-rs2-vallila1.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752100AbeFNLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:51:25 -0400
Received: from whs-18.cs.helsinki.fi (whs-18.cs.helsinki.fi [128.214.166.46])
        by smtp-rs2.it.helsinki.fi (8.14.7/8.14.7) with ESMTP id w5EBpIpc002556;
        Thu, 14 Jun 2018 14:51:18 +0300
Received: by whs-18.cs.helsinki.fi (Postfix, from userid 1070048)
        id 5ABA33601A6; Thu, 14 Jun 2018 14:51:18 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by whs-18.cs.helsinki.fi (Postfix) with ESMTP id 5923D360080;
        Thu, 14 Jun 2018 14:51:18 +0300 (EEST)
Date:   Thu, 14 Jun 2018 14:51:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@whs-18.cs.helsinki.fi
To:     Michal Kubecek <mkubecek@suse.cz>
cc:     Yuchung Cheng <ycheng@google.com>, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
In-Reply-To: <20180614093408.5e34ijwhome4t5yn@unicorn.suse.cz>
Message-ID: <alpine.DEB.2.20.1806141409150.29120@whs-18.cs.helsinki.fi>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz> <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com> <alpine.DEB.2.20.1806141045430.29120@whs-18.cs.helsinki.fi>
 <20180614093408.5e34ijwhome4t5yn@unicorn.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1797808129-1528976444=:29120"
Content-ID: <alpine.DEB.2.20.1806141440490.29120@whs-18.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1797808129-1528976444=:29120
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.20.1806141440491.29120@whs-18.cs.helsinki.fi>

On Thu, 14 Jun 2018, Michal Kubecek wrote:

> On Thu, Jun 14, 2018 at 11:42:43AM +0300, Ilpo Järvinen wrote:
> > On Wed, 13 Jun 2018, Yuchung Cheng wrote:
> > > On Wed, Jun 13, 2018 at 9:55 AM, Michal Kubecek <mkubecek@suse.cz> wrote:
> > > >
> > > > When F-RTO algorithm (RFC 5682) is used on connection without both SACK and
> > > > timestamps (either because of (mis)configuration or because the other
> > > > endpoint does not advertise them), specific pattern loss can make RTO grow
> > > > exponentially until the sender is only able to send one packet per two
> > > > minutes (TCP_RTO_MAX).
> > > >
> > > > One way to reproduce is to
> > > >
> > > >   - make sure the connection uses neither SACK nor timestamps
> > > >   - let tp->reorder grow enough so that lost packets are retransmitted
> > > >     after RTO (rather than when high_seq - snd_una > reorder * MSS)
> > > >   - let the data flow stabilize
> > > >   - drop multiple sender packets in "every second" pattern
> > 
> > Hmm? What is deterministically dropping every second packet for a 
> > particular flow that has RTOs in between?
> 
> AFAIK the customer we managed to push to investigate the primary source
> of the packet loss identified some problems with their load balancing
> solution but I don't have more details. For the record, the loss didn't
> last through the phase of RTO growing exponentially (so that there were
> no lost retransmissions) but did last long enough to drop at least 20
> packets. With the exponential growth, that was enough for RTO to reach
> TCP_RTO_MAX (120s) and make the connection essentially stalled.
> 
> Actually, it doesn't need to be exactly "every second". As long as you
> don't lose two consecutive segments (which would allow you to fall back
> in step (2a)), you can have more than one received segments between them
> and get the same issue.
> 
> > Years back I was privately contacted by somebody from a middlebox vendor 
> > for a case with very similar exponentially growing RTO due to the FRTO 
> > heuristic. It turned out that they didn't want to send dupacks for 
> > out-of-order packets because they wanted to keep the TCP side of their 
> > deep packet inspection middlebox primitive. He claimed that the middlebox 
> > doesn't need to send dupacks because there could be such a TCP 
> > implementation that too doesn't do them either (not that he had anything 
> > to point to besides their middlebox ;-)), which according to him was 
> > not required because of his intepretation of RFC793 (IIRC). ...Nevermind 
> > anything that has occurred since that era.
> > 
> > ...Back then, I also envisioned in that mail exchange with him that a 
> > middlebox could break FRTO by always forcing a drop on the key packet
> > FRTO depends on. Ironically, that is exactly what is required to trigger 
> > this issue? Sure, every a heuristic can be fooled if a deterministic (or
> > crafted) pattern is introduced to defeat that particular heuristic.
> 
> OK, let me elaborate a bit more about the background. Within last few
> months, we had six different reports of TCP stalls (typically for NFS
> connections alternating between idle period and bulk transfers) which
> started after an upgrade from SLE11 (with 3.0 kernel) to SLE12 SP2 or
> SP3 (both 4.4 kernel).
> 
> Two of them were analysed down to the NAS on the other side which was
> sending SACK blocks violating the RFC in two different ways - as
> described in thread "TCP one-by-one acking - RFC interpretation
> question".
> 
> Three of them do not seem to show any apparent RFC violation and the
> problem is only in RTO doubling with each retransmission while there are
> no usable replies that could be used for RTT estimate (in the absence of
> both SACK and timestamps).
> 
> For the sake of completeness, there was also one report from two days
> ago which looked almost the same but in the end it turned out that in
> this case, SLES (with Firefox) was the receiver and sender was actually
> Windows 2016 server with Microsoft IIS.
> 
> > I'd prefer that networks "dropping every second packet" of a flow to be 
> > fixed rather than FRTO?
> 
> Yes, that was my first reaction that their primary focus should be the
> lossy network. However, it's not behaving like this all the time, the
> periods of loss are relatively short - but long enough to trigger the
> "RTO loop".
>
> > In addition, one could even argue that the sender is sending whole the 
> > time with lower and lower rate (given the exponentially increasing RTO) 
> > and still gets losses, so that a further rate reduction would be the 
> > correct action. ...But take this intuitive reasoning with some grain of 
> > salt (that is, I can see reasons myself to disagree with it :-)).
> 
> As I explained above, the loss was over by the time of first RTO
> retransmission. I should probably have made that clear in the commit
> message.

Right. I had a preconveived mental image from another, similar case which 
requires a loss after each RTO but it does seem to be case here (and I 
only took look into the drill after sending the first mail out).

> > > >   - either there is no new data to send or acks received in response to new
> > > >     data are also window updates (i.e. not dupacks by definition)
> > 
> > Can you explain what exactly do you mean with this "no new data to send" 
> > condition here as F-RTO is/should not be used if there's no new data to 
> > send?!?
> 
> AFAICS RFC 5682 is not explicit about this and offers multiple options.
> Anyway, this is not essential and in most of the customer provided
> captures, it wasn't the case.

Lacking the new segments is essential for hiding the actual bug as the 
trace would look weird otherwise with a burst of new data segments (due 
to the other bug).

> > ...Or, why is the receiver going against SHOULD in RFC5681:
> >    "A TCP receiver SHOULD send an immediate duplicate ACK when an out-
> >    of-order segment arrives."
> > ? ...And yes, I know there's this very issue with window updates masking 
> > duplicate ACKs in Linux TCP receiver but I was met with some skepticism 
> > on whether fixing it is worth it or not.
> 
> Normally, we would have timestamps (and even SACK). Without them, you
> cannot reliably recognize a dupack with changed window size from
> a spontaneous window update.

No! The window should not update window on ACKs the receiver intends to 
designate as "duplicate ACKs". That is not without some potential cost 
though as it requires delaying window updates up to the next cumulative 
ACK. In the non-SACK series one of the changes is fixing this for
non-SACK Linux TCP flows.

> > > Acked-by: Yuchung Cheng <ycheng@google.com>
> > > 
> > > Thanks for the patch (and packedrill test)! I would encourage
> > > submitting an errata to F-RTO RFC about this case.
> > 
> > Unless there's a convincing explination how such a drop pattern would 
> > occur in real world except due to serious brokeness/misconfiguration on 
> > network side (that should not be there), I'm not that sure it's exactly
> > what erratas are meant for.
> 
> As explained above, this commit was not inspired by some theoretical
> study trying to find dark corner cases, it was result of investigation
> of reports from  multiple customer encountering the problem in
> real-life.  Sure, there was always something bad, namely SACK/timestamps
> being disabled and network losing packets, but the effect (one packet
> per two minutes) is so disastrous that I believe it should be handled.

Yes, I was guessing/hoping that the every second packet stuff was just for 
the reproducer (but of course it could have been something that is 
just very broken - it wouldn't surprise me that much :-(). Now, however,
I think if the FRTO undo bug is fixed, the main problem that remains is 
that with new data to send, then FRTO logic will not send anything after 
the first ACK and there won't be second ACK leading to that RTO loop. 
Given that FRTO RFC already recommends falling back to normal RTO recovery 
in the cases where there's no new data to send, I don't think there's
anything that needs to be changed in the RFC that would warrant an errata.


-- 
 i.
--8323329-1797808129-1528976444=:29120--
