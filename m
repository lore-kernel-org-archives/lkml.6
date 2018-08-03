Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69475C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221AC216FB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="o9LlyPnB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xsm2s+yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221AC216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeHCEug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:50:36 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41969 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeHCEuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:50:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so449005ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mvkT1qP+nOBUKDKRoMfZVTlToVTgu9yCAl4Zk8RVTzk=;
        b=o9LlyPnB0mHuwYRoNNBdOtP/5HwjrEgFNfLDlSwHt/j2dEpN/clyQprqQYR0ZPgm5g
         PzfFm997yz0mwGg8upGU7kyUoP6vNcL2uCT6ReI2yyvTJGV+0YetCM3pzGa/SK1nRoSQ
         Jg90V7Qtt4agUIt9G/n1Odo8S8tEO56pJgM+G+puvoTXQ874nOx6r2UJxBThL9f86F8n
         nTWeUS0rejO0KonSLcnJhq4wH/0g9+9L8vB0IAz35u4aWZntFIWCuuNIvRqJDr6gb9mK
         k+Y9XolRf4lqfAkSCZmKpS4KWIm/e2VsNApV7xupl6t7VQJ0ExFuNvsGsSvGjpplA44v
         MIRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mvkT1qP+nOBUKDKRoMfZVTlToVTgu9yCAl4Zk8RVTzk=;
        b=Xsm2s+yx+UU12wZoXBZ1HWVPAlyCaYCdnpBmK/UHv5hMoteC9yiZRRhFAltEqVUEI+
         +C0KxuPuLC7UD/KO1+Yccz03EY5UC3eMdXijvXMpBT+zrN73s75+2T++9ggWih98WCHE
         uFdiwXqEc+l5tllMB5qBWwsa24ZxGxm1cwyrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mvkT1qP+nOBUKDKRoMfZVTlToVTgu9yCAl4Zk8RVTzk=;
        b=kqPcCyWS2HBlTFuBKZJdldBSjj1fRRHsYOGBi0RlaDSwQ6umtU7KeUM80WvsyAusV8
         lAzZ/EofKbEk2x4cuuF8AZU7T3u8sKpElGpTVlhqx/RJGipP6PzPpZ9qJHwmo5kjVm21
         6iLidIXGiwBF+JM2JtNF3tvZZLJNiVtxEQLX+hVWSw8QMzsSYa8ne9Ju/tdAAkRahcSf
         99PDtWu5jORcQclIGmD6uKrgwKGjkLI6MHIT0NU7Iw/BFfP226LuBgmzdhTAP8edEZAr
         mSRNrV+blCgpVxQngOd0aeLIk4tVwpayD0P/jcY4f2TBpvns1+q3BTH3HLa/4FWdJ/Ej
         +QQw==
X-Gm-Message-State: AOUpUlEvtbUoENoAfWPTSgIJdn/0nH/g6y+h2e5KlOvPpl5nTczkWiym
        MuGVppggFzBiJTctHh6FqEb8cWaORQWSQWk54/DIAw==
X-Google-Smtp-Source: AAOMgpdj6xxShRz1oE1ilhUFRFzCC38oLZbUbvnnp2/rTTcA5780DkYRp4xrsGQUFFmkopKeyPH0IAqScykw8KaOJwc=
X-Received: by 2002:a81:b248:: with SMTP id q69-v6mr1148290ywh.38.1533264988571;
 Thu, 02 Aug 2018 19:56:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 19:56:27 -0700 (PDT)
In-Reply-To: <20180803110002.5942ff15@canb.auug.org.au>
References: <20180803110002.5942ff15@canb.auug.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 2 Aug 2018 19:56:27 -0700
X-Google-Sender-Auth: 2DRId88ZpK3LjldhQvBKbBvn2FM
Message-ID: <CAGXu5jKr_M1zxirDJjbE5fzzhQyXeNWaAkGUK13RDKTBANTbPQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pstore tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geliang Tang <geliangtang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 6:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Kees,
>
> After merging the pstore tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> fs/pstore/platform.o: In function `zbufsize_zstd':
> platform.c:(.text+0x172): undefined reference to `ZSTD_compressBound'
>
> Caused by commit
>
>   48ed452ca6ad ("pstore: add zstd compression support")

Yikes. I have no idea how this slipped through. allmodconfig builds
are my standard sanity-check but I clearly made some kind of error in
my scripting.

I'll get it fixed. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
