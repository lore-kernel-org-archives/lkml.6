Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B46BC28CBE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C7921566
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0GW6kj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C7921566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeI0Btm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:49:42 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40927 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0Btl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:49:41 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so62068ywa.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gy39weLiWkcXXbnViIhFr1a88Sp0IFml5j5Be5XTFvk=;
        b=V0GW6kj1WoBKj4A2E8hSy0gU54XVMhgYOe/A7TD1I1kud8a9sB7je0C8crHy/4JJEC
         pKO8Nt+/7haSxuh/NggjG5YKkhpeRik37nLP7XDyAwK6AWKE8gLTlqgm37OsgHmCiJXi
         gsgHuEn4QJp3OVNAZ1dhjnzgjr0QndQikqzNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gy39weLiWkcXXbnViIhFr1a88Sp0IFml5j5Be5XTFvk=;
        b=ZTZPH6FFfi6B9GKV1JJ6Mnp9umAXVaZYAZxPttoxqYkJ8PyXZAyKQaQaESrcOB5Fsa
         hw82rB0dfy9eBoXf3cxpx8byidyIgKO+48B/rtqntQEMP0rBQWenXVSYIJHYGffMFhdw
         PXyIOVJe2pls+LmAWrNv9WlBi1DzWWxIo+Wt8OK6wrMkTLXwm5eEWOCMNkXaGBqjngir
         sxqcjPHvOJbbW6m6fHjgoTwDnpmaOGd25g9OoEejoWu/tU42zgHUzKr9WhWh6tw9H+Uj
         k7YMzEaYz+obdIMGGm3AvqWmpygLN1EOt2gLuQc/Ixj0bjYV5uvrYzJQj8bzoyBWQpba
         fvpA==
X-Gm-Message-State: ABuFfoiC3/GtWeyYKf0vKTGvRvvVlnSlnd2E1UccDggRQGXmEKz+ttod
        5fMC7wIed9w1VLRL6oJ3FbZxwRulkrI=
X-Google-Smtp-Source: ACcGV63tFBGhSkpDUA7RaLLHjiExWAJ2neOF1/PEN/tPG8F5ty9+RA0hhDYEJKelB6dDUeT10EBypw==
X-Received: by 2002:a0d:d281:: with SMTP id u123-v6mr3757890ywd.97.1537990511632;
        Wed, 26 Sep 2018 12:35:11 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id d136-v6sm4591084ywh.33.2018.09.26.12.35.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:35:10 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id w7-v6so61437ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:35:09 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr4106650ybd.403.1537990509226;
 Wed, 26 Sep 2018 12:35:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:ab0a:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 12:35:06
 -0700 (PDT)
In-Reply-To: <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com> <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 26 Sep 2018 12:35:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
Message-ID: <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:29 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Wed, Sep 26, 2018 at 12:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, Sep 26, 2018 at 11:45:19AM -0700, Kees Cook wrote:
>> > On Wed, Sep 26, 2018 at 11:42 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > > I'm not digging up a compiler.h patch from a web site and adding it to
>> > > the tree this late in the release cycle.  Especially given that it
>> > > hasn't had any testing anywhere...
>> >
>> > Good point about it not living in -next.
>> >
>> > Who should be carrying these sorts of patches? In the past it's been
>> > Andrew or Masahiro, yes? For linux-next, maybe it can go via -mm?
>>
>> Either is fine with me, as long as it isn't one of my trees :)
>>
>> thanks,
>>
>> greg k-h
>
> Besides, I think we want the v2: https://lkml.org/lkml/2018/8/25/103

Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?

-Kees

-- 
Kees Cook
Pixel Security
