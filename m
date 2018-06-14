Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F8A5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2E5208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2E5208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helsinki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeFNJw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:52:56 -0400
Received: from smtp-rs2-vallila1.fe.helsinki.fi ([128.214.173.73]:60026 "EHLO
        smtp-rs2-vallila1.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754665AbeFNJwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:52:55 -0400
X-Greylist: delayed 4205 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 05:52:54 EDT
Received: from whs-18.cs.helsinki.fi (whs-18.cs.helsinki.fi [128.214.166.46])
        by smtp-rs2.it.helsinki.fi (8.14.7/8.14.7) with ESMTP id w5E8ghiP002152;
        Thu, 14 Jun 2018 11:42:43 +0300
Received: by whs-18.cs.helsinki.fi (Postfix, from userid 1070048)
        id B018C3601A6; Thu, 14 Jun 2018 11:42:43 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by whs-18.cs.helsinki.fi (Postfix) with ESMTP id A7E68360080;
        Thu, 14 Jun 2018 11:42:43 +0300 (EEST)
Date:   Thu, 14 Jun 2018 11:42:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@whs-18.cs.helsinki.fi
To:     Yuchung Cheng <ycheng@google.com>
cc:     Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
In-Reply-To: <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1806141045430.29120@whs-18.cs.helsinki.fi>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz> <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Yuchung Cheng wrote:

> On Wed, Jun 13, 2018 at 9:55 AM, Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> > When F-RTO algorithm (RFC 5682) is used on connection without both SACK and
> > timestamps (either because of (mis)configuration or because the other
> > endpoint does not advertise them), specific pattern loss can make RTO grow
> > exponentially until the sender is only able to send one packet per two
> > minutes (TCP_RTO_MAX).
> >
> > One way to reproduce is to
> >
> >   - make sure the connection uses neither SACK nor timestamps
> >   - let tp->reorder grow enough so that lost packets are retransmitted
> >     after RTO (rather than when high_seq - snd_una > reorder * MSS)
> >   - let the data flow stabilize
> >   - drop multiple sender packets in "every second" pattern

Hmm? What is deterministically dropping every second packet for a 
particular flow that has RTOs in between?

Years back I was privately contacted by somebody from a middlebox vendor 
for a case with very similar exponentially growing RTO due to the FRTO 
heuristic. It turned out that they didn't want to send dupacks for 
out-of-order packets because they wanted to keep the TCP side of their 
deep packet inspection middlebox primitive. He claimed that the middlebox 
doesn't need to send dupacks because there could be such a TCP 
implementation that too doesn't do them either (not that he had anything 
to point to besides their middlebox ;-)), which according to him was 
not required because of his intepretation of RFC793 (IIRC). ...Nevermind 
anything that has occurred since that era.

...Back then, I also envisioned in that mail exchange with him that a 
middlebox could break FRTO by always forcing a drop on the key packet
FRTO depends on. Ironically, that is exactly what is required to trigger 
this issue? Sure, every a heuristic can be fooled if a deterministic (or
crafted) pattern is introduced to defeat that particular heuristic. ...But 
I'd prefer that networks "dropping every second packet" of a flow to be 
fixed rather than FRTO?

In addition, one could even argue that the sender is sending whole the 
time with lower and lower rate (given the exponentially increasing RTO) 
and still gets losses, so that a further rate reduction would be the 
correct action. ...But take this intuitive reasoning with some grain of 
salt (that is, I can see reasons myself to disagree with it :-)).

> >   - either there is no new data to send or acks received in response to new
> >     data are also window updates (i.e. not dupacks by definition)

Can you explain what exactly do you mean with this "no new data to send" 
condition here as F-RTO is/should not be used if there's no new data to 
send?!?

...Or, why is the receiver going against SHOULD in RFC5681:
   "A TCP receiver SHOULD send an immediate duplicate ACK when an out-
   of-order segment arrives."
? ...And yes, I know there's this very issue with window updates masking 
duplicate ACKs in Linux TCP receiver but I was met with some skepticism 
on whether fixing it is worth it or not.

> > In this scenario, the sender keeps cycling between retransmitting first
> > lost packet (step 1 of RFC 5682), sending new data by (2b) and timing out
> > again. In this loop, the sender only gets
> >
> >   (a) acks for retransmitted segments (possibly together with old ones)
> >   (b) window updates
> >
> > Without timestamps, neither can be used for RTT estimator and without SACK,
> > we have no newly sacked segments to estimate RTT either. Therefore each
> > timeout doubles RTO and without usable RTT samples so that there is nothing
> > to counter the exponential growth.
> >
> > While disabling both SACK and timestamps doesn't make any sense, the
> > resulting behaviour is so pathological that it deserves an improvement.
> > (Also, both can be disabled on the other side.) Avoid F-RTO algorithm in
> > case both SACK and timestamps are disabled so that the sender falls back to
> > traditional slow start retransmission.
> >
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> Acked-by: Yuchung Cheng <ycheng@google.com>
> 
> Thanks for the patch (and packedrill test)! I would encourage
> submitting an errata to F-RTO RFC about this case.

Unless there's a convincing explination how such a drop pattern would 
occur in real world except due to serious brokeness/misconfiguration on 
network side (that should not be there), I'm not that sure it's exactly
what erratas are meant for.


-- 
 i.
