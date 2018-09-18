Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB6CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A362086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Sa7KrNXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A362086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeIRVvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:51:14 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41484 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbeIRVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:51:13 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 048A35C0F2E;
        Tue, 18 Sep 2018 18:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537287473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CLMBsn20r2mD6y9D329ghkLbgbZk9Gfxs8loe3Yu8U=;
        b=Sa7KrNXIJrQaxmGc6br2k9syn1YczltEsB0yX7qbJbHyJVC6sK+R63EQcvffLfHinxE23S
        ZYuy97L7bfldQs2p83VnPbbZChexYGK+17K1+3DPoFu/uSSZAz3ep831SOCzKNu0Tpxc0s
        ybigrm+ouokRevi3yF9q1wvVEniS7P4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Sep 2018 09:17:52 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/2] Compiler Attributes: naked can be shared
In-Reply-To: <CANiq72=JnMMp=jTvqi4iiTrOXxRMHs3kk8h_ukr0ughtntdEaw@mail.gmail.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com>
 <40a059bad54389ff2a9ddc26b9d99a4b@agner.ch>
 <20180918073005.GA4067@kroah.com>
 <CANiq72=JnMMp=jTvqi4iiTrOXxRMHs3kk8h_ukr0ughtntdEaw@mail.gmail.com>
Message-ID: <e6faf216c6b766228adb4d328c8cb6c0@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.2018 09:06, Miguel Ojeda wrote:
> On Tue, Sep 18, 2018 at 9:30 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Mon, Sep 17, 2018 at 08:19:50PM -0700, Stefan Agner wrote:
>>> On 13.09.2018 16:59, Miguel Ojeda wrote:
>>> > The naked attribute is supported by at least gcc >= 4.6 (for ARM,
>>> > which is the only current user), gcc >= 8 (for x86), clang >= 3.1
>>> > and icc >= 13. See https://godbolt.org/z/350Dyc
>>> >
>>> > Therefore, move it out of compiler-gcc.h so that the definition
>>> > is shared by all compilers.
>>> >
>>> > This also fixes Clang support for ARM32 --- 815f0ddb346c
>>> > ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>>> >
>>> > Cc: Stefan Agner <stefan@agner.ch>
>>> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> > Cc: Eli Friedman <efriedma@codeaurora.org>
>>> > Cc: Christopher Li <sparse@chrisli.org>
>>> > Cc: Kees Cook <keescook@chromium.org>
>>> > Cc: Ingo Molnar <mingo@kernel.org>
>>> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> > Cc: Joe Perches <joe@perches.com>
>>> > Cc: Dominique Martinet <asmadeus@codewreck.org>
>>> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> > Cc: linux-sparse@vger.kernel.org
>>> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>>>
>>> Reviewed-by: Stefan Agner <stefan@agner.ch>
>>>
>>> Ideally this two patches should go into v4.19. Not sure which path the patch should take, MAINTAINERS is not quite clear about that. This fixes 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive") for ARM32, which has been merged directly by
>>> Linus, afaict...
>>
>> Good point, can you resend these to me with all of the acks added so
>> far?
> 
> Sure (I think only Stefan is the added ack, though).
> 

Thanks Miguel.

You can also add my Tested-by: Stefan Agner <stefan@agner.ch> to the two patches.

--
Stefan

> Cheers,
> Miguel
