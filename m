Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4/rDpCCCb8C0O8rEx96lJFhaAhRbfNeyXf6WH4vhpr5mRylxx40mVGq0KlnXl2eLb8SZ/6j
ARC-Seal: i=1; a=rsa-sha256; t=1522939880; cv=none;
        d=google.com; s=arc-20160816;
        b=MCeAT9f4p0MTHKy0NtbXMi3gLgE56jOqPIm771a6tZ8ckRbL2D6FH1Z8arxnyvAhcf
         DJVNR6c/TbIkQ8l3W5GkHkme3gV2PoWKi4ZrfzKIRQ5lqOysZRCFlqgikTr3gtnpok/z
         wabKZOrzzm33XzwYNJKOmfM80CsqI07twdC7Ss24StVr3ZjHIv/shmQblr+GH4GXLNaA
         6TJUBOJWMHmMNcl6Yr4C9vPtF/BqDVEsRldT7d70k3brhTXifFrnBx5Gix3yzNDdbAvm
         l9rFj2zmZkHHHjvUdUQFdaRQyenaHSlGCFRcC+HM3LgQFCifS49Wh40IRg6/braZfiJe
         dplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=xzUBh90egN47BxglXZkVaTz8KQDK7wu9aIIF9PxxENU=;
        b=0Zg2Y1sSM5cGs+5157yyfabXmZtEOBZKG3mUxTF1m2Hy2Jg5/3pnkkX1yZEx71B4dm
         vEikyX/j+FmkzvPl34wVwgccbefTwRJsqa55dH6r7LtxvcyNtFeCeAwk4jCNulPYD0Oc
         dOZHmSdGQ9SZ1Ln5CHyb1W/Hg7k3JZQn6JlFU99OO9MC7O30T+vnYvEQwhjcZaRRrjzT
         nFhQadjqUA8EdFkalrCtP1ijk/cQ6vBA3Yn1qbTnmQKE75TjjbDIqDI0oe/4Q3dVK/jo
         KWS93mMKf1BIQGajeTALJiuMf1NW95uHJuMOb3G3fK7rFjQCNH12xTU/YSe59hV1vMeq
         2Tug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Pqt5ylIP;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Pqt5ylIP;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w35Ep7ca015179
X-Nifty-SrcIP: [209.85.213.49]
MIME-Version: 1.0
In-Reply-To: <1522383326-3880-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522383326-3880-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 5 Apr 2018 23:50:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7qOTYnK3JEShhVo807mMwm9-DiSB2yZrKa4vr+BBD1g@mail.gmail.com>
Message-ID: <CAK7LNAR7qOTYnK3JEShhVo807mMwm9-DiSB2yZrKa4vr+BBD1g@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: use -fmacro-prefix-map to make __FILE__ a
 relative path
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Rini <trini@konsulko.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596334666549330178?=
X-GMAIL-MSGID: =?utf-8?q?1596918207833333395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-30 13:15 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The __FILE__ macro is used everywhere in the kernel to locate the file
> printing the log message, such as WARN_ON(), etc.  If the kernel is
> built out of tree, this can be a long absolute path, like this:
>
>   WARNING: CPU: 1 PID: 1 at /path/to/build/directory/arch/arm64/kernel/foo.c:...
>
> This is because Kbuild runs in the objtree instead of the srctree,
> then __FILE__ is expanded to a file path prefixed with $(srctree)/.
>
> Commit 9da0763bdd82 ("kbuild: Use relative path when building in a
> subdir of the source tree") improved this to some extent; $(srctree)
> becomes ".." if the objtree is a child of the srctree.
>
> For other cases of out-of-tree build, __FILE__ is still the absolute
> path.  It also means the kernel image depends on where it was built.
>
> A brand-new option from GCC, -fmacro-prefix-map, solves this problem.
> If your compiler supports it, __FILE__ is the relative path from the
> srctree regardless of O= option.  This provides more readable log and
> more reproducible builds.
>
> Please note __FILE__ is always an absolute path for external modules.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> I tested this on GCC 8.
> (not released yet, but you can get the source code from the trunk.)


Applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada
