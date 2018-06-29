Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9302FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465FA27D3D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465FA27D3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helsinki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeF2KSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:18:04 -0400
Received: from smtp-rs2-vallila1.fe.helsinki.fi ([128.214.173.73]:44054 "EHLO
        smtp-rs2-vallila1.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752128AbeF2KSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:18:02 -0400
Received: from whs-18.cs.helsinki.fi (whs-18.cs.helsinki.fi [128.214.166.46])
        by smtp-rs2.it.helsinki.fi (8.14.7/8.14.7) with ESMTP id w5TAHv3P026232;
        Fri, 29 Jun 2018 13:17:57 +0300
Received: by whs-18.cs.helsinki.fi (Postfix, from userid 1070048)
        id 535FE3601A6; Fri, 29 Jun 2018 13:17:57 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by whs-18.cs.helsinki.fi (Postfix) with ESMTP id 51C73360030;
        Fri, 29 Jun 2018 13:17:57 +0300 (EEST)
Date:   Fri, 29 Jun 2018 13:17:57 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@whs-18.cs.helsinki.fi
To:     Yuchung Cheng <ycheng@google.com>
cc:     Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
In-Reply-To: <CAK6E8=fFm2PVY=FXpa88sbB6OmJfpfnavm02ke-7MgZ4J4Esaw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1806291308170.29120@whs-18.cs.helsinki.fi>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz> <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com> <alpine.DEB.2.20.1806141045430.29120@whs-18.cs.helsinki.fi> <20180614093408.5e34ijwhome4t5yn@unicorn.suse.cz>
 <alpine.DEB.2.20.1806141409150.29120@whs-18.cs.helsinki.fi> <20180614131801.hd474jgrhmtqzhag@unicorn.suse.cz> <alpine.DEB.2.20.1806151048000.29120@whs-18.cs.helsinki.fi> <20180615092753.lmxqh65moc33rzbq@unicorn.suse.cz> <alpine.DEB.2.20.1806151230340.29120@whs-18.cs.helsinki.fi>
 <CAK6E8=fFm2PVY=FXpa88sbB6OmJfpfnavm02ke-7MgZ4J4Esaw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1584806766-1530267477=:29120"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1584806766-1530267477=:29120
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 27 Jun 2018, Yuchung Cheng wrote:

> On Fri, Jun 15, 2018 at 3:35 AM, Ilpo Järvinen
> <ilpo.jarvinen@helsinki.fi> wrote:
> > On Fri, 15 Jun 2018, Michal Kubecek wrote:
> >
> >> My understanding is that this means that while the first ack after new
> >> data is correctly ignored, the following ack which preserves window size
> >> should be recognized as a dupack and (3a) should be taken.
> >
> > Linux FRTO never gets that far (without my fix) if the ACK in step 2
> > covers beyond the RTO rexmit because 3b is prematurely invoked, that's
> > why you never see what would occur if 3a is taken. TCP thinks it's not
> > recovering anymore and therefore can send only new data (if there's some
> > available).
> >
> > This is what I tried to tell earlier, with new data there you see there's
> > something else wrong too with FRTO besides the RTO loop.
>
> agreed. Ilpo do you mind re-submitting your fix
> https://patchwork.ozlabs.org/patch/883654/ (IIRC I already acked-by)

Resent as individual patch. And, no you didn't ack it but my impression
in general is that we have converged into agreement about the sender side 
fixes including this one but I'm hesitant to interpret such vague 
impression about agreement alone as acked-by.

(Now with hindsight, maybe I should have interpreted this statement
of yours above as acked-by and added it but I already did send it out 
without adding it).

> tcptest suite may have to wait due to some internal workload Neal is 
> juggling. 

Ok, no problem. Thanks for keeping me updated.


-- 
 i.
--8323329-1584806766-1530267477=:29120--
