Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C75C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DEB20652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H0C6wBLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DEB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeIFAMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:12:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56045 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeIFAMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:12:18 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so11556904itj.5;
        Wed, 05 Sep 2018 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zENSwIHiYQAL9t9ev9k2hZssc9v3IioXvpNv9y2D9UI=;
        b=H0C6wBLNSj8MW/vIRd9+rdr6x+EqmFhB7drfHamoRoC/XjRpLda2HErIazq8cVS6zp
         bgtu3UKUk6PhO5CfmfImGxws2phgpXAXOUJ+gSCxy1sefVINvjATEYIJ0wBwsxHCFftc
         OIWBC0mDaslkUMPm2vQvnCPgXJDhV8xEaA60E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zENSwIHiYQAL9t9ev9k2hZssc9v3IioXvpNv9y2D9UI=;
        b=PccnCm9tVFSkzeYaCKYP5ekdBlY+OcsanBH83RPeiVJEEXO3cRAWqkLyhnB6C2AyXQ
         u1r1VnrJal2kDJE8IrkYzbGQ0YnQwsaJadHjpJFgR3j8nNJ9EfL/NIcJAwSXeiD5CqDT
         ipHMaEUvPWrAsoJOokR5jUWDPvb4V6JWyMYaNUlmhwhHvW11V+pT7PtKpTdI97DYiEZK
         ElDiXLUg/Dg7oyyDeVjdyk5MFzvln0WAd5bLySQkN/WcDNF5D0SZCT9R13f0sA+UETH/
         wwAN/ANFbWZa0oiyJfg7b/cpswHMl8mlGvB/kgIU7+2Whk6haPinegElXcK45VXa7Dae
         CiuA==
X-Gm-Message-State: APzg51BZh/kOTRtHqPKW74MBvpH324vU2QR21VSYkSD9mib4UBXdXvg3
        RS9Q9Rf+x+1w46+u3eKkN4zqV7ObhKBW1+XigdY=
X-Google-Smtp-Source: ANB0Vdak0BvMZyVpb/SsC38DH1JsGOa6dLfkh9A6MovY2a0Whlbpq2FtngVJ8ScXm1nyJJvH9b1L1cBH1D9i9R7xwLU=
X-Received: by 2002:a02:9d45:: with SMTP id m5-v6mr27246349jal.72.1536176438970;
 Wed, 05 Sep 2018 12:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
 <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com> <20180905182038.muv535vfugm72spk@ltop.local>
 <20180905193035.GB3420@localhost>
In-Reply-To: <20180905193035.GB3420@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Sep 2018 12:40:26 -0700
Message-ID: <CA+55aFxWcAqzuYOn1OPnRy5g5Uj69mQvxDK9Tn5HqecA-f3eiQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:30 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Unlike GCC, I don't think it's at all unreasonable to assume a
> *relatively* recent version of Sparse.

Yeah, sparse is small and easy to build and installs in your own
~/bin/ directory by default.

Anybody who can build the kernel can trivially fetch and build sparse
in seconds.  It literally builds from scratch in 2.5s for me.

I don't think you even need any development packages that you don't
already need for the kernel. Just a C compiler and libc, basically.

Sure, some parts of sparse can use things like libxml and llvm and
even gtk, but that's for functionality that the "check kernel with
sparse" doesn't even need, and the makefile will automatically disable
them if you don't have it installed.

So if people are having trouble, just point them to the sparse repo,
and tell them that

    git clone ...
    cd sparse
    make -j8
    make install

fixes the issue in 30 seconds.

Although maybe I'm misstating just how easy sparse is to build and
install, and people have had problems?

                 Linus
