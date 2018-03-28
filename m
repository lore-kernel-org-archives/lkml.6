Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522236338; cv=none;
        d=google.com; s=arc-20160816;
        b=RM1SZ0ufYvXdCK+QkLOGUaR1qUbLgqaF7GAl6uCwz0pNLfY7abl4VBQXeTCfKPEmjp
         REWs/0suJt0Tcgb/zmpFsQAuMir3sreSjbRr+hTum3ZoMwI8625YqWLBK4KMAuu0TV0h
         h5fsEtNv94E6Qd2bh+acbn8je9SU4rFibKSf9OksA7zmbUUvlXYxfpEJgHGoP9cLDqyY
         vwtjmF7ly5/0CY95ssDS+NO3QJWQ4VZIvUS6LlinyZeKUDdpxpxYxqmmvPTIESGovdTW
         X3r6Fsd1zAfh5+JpzCx6ODEG9356aPBg7o/p/LgKE6htcRxCOf3NpyHD1gNfjuRw/MXg
         5Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=6CgAIPry5K9Az1AdGf3WrsA5F27J7xCc7ru8FozndyM=;
        b=vm7TrJ0XevC4TnAr2qiL85FPhE8dVF7B7Vydyld7uix3X6FN6zEtm4bZ4Fvr+0LIWs
         f8aMctNCtgcAdWdwdZDnVKCnQj01DKT046F2eMFlzSbIoLcF9g6ZQvqtrSn3e0XTWysH
         ABbaLNY8e55Q5+a3dL7F7g0ptmfXA2y8+MmgtQb4Ei/kbQ0jSyq2v6RM6TEnuGJ/fD5+
         kObU3CrvaZzccME0I7ytqI0qIxwUteNdDV5y7qSzepjAb5VPbrWQZclO7lQjVh9fgZ5R
         qMLbY4KSCVP5b1slmm3fEefheowgzSl3Vc0oOs3GpZ/4u3+7+oqtbsfYCdg49HHi03z6
         DWUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Mn5qqHzM;
       dkim=pass header.i=@chromium.org header.s=google header.b=aZSzu1SA;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Mn5qqHzM;
       dkim=pass header.i=@chromium.org header.s=google header.b=aZSzu1SA;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49RQSvZzYMdW64meTjkbe/2ya50DxkyYnEW1biIJuUv/pbxzTIy68ZLKLDRQY3UivCfuacICoJqjry9F7igc6M=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-17-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-17-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:25:37 -0700
X-Google-Sender-Auth: V91EQtoyFm7i6-0MVMhfHxtNw28
Message-ID: <CAGXu5j+YCwPjd9ha2hP26Wjho8q4vVA6kzvOjGUROVJxffGekQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] kcov: imply GCC_PLUGINS and GCC_PLUGIN_SANCOV
 instead of select'ing them
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067544988572436?=
X-GMAIL-MSGID: =?utf-8?q?1596180491453525736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
> used with care - it forces a lower limit of another symbol, ignoring
> the dependency.  In this case, KCOV can select GCC_PLUGINS even if
> 'depends on HAVE_GCC_PLUGINS' is unmet.
>
> 'imply' is modest enough to observe the dependency, and this makes
> sense.  If you enable KCOV, you will probably want to enable
> GCC_PLUGIN_SANCOV, but it should not break the dependency.
>
> I also remove unneeded code, I just happened to notice.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
