Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF29C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F95720827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QeEbJ+ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F95720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeJ2KR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:17:59 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:43058 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJ2KR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:17:59 -0400
Received: by mail-lj1-f173.google.com with SMTP id g26-v6so4908892lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GP/v4e14BPItWcRABGxKw20BeVuq6xYG7hmyleerOrQ=;
        b=QeEbJ+ahb0MG63MXbE5rFrEn2VHosaPiPK0hUsP3fK4Quiu3nF4GXfe7kDQlcyRpOV
         hhOra5Qgwgsa95uAauFeMzCYtlDQxfbGjgPZnd8MUc1YDhHfKt3HD1TPfy270Rn4ONn9
         S4jpeqLcHrUg04WLOgGiroysChMBaCnaT6yGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GP/v4e14BPItWcRABGxKw20BeVuq6xYG7hmyleerOrQ=;
        b=cp6EvA5f4x2ciAgyYr8EBWwvU8H7pxiLG69MZv5t0tZc+PB/gM2ZD4Wnn1eMMFIdGG
         oM1MHo1ZnXaFW9OO9X6tk8emsH0AkiWCiNV//6KJQN3nA6ZfncWoppXa+arVHsjYA5PL
         De/m8TzA0GecyuwvX0g5djjjn5Cz9O7GdbYPfp3gQFYf1tN3y2uh3AAFkGcSSgs2/QTN
         xNBzKtc6BifYqsXsw3ITkv8pn8wgQTocNUsCsw+Es/EpAJjdTmk7sMnG4BVtCkCWeur1
         nNza/ZsN3LIvitO0Rcqt42zywIz/iAA+IMM7opniuLkTT1cS2wHvdIB0gPsf9NKNYnGr
         8p8g==
X-Gm-Message-State: AGRZ1gJzuxyU5U445TfxgXMIQS016kAJPspR9RYFQFKZS7urNzHxfCFC
        4hOfyz49/AbpydZ0wGKkphSBtpQ9EvEedg==
X-Google-Smtp-Source: AJdET5ez6A/8a+CrThW3qEdgk2Z1NXP2jhL78mAKt3TP22eEiZhmgJieagV9o24kuz1ZPdyton8XZA==
X-Received: by 2002:a2e:812:: with SMTP id 18-v6mr6731292lji.10.1540776693512;
        Sun, 28 Oct 2018 18:31:33 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id u77-v6sm2783903lja.37.2018.10.28.18.31.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 18:31:32 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t22-v6so6169810lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:31:32 -0700 (PDT)
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr2701377ljc.120.1540776691653;
 Sun, 28 Oct 2018 18:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181028220927.56227-1-post@steffenvogel.de> <CAADWXX89jMiTp-Nz887tv+6YwWkrWF8qYfpuTkmk2OE3_SqeGA@mail.gmail.com>
 <20181029002919.3cek4f27mdrnrgkj@cam.home.0l.dn42>
In-Reply-To: <20181029002919.3cek4f27mdrnrgkj@cam.home.0l.dn42>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 18:31:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMMAOSFdr-+ABZoffQ6NsJVB=iiQ97FUrCC6rt7njccA@mail.gmail.com>
Message-ID: <CAHk-=wjMMAOSFdr-+ABZoffQ6NsJVB=iiQ97FUrCC6rt7njccA@mail.gmail.com>
Subject: Re: w1: coding style and checkpatch fixes
To:     post@steffenvogel.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 5:30 PM Steffen Vogel <post@steffenvogel.de> wrote:
>
> For those who are interested. Rspamd, by default, includes the sender
> address into the list of signed headers:

Ugh. That's just broken.

> There is RFC6377 which discusses this problem. On possible solution is
> a mailing list service which understands DKIM and can check/sign the
> messages.

I think that is almost purely historical.

People figured it out. The actual solution was that mailing lists just
don't rewrite headers or bodies, but they do set that "sender" line
(and add various new ones, like "List-ID" etc unsubscribe
information).

And that was exactly so that dkim would just work, without the list
having to then add its own signing that just causes even more
problems.

[ And no, lkml isn't actually great at this - it will mess up
whitespace on headers, so it only works with a relaxed/relaxed dkim
signature.

  But honestly, if you use strict/strict, you're doing something
wrong. It's a bad idea. Smtp was never whitespace-strict ]

> This is actually according to RFC. Listing signed header-fields
> multiple times prohibits them from beeing modified and resigned my other
> MTAs.

Again, that is mostly historical baggage. I don't think anybody
actually does that.

So yes, you'll find a lot of "what ifs" from ten years ago when people
weren't actually using dkim and mailing lists didn't try to work with
it. Mostly theoretical "this is how it could work".

I've seen some truly horrendous suggestions for mailing lists, like
always rewriting "From" headers etc exactly so that you can then make
a new dkim signature. That would make for a really bad mailing list.

.. and yes, I'm sure such bad mailing lists exist.

                Linus
