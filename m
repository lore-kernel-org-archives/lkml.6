Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9931DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E4C214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E4C214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeHUTyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:54:32 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:52870 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbeHUTyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:54:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 6E463180A8847;
        Tue, 21 Aug 2018 16:33:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: maid60_1fd6be84bc85a
X-Filterd-Recvd-Size: 2605
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Aug 2018 16:33:38 +0000 (UTC)
Message-ID: <6b1d5081e2da107537f72125fc595229128b46e6.camel@perches.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 21 Aug 2018 09:33:37 -0700
In-Reply-To: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 15:48 +0900, Masahiro Yamada wrote:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> missed the fact that <linux/compiler-gcc.h> is included by Clang
> as well as by GCC.
> 
> Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
> and it looks like GCC 4.2.1.
> 
>   $ scripts/gcc-version.sh -p clang
>   040201
> 
> If you try to build the kernel with Clang, you will get the
> "Sorry, your compiler is too old - please upgrade it."
> followed by a bunch of "unknown attribute" warnings.
> 
> Add !defined(__clang__) to the minimum version check.
> 
> Also, revive the version test blocks for versions >= 4.2.1
> in order to disable features not supported by Clang.

What is the minimum clang version required to compile the kernel?
What features are not supported by the minimum clang version?

On my system, using clang

$ clang -v
clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)

and

$ git checkout v4.16 ; make clean ; make CC=clang defconfig ; make CC=clang
HEAD is now at 0adb32858b0b... Linux 4.16

is successful

but

$ git checkout v4.17 ; make clean ; make CC=clang defconfig ; make CC=clang
HEAD is now at 29dcea88779c... Linux 4.17
arch/x86/Makefile:184: *** Compiler lacks asm-goto support..  Stop.
arch/x86/Makefile:184: *** Compiler lacks asm-goto support..  Stop.

