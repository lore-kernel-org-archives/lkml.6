Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0732FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E02088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dhCJqVuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6E02088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeIQU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:59:57 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57749 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbeIQU75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:59:57 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 37236be9;
        Mon, 17 Sep 2018 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=PR7VKoV/mArejq5lfHQeNp92ISQ=; b=dhCJqV
        uLyITH0OiwdWwrJyyC0DKJ+67ki8kKxGokIPUDSG9CPcyTnIkd7OQesg9ncA95Bc
        t9IW0QjLcLOzujlplKFlok/XeLlrd7qpkfW4bFqpBL2NUrZ7mHEOXa//BopkYGhf
        zgrvbBkJjHGsJUAmTEQwDEv4Tqa8Rqt2dXKAbt1onDvv64SeYtTYn6KhelrmvhY4
        WoQ1ykhFpGpsJTwXqS0wrjgAkp5tWxO3f3Oui00ukCjylfOoOsdKkbhPwKVOiYaI
        J4pAAGpQU0Sx5g6kl3tpJlpxnDEkJrIEAjcEMMzbW/I1jPkG6/oRvYbU0kJp5cr3
        2BDMvfeFeIg/Cw/g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 87f16a2f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 15:14:37 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id 13-v6so19324802ois.1;
        Mon, 17 Sep 2018 08:32:04 -0700 (PDT)
X-Gm-Message-State: APzg51BEPTw2FCh8nTdRuiP+RQdcP341IPlMHSVH8NkO1asvxc/tVpHu
        U/bCUB8ADkNcXGDUdMZPFHd8OVjQV5INVaLJNQU=
X-Google-Smtp-Source: ANB0VdZXlwLBnpOr+JOoJOvDwk0t6xxEYKKau8T7+aaeyDtjq/R8u09TFc17xIhTnq2PvrDtSBxLxb+0x6AXaEDVjyg=
X-Received: by 2002:aca:ce02:: with SMTP id e2-v6mr18733540oig.225.1537198323121;
 Mon, 17 Sep 2018 08:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com> <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net>
In-Reply-To: <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 17:31:50 +0200
X-Gmail-Original-Message-ID: <CAHmME9o2sB-rQo0DRh56AFe7ZLJJh+CU6Z1m5XZ4tA8vATCy1g@mail.gmail.com>
Message-ID: <CAHmME9o2sB-rQo0DRh56AFe7ZLJJh+CU6Z1m5XZ4tA8vATCy1g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:52 PM Andy Lutomirski <luto@amacapital.net> wrote:
> I think the module organization needs to change. It needs to be possible to have chacha20 built in but AES or whatever as a module.

Okay, I'll do that for v5.

> I might have agreed before Spectre :(. Unfortunately, unless we do some magic, I think the code would look something like:
>
> if (static_branch_likely(have_simd)) arch_chacha20();
>
> ...where arch_chacha20 is a *pointer*. And that will generate a retpoline and run very, very slowly.  (I just rewrote some of the x86 entry code to eliminate one retpoline. I got a 5% speedup on some tests according to the kbuild bot.)

Actually, the way it works now benefits from the compilers inliner and
the branch predictor. I benchmarked this without any retpoline
slowdowns, and the branch predictor becomes correct pretty much all
the time. We can tinker with this after the initial merge, if you
really want, but avoiding function pointers and instead using ordinary
branches really winds up being quite fast.
