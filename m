Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeFDIMq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:12:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44437 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeFDIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:12:43 -0400
X-Google-Smtp-Source: ADUXVKL39D0DKFjxhHQWVr7T6hMvX7gbdWXVyD0ZiXjDogmT8shSb3qPHQQZl4h4kGVUnsWVea0ALJ6L+bVde9n7T/Q=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 4 Jun 2018 10:12:41 +0200
Message-ID: <CA+icZUVez5tdR61_0y-jcojFNuzFskEhHqfPCsd3PBUJTgmRBg@mail.gmail.com>
Subject: [2/3] x86/build: use -std=gnu89 for proper extern inline semantics
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, tstellar@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC me I'am not subscribed to LKML and linux-kbuild ]
[ Unsure if this the complete CC list of the original posting [0] ]

Hi,

I am discovering clang's compiler flags as HPA writes in [0]...

"-fgnu-inlines would be a better option.

We could also simply #define inline inline __attribute__((gnu_inline))"

[1] says on clang-7 compiler-flags...

Generate output compatible with the standard GNU Objective-C runtime

-fgnu89-inline, -fno-gnu89-inline

...and...

Place each function in its own section (ELF Only)

-fgnu-inline-asm, -fno-gnu-inline-asm

Should that be '-fgnu89-inline'?
You happen to know what '-fgnu-inline-asm' does and it is an option?

This what Linux v4.17 says about inline defines...

[ include/linux/compiler-gcc.h ]
...
/*
 * Force always-inline if the user requests it so via the .config,
 * or if gcc is too old.
 * GCC does not warn about unused static inline functions for
 * -Wunused-function.  This turns out to avoid the need for complex #ifdef
 * directives.  Suppress the warning in clang as well by using "unused"
 * function attribute, which is redundant but not harmful for gcc.
 */
#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||                \
    !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
#define inline inline           __attribute__((always_inline,unused)) notrace
#define __inline__ __inline__   __attribute__((always_inline,unused)) notrace
#define __inline __inline       __attribute__((always_inline,unused)) notrace
#else
/* A lot of inline functions can cause havoc with function tracing */
#define inline inline           __attribute__((unused)) notrace
#define __inline__ __inline__   __attribute__((unused)) notrace
#define __inline __inline       __attribute__((unused)) notrace
#endif
...

[ include/linux/compiler_types.h ]
...
/*
 * Allow us to avoid 'defined but not used' warnings on functions and data,
 * as well as force them to be emitted to the assembly file.
 *
 * As of gcc 3.4, static functions that are not marked with attribute((used))
 * may be elided from the assembly file.  As of gcc 3.4, static data not so
 * marked will not be elided, but this may change in a future gcc version.
 *
 * NOTE: Because distributions shipped with a backported unit-at-a-time
 * compiler in gcc 3.3, we must define __used to be __attribute__((used))
 * for gcc >=3.3 instead of 3.4.
 *
 * In prior versions of gcc, such functions and data would be emitted, but
 * would be warned about except with attribute((unused)).
 *
 * Mark functions that are referenced only in inline assembly as __used so
 * the code is emitted even though it appears to be unreferenced.
 */
#ifndef __used
# define __used                 /* unimplemented */
#endif

#ifndef __maybe_unused
# define __maybe_unused         /* unimplemented */
#endif

#ifndef __always_unused
# define __always_unused        /* unimplemented */
#endif

#ifndef noinline
#define noinline
#endif

/*
 * Rather then using noinline to prevent stack consumption, use
 * noinline_for_stack instead.  For documentation reasons.
 */
#define noinline_for_stack noinline

#ifndef __always_inline
#define __always_inline inline
#endif
...

Regards,
- Sedat -


[0] https://patchwork.kernel.org/patch/10444075/
[1] https://clang.llvm.org/docs/ClangCommandLineReference.html
