Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6kOxBv98GVupWQAAmS7hNA
	; Thu, 07 Jun 2018 18:44:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 024906074D; Thu,  7 Jun 2018 18:44:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8039B601C3;
	Thu,  7 Jun 2018 18:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8039B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935161AbeFGSoK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:44:10 -0400
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:55350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933108AbeFGSoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:44:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B7F54100E806B;
        Thu,  7 Jun 2018 18:44:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: badge66_5d81958f3f2f
X-Filterd-Recvd-Size: 4608
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Jun 2018 18:44:00 +0000 (UTC)
Message-ID: <c58f58de39332a27f48dd485eab19a32c289a682.camel@perches.com>
Subject: Re: [PATCH v3 1/3] compiler-gcc.h: add gnu_inline to all inline
 declarations
From: Joe Perches <joe@perches.com>
To: Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        thomas.lendacky@amd.com, tweek@google.com, mjg59@google.com
Date: Thu, 07 Jun 2018 11:43:58 -0700
In-Reply-To: <20180607183219.192973-2-ndesaulniers@google.com>
References: <20180607183219.192973-1-ndesaulniers@google.com>
         <20180607183219.192973-2-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 11:32 -0700, Nick Desaulniers wrote:
> Functions marked extern inline do not emit an externally visible
> function when the gnu89 C standard is used. Some KBUILD Makefiles
> overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
> an explicit C standard specified, the default is gnu11. Since c99, the
> semantics of extern inline have changed such that an externally visible
> function is always emitted. This can lead to multiple definition errors
> of extern inline functions at link time of compilation units whose build
> files have removed an explicit C standard compiler flag for users of GCC
> 5.1+ or Clang.
[]
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
[]
> @@ -72,17 +72,22 @@
>   * -Wunused-function.  This turns out to avoid the need for complex #ifdef
>   * directives.  Suppress the warning in clang as well by using "unused"
>   * function attribute, which is redundant but not harmful for gcc.
> + * Prefer gnu_inline, so that extern inline functions do not emit an
> + * externally visible function. This makes extern inline behave as per gnu89
> + * semantics rather than c99. This prevents multiple symbol definition errors
> + * of extern inline functions at link time.
>   */
>  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
>      !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
> -#define inline inline		__attribute__((always_inline,unused)) notrace
> -#define __inline__ __inline__	__attribute__((always_inline,unused)) notrace
> -#define __inline __inline	__attribute__((always_inline,unused)) notrace
> +#define inline \
> +	inline __attribute__((always_inline, unused, gnu_inline)) notrace
> +#define __inline__ inline
> +#define __inline inline
>  #else
>  /* A lot of inline functions can cause havoc with function tracing */
> -#define inline inline		__attribute__((unused)) notrace
> -#define __inline__ __inline__	__attribute__((unused)) notrace
> -#define __inline __inline	__attribute__((unused)) notrace
> +#define inline inline		__attribute__((unused, gnu_inline)) notrace
> +#define __inline__ inline
> +#define __inline inline
>  #endif

Perhaps move these last 2 defines below the #endif
as they are common to both cases

#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||               \
    !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
#define inline inline __attribute__((always_inline, unused, gnu_inline)) notrace
#else
/* A lot of inline functions can cause havoc with function tracing */
#define inline inline __attribute__((unused, gnu_inline)) notrace
#endif

#define __inline__	inline
#define __inline	inline
#define __always_inline	inline __attribute__((always_inline))
