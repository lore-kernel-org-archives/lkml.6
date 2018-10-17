Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF04FECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77813213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RslRXyWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77813213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJRGtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:49:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42121 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRGtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:49:18 -0400
Received: by mail-yb1-f194.google.com with SMTP id p74-v6so11066900ybc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9EIVAGdeAV6Bg/PPh56IRt+ZYwMbFdtVfvHVjxDcryg=;
        b=RslRXyWJ87wRkFRYQoUukRB6NxkMTGgp4deuD/fhe7BRU3VohixtgZ1WJKm6AuuDrR
         rZCur8DLr2xr64AYWzav5YDCQxWRPgvbAfcYb3S7mneuEmCJi9A+TF/fCs5qI60F5Vpy
         ugD0lyDrtNEVAICV7ugQy/U56p4F+tgBAjyGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9EIVAGdeAV6Bg/PPh56IRt+ZYwMbFdtVfvHVjxDcryg=;
        b=hIzWVW6UGzOyR1hh3giblmFiw7yOQp84tlZwlV03LrAEZtwulPYEUOQ+8YkXlbbzVl
         o6fsudhVL8JDHfFob1VSJwUaz37TB8YHMEe9rQo0evoZx7Jkx1CNsn5s/fDq6NZxfDxU
         ikzIl3VDPpbbhDsPoVzxoZQr9lRTsqKuQWv4VIk+IZCv83b0edYJTL0+ATgMWZICR01c
         bOUXnIxw1VKL5b7IcLIr9EbZYj0SFAxcbpSdz1Z/BFXYanP1pDfb03+ynHJ5N7J1zAB1
         0TkeqKfT1w6lRhq0vo5fRHNgUw67kjbcvhsT/EmmoT0MIkR3sacACE/FYBEOuwquWA8d
         +vrA==
X-Gm-Message-State: ABuFfojkr914UtaIbVEYpyn9fUZ+4Yc2H4ZDjvXD+LPJmetcG9HgI4us
        +YcE4FAdSmGXlAXul4O8TNFrhWbYkAg=
X-Google-Smtp-Source: ACcGV61USTi9GbINhbeXYLfRlJIA4sdaHH1+mhI7G+pWbtNufvev0SiFCNgm/utydV5shcP88mw0KQ==
X-Received: by 2002:a25:508d:: with SMTP id e135-v6mr16628924ybb.44.1539816685095;
        Wed, 17 Oct 2018 15:51:25 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id a126-v6sm4714252ywc.4.2018.10.17.15.51.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:51:23 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id v1-v6so11056617ywv.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:51:23 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr17253859ywf.237.1539816683309;
 Wed, 17 Oct 2018 15:51:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 15:51:22
 -0700 (PDT)
In-Reply-To: <20181017065011.40ad8b24@lwn.net>
References: <20181017021708.GA22211@beast> <20181017065011.40ad8b24@lwn.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Oct 2018 15:51:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+CP9aqGNxO9HvbMgR9rJHx1d1=5vS7id8S-bUWRASw_g@mail.gmail.com>
Message-ID: <CAGXu5j+CP9aqGNxO9HvbMgR9rJHx1d1=5vS7id8S-bUWRASw_g@mail.gmail.com>
Subject: Re: [PATCH] docs: Introduce deprecated APIs list
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:50 AM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Tue, 16 Oct 2018 19:17:08 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> As discussed in the "API replacement/deprecation" thread[1], this
>> makes an effort to document what things shouldn't get (re)added to the
>> kernel, by introducing Documentation/process/deprecated.rst. It also
>> adds the overflow kerndoc to ReST output, and tweaks the struct_size()
>> documentation to parse correctly.
>
> Seems like a good idea overall...a couple of quick comments
>
>> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005282.html
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  Documentation/driver-api/basics.rst  |  3 +
>>  Documentation/process/deprecated.rst | 99 ++++++++++++++++++++++++++++
>>  Documentation/process/index.rst      |  1 +
>
> I wonder if "process" is the right place, or core-api?  I guess we have a
> lot of similar stuff in process now.

Totally up to you. It seemed better suited for "process" (here's
things NOT to do) than "core-api" (here's things to use).

>
> [...]
>
>> +open-coded arithmetic in allocator arguments
>> +--------------------------------------------
>> +Dynamic size calculations (especially multiplication)
>> +should not be performed in memory allocator (or similar)
>> +function arguments.
>> +
>> +For example, do not use ``rows * cols`` as an argument, as in:
>> +``kmalloc(rows * cols, GFP_KERNEL)``.
>> +Instead, the 2-factor form of the allocator should be used:
>> +``kmalloc_array(rows, cols, GFP_KERNEL)``.
>> +If no 2-factor form is available, the saturate-on-overflow helpers should
>> +be used:
>> +``vmalloc(array_size(rows, cols))``.
>> +
>> +See :c:func:`array_size`, :c:func:`array3_size`, and :c:func:`struct_size`,
>> +for more details as well as the related :c:func:`check_add_overflow` and
>> +:c:func:`check_mul_overflow` family of functions.
>
> I think this should say *why* developers are being told not to do it.  Does
> this advice hold even in cases where the dimensions are known, under the
> kernel's control, and guaranteed not to overflow even on Alan's port to
> eight-bit CPUs?

I will attempt to explain this better. When all factors are constants,
the compiler will warn if there is an overflow. If, however, anything
is a dynamic size, we run the risk of overflow. It's not true in all
cases (e.g. u8 var * sizeof()) but it's more robust to globally avoid
it. (What happens when that u8 becomes a u64 at some future time?)

> To me it's also a bit confusing to present the arguments to kmalloc_array()
> as "rows" and "cols" when they are really "n" and "size".

That's true, though I used rows * cols as an example because people
aren't always thinking about their multiplications as having n-many
sizes. e.g. "I just want a full screen of pixels." Let me see if I can
adjust it...

Thanks for the feedback!

-Kees

-- 
Kees Cook
Pixel Security
