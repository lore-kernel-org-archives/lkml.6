Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EA0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D8F20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ap6+XNMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D8F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeLKBk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:40:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45194 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbeLKBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:40:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so11424916ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 17:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=108tEwMnsOyR1Qg6kCaAed0YVY4gMbMYx9nYF5g2vss=;
        b=Ap6+XNMgpe9K7kzWrVKQMc0yB3Q4W9dUSZ3coH4Ckfl8WWkr1bLJuVMdsPuYq4qHFD
         tPr95BAMliFIJ3SMEzffmc2NOWkkCkkb8Wl/sEtEPYHqiWZ9o+GatitFv766i3wVgN9y
         7foCjkMH5YtYG4l20OArWoXFyy1kRIXMonJ74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=108tEwMnsOyR1Qg6kCaAed0YVY4gMbMYx9nYF5g2vss=;
        b=RHBjIjrC1lnUCpzbqZB+1/f9Sb+ExZIvKS+I6rN/nxI3ETVNpsz+X5P9FKmtKkGh11
         nBLgbQt07KS8AHeqyT1GGqt5KuqImEYvu2vL2kk1Az6iT2Lbm/S5SCTHoKZIedP0zGuT
         cWV31GN0RQg3a9vTbwqiRImodx5hktN4xnmTY8gZ2zRqZc0UfbukHUDMoARROyoB6KEa
         2i3KVPndZ5dFm8BRqL8IP/Pr7YiZyMdlu0gVdWeDeFwKFkIeNCPrBpYI3Ydk3d/njRrA
         rb3cC3r19l/QTbw8tqSTqLinvHfG8R/BHMWuGRO2y1VT78kHybrjgx15vWmEVouCc95a
         uEzg==
X-Gm-Message-State: AA+aEWaBzRU30w1LNXbObWEVwdgDh8i0ObQcD3wI2MPdrvhaR3oD3z97
        6A36Ixd7yzA9JTiJSzU/QJGgY8UtCt8=
X-Google-Smtp-Source: AFSGD/XsDfUG4Vyh75/lakvvrlEd8HCuQbemHxftXzvIvTXtsYhdIh1/tF1OOSiBXfg2M9Yt+kSLvw==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr8547087ljg.155.1544492452727;
        Mon, 10 Dec 2018 17:40:52 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d10sm2395222lfa.71.2018.12.10.17.40.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 17:40:51 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id c16so9500952lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 17:40:50 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr7866096lfj.138.1544492449862;
 Mon, 10 Dec 2018 17:40:49 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
In-Reply-To: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Dec 2018 17:40:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
Message-ID: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        fweimer@redhat.com, vapier@gentoo.org, hjl.tools@gmail.com,
        dalias@libc.org, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> I'm seriously considering sending a patch to remove x32 support from
> upstream Linux.  Here are some problems with it:

I talked to Arnd (I think - we were talking about all the crazy ABI's,
but maybe it was with somebody else) about exactly this in Edinburgh.

Apparently the main real use case is for extreme benchmarking. It's
the only use-case where the complexity of maintaining a whole
development environment and distro is worth it, it seems. Apparently a
number of Spec submissions have been done with the x32 model.

I'm not opposed to trying to sunset the support, but let's see who complains..

              Linus
