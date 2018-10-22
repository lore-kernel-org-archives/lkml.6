Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4482C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E93220658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZpJdltZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E93220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeJVRwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:52:02 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45428 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeJVRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:52:02 -0400
Received: by mail-yb1-f195.google.com with SMTP id 131-v6so1105861ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gh3kUPWXIp5mrPU/Do+stSfXrDwAtMQcpb+ivzkBaOY=;
        b=ZpJdltZrkMsKFsaJ2c0iSoW5BHJEaEsP7nL/OpkuBL4TlMlPPIVn7B+dq8MBUwUyhv
         f8z7TK8zMmR7vq/f4rOnIaMlOOAbnrZMSdLqHDI8MAP/zHs7/5AONhG+lfznVeecua9e
         xCqmB8hnbLolfC/vEL+UcEP8hd/h4Y1IBW8yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gh3kUPWXIp5mrPU/Do+stSfXrDwAtMQcpb+ivzkBaOY=;
        b=NymwVqiyQ8uH8AZo28yh1bKiZrM4rIllFsCLa+BaBmFmfWexgCrAzwndrylvFQ7ig2
         1+rxbYS4B+0bmWilKUX5b6LZ8wFy8R9zjInZL8Q3fDm6eSkiCW+azVD6qLt6qcWX5rMt
         P+0q+BwVWLOELLuKt/1mNCtWc0v324sdLuse2WRuaYSLFuCf6sXObYfgpD2Ir/BeqAMd
         v+2zGkmJp4876LXFoNEvuOZ8tWljHjzR22BqE6FVIq4fAuUxjndgQoY2JCV2oJgf9Duf
         My1SxvUXaP8QE2EXWse81KU8ARhoJe2/yqsoYmdlxCIpoCEK0sXyPY0yOapZR9zMPgBk
         tTYg==
X-Gm-Message-State: AGRZ1gINIoFFA4NEdwLW+UmxXn4YRp1uqunw/brSwyOdwkUeUubrIRyo
        NI560g/myiI1rU/MmlLUz3oidVIfEEw=
X-Google-Smtp-Source: AJdET5eA/RXP44Ypieh0//EnWS6LRbq9rTlcxkIt0wknVKbf2ZSMezxbaRwCKxA5vufeusthHCMxMw==
X-Received: by 2002:a25:3813:: with SMTP id f19-v6mr9424335yba.237.1540200856785;
        Mon, 22 Oct 2018 02:34:16 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w188-v6sm1458980ywf.59.2018.10.22.02.34.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 02:34:15 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id k132-v6so4733454ybc.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 02:34:15 -0700 (PDT)
X-Received: by 2002:a25:820d:: with SMTP id q13-v6mr16994817ybk.171.1540200854791;
 Mon, 22 Oct 2018 02:34:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 02:34:13
 -0700 (PDT)
In-Reply-To: <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 22 Oct 2018 02:34:13 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
Message-ID: <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Ted Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
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

On Mon, Oct 22, 2018 at 2:26 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, Oct 22, 2018 at 12:27 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>
>> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
>> > From the GCC manual:
>> >
>> >   fallthrough
>> >
>> >     The fallthrough attribute with a null statement serves as a
>> >     fallthrough statement. It hints to the compiler that a statement
>> >     that falls through to another case label, or user-defined label
>> >     in a switch statement is intentional and thus the -Wimplicit-fallthrough
>> >     warning must not trigger. The fallthrough attribute may appear
>> >     at most once in each attribute list, and may not be mixed with
>> >     other attributes. It can only be used in a switch statement
>> >     (the compiler will issue an error otherwise), after a preceding
>> >     statement and before a logically succeeding case label,
>> >     or user-defined label.
>> >
>> >   https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html

Please CC Gustavo on these kinds of things -- he's been driving the
bulk of the fall through coverage.

>> Do we know if coverity understands the fallthrough attribute?  One of
>> the reasons why I started using /* fallthrough */ is because it kept
>> Coverity happy.
>
> If Coverity is like gcc, they should be doing both (i.e. I see the
> comment parsing as an "extra" that gcc did, but the "basic stuff" is
> the attribute -- and I would guess it is way easier for them to
> support than the comment parsing).
>
> But I cannot test it myself :-( Someone, please?
>
> However, if I understood Greg correctly in his reply to the cover
> letter, he replied that Coverity knows about it (?).
>
>>
>> If the conversion from /* fallthrough */ to the __fallthrough__
>> attribute means that we start gethting a lot of Coverity warnings,
>> that would be unfortunate.  OTOH, if this is getting standardized,
>> maybe we can get Coverity to understand this attribute?
>
> Indeed! That would be the best for everyone, including Coverity customers.

We need to make sure the static analyzers are happy with either
method. Additionally, when was -Wimplicit-fallthrough added to GCC? If
it was added _before_ the attribute, we need to continue using the
comment style otherwise we lose coverage even with gcc itself.
Additionally, does Clang support this attribute (it supports
-Wimplicit-fallthrough).

-Kees

-- 
Kees Cook
Pixel Security
