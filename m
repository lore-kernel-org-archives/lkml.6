Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7A5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A585214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmlrB5Ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A585214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeHOWjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:39:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44720 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbeHOWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:39:20 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so1696892ywc.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+2zaeegHuoo3f2deUQgqqVIE8vG0UFc2HnMQwZiir3M=;
        b=YmlrB5Ne0tesGm1IzE/gQlLGjSIzXaZwPBPrksZd9A6KE7Y2nNY5cF8TkaJc+3dzGJ
         S5z4T4AxHIMOmGgJ5MsrV3s59HG7OAP47A91mT+zxUeeJ2yBnq76tKMUw6NEBp3hyP3m
         Blm1avdlh3yghDc/pPonPmnlgBem+uWDs9T6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+2zaeegHuoo3f2deUQgqqVIE8vG0UFc2HnMQwZiir3M=;
        b=r+3+JO4VKytanqmKh2+FzXSoWZ5A9VOLE/9kJE7mVWHvV/ou7o3UjsVwuZYPbr0EiU
         dnF8vxSI1k3Fk8puAr58k2H4hnxt1rTqmYjY4VZZAxV3dnJzXANUpzmattrbKJITpJUF
         tigjl1dl5K8qGMmlJRRtTt9WXOMubPS8a/qt11P17g9pwfNprWnPatpSgkZhVQjmeUn6
         NmozRsDnKLYk3H0Ow+sROz9ans72pTt1JsicoX2y2wE//UHkONusWOqLiU/0wdKJMfBR
         Wl2HLkWVdoSB3KqzqiEl6jfEZ6SmJrj3q55ILTDe8+L4YuaeoM49EtyqQckG3q7Iadfq
         Vwsw==
X-Gm-Message-State: AOUpUlG3ujo8I35xJU/X9pa3MbhnBeOVxG0iKNjJ1+jdUW7709TTgQA9
        AcvKtxJ/6ehWKvtztU0aJS7Az0IJAAw=
X-Google-Smtp-Source: AA+uWPyqRouDyCJ4HPAYV3DbJ9DWcgxHizOoWgeVxRp0xxOLuX1+xrpJ/YqZN4eY2teSYxL9SKBYNA==
X-Received: by 2002:a25:7708:: with SMTP id s8-v6mr6582728ybc.67.1534362347198;
        Wed, 15 Aug 2018 12:45:47 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id n3-v6sm8240793ywh.14.2018.08.15.12.45.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 12:45:46 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id z143-v6so1709358ywa.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:45:45 -0700 (PDT)
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr15971177ybi.193.1534362345303;
 Wed, 15 Aug 2018 12:45:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5092:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 12:45:44
 -0700 (PDT)
In-Reply-To: <CA+55aFyFCWH3YJnRUKtSzs9Mvny0eU+=QANxoPTE+9B9CkUWDw@mail.gmail.com>
References: <20180813214328.GA15137@beast> <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
 <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com> <CA+55aFyFCWH3YJnRUKtSzs9Mvny0eU+=QANxoPTE+9B9CkUWDw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 15 Aug 2018 12:45:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ1JNSxJABUTAO85z_hXjSkjD=nWEho7KrYJTqqVGivig@mail.gmail.com>
Message-ID: <CAGXu5jJ1JNSxJABUTAO85z_hXjSkjD=nWEho7KrYJTqqVGivig@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin updates for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Aug 15, 2018 at 11:35 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> I swear I'm doing my best. Are you speaking of
>> stackleak_check_alloca() or stackleak_erase()? These were both
>> discussed on the list, and we weren't able to come up with
>> alternatives: in both cases we're off the stack, and recovery is
>> seemingly impossible.
>
> Why do you even *test* that thing? Why don't you just allocate stack
> and clear it.

I feel like we're talking cross purposes. The BUG() cases were for
places where we detect that we're executing with an impossible stack
pointer. It seems like trying to recover from that would just hide the
corruption for a later time that would be much harder to debug. These
weren't left in here to upset you. :) I have tried to take your "make
it debuggable" declaration to heart.

> Dammit, the whole f*cking point of this patch-set is to clear the
> stack used. It is *not* supposed to do anything else. If the process
> runs out of stack, that's caught by the vmalloc'ed stack.

It also handles VLA abuse, since those could (and have in past
exploits) been used to jump over guard pages. If you're saying you
want to see VLAs entirely removed and this feature dropped from the
plugin before you'll accept it, that's what we can do. I was trying to
help things develop in parallel since we're now three releases into
removing VLAs and it continues to be slow work.

> And if you don't  have vmalloc'ed stack, then clearly you don't care.

Agreed: this is why the plugin already does an "imply VMAP_STACK" for
Kconfig. Are you suggesting we should make it a hard "depends on
VMAP_STACK"?

> I refuse to take this kind of code that does stupid things, and then
> *because* it does those initial stupid things it does even more stupid
> things to correct for it.
>
> I hated the thing to begin with, told people that there are better
> approaches that don't have the downsides, got ignored, and then I'm
> pushed crap.

I tried to detail in the pull request how we absolutely did not ignore
you. Something like 15 people have been helping to remove VLAs, and
I've been testing both gcc's stack forced-initialization patch and
Clang's, and doing it via a plugin (none are really "there" yet).

-Kees

-- 
Kees Cook
Pixel Security
