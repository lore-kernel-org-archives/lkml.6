Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9855EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491BE2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="COmLX/3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491BE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeIJMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:47:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45015 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeIJMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:47:44 -0400
Received: by mail-io1-f68.google.com with SMTP id 75-v6so6270685iou.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAaVZfXxkxG2QPmLeC0tnHiumOVMC+J38AHY/HMfKwE=;
        b=COmLX/3kCvi3CQ+w3GZHG/pQrOLGg9eWll6ZtljbsBguksZQxR6SreWi3vkgBgIkdB
         QOMpdjzmBAwzVUTH3qikzUFPLccp/uVdu4FJA3RWP55aOD3lpTCd7loICLshcW+qEaad
         vRA5rOULwICijcCRHOxWY8Y0PGmJN3hDvGk6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAaVZfXxkxG2QPmLeC0tnHiumOVMC+J38AHY/HMfKwE=;
        b=Q9mMnzgUXrFTiEBiIVCaya2gByU7+M0rDFlOnQw3n+NABa44gmcRpaL/TqkL01Spkp
         naa4lOgFs4GhgjVW3r+oluHSz9A797nMNUwbuXEZXoBs9qmoQjSiKflmTJjCKbamUVc3
         2tK/ZClUGco32JwbjSQHpZZ3QbSWQENNW1jIHQuz0JXJkL96ZfmGW6eSr2P7HS5qzMgr
         GOH6jBBYq0kBL1EdhsIe911TLKKRTycZ6ARo2tDtq6rekVTvqx9b3ps6yKw/dNEAI+3B
         6U9oLDzJyjcu43KGGUVFUqUlWGFtCF4sdtlmzzwNNhqMB7Fg3ymTxImmMo2m88MqSO/J
         /O6Q==
X-Gm-Message-State: APzg51Cpm/kU/oYMi87X2yf1D/MxWO4gVxTUyUSbNXRTHHYVVemB18UL
        PL6Rtd7AbRrAsU4OCbGd8TtrDcajbR708jNUwJoUOQ==
X-Google-Smtp-Source: ANB0VdadEvZoJBTSwZ4NMNr6G69JvSdQSPokBnY4EtK5wFDn5r9OoBjc6mBooE11trLTSQPhghVmMM0DfLEXsZKurj0=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr15242517iog.175.1536566099406;
 Mon, 10 Sep 2018 00:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1526400945.git.vilhelm.gray@gmail.com> <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
 <20180905150348.GA27089@sophia>
In-Reply-To: <20180905150348.GA27089@sophia>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 09:54:47 +0200
Message-ID: <CACRpkdah-CSkdmpYQ_sgOFNqXMD5mMLkmRDRBszK+twPbRNLpA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Introduce the for_each_set_clump macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 5:04 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Wed, May 16, 2018 at 04:03:51PM +0200, Linus Walleij wrote:
> >On Tue, May 15, 2018 at 6:22 PM, William Breathitt Gray
> ><vilhelm.gray@gmail.com> wrote:
> >
> >> For example, suppose you would like to iterate over a 16-bit integer 4
> >> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
> >> represents the current 4-bit group:
> >>
> >>     Example:        1011 1110 0000 1111
> >>     First loop:     1011 1110 0000 XXXX
> >>     Second loop:    1011 XXXX 0000 1111
> >>     Third loop:     XXXX 1110 0000 1111
> >>
> >> Each iteration of the loop returns the next 4-bit group that has at
> >> least one set bit.
> >>
> >> The for_each_set_clump macro has six parameters:
> >>
> >>     * clump: set to current clump index for the iteration
> >>     * index: set to current bitmap word index for the iteration
> >>     * offset: bits offset of the found clump in the bitmap word
> >>     * bits: bitmap to search within
> >>     * size: bitmap size in number of clumps
> >>     * clump_size: clump size in number of bits
> >>
> >> The clump_size argument can be an arbitrary number of bits and is not
> >> required to be a multiple of 2.
> >
> >I must say I'm impressed. Very nice arithmetics going on there.
> >
> >If I can get some ACK for the bitops patch I'd be happy to merge
> >it all through the GPIO tree. The users are pretty clear cut.
> >
> >BTW: if I could, I would pull out Donald Knuth's "The Art of Computer
> >Programming vol 4A" chapter 7.1.3 "Bitwise Tricks and Techniques"
> >to see what he has to say about the subject, but I don't have
> >that book as it turns out.
> >
> >Yours,
> >Linus Walleij
>
> Hi Linus,
>
> I'd like to get this patchset merged, but I'm aware that we haven't yet
> received additional ACKs in the past couple months. Are there any
> changes you would like made, or should I resubmit this patchset with
> additional CCs in the hopes of some ACKs for the bitops patch?

It seems Andy wanted some time and he had ~4 months now
so either he forgot it or has way too much to do.

I would say send this patch to Andrew Morton (the bitops patches)
so he can decide on it. He has the right bird's eye view on this
kind of things.

Yours,
Linus Walleij
