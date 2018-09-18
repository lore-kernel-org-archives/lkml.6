Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F9ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D20421471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ecf+2FFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D20421471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbeIRIn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:43:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33568 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbeIRIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:43:28 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D40965C05D1;
        Tue, 18 Sep 2018 05:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537240376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5AEf5NijzVrrZAwDkCjLY+P6r3FQzOzDPLq4eZ+WWrQ=;
        b=ecf+2FFUPDuviidsn75hxjf+VKrpHBOVlXNkZ1i4m8DaosOaFj6IO+4G7ABdaDBQrTmVET
        FaLCTcDftDLCd1CBBgBHc7uD/vfRDSVvkGjzP/NTEP00CoCVPcOIKJwj0S4Gs+1XnHcG3I
        QttLvRIwk7EkLYz7CfGYrqy4+xcIM2g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Sep 2018 20:12:56 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 1/2] Compiler Attributes: naked was fixed in gcc 4.6
In-Reply-To: <20180913235941.31211-2-miguel.ojeda.sandonis@gmail.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-2-miguel.ojeda.sandonis@gmail.com>
Message-ID: <37d9042a2a6331cecd561162a615bd62@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2018 16:59, Miguel Ojeda wrote:
> Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
> and noinline on __naked functions") added noinline and noclone
> as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.
> 
> Since now the minimum gcc supported version is 4.6,
> we can clean it up.
> 
> See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
> and https://godbolt.org/z/h6NMIL
> 
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  include/linux/compiler-gcc.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 763bbad1e258..25d3dd6b2702 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -84,14 +84,8 @@
>   * to trace naked functions because then mcount is called without
>   * stack and frame pointer being set up and there is no chance to
>   * restore the lr register to the value before mcount was called.
> - *
> - * The asm() bodies of naked functions often depend on standard calling
> - * conventions, therefore they must be noinline and noclone.
> - *
> - * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
> - * See GCC PR44290.
>   */
> -#define __naked		__attribute__((naked)) noinline __noclone notrace
> +#define __naked		__attribute__((naked)) notrace
>  
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
