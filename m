Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90068208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KLA2jev+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90068208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeHWDtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:49:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39207 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeHWDtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:49:00 -0400
Received: by mail-it0-f65.google.com with SMTP id t69-v6so4679813itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyRTh7vOkoyuuxIK95ALIc2+A9pakCWVK9T0y4FkGWM=;
        b=KLA2jev+G4JtHGN/9GMFeoWla26AImsaoiUEnVPFJ1fQ4uBVznkBgX/eU1OCUtCHms
         K0RrwyPrRdf9+KFyhe3L5QxpxK/uHOk9IUJmJKRYmr3AQmtrrZ2gIJVpqny38KWj+dOc
         OFYUq2woiWrVCVeh+I7tTS+i/Ds8/4nRR2Bg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyRTh7vOkoyuuxIK95ALIc2+A9pakCWVK9T0y4FkGWM=;
        b=SJW/lAAnfEDgjtbETnsSGP9b+dpnlbzj9U8UEZbgdWA1iVf3Pu3IKDk4+H+qFdBIZq
         uK5r6nnWp+fhCXdT2LESjsuQuotGSgIC/IlBaSkJhBIC5bmXPvY9M4FK7/XiWAvZABsR
         CVY+eMe5xJZFaInCJb/d1osKXQhfW+Z8ZdGd7wXCh3s8JzrI1UQ2LpA4Rv7jE12K2n86
         w12h+XEeOr2pQ/Vlx7FtXwCq60WhqwfjdSC74jfKapmVL6FZOmGUUN9Nk1lfKtA4qQ2w
         AM9K8ANkRRrFBRQfoKA90jcRMF9ubm1e7AVe6f3TqTE38Fz2a8KiXucWQuwyocMc0Pq0
         eXDA==
X-Gm-Message-State: APzg51Dij2DXf5AJ1X+TyIG8RWNbVLuc1uMkqhmwwQJRO+pn3eSvU8OV
        EBW443eqmJGm38sLYBsroFSw9Ro2T2hfJAjZHAU=
X-Google-Smtp-Source: ANB0Vdb+eoWSBAGBWfb0mnU0euANuwunPe1Be0cF54MfAWZhnsjOiSWJDJ2/IzfXVdwblf1XkRHhfx2QFhZseSWO5YQ=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr5560594itc.22.1534983719464;
 Wed, 22 Aug 2018 17:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180822233724.110454-1-ndesaulniers@google.com>
In-Reply-To: <20180822233724.110454-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 17:21:48 -0700
Message-ID: <CA+55aFxNMhEacF2CAqCRX=L3Kcg2AR98FRbaU8F18zMuhhw4jg@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually exclusive
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 4:39 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Rather than always including compiler-gcc.h then undefining or
> redefining macros in compiler-intel.h or compiler-clang.h, let's
> separate out the compiler specific macro definitions into mutually
> exclusive headers, do more proper compiler detection, and keep shared
> definitions in compiler_types.h.

Ack, especially with the other cleanups leading to

>  9 files changed, 133 insertions(+), 253 deletions(-)

and I just took it directly, since I had taken the original
cafa0010cd51 directly too.

I'm sure this can still be tweaked, but let's get the baseline in and working.

               Linus
