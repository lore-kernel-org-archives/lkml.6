Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522208083; cv=none;
        d=google.com; s=arc-20160816;
        b=OVVS8uJyO3tO3Kg5I3fmrf09lkVLQMtGWmvS4pNGC1lf13BBaMp/+xKYnT53fhnNFQ
         6R93aNgt1Bj+ZMx7O01MX07GuUvaJBNeJHCsR2ESd7y8Lk6Zk5KmP7BJ5R+CEEP2WuDy
         6mOz7TSXfAItXa/hDPCTmcXdbmBzX+Y6+wotHc5RcsblOXWCJCZKJsRg42qK4cBlWraf
         NKzbWs0/TTknaeH7NOx4KY6VvHnPPGOvpCajUaLfzkzHL/69gzZ1kiB8A48fqQEvRdVe
         ELJLe3rEWYZX/la9Dr3SIhIJuElfXZnMxvoDbJUHeTRoMRe5bHXvDhwtCbN0OIGCfrun
         cVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=M95+9d3xtOMXYLuDNJf/v2QDkEqEaa0WRLGKhWygDIg=;
        b=MlIizYueDpjPaSizc0iaW5SA0W07ZiCdEwtHVNsjItG0Co+ck6vAt3LksAT4SKF2np
         9vdmvNF7EjREYJtw87yagzPETHBUYBpuQ+goOSqabiYYgLtWd/hjISdpSJnZomKmHrjp
         BTZUWexbIZ2gMqPAVtn+eJZrwi8Zv1J3419h/CZgT/3p04WuVpvlb1/HbRVZBF1MZNrg
         J4G71WgMwcJaxLdLquaPs9oKkStuyfxkISySnriTfC7/syCY+HpTYsF85Gwj0qIBw/jI
         Hxt7qqUfeZCZTBLLUYQ7N4vAjX4Hb/69NGACPqYYyAITCXbAn/rd3gWZ3RWourOduNtd
         Nmug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wSDSrm3E;
       dkim=pass header.i=@chromium.org header.s=google header.b=K3+83Dng;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wSDSrm3E;
       dkim=pass header.i=@chromium.org header.s=google header.b=K3+83Dng;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+OTSL9k2ZdfmBBnPFKEI/Kwtfz4rsVVIXc5TG3r47SLzJ4QokeDNf/cFZ4xntStWYDrcRqNuIWPVQXvL2HLyI=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-6-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-6-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:34:41 -0700
X-Google-Sender-Auth: 2FmN7odwxyTjI00S3IHT3XveNus
Message-ID: <CAGXu5jLASUx_SJV-WfKLq5wPXeDpJzBOKneG8q_TjA4jY9w0aA@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] kconfig: remove string expansion in file_lookup()
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538242865703?=
X-GMAIL-MSGID: =?utf-8?q?1596150862901361692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> There are two callers of file_lookup().
>
> [1] zconf_initscan()
>     This is used to open the first Kconfig.  However, it cannot
>     contain environments in the file path because zconf_fopen() is
>     called before file_lookup().  By swapping the call order,
>     KBUILD_KCONFIG would be able to contain environments, but I do
>     not see practical benefits to support it.
>
> [2] zconf_nextfile()
>     This is used to open the next file from 'source' statement like
>         source "arch/$SRCARCH/Kconfig"
>     but this has already been expanded in the lexer phase.
>
> So, file_lookup() does not need to expand the given path.
>
> By the way, file_lookup() was already buggy; it expanded a given path,
> but it used the path before expansion for look-up:
>         if (!strcmp(name, file->name)) {
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
