Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57C5ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB29F20858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB29F20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeIRNHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:07:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeIRNHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:07:33 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31F13CB5;
        Tue, 18 Sep 2018 07:36:11 +0000 (UTC)
Date:   Tue, 18 Sep 2018 09:30:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, arnd@arndb.de,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20180918073005.GA4067@kroah.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com>
 <40a059bad54389ff2a9ddc26b9d99a4b@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a059bad54389ff2a9ddc26b9d99a4b@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:19:50PM -0700, Stefan Agner wrote:
> On 13.09.2018 16:59, Miguel Ojeda wrote:
> > The naked attribute is supported by at least gcc >= 4.6 (for ARM,
> > which is the only current user), gcc >= 8 (for x86), clang >= 3.1
> > and icc >= 13. See https://godbolt.org/z/350Dyc
> > 
> > Therefore, move it out of compiler-gcc.h so that the definition
> > is shared by all compilers.
> > 
> > This also fixes Clang support for ARM32 --- 815f0ddb346c
> > ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
> > 
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Eli Friedman <efriedma@codeaurora.org>
> > Cc: Christopher Li <sparse@chrisli.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Dominique Martinet <asmadeus@codewreck.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: linux-sparse@vger.kernel.org
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> 
> Ideally this two patches should go into v4.19. Not sure which path the patch should take, MAINTAINERS is not quite clear about that. This fixes 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive") for ARM32, which has been merged directly by
> Linus, afaict...

Good point, can you resend these to me with all of the acks added so
far?

thanks,

greg k-h
