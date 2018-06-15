Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E484C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7DE208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7DE208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helsinki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756004AbeFOIFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:05:12 -0400
Received: from smtp-rs2-vallila1.fe.helsinki.fi ([128.214.173.73]:48948 "EHLO
        smtp-rs2-vallila1.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755860AbeFOIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:05:11 -0400
Received: from whs-18.cs.helsinki.fi (whs-18.cs.helsinki.fi [128.214.166.46])
        by smtp-rs2.it.helsinki.fi (8.14.7/8.14.7) with ESMTP id w5F853Tb029650;
        Fri, 15 Jun 2018 11:05:03 +0300
Received: by whs-18.cs.helsinki.fi (Postfix, from userid 1070048)
        id 50E133601A6; Fri, 15 Jun 2018 11:05:03 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by whs-18.cs.helsinki.fi (Postfix) with ESMTP id 4DAAA360012;
        Fri, 15 Jun 2018 11:05:03 +0300 (EEST)
Date:   Fri, 15 Jun 2018 11:05:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@whs-18.cs.helsinki.fi
To:     Michal Kubecek <mkubecek@suse.cz>
cc:     Yuchung Cheng <ycheng@google.com>, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
In-Reply-To: <20180614131801.hd474jgrhmtqzhag@unicorn.suse.cz>
Message-ID: <alpine.DEB.2.20.1806151048000.29120@whs-18.cs.helsinki.fi>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz> <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com> <alpine.DEB.2.20.1806141045430.29120@whs-18.cs.helsinki.fi> <20180614093408.5e34ijwhome4t5yn@unicorn.suse.cz>
 <alpine.DEB.2.20.1806141409150.29120@whs-18.cs.helsinki.fi> <20180614131801.hd474jgrhmtqzhag@unicorn.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-577910731-1529049903=:29120"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-577910731-1529049903=:29120
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 14 Jun 2018, Michal Kubecek wrote:

> On Thu, Jun 14, 2018 at 02:51:18PM +0300, Ilpo Järvinen wrote:
> > On Thu, 14 Jun 2018, Michal Kubecek wrote:
> > > On Thu, Jun 14, 2018 at 11:42:43AM +0300, Ilpo Järvinen wrote:
> > > > On Wed, 13 Jun 2018, Yuchung Cheng wrote:
> > > > > On Wed, Jun 13, 2018 at 9:55 AM, Michal Kubecek <mkubecek@suse.cz> wrote:
> > > 
> > > AFAICS RFC 5682 is not explicit about this and offers multiple options.
> > > Anyway, this is not essential and in most of the customer provided
> > > captures, it wasn't the case.
> > 
> > Lacking the new segments is essential for hiding the actual bug as the 
> > trace would look weird otherwise with a burst of new data segments (due 
> > to the other bug).
> 
> The trace wouldn't look so nice but it can be reproduced even with more
> data to send. I've copied an example below. I couldn't find a really
> nice one quickly so that first few retransmits (17:22:13.865105 through
> 17:23:05.841105) are without new data but starting at 17:23:58.189150,
> you can see that sending new (previously unsent) data may not suffice to
> break the loop.

My point was that the new data segment bursts that occur if the sender 
isn't application limited indicate that there's something going wrong
with FRTO. And that wrong is also what is causing that RTO loop because
the sender doesn't see the previous FRTO recovery on second RTO. With 
my FRTO undo fix, (new_recovery || icsk->icsk_retransmits) will be false
and that will prevent the RTO loop.

> > > Normally, we would have timestamps (and even SACK). Without them, you
> > > cannot reliably recognize a dupack with changed window size from
> > > a spontaneous window update.
> > 
> > No! The window should not update window on ACKs the receiver intends to 
> > designate as "duplicate ACKs". That is not without some potential cost 
> > though as it requires delaying window updates up to the next cumulative 
> > ACK. In the non-SACK series one of the changes is fixing this for
> > non-SACK Linux TCP flows.
> 
> That sounds like a reasonable change (at least at the first glance,
> I didn't think about it too deeply) but even if we fix Linux stack to
> behave like this, we cannot force everyone else to do the same.

Unfortunately I don't know what the other stacks besides Linux do. But 
for Linux, the cause for the changing receiver window is the receiver 
window auto-tuning and I'm not sure if other stacks have a similar 
feature (or if that affects (almost) all ACKs like in Linux).


-- 
 i.
--8323329-577910731-1529049903=:29120--
