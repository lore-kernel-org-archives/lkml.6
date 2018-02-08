Return-Path: <pintu.ping@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518067028; cv=none;
        d=google.com; s=arc-20160816;
        b=LXELyikDKjRhbqrgSmQYRCguCpdQZUn29l+d5i9I+zOIQ/b3yrupn2Qy6gaP3CT+ii
         i91KVC+5Lmov0mQiUj4bk9zIaP6zPPSLNQJHRob+e0YNVvCRLHYeipYj1f2ybgv8SIwX
         vcvM4wl3WJ1DyUwDdvSaPAPK0xjb7EK8CoobTUj7mleBZ2NVXTpYTeEecFtXjssB9mdo
         4s8Qem9cz988c+shIwuE/07zoyYvUWioi9U81b5KAbplIb5EUq6EdGQNZC3RAqr4kSUi
         XpUNp5R9+2o2g3WPLK6cFcmFABIMaBjj9n53lRjVUIzBewBMnrfY5Xa33ofqWrtQEHKP
         +RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=n/HAySqx4WFPBFK6oZQU5LdIReWD5rXbbGN+elBdM8c=;
        b=q+DvJodRtrlLC/IrnwZRm959+xNdQ282G9LD5a+Q1FC01dtFOaAMPUiSUslWADUa1q
         KtdCJzJgP9Fe9icx6Kb603SDy62l0FOAQ7V13eoOwRU+bMEl5KjrgP8G8bx776sOMJIH
         LKGnkaFf+ReWzAERw9sx7EuCk0BzY7oQyX0b/3PQmoaaQB0XrbziEB1UvlXJ+2UxkrTh
         RiPG6Z3BowNqTQHhnkc4G8fCujHmVZZdZLV9inrW7sT2plyjyaMIti6CpLouvcQ6EoX/
         Smxiavp9N7a/+FccoYAB46oZP82iyn2OBT4U7UbTLJjtcB3tNK3hKr7/wEb2/jvbknFM
         EQzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ryvd+bKC;
       spf=pass (google.com: domain of pintu.ping@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pintu.ping@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ryvd+bKC;
       spf=pass (google.com: domain of pintu.ping@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pintu.ping@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225x3RO/rUW7/2j8+h8G3FllUeU6lzNnRL5CcTzADsKHQGTTBpdXFZUjgyKTLLLCj5wRUJ9/J6iGkWSVcGmBfVE=
MIME-Version: 1.0
In-Reply-To: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
References: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 8 Feb 2018 10:47:07 +0530
Message-ID: <CAOuPNLgJx9voztUYGoUmgPR6B7qKfDXx8TUx5utpSi0gxMOFcQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/android: Fix line continuation in Makefile
To: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Darren Hart <dvhart@infradead.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697740031389880?=
X-GMAIL-MSGID: =?utf-8?q?1591808652669970354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 5:22 AM, Daniel D=C3=ADaz <daniel.diaz@linaro.org> w=
rote:
> The Makefile lacks a couple of line continuation backslashes
> in an `if' clause, which can make the subsequent rsync
> command go awry over the whole filesystem (`rsync -a / /`).
>
>   /bin/sh: -c: line 5: syntax error: unexpected end of file
>   make[1]: [all] Error 1 (ignored)
>   TEST=3D$DIR"_test.sh"; \
>                   if [ -e $DIR/$TEST ]; then
>   /bin/sh: -c: line 2: syntax error: unexpected end of file
>   make[1]: [all] Error 1 (ignored)
>   rsync -a $DIR/$TEST $BUILD_TARGET/;
>   [...a myriad of:]
>   [  rsync: readlink_stat("...") failed: Permission denied (13)]
>   [  skipping non-regular file "..."]
>   [  rsync: opendir "..." failed: Permission denied (13)]
>   [and many other errors...]
>   fi
>   make[1]: fi: Command not found
>   make[1]: [all] Error 127 (ignored)
>   done
>   make[1]: done: Command not found
>   make[1]: [all] Error 127 (ignored)
>
> Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/android/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/sel=
ftests/android/Makefile
> index 1a74922..f6304d2 100644
> --- a/tools/testing/selftests/android/Makefile
> +++ b/tools/testing/selftests/android/Makefile
> @@ -11,11 +11,11 @@ all:
>                 BUILD_TARGET=3D$(OUTPUT)/$$DIR;   \
>                 mkdir $$BUILD_TARGET  -p;       \
>                 make OUTPUT=3D$$BUILD_TARGET -C $$DIR $@;\
> -               #SUBDIR test prog name should be in the form: SUBDIR_test=
.sh
> +               #SUBDIR test prog name should be in the form: SUBDIR_test=
.sh \
>                 TEST=3D$$DIR"_test.sh"; \
> -               if [ -e $$DIR/$$TEST ]; then
> -                       rsync -a $$DIR/$$TEST $$BUILD_TARGET/;
> -               fi
> +               if [ -e $$DIR/$$TEST ]; then \
> +                       rsync -a $$DIR/$$TEST $$BUILD_TARGET/; \
> +               fi \
>         done
>
>  override define RUN_TESTS

Acked-by: Pintu Agarwal <pintu.ping@gmail.com>

> --
> 2.7.4
>
