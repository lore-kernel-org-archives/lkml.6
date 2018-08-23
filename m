Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDBE208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hwqNuI52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDBE208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeHWEaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:30:02 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53312 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeHWEaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:30:02 -0400
Received: by mail-it0-f66.google.com with SMTP id k188-v6so738337itk.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 18:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdJoxnB1+Bp7xcMmieTKxeRT3Ftk8uAXI2ZL3li8TyI=;
        b=hwqNuI52lwcABu6PXRl+TEQ8SGp55TOIpB5CRZoPGJngICyqboN5vvDx4zRy/9DKOD
         /Qz08dubv/N1LiIOxZadK3lm/GGhUPok4zsH5Eh1k7pXB11RdqVA28UgIWXkbC1AoO53
         fp1KQysU1MYnIOI+HpaDJGrTyJKgraqAOUeHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdJoxnB1+Bp7xcMmieTKxeRT3Ftk8uAXI2ZL3li8TyI=;
        b=DoomrpBAWoN1pxscb9xivw6kiDC55baOaChjvdBRhG7Px0189POkwcSGBWY2qMcjzr
         v/kKoV0z5Tce8MQE3cYWVgYqLjr9iZg0UPsNhorxrSnVwXrN5fWQg005sLvbUFTKW6pC
         KtX/Qd8/KKeaU1jK6iEeHBGADovtS2pwdeMu2KvBb/l39v4mfz7x1Ko6UWEj10edT/kD
         oNi98/WkJazb2kj9tHh2adBh4J4vLBIeDDVKmfLMAax0BJraGO+8GHywwFXhJNc8lGoA
         YZdJV/zB3mgX4WXLhojv42bPDpGcBXMpybexMFFUhsjVMnkXG9I8w0iE7tb/KtHkwiKD
         CwVA==
X-Gm-Message-State: AOUpUlGMjcf0fKMo6Sdm24eyeroDtynzgwIethrj4CuxH0XMbsnrUeNy
        2sxmGdfgpfLS81DNjPMZIhljGOBvitpt7jvHYYA=
X-Google-Smtp-Source: ANB0VdbvAj6Xc0KU1HHn+eBsIwqnpQ8z4/eYNAHrl/uzj6N3HOez/o7FgfRkZqFtNFKNdbbBGX5+5TCrBmFSE7JxyXs=
X-Received: by 2002:a02:9d45:: with SMTP id m5-v6mr9734642jal.72.1534986175177;
 Wed, 22 Aug 2018 18:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180822233724.110454-1-ndesaulniers@google.com> <20180823002508.GA822@nautica>
In-Reply-To: <20180823002508.GA822@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 18:02:44 -0700
Message-ID: <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually exclusive
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 5:25 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Overall looks good to me, just pointing at the same error I wrote in my
> other mail here -- I saw that by the time I was done writing this this
> patch got taken but that alone will probably warrant a follow-up :/

I've fixed that manually, but when I tried to test it I just hit the

  arch/x86/Makefile:179: *** Compiler lacks asm-goto support..  Stop.

error.

Do you have some experimental clang build with asm goto support? What
version? Or is it just that you're building ARM, not x86?

             Linus
