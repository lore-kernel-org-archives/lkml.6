Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEQGdK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:33:10 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34882 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeEQGdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:33:08 -0400
X-Google-Smtp-Source: AB8JxZpJhGSERwLm8ujHF5t5nVAmkvsOMC+Wir0grkfbGIjNkiYN5NZTOHY4xUOZSalwSbg9JrJcEwRkFiyV/V+RukY=
MIME-Version: 1.0
In-Reply-To: <1526537830-22606-28-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <1526537830-22606-28-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 23:33:06 -0700
X-Google-Sender-Auth: uNKkusG9HrupYmkWEbtzAhbdwbg
Message-ID: <CAGXu5j+OAXpbc4qaKJfAaUNpPh3MsuFq6FWQ6iPky41ExuVUjA@mail.gmail.com>
Subject: Re: [PATCH v4 27/31] kcov: test compiler capability in Kconfig and
 correct dependency
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:17 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
> be used with care - it forces a lower limit of another symbol, ignoring
> the dependency.  Currently, KCOV can select GCC_PLUGINS even if arch
> does not select HAVE_GCC_PLUGINS.  This could cause the unmet direct
> dependency.
>
> Now that Kconfig can test compiler capability, let's handle this in a
> more sophisticated way.
>
> There are two ways to enable KCOV; use the compiler that natively
> supports -fsanitize-coverage=trace-pc, or build the SANCOV plugin if
> the compiler has ability to build GCC plugins.  Hence, the correct
> dependency for KCOV is:
>
>   depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
>
> You do not need to build the SANCOV plugin if the compiler already
> supports -fsanitize-coverage=trace-pc.  Hence, the select should be:
>
>   select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
>
> With this, GCC_PLUGIN_SANCOV is selected only when necessary, so
> scripts/Makefile.gcc-plugins can be cleaner.
>
> I also cleaned up Kconfig and scripts/Makefile.kcov as well.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
