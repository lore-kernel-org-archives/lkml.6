Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522207603; cv=none;
        d=google.com; s=arc-20160816;
        b=x9wQZy4irYGGORxVMDrWls7ltGhkrT9380PcJPyxrQ8Aw2v1UOVFXNtsXK5kSkfjRo
         efTYSBkUPN84ImP0EoOWs6isATJ1uQCNrNp1YhAcKjyeI8So8xWCKaBJAazZlvZYG0Nb
         9B5/Ikg+ehO0zmfpkethjZGeMtJJKL4SnKOlKmVo4Hr1vbCI+uepPtlLKX9RLgtyCJlV
         urzZ0mVBff/KH57OqGXlIMZsMT6jff0sGdIA3c+RTDbLUci1UH4AnqSFjIzj4xmhR4RV
         Z7dx3no25GhWB0uJlcwsJgVj8z6TBoT9iXMr/jk+8g9VTp/zQXCtFpaeWab6trzE2IJQ
         OpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=jXgPajrPc9C1MmKqUkor2sGjcL9W/o6CTNgcgeH82FQ=;
        b=D/QcCOUS0KypDlRcqB8mTR8sAHQ8ETXTUkHJi4RQQ3Jj4IHtzPLRxdBWf4GSqDQWsc
         Qd54vEo1qvXpq5Nj4a3D8o/ijl9EvynhQ/wyjLH++tM3yRB6R7xEV+D9QpAxO9dIZQ3X
         zfsAuUMQgig78l5+p2Ltks0DTqg81+aQxY6HHm+3N1wQRKlO2qLkh809mtTC/JnskGn9
         xHHySo9AzIKc0HBCx4UZc78PEX8LK2ayKlaaRB4QHVv7vLpJgBLv7JnpNeI+9jgcBTGl
         XAK4AaFjLUjDGDKqTHDCwNo3MXZoAPgNgUi/t++5Du+JSxAz6qXofm0+gJM0japSH9Qj
         coYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WOuW8n/x;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZsVQ6iAX;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WOuW8n/x;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZsVQ6iAX;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+kz2q49UqN4rXiZLUOniwv4svDx2uIw7LspMUcSgzVyFM5VykdKDNvQaz/ou+1YFaQ0MKY0o65/60gyfz8hDQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-2-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-2-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:26:41 -0700
X-Google-Sender-Auth: ICK88JyrAZyGUkYTAml0ebDlg7Q
Message-ID: <CAGXu5jJBePX5b6zbSa5rM=ouFgSeLvqxEg3kxTViKdnOukmnGA@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] kbuild: remove kbuild cache
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538031163827?=
X-GMAIL-MSGID: =?utf-8?q?1596150359363595749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The kbuild cache was introduced to remember the result of shell
> commands, some of which are expensive to compute, such as
> $(call cc-option,...).
>
> However, this turned out not so clever as I had first expected.
> Actually, it is problematic.  For example, "$(CC) -print-file-name"
> is cached.  If the compiler is updated, the stale search path causes
> build error, which is difficult to figure out.  Another problem
> scenario is cache files could be touched while install targets are
> running under the root permission.  We can patch them if desired,
> but the build infrastructure is getting uglier and uglier.
>
> Now, we are going to move compiler flag tests to the configuration
> phase.  If this is completed, the result of compiler tests will be
> naturally cached in the .config file.  We will not have performance
> issues of incremental building since this testing only happens at
> Kconfig time.
>
> To start this work with a cleaner code base, remove the kbuild
> cache first.
>
> Revert the following commits:
> Commit 9a234a2e3843 ("kbuild: create directory for make cache only when necessary")
> Commit e17c400ae194 ("kbuild: shrink .cache.mk when it exceeds 1000 lines")
> Commit 4e56207130ed ("kbuild: Cache a few more calls to the compiler")
> Commit 3298b690b21c ("kbuild: Add a cache for generated variables")
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
