Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62BDC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA5620666
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGVef39Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA5620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeI3RtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:49:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42281 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeI3RtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:49:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id z8-v6so11136517qto.9;
        Sun, 30 Sep 2018 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o83ntsX5hLfAFFT/V5gbY42k+0A97ALRZnJZhtGVxXo=;
        b=hGVef39ZrQQ+wCqFI5z7CciRMPgeon08IvjZFbbQBwP2L3ljkOOdRW/vBf9WqFjGAz
         OGSy5HOnXntFIHAPndWMINuEfDaRdxc8Yhl96U2h23K77xWADcN61qh/w6otfMevZfT1
         ZM4I2AF5p/v+bS+pi/LpIga1EEot84pIFTpMsaziBT3QVXbxMblwy4RASbvKeZgNoZUb
         XWmWThddeB3wmGv3bkBz706yr/zzm6bD3oAzKwf9GVxb+ihfHC+i6+7tZtOZpHD2l73i
         MWzFPFBj5m7HleK5POwp3amgzcPH+1y0IR0RYWAMWU/O0b/fHHt2NA6WT13xDDyCTk8f
         or2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o83ntsX5hLfAFFT/V5gbY42k+0A97ALRZnJZhtGVxXo=;
        b=lms2UAHXsFAjs3wavp+espmWBOxNx0Y5FTVBVjrKKC/14Z60VIcUuzZmuOLxTrQIRM
         J6YxzZ2MeEgBfQntLqKbZWpx4ydqld25CX4m5YJf7V4Ce2jKWWLVX0b+ohm8P9VoShdi
         +dvp/WKwtVInoiCkZlZO5PRKAN5toH01dJ7ap5AfHbmMLSVkRKgN8pWcI9zqh1t0uF9m
         KQdrYhu9Xwkq7pV/fxxejZSbS6u84Eo0K9y8PWFSe3JOUI+KZ7In4JdPe0llVcdBtc5d
         WL6+hfyegCFPHyRLOxmbuJbELwBAFA+V+LLrbwpxt8mVm6JEHQhyz8fBUhRuNc3pdnZZ
         c/zg==
X-Gm-Message-State: ABuFfogh6qwPMXChR5iDiCNQoo43FqF4GkIZPT3F7bbf6stsHNwXrogZ
        20cOZXZri4MJtItzXiqU41t+bWsH5SuQ7tXwavg=
X-Google-Smtp-Source: ACcGV638kfuV8n3AzPdZ6h2MTkB0z6WBNjttj6/nchtJfMRzvpGgWvmLNRSTX9JstxnRYmGG9QIsoQp/JTEvqGhSM0Q=
X-Received: by 2002:aed:3c1b:: with SMTP id t27-v6mr673041qte.226.1538306186777;
 Sun, 30 Sep 2018 04:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
 <20180920172301.21868-13-miguel.ojeda.sandonis@gmail.com> <CAGXu5jJEXFXnOVZrjoUyyuQ-=L=Lou3iLsA2Jjzci_McSgn2XA@mail.gmail.com>
In-Reply-To: <CAGXu5jJEXFXnOVZrjoUyyuQ-=L=Lou3iLsA2Jjzci_McSgn2XA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 30 Sep 2018 13:16:15 +0200
Message-ID: <CANiq72nT12vjxjyPr2_nPFQroiiPbba7uoF0V-y_5+4yid=1iw@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] Compiler Attributes: add support for __nonstring
 (gcc >= 8)
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Done! Thanks!

Cheers,
Miguel
