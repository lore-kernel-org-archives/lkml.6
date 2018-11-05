Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9703C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882172085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loEgC+Mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882172085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbeKFH7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:59:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45724 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbeKFH7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:59:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id o19-v6so5137800pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZACWSjZ3Q5WmL3kd7vzGZGnEgREaoyhBQDYpK6S+ic=;
        b=loEgC+MmKhvc+amScuS9dM5DJuIjeijXRkGzrHvznv1L1xh8fEOiGHlsA3KUaRSpSn
         nvyUZ1aFvl569emwknlhHLGKX6/yKNVZAkC8Rt780SXDenj8TsPuPS6SP8fjKRxHlN0/
         LYQvrL1/KZ+t1pEjjcVHhpt/jPFKXhPMPGitMczYSed1HZc6zMKGrORz25qb3iIwyZ6o
         AftCaGr7p0zaCVr3pSk94kXOYmaL7Apt70iDc6HfXQopyg8KbvFggkfmeaZ8PsL5YqOQ
         VcM4bq689GYryayC9wihFIwVuE4+S1KUnCwvVQqyt+XMd0W+Z7afkDq2tIvJlKXP64/v
         Gmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZACWSjZ3Q5WmL3kd7vzGZGnEgREaoyhBQDYpK6S+ic=;
        b=FNahG00nZljkhT0ru06fte0vze6IEYQN4PfCPLBsraisih/BE+LG6wwAtK4dReJsVI
         bbTj7TXdXSl9UcLb7Etqx0uzKGNFkGZetSBq/Fuqq38SEPO1tC2kUbsOySR7VTsSClk2
         Na2tXMcweysTXfYMvtR1wWrEnOEIUyeRqdC4y5GffH5SUrn6LK6tEDKiEcCkdY3go3xc
         T6iSZWkd53mYLcM5WhxFzXjrsHapnRPpToiJPLKRM3EJ1FHwrbsVCL5bkWCOc3j6smX8
         go6mt+QQZCDXX2Xxirtif+uvnqp0axLj7o5zqlX69O8uzAAawMkrdaz3PRuNLscy78/k
         +EtQ==
X-Gm-Message-State: AGRZ1gJIyPB8VIDszQnVCG1+i6KK6QIvC9x2fRNQiCWD4oU1Yb1IPk5p
        Ijc9S9PuJBhKxg8TklGhjDr7tLyxe77wondkFmJVwA==
X-Google-Smtp-Source: AJdET5c/9016aIchIGgGORthwYlI6HydHAI0r9WmpRvkHSoVNHhTUQH+OEg6T5jxuTNUaRbfSCfJcUja1WDdx8NskpU=
X-Received: by 2002:a17:902:9897:: with SMTP id s23-v6mr5297812plp.229.1541457475475;
 Mon, 05 Nov 2018 14:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20181104231133.30848-1-joel@jms.id.au>
In-Reply-To: <20181104231133.30848-1-joel@jms.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 5 Nov 2018 14:37:44 -0800
Message-ID: <CAKwvOdm8WZTeB_wxkO2nN7PW=v=2z7tdVapTq-TiB18nZZfS=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] poewrpc/Boot: Fix cross compiling with clang
To:     joel@jms.id.au
Cc:     mpe@ellerman.id.au,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 3:11 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Hello,
>
> These patches allow clang to cross-compile the powerpc boot wrapper.
> The boot wrapper constructs it's own compiler flags as it may not be
> built for the same arch as the kernel.

Hi Joel, thanks for the series!  I'm just curious, how does the boot
wrapper run on a different arch than the kernel?

>
> The powerpc64le kernel builds natively with clang and with this patch it
> can cross compile too.
>
> Joel Stanley (2):
>   Makefile: Export clang toolchain variables
>   powerpc/boot: Set target when cross-compiling for clang
>
>  Makefile                   | 3 +++
>  arch/powerpc/boot/Makefile | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
