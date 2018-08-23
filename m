Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0167C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D2B20B6F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="amaQ8LVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D2B20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeHWEke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:40:34 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40479 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeHWEke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:40:34 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so3004477iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwOSSVBD68d9p94j1hYhU9xhooO00I3zpsIalbzIyGQ=;
        b=amaQ8LVO35w7o+AArixlsGiHq0z2QtturBJBZLgpWWQLki0ZMyKPmifTEA6d2N8T/T
         LA1L5QnG42HStKoNXEen8/VjBXOGkjQOzcbrZ0E3mOAyCkNU5GjsUoERg7/4Pe1fN0/f
         dKWtlEm3dNIQg0YqpPygHwCMJbLVzQGfP26MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwOSSVBD68d9p94j1hYhU9xhooO00I3zpsIalbzIyGQ=;
        b=PoBdLdbDpyhhprQocEyNDp11+1EHazup3Z7Gzs9mxkiaoYrOZafjfNyrZmwEPO3+4D
         MQvKEq6/KtLlUhk0TiGTOsTyKhUZ/BWsOuDacOWlLL8C0Bj0b92BpQ8wMko0Ws2kVn55
         mN70sbcVC3mksXzKHjf2ipW3BaRR3D73o99rARNLDzu7E5xu0WoZRXNv7LAGI+qFG1Dp
         uHtdEhjVvQ+wgZX/fs2gKfI46IrDFiHsY7eBE8Yonvix37nqQNMJK7KMB6qV3wSPIGZC
         I/c790/0SNBIa3xZijzgr9UOXF0KBvwd6b8X4WVT6SmSMWzqPG9as+GpSlFZ9rpiWoxi
         N+Mg==
X-Gm-Message-State: APzg51DSRntn3jOoqJrywZPimhxr31RLXmP/oHMJD0PzkbZt1QDu1g0E
        ZvyieGWnwsJqHm0CagWS4uFaZPEYIT1AMUK/2fk=
X-Google-Smtp-Source: ANB0VdbcfRamn0l5AZBgiKZ47t8PX6f5eEhYhgOlmfLCSVJob//XfjUaQI0F5zNEIPjb8a8Ac3oo4RoFEsnphwqb1xE=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr6700187iop.238.1534986805053;
 Wed, 22 Aug 2018 18:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180822233724.110454-1-ndesaulniers@google.com>
 <20180823002508.GA822@nautica> <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
 <20180823011002.GB6244@nautica>
In-Reply-To: <20180823011002.GB6244@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 18:13:13 -0700
Message-ID: <CA+55aFx-tCjzOjmpCpNZKx7sPpFX858k7SKRuTztDCjoxY89gw@mail.gmail.com>
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

On Wed, Aug 22, 2018 at 6:10 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> I'm not building linux directly, but BPF programs that indirectly uses
> clang with bcc

Oh, ok.

I _can_ test the basic build (just not get a working link and a
kernel) by just forcing it, so I guess I'll call that testing enough.

I'll push it out. It's just Nick's patch, but with the extra barrier
parenthesis removed.

          Linus
