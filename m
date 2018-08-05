Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A9C4646F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF969217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF969217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeHEDlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 23:41:44 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:46614 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbeHEDlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 23:41:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5A1EE182CED2A;
        Sun,  5 Aug 2018 01:39:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bait57_1404ee92d0b58
X-Filterd-Recvd-Size: 4641
Received: from XPS-9350 (unknown [172.58.27.170])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun,  5 Aug 2018 01:38:57 +0000 (UTC)
Message-ID: <3081c875c5c5854188288e80c4e1bf27651e1436.camel@perches.com>
Subject: Re: [PATCH v2 1/2] Support the nonstring variable attribute (gcc >=
 8)
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Martin Sebor <msebor@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 04 Aug 2018 18:38:55 -0700
In-Reply-To: <20180801175433.GA25298@gmail.com>
References: <20180801175433.GA25298@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 19:54 +0200, Miguel Ojeda wrote:
> From the GCC manual:
> 
> The nonstring variable attribute specifies that an object or member
> declaration with type array of char or pointer to char is intended to
> store character arrays that do not necessarily contain a terminating NUL
> character. This is useful in detecting uses of such arrays or pointers
> with functions that expect NUL-terminated strings, and to avoid warnings
> when such an array or pointer is used as an argument to a bounded string
> manipulation function such as strncpy.
> 
>   https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
> 
> Some reports are already coming to the LKML regarding these
> warnings. When they are false positives, like this one
> 
>   https://lkml.org/lkml/2018/1/16/135
> 
> we can use __nonstring to let gcc know a NUL character is not required.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Martin Sebor <msebor@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
> Re-sending this since a few months have passed, Martin has improved
> GCC's feature and warnings are appearing in Geert's build bot.
> Added an example in the second patch as requested by David.
> 
>  include/linux/compiler-gcc.h   | 14 ++++++++++++++
>  include/linux/compiler_types.h |  4 ++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 573f5a7d42d4..fab4e904f1fe 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -343,6 +343,20 @@
>  #define __designated_init __attribute__((designated_init))
>  #endif
>  
> +#if GCC_VERSION >= 80000
> +/*
> + * The nonstring variable attribute specifies that an object or member
> + * declaration with type array of char or pointer to char is intended
> + * to store character arrays that do not necessarily contain a terminating
> + * NUL character. This is useful in detecting uses of such arrays or pointers
> + * with functions that expect NUL-terminated strings, and to avoid warnings
> + * when such an array or pointer is used as an argument to a bounded string
> + * manipulation function such as strncpy.
> + * https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
> + */

Please move this down to the already existing test
for GCC_VERSION >= 80000 near the bottom of the
file so that version number tests are always in
increasing order in the file.

> +#define __nonstring __attribute__((nonstring))
> +#endif
> +
>  #endif	/* gcc version >= 40000 specific checks */
>  
>  #if !defined(__noclone)
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index a8ba6b04152c..9c07be36e86a 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -289,4 +289,8 @@ struct ftrace_likely_data {
>  #define __diag_error(compiler, version, option, comment) \
>  	__diag_ ## compiler(version, error, option)
>  
> +#ifndef __nonstring
> +# define __nonstring
> +#endif
> +
>  #endif /* __LINUX_COMPILER_TYPES_H */
