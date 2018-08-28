Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730AC2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730AC2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeH1OrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:47:04 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44323 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH1OrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:47:04 -0400
Received: by mail-qk0-f195.google.com with SMTP id d131-v6so634434qke.11;
        Tue, 28 Aug 2018 03:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EyVnGzEXtmHDUZNpeAAbtRg/nqDNiWg+/uLUN1sf70=;
        b=OmdgsBrUPcnhOWHwmCDOWp8ob1Vkwh+l+hyXFqpCjl4677Z9o9HhK+uZl9sqdQY75L
         HG30QNNhaiJSusIb9X2YWSIGZNjUwNGEBgTfHZaH1jIayxcX52UDVyo88V20zoKri+wE
         GePa2biaqxItfpKULd+38IoxmEbhcU+RvoyDWPpUVlID8BljKWNTdV6e5Xohy7kM1eCA
         0S64H4w98I66+tMba6sg1rgi81Nhs5NIfUimitDwtSilpE7OWS99Nzy/G6FTYIIQwix6
         odki9ic6LwbvkWrJTkuyzZuz6+EibAEX1L8Y14Peopce/gwSnyVmA7KsFfguEu0VgL7+
         ASjQ==
X-Gm-Message-State: APzg51DeDZcLbpERc7h0cJA8jBu+aMIPzoG/c7ISwEgWmDLKv+C3u4Jd
        AykX5vwlqDGLKE6Cr4P53FRSmwkvjg46zRXT7tM=
X-Google-Smtp-Source: ANB0VdbSIhdAZGZZ6LQt2ChhQBRNGm0ZUrixWHAIVQr83OMA8TMhfhYyGWVgPPChE630VILoXSiqDuogqXLIbQJzld0=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr868366qkc.107.1535453758926;
 Tue, 28 Aug 2018 03:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
In-Reply-To: <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 12:55:42 +0200
Message-ID: <CAK8P3a2NgqV6fnQSaTFKWdBpwp656L9Kp4NB=bwTwRb8ojZAuQ@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     daniel.santos@pobox.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:44 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>
> On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> >> Now we're back to the question of "what do you mean by 'constant'"?  If
> >> you mean a C constant expression (as defined in the C standard) than
> >> almost none of this code fits that criteria.  For these compile-time
> >> assertions to work, we are concerned with the data flow analysis and
> >> constant propagation performed by the compiler during optimization.  You
> >> will notice in include/linux/compiler.h that __compiletime_assert is a
> >> no-op when __OPTIMIZE__ is not defined.
> > Depending on optimizations for static assertions sounds problematic.
>
> (with my best Palpatine voice) It is unavoidable.
>
> Actually it's theoretically possible, but the compiler would have to do
> something akin to copying it's control flow graph et. al, run -O2-ish
> optimizations, perform the static assertions and then throw away the
> optimized control flow graph and emit code based upon the original.

In the context of the kernel, compiling with anything less than -O2 or
-Os is not an issue, we don't do it anyway. -O0 never worked, and
AFAICT we only build one file with -O1, but that is something we can do
away with as well:

from fs/reiserfs/Makefile:
# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
# functions are used.  This causes the compiler to advance the stack
# pointer out of the available stack space, corrupting kernel space,
# and causing a panic. Since this behavior only affects ppc32, this ifeq
# will work around it. If any other architecture displays this behavior,
# add it here.
ccflags-$(CONFIG_PPC32) := $(call cc-ifversion, -lt, 0400, -O1)

     Arnd
