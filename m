Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A63C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7DB21738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeLaMTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:19:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35960 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeLaMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:19:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so29165087qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtZXBXSwQzuhM6llgbZc1NEGQibmPDxx7rAlim7Nhm0=;
        b=jwvAlB2nrWYa/UMk5VSLrbNpWCywKCyx7vUU8yo7v2khuwzL3eCzeGw6ph05BM2gXX
         C1bvxS+c1ighlCvO3E+BtdKtVmmVrlm+tHT0rIVRJsjPMtrOq6C633CHNgxK+Iy1f1D0
         b95RVxRv6nc2F4AF2qpTERzmMiMdI5RKpoeXE5jhlLUyaBP/URPexsI7hi75XFmt8fA2
         wcHA4GVUFf3f6HRkt6El+9SPbo16Gf0zYbCAMvDQYiaSjkJueCCWbNrE+NnUo94SYJ6Q
         SvtuDU0CJioUmrUb0lWr1vAF4mAgYx/Gq5hhK3s44K8M6yMemTN/p4xgglrySrSxD8rb
         MQKA==
X-Gm-Message-State: AJcUukc3JDOxe9exmRWIuphImJCzo1tCjTRwezyYO1cYav5b/Mna1vWX
        WLNoxV9z0T8A7L8WVCsmbth2r5hjuziCpT7VWZI=
X-Google-Smtp-Source: ALg8bN4oVjvi2Q14NJJtP8prMbk3T1Rd1/JF9EUL0lUZ8LZc/JYzPccFVMlzIZtenBQWTy7yJiaL6KrX0cDNvAcpXBw=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr35156465qvm.149.1546258759237;
 Mon, 31 Dec 2018 04:19:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
 <alpine.LNX.2.21.1812301750320.424@nippy.intranet> <20181230185300.Horde.o5iU5x8n8UeDsyjemaBU_w7@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812310847210.444@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812310847210.444@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Dec 2018 13:19:03 +0100
Message-ID: <CAK8P3a09GW_r6L74LtaPKdjcPONk7qweLMuCgrw=7daQ5tBcCQ@mail.gmail.com>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac functions
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     LEROY Christophe <christophe.leroy@c-s.fr>,
        Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 11:12 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 30 Dec 2018, LEROY Christophe wrote:

> But I'm over-simplifying. Arnd's alternative actually goes like this,
>
> #if defined(CONFIG_MAC) && !defined(CONFIG_ATARI)
> const struct nvram_ops arch_nvram_ops = {
>         /* ... */
> }
> #elif !defined(CONFIG_MAC) && defined(CONFIG_ATARI)
> const struct nvram_ops arch_nvram_ops = {
>         /* ... */
> }
> #elif defined(CONFIG_MAC) && defined(CONFIG_ATARI)
> const struct nvram_ops arch_nvram_ops = {
>         /* ... */
> }
> #endif
>
> So, you're right, this isn't "duplication", it's "triplication".

Ok, I failed to realized that MAC and ATARI are not mutually exclusive.
I agree that your original version is best then.

       Arnd
