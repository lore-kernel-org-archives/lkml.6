Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522551123; cv=none;
        d=google.com; s=arc-20160816;
        b=AltEal5ltYaLVrwoYJnJvIsa0yxT2AaR7dRbdiMsX7OyrAzNSKP1EViIgSbWWTHNFN
         Se76BH0yquEMUmmsn8ZCYWrioFC80SarWuJ1R30I6tbaJ8vmSybXMpOFAXfi2Hf6fuIZ
         n2gIbLxbr+kf7ggeTZln9Yo+bo8XjOP7jox3i1UDb5Yn1GF3EfqxK+8GPM+65YbTFHIq
         uKRnAFhyfYVWGZi7gULFeYYKcFkDrGX/Q0l/2kCAC7aEsB1BSIVhzm+hIr23e8wnIE/G
         7RX5fVAmCUU/sZCGaG0qytERq0x77ssvQ5uy6egtVz2dzy/5mxZsTGNzHna6/1MIQr9i
         umDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=H+IU5ESiry/6nD79TfmuKsjhxcjR/QmL1BcOzR0zjUA=;
        b=kp8LXLnt7R554mELi9kJqYJldWjGmPoluW/dEi065S1UqrKOcjFZ6RY+0F+VgqRa5v
         Dg5lHrvkv8tzFzP0bg4abtHdIznT0JiuUOz5nCb8fYtPDglpOlnJNJRUQLS6Gn4BvHj9
         I+Fp6MiVL22FNXrSeBnOzBzkzjd3GRAl6PXXKiavqjlfkhC5XYi9ZjYBDtup+/3qzNjU
         aW0QIExeC5nB+Z9BHxmOgoNFh2iQlaKYexHny4zcquAST/FWbsV+3VdqflhCz521mscg
         Wk7kuSYYe0vrxhxbsfqIKBJP6fGrXgYoJsaYMdJV+l2/4ZpqiYGFJ+f1j4MsSCIrOgB7
         h07w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=evdzVQoV;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=evdzVQoV;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+g5sVSIBAkWu5fMQwz9vvnANMGlWB6avC+tzKgNV58x1Glino1P0BJsRNNf2OqoO/ku1ZKcx9wbsySNi9G1Lk=
MIME-Version: 1.0
In-Reply-To: <1522128575-5326-6-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-6-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 1 Apr 2018 04:52:02 +0200
Message-ID: <CAFkk2KSiy+Q_KrQBO8AQxg9PQdoQ5maSMeP64XapJdBfePdQhA@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] kconfig: remove string expansion in file_lookup()
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538242865703?=
X-GMAIL-MSGID: =?utf-8?q?1596510566393540770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 7:29 AM, Masahiro Yamada
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

s/environments/environment variables/

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
