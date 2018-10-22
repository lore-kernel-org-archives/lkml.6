Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D579AC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930AB2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BzTFoqEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930AB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeJVTLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:11:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39660 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeJVTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:11:21 -0400
Received: by mail-yb1-f196.google.com with SMTP id j193-v6so4693724ybj.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 03:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sZ270nSjaKfi68ZW9Vo6MWbGRIFX4jrmR7nP2GqKqhI=;
        b=BzTFoqEaw+Wgv0mNgso4rduZZHV5EdrzpDWkaQIk05vvJqfiVgev98BnzOVUu/L1rg
         Vr21M5evhiq19twdE68VvO/KfKH4ITW4EggQoWEbbWeLAFSkreK7GK44wlWvmCD6ZPet
         DrU7pz5ghKHukaTKrTJs4B8BXMt33AyCfSsGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sZ270nSjaKfi68ZW9Vo6MWbGRIFX4jrmR7nP2GqKqhI=;
        b=iB3514YLxclDdhCm5P0U44yNwO7GCN28SfEbF0v3pNWBfypJxFHn17JWfdKv4eVzTs
         6TnKOW8buJ86MCcDrUiXfBMHNtXdQWWYG33m9bar3ZRlOAjEblj7SyAQMaNMS0O0KVUl
         Lk5z+Q+JlvLi6T6PwmPINGDfG9fFZUJNhrOqU84feAdntwauwSDv1/txEhmz/7XkawLn
         hBJTu7rZshfO5K4ct3zNuOf/RGLwbc1GYpz1ljaXQ87aYABAnlCxpP4TsGwSsZhrDBXQ
         fZjPV7uu4vSXJkx9ltgWvJFEbZkL4T5cOD4Kxdd7xlY+60JAvpEW9mgm7N2A+Y4p4kQr
         4Kxw==
X-Gm-Message-State: ABuFfoiVqXk+5/Gq9MesbVQrCyVhQywMFV8bKkBm9EIzlQUzNjSI+OHW
        Pb4aOIyybqipVcaMKYVwkhqq2IhEqkQ=
X-Google-Smtp-Source: ACcGV61xJYo+vF7MXPjYHQcr1TmHD7nQyTNncM+acg01ohCno8REV6E+wF1VFcMGKp4Fvi7eZ06H+g==
X-Received: by 2002:a25:2d53:: with SMTP id s19-v6mr18804960ybe.471.1540205596530;
        Mon, 22 Oct 2018 03:53:16 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id c128-v6sm12345560ywb.68.2018.10.22.03.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 03:53:14 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 131-v6so1185613ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 03:53:14 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr31941229ybk.209.1540205593804;
 Mon, 22 Oct 2018 03:53:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 03:53:12
 -0700 (PDT)
In-Reply-To: <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com> <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 22 Oct 2018 03:53:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLzfuEnWpJFL1Caq94nKbPps-QTaYGpge2CfZWj1Zzf9g@mail.gmail.com>
Message-ID: <CAGXu5jLzfuEnWpJFL1Caq94nKbPps-QTaYGpge2CfZWj1Zzf9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Ted Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan <dan.carpenter@oracle.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
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
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 2:41 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Oct 22, 2018 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> We need to make sure the static analyzers are happy with either
>> method. Additionally, when was -Wimplicit-fallthrough added to GCC? If
>> it was added _before_ the attribute, we need to continue using the
>> comment style otherwise we lose coverage even with gcc itself.
>> Additionally, does Clang support this attribute (it supports
>> -Wimplicit-fallthrough).
>
> Please take a look at the rationale (also more details at the linked thread):
>
>   * gcc 7.1 added -Wimplicit-fallthrough at the same time as the
> attribute and the comment parsing.

Ah, perfect. I missed this. :)

>   * clang does *not* support the attribute in C.

Well that's not good. :)

-Kees

-- 
Kees Cook
Pixel Security
