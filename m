Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B202C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBBF23EA8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="POEyycBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBBF23EA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeGFQ1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:27:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:14550 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFQ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530894431;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2QyDtVIvXZzemf0mk3LaK2PIlbJt2knwJ+eubj0ms5c=;
        b=POEyycBwsk7lZLexJekuxRyDOE4JtqbCOJMFkychRBollJh/y3FvJtxxDo1lpIm9vL
        819BCMOzcssBqAdhmPO3zu6MHCBg/H1KRuOHZnFNGqE/dIer5puCfzwxUb8VgxeS2H/i
        YTelgmG4hSJ0OZ7pbEtE4SFU4scEVGocUKzGR7df9UlAXgFtmBbhq7oUGiWI5D5Sz+rs
        ZkQn2+qZaRQJuQNMbJ1ZgevlGRszYqsqwZBamr2Ka4f367q1w/hJb0pBdpExEyeg4mRQ
        +jiM8xSaM9vrFhAKapDPG/EY+L5fUKSkKaOZ0/mNdX2HbMBQPjVfaCRKX8VqZGvhkYyq
        Xdqw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZGrithBFZUqsJqaA7gBRM3H/SoCRTjrR5clfHiy/"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u66GR7ItJ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 6 Jul 2018 18:27:07 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
Date:   Fri, 06 Jul 2018 18:27:07 +0200
Message-ID: <2936767.s7CfvshsC6@tauon.chronox.de>
In-Reply-To: <CACT4Y+Yv8M93-N3J1U6r1X=Oy2SaKQpJU1S6iJeFC8bJMnjuKg@mail.gmail.com>
References: <1616306.R4SzcgHSdy@positron.chronox.de> <000000000000363e2e0570502d42@google.com> <CACT4Y+Yv8M93-N3J1U6r1X=Oy2SaKQpJU1S6iJeFC8bJMnjuKg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Juli 2018, 10:19:07 CEST schrieb Dmitry Vyukov:

Hi Dmitry,

> On Fri, Jul 6, 2018 at 10:09 AM, syzbot
> 
> <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com> wrote:
> > Hello,
> > 
> > syzbot tried to test the proposed patch but build/boot failed:
> > 
> > lost connection to test machine
> 
> Looking into this.

syzkaller reported the following which implies that the patch seems to fix the 
issue.


syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com

Tested on:

commit:         a00de5aa4da3 kmsan: delete some dead code
git tree:       https://github.com/google/kmsan.git/master
kernel config:  https://syzkaller.appspot.com/x/.config?x=b11f4cfb262ee607
compiler:       clang version 7.0.0 (trunk 334104)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13194968400000

Note: testing is done by a robot and is best-effort only.


Ciao
Stephan


