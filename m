Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A7C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779AF21885
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GLLoBF3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779AF21885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeHER6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:58:04 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50246 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeHER6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:58:04 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so12582594ite.0;
        Sun, 05 Aug 2018 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3FBxGXf+7GJ8tF1AYKx0g1C9qr2U67cCxPrcY4D+7U=;
        b=GLLoBF3g5GGjtv8j918Zo0f35vbhmNBHMQWwjBIEQmZwP0XMMYZIBJ3m+afuqjwTC8
         QcWyPyCubBWlpvZ2x1xBS+dArMVMMNnv2vRLa7Ai7+Suz1haIVsnhkyg53fXX7WJVlxF
         HWtbd/lyMhWcef8aYZ5HTZDjJU2tT9bqzN2/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3FBxGXf+7GJ8tF1AYKx0g1C9qr2U67cCxPrcY4D+7U=;
        b=KzhbDAmojadsYaYwdiiIumTOo+3e3hZOu13ied1ePV2YJAAtAZycco/SPuRlT0N8Xb
         ZY1r9TjjZsNq/LomTzkUMf8KlBAcgYd+6QOV+Hvj/UNEUAzkDc7FLPYQerDoLuao5wfW
         Enh53BDpau44CPRyLd/O7Ga+yIzuW6Syyq0t9BVG2DZr9pRgbgrrl0wLF+aIkaqgaP0e
         Uu/LgyarjWufXXRgLrp858bJW3VH6lXvEy+Yos5GO+kTjTWIbdyy+kz9GD7W4DxYCwRG
         PywSKPKT4msYVigdM2dsW3JeJuNsVpdG3SlR+mFNAM6x1o6ajFklEskZfI/8BjLtuDKT
         Zgqg==
X-Gm-Message-State: AOUpUlFBe6xLoSlzoU9TME5ZinNLgAMg8Qp7UrLvY1EOca1GIrAvRBDv
        sHIrQcskICHh1B5NdaJuozhuSb+a9ls6YUj5+NLBkAKC
X-Google-Smtp-Source: AAOMgpfR8Td1qP4CIHHV2jBJmhBIYnzSACYrKkXk7tH1IBt/sfZ0BtWAUBh+HEuV3EDNrF5JQbhVfzAGh41xSuaAgTQ=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr12316889ite.1.1533484381742;
 Sun, 05 Aug 2018 08:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180805.004744.1043412275329854518.davem@davemloft.net>
In-Reply-To: <20180805.004744.1043412275329854518.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Aug 2018 08:52:50 -0700
Message-ID: <CA+55aFx1vbQWnQUVoieFgKrNECLKJs-RQi8z8cpe29g0aAiq3A@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 12:47 AM David Miller <davem@davemloft.net> wrote:
>
> 4) Fix regression in netlink bind handling of multicast
>    gruops, from Dmitry Safonov.

This one is written kind of stupidly.

The code went from the original

        groups &= (1UL << nlk->ngroups) - 1;

(which is incorrect for large values of nlk->ngroups) to the fixed

        if (nlk->ngroups == 0)
                groups = 0;
        else if (nlk->ngroups < 8*sizeof(groups))
                groups &= (1UL << nlk->ngroups) - 1;

which isn't technically incorrect...

But it is stupid.

Why stupid? Because the test for 0 is pointless.

Just doing

        if (nlk->ngroups < 8*sizeof(groups))
                groups &= (1UL << nlk->ngroups) - 1;

would have been fine and more understandable, since the "mask by shift
count" already does the right thing for a ngroups value of 0. Now that
test for zero makes me go "what's special about zero?". It turns out
that the answer to that is "nothing".

I certainly didn't care enough to fix it up, and maybe the compiler is
even smart enough to remove the unnecessary test for zero, but it's
kind of sad to see this kind of "people didn't think the code through"
patch this late in the rc.

I'll be making an rc8 today anyway, but I did want to just point to it
and say "hey guys, the code is unnecessarily stupid and overly
complicated".

The type of "groups" is kind of silly too.

Yeah, "long unsigned int" isn't _technically_ wrong. But we normally
call that type "unsigned long".

And comparing against "8*sizeof(groups)" is misleading too, when the
actual masking expression works and is correct in "unsigned long"
because that's the type of the actual mask we're computing (due to the
"1UL").

So _regardless_ of the type of "groups" itself, the mask is actually
correct in unsigned long. I personally think it would have been more
legible as just

        unsigned long groups;
        ...
        if (nlk->ngroups < BITS_PER_LONG)
                groups &= (1UL << nlk->ngroups) - 1;

but by now I'm just nitpicking.

                  Linus
