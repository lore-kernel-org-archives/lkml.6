Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A12152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJIPAfOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A12152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeI0AlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:41:06 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35081 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0AlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:41:06 -0400
Received: by mail-yb1-f193.google.com with SMTP id o63-v6so11752755yba.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pn8eFJkeUpbV0DIAXKeU8bGiN1TDQW2pfyny7zKQXMw=;
        b=nJIPAfOGEmKpy0cKWBQgT1m/li4+lKaiARn9/46ky0dnZbLN6mr3VSoBp++HkVicyf
         o+R5c9rGZOOpnAyrYLeJQxdF5ACn3O+AGkRE1w7s7yE7so7SwhI3tAqi9HND8svnshuW
         Qdw2sIQnZXRGglRXjq1aWvXMEb43KrY4TXXFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pn8eFJkeUpbV0DIAXKeU8bGiN1TDQW2pfyny7zKQXMw=;
        b=kuQJ7GIWWUO2QvXSDGwJj72LCbsjY2ImftUQJBj1T74mfqEBlSQR1gC5O7rADOo/wW
         DU17mTOeq3NBriqbBY9nB7iY20kY/nOOj7fTyvzsygVtI4hhiK5VyWKlDUF7X6ychJIH
         ydNb0XJzg2dDrf5a9XH2HHS+K/dmZOru/nSk0rYQRDvp3/b7mTm8zZQaxT0tR7fL0n8T
         QGxTgOm7sFV0KG3qE5v6kp2UV015nb0yfdMquECtikwsMwnSPDzV8fiXHAldSdpfU1JY
         CTOI7HU48Wp5dQhwlXWA4w6hNGURib8RsGXCdp9nTRDqjeCxToFWGtRk/U9LOwILHgzc
         yyDQ==
X-Gm-Message-State: ABuFfohV5hRPyAi6nLdzOWRoBHHga0ZFReIXVTo/bzfVk2gs66jo58+Q
        t6PzmW/xSmlqP6JBsbHnBxHKhECpYM8=
X-Google-Smtp-Source: ACcGV62DinuNGkBOAsFCpFFozB5pTY+twiPC5W++soZhNFi7ZEkB55yEWE3bHMIte2kvBCeek9md+g==
X-Received: by 2002:a25:a189:: with SMTP id a9-v6mr3886838ybi.345.1537986411961;
        Wed, 26 Sep 2018 11:26:51 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id j8-v6sm3287964ywj.6.2018.09.26.11.26.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:26:50 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id q129-v6so11206704ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:26:49 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr1131482ywg.47.1537986409442;
 Wed, 26 Sep 2018 11:26:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf05:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 11:26:46
 -0700 (PDT)
In-Reply-To: <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 26 Sep 2018 11:26:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
Message-ID: <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:03 AM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Wed, Sep 26, 2018 at 11:00 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>>
>> On Fri, Aug 31, 2018 at 09:46:02AM -0700, Nick Desaulniers wrote:
>> > On Tue, Aug 28, 2018 at 4:00 PM Nick Desaulniers
>> > <ndesaulniers@google.com> wrote:
>> > >
>> > > On Mon, Aug 27, 2018 at 1:42 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>> > > >
>> > > > Hello Nick,
>> > > >
>> > > > On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
>> > > > >>> Let's give up __compiletime_assert_fallback().  This commit does not
>> > > > >>> change the current behavior since it just rips off the useless code.
>> > > > >> Clang is not the only target audience of
>> > > > >> __compiletime_assert_fallback().  Instead of ripping out something that
>> > > > >> may benefit builds with gcc 4.2 and earlier, why not override its
>> > > > > Note that with commit cafa0010cd51 ("Raise the minimum required gcc
>> > > > > version to 4.6") that gcc < 4.6 is irrelevant.
>> > > >
>> > > > Ah, I guess I'm not keeping up, that's wonderful news!  Considering that
>> > > > I guess I would be OK with its removal, but I still think it would be
>> > > > better if a similar mechanism to break the Clang build could be found.
>> > >
>> > > I'm consulting with our best language lawyers to see what combinations
>> > > of _Static_assert and __builtin_constant_p would do the trick.
>> >
>> > Linus,
>> > Can this patch be merged in the meantime?
>>
>> friendly ping :)
>>
>> With c5c2b11894f4 ("drm/i915: Warn against variable length arrays")
>> clang raises plenty of vla warnings about
>> __compiletime_error_fallback() in the i915 driver. Would be great to
>> get rid of those without having to revert that commit.
>
> I've been meaning to follow up on this, thanks Matthias.  I too would
> really like this patch.

Adding Greg to the thread. Between Masahiro's detailed commit log and
the Clang-familiar reviewers, I think this should land for 4.19 (as
part of the other Clang-sanity patches that are already in 4.19). This
has no impact on gcc now that we're requiring 4.6+.

https://lore.kernel.org/patchwork/patch/977668/

-Kees

-- 
Kees Cook
Pixel Security
