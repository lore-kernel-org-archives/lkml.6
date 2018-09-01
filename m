Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BFFC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3458320841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 10:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3458320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeIAO0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:26:19 -0400
Received: from nautica.notk.org ([91.121.71.147]:53657 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeIAO0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:26:19 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 1640AC009; Sat,  1 Sep 2018 12:14:45 +0200 (CEST)
Date:   Sat, 1 Sep 2018 12:14:30 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
Message-ID: <20180901101430.GA21877@nautica>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote on Fri, Aug 31, 2018:
> Instead of using version checks per-compiler to define (or not)
> each attribute, use __has_attribute to test for them, following
> the cleanup started with commit 815f0ddb346c
> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
> 
> All the attributes that are fairly common/standard (i.e. those that
> do not require extra logic to define them) have been moved
> to a new file include/linux/compiler_attributes.h.
> 
> In an effort to make the file as regular as possible, comments
> stating the purpose of attributes have been removed. Instead,
> links to the compiler docs have been added (i.e. to gcc and,
> if available, to clang as well). In addition, they have been sorted.
> 
> Finally, if an attribute is optional (i.e. if it is guarded
> by __has_attribute), the reason has been stated for future reference.
> 
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
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Nice work!
Since I'm being Cc'd I took the time to test this as well, and have no
problem with libbcc-building-with-clang (or native x86 gcc build)

Nick already made many comments so I only have one more.

> [...]
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> new file mode 100644
> index 000000000000..a9dfafc8fd19
> --- /dev/null
> +++ b/include/linux/compiler_attributes.h
> [...]
> +/*
> + * To check for optional attributes, we use __has_attribute, which is supported
> + * on gcc >= 5, clang >= 2.9 and icc >= 17. In the meantime, to support
> + * 4.6 <= gcc < 5, we implement __has_attribute by hand.
> + */
> +#ifndef __has_attribute
> +#define __has_attribute(x) __GCC4_has_attribute_##x
> +#define __GCC4_has_attribute_externally_visible 1
> +#define __GCC4_has_attribute_noclone 1
> +#define __GCC4_has_attribute_optimize 1
> +#if __GNUC_MINOR__ >= 8
> +#define __GCC4_has_attribute_no_sanitize_address 1
> +#endif
> +#if __GNUC_MINOR__ >= 9
> +#define __GCC4_has_attribute_assume_aligned 1
> +#endif
> +#endif

Hmm, if this is in this file and not compiler-gcc, I am not sure about
using GNUC_MINOR without checking the major -- I have no idea what kind
of versions e.g. icc will use (or what attributes ancients version of
clang or old icc support, actually)


It's a bit of research work but I think it'd be cleaner to define
similar macros for all three compilers, if we care about the old
versions... Or actually..

For clang you've implicitely required clang >= 3.0 in patch 3 of this
serie, so presumabely it wouldn't need this compat macro at all.

For icc I think icc 17 is still fairly recent... But I just abused work
to test and linux fails to compile with icc 15/17/18 for other reasons
(unrelated to this patch), so unless anyone helps with this I'm tempted
to suggest leaving it at it, and whoever that is will probably have a
better idea of how far back they want to make icc work / what attributes
are defined there.
It's a bit of a shame there's no linux-compilers list to reach out to :)

(this would need to move the include of this file after the
compiler-specific headers, but from what I can see there is no problem
with that)

-- 
Dominique
