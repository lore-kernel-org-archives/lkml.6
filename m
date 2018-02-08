Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518110375; cv=none;
        d=google.com; s=arc-20160816;
        b=wEHrm16dr22jS/tUcyeXm5pj4L+GUGASCc9TmMpHcEWApjnnPMyuULgoLjHr2tkMX9
         NhoZHMkh07ZeoUc3SbIgW4v9Cv2ZIDt3qC0zcsgc+5J8gCeNm3chhE2CmleOfKGIxBQ6
         qONHB8AZbPBqkpiEmxD+LrsU4/ZPWpY36Vw+l7W0Ubh33F6RUBz4z+fVbAmXTny9P9lr
         rGk0uxOTBQtM41fv1DdU/gf1lUsxiVdwuw6y+CQqNOkSKjdrQU6RotSZDFRyNTLNEeOK
         7/wcfe+w65MJZSopGCQ+byNCxkql6M1/+DZDfajXW4dDcyT0097Gtnl3glL4YYMTjp+9
         6/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gB0FouZNGwdphzvqNWoaASyuUAuoUVxD/k3hfugHIU4=;
        b=ZA4/HZa6U/YI7vw2m4GmNS4pEkkaH5G8Sswd5JbGUn5YY1OpHsmT6vfhlVOBNBeuLW
         VJPqQy7tfBSx4WHCnwUDJoA3IMoim5Q8F8uckrPtrNOomFHc3zvpTo1XhUEPzTWejRqn
         e47/ZozCoz8icRCxG5MiEP93I9/B7sq5DYLFpY53ZfOxdpkgbpdIe66abmH7iZSUG+r8
         K1haOIJnfnuYLsjGxrtl/+7kTQqxeJzKQD5cyyu59QINAGX/XUrDF/y62j0D1a8rydOl
         hhFdjqt7dBnUf56VjfyiG9LJI2uh80PcX9zktFHaDUbmwTneeDnubDALC9XkmQ5jRcKw
         GzsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IxNv7FyU;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IxNv7FyU;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224spT4OBX8wzvWPDrifChbAa5J5xrSUH3TRPgOrSWpQu0p9z67TNaZQyqdKv5oXwjOU5yP1SsDxoRd3EnRH0WU=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 09:19:34 -0800
X-Google-Sender-Auth: D1tM9EUS42NAVp6U-ZSyfwdWZK4
Message-ID: <CA+55aFxpxAGkCTvugOAXp+izb8O1C5YD+ExMQ27uYVU3-97P1A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Kconfig: add new special property shell= to test
 compiler options in Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>,
	Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368430758875?=
X-GMAIL-MSGID: =?utf-8?q?1591854104626897527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 8:19 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This was prompted by the email from Linus today's morning.

Thanks.

> I implmented this in a rush today, so there are still many TODOs,
> but I put it here to start discussion.
>
> I think it is working, but as you notice, it is tedious to repeat something
> like follows:
>
> config CC_HAS_STACKPROTECTOR
>         bool
>         option shell="$CC -Werror -fstack-protector -c -x c /dev/null"

Yeah.

I do think we want to have the "shell" thing as a generic escape for
other things too, but *realistically*, the primary target for this is
compiler flags, and I think we should target that specifically with a
shorthand.

Doing some statistics, and looking for

    flag = $(call xyz ...)

patterns in our makefiles (ignoring single uses), it really is
cc-option that dominates:

      2  name-fix
      2  try-run
      3  __cc-option
      3  grep-libs
      3  strip-libs
      4  flags
      4  get-executable
      4  ld-option
      4  logo-cfiles
      5  as-option
      5  cc-cross-prefix
      6  cc-ldoption
      6  cc-supports
      7  cc-option-yn
      7  tune
      9  cc-ifversion
     30  as-instr
     48  cc-disable-warning
    239  cc-option

so I think that's the one that we want to special-case.

If we then have a _usable_ - but perhaps not wonderful "shell" escape
to do any random thing (including scripts etc), that will take care of
the rest, but cc-option is so common that I think it's worth making a
special Kconfig syntax for them. For all I know, the others aren't
even worth Kconfig options at all.

> I was thinking of something like follows:
>
> config CC_STACKPROTECTOR
>           bool
>           option shell="$(CC_OPTION -fstack-protector)"

I think we should go even further, and just make it be

config CC_STACKPROTECTOR
          bool
          option cc_option="-fstack-protector"

and actually have the Kconfig language itself have this special-cased.

And obviously that "option cc_option" would be *implemented* as just
"option shell", with just some stupid string substitution. So it
really would be purely a shorthand for readability.

What do you think?

And btw, the patches look nice. What I like in particular is that they
don't even seem to add a lot of lines: the new shell option code is
almost balanced out by the Kconfig script simplifications. And maybe
it's just that I read C a lot better than I read GNU Makefile magic,
but I think it's more understandable too.

                  Linus
