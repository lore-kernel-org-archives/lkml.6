Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ED4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC5E2401B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="WUYn6LN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC5E2401B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeGEHtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:49:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:12700 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGEHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530776991;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Y7dX1eQ63OZ912w2fdvynQAfsY39jx0SEe9D36k3qG0=;
        b=WUYn6LN2UwxTPN5FOPtIA7vdDLYsMa8rT76U9dfsLBbVgLtqw7tw1q1/x+JxxUJn98
        zGIQ2gsgXJSdc6e4/Hai9RCETuL/xqZIRlOe6p0bUZPYtt80H+iXDS49mq0MxcNLkVkI
        6GT2QBdtwEpHxwzZI/isHBIQXw/xXrLCe1VStoqSF5NE3KkJLEnsoG6ADaQiyUhhQ1Cd
        2mH14jKwXuDARpXhnUTITqOEQC0CVT+qW8JwCm0qzPmXvOo31ln73xWsHuX+HCunmyDS
        BBnikprFEQEbLdck1LvNHJULqWwMnVMPvz2d/PefSfSsslunAEEuJSVy3VTHX+KxZxra
        vPDw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZWvq/+MyXt/DL7dI0Ihg0SicdGB/Mshf6dqAJJ4h"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u657nl6K7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 09:49:47 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] AF_ALG: register completely initialized request in list
Date:   Thu, 05 Jul 2018 09:49:41 +0200
Message-ID: <3179058.YavDkrnvkQ@positron.chronox.de>
In-Reply-To: <20180704233757.GK725@sol.localdomain>
References: <00000000000092ad87056950ef9e@google.com> <3223691.KS9TZr8pPl@tauon.chronox.de> <20180704233757.GK725@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Juli 2018, 01:37:57 CEST schrieb Eric Biggers:

Hi Eric,

> On Mon, Apr 09, 2018 at 09:54:12AM +0200, Stephan Mueller wrote:
> > Am Montag, 9. April 2018, 09:51:13 CEST schrieb Dmitry Vyukov:
> > 
> > Hi Dmitry,
> > 
> > > You can ask syzbot to test by replying to its report email with a test
> > > command, see:
> > > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communica
> > > tion -with-syzbot
> > > 
> > > Note that all testing of KMSAN bugs needs to go to KMSAN tree, for
> > > details
> > > see:
> > > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bug
> > > s
> > 
> > Thank you. I will resend the patch later today with the proper tags.
> > 
> > Ciao
> > Stephan
> 
> Hi Stephan, it seems you never sent your patch out.

Thank you for pointing this one out. At the time, I was searching for how I 
can refer to the syzbot KMSAN branch that was used to produce the bug report. 
I only see guidance on how to point to the Linux kernel tree.

Do you have a hint how to point to a different syzbot tree?

Ciao
Stephan


