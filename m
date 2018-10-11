Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220F3C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE65F2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7hfwrEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE65F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeJKWnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:43:25 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43576 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJKWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:43:24 -0400
Received: by mail-yb1-f196.google.com with SMTP id w80-v6so3733242ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=08iS1Ysr1zICRogT714u/UPMyNfLX1/ki5+JwH70t44=;
        b=K7hfwrEJR1s/MWti7kcej9QF0qXM+7ATB9L73dR6O3XTenVXbw4+rmCYZflLiRBTgs
         CiXtmSfQrWSGO0CwhG98U2FmdI5XDlWzwKgrwzju0IZ8qk61wkCnIoY9acSgiUUAhYdt
         xEywmq8Zh1M+gPLuNuuqNQuMV9jBi1LXoe0jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=08iS1Ysr1zICRogT714u/UPMyNfLX1/ki5+JwH70t44=;
        b=Ea1gZFLX8kIq55eZALCjMQLMn7cxoMVP1nl9FtZOYa62L/RfcvhtpQLUrxf14X9wTQ
         e/B4rGPv6/dZgCmOVSLPw6VqB0ix+8SVj+78N1T3WUmiXA1RxMYgvUIjqnrtod96WH9s
         DFs2d+QZJBhum+ssbniSc7ztj8ZkQ/07REPM0GgE7hbVMLkp/9MN3lPeNdXnhw/onPxj
         TEND0I2GRYm1gLL45nqiRALQ8uH4JHs/RLHso41WSZK4vgKgWGIRaVOsftpQlR06Djq8
         QIe8VhHUGfT0OvBAz/WvfFCnqSoJq+Vp7OA8xEOIoqwhwcAJWIbFhxcHhV4BIOmI1GVl
         I3mQ==
X-Gm-Message-State: ABuFfoiqVzOAQbUydkKPL8LOw8lbDNVGaNvKAE/8cRqiifUqeTbcXIvF
        zhT8T9u7Kdw8F5NG5fkcy/x9RYJUaP8=
X-Google-Smtp-Source: ACcGV60Yz94DzJVWrSXw43eqyW8KLmCftLxh6PDtoZ0K5YU0F28cM96WukbKU+4L+uADCajNvwbOtg==
X-Received: by 2002:a25:4bc3:: with SMTP id y186-v6mr1026584yba.18.1539270947126;
        Thu, 11 Oct 2018 08:15:47 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id o202-v6sm42799258ywo.38.2018.10.11.08.15.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 08:15:45 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id w80-v6so3733183ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:15:45 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id j143-v6mr1046482ybj.137.1539270945243;
 Thu, 11 Oct 2018 08:15:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 08:15:44
 -0700 (PDT)
In-Reply-To: <CAK7LNATXiJkXa4bfrCMb-kuWrn2gg-7jJg3qT3UR6HVSpC3Y3w@mail.gmail.com>
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com> <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
 <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
 <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com>
 <CANiq72nGrNMEqnPrxGXCp_iKf1_FuJLMvoV1+bbfYYCKnfTPVw@mail.gmail.com>
 <CAGXu5jKShFRJcP3vroEcZUevcHBSi53Towgs-t0v1JyEqmHJCA@mail.gmail.com> <CAK7LNATXiJkXa4bfrCMb-kuWrn2gg-7jJg3qT3UR6HVSpC3Y3w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 08:15:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKxF4AmA3GCuijqryca6fYgJYFZJUNf9vnvgJAYCUUiuw@mail.gmail.com>
Message-ID: <CAGXu5jKxF4AmA3GCuijqryca6fYgJYFZJUNf9vnvgJAYCUUiuw@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 7:48 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Wed, Oct 10, 2018 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Wed, Oct 10, 2018 at 12:03 AM, Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>> > On Wed, Oct 10, 2018 at 8:12 AM Joel Stanley <joel@jms.id.au> wrote:
>> >>
>> >> On Thu, 27 Sep 2018 at 05:07, Kees Cook <keescook@chromium.org> wrote:
>> >> >
>> >> > Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?
>> >>
>> >> clang built -next is blowing up now that Kees' -Wvla patch has been
>> >> included. This patch fixes it.
>> >>
>> >> Kees, perhaps it should go in your tree along side of the -Wvla patch
>> >> if no one else wants to take it?
>> >>
>> >
>> > I can take it along in the compiler attributes tree, since that
>> > touches the compiler*.h stuff. Although that would make it
>> > not-only-attributes, i.e. slightly lying :-)
>>
>> Oh, I had assumed Masahiro was going to carry it.
>
> No, I am not.
>
> Putting all sort of things into kbuild basket
> is painful for me.

Okay, I'll take it for the VLA series.

-Kees

-- 
Kees Cook
Pixel Security
