Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518048360; cv=none;
        d=google.com; s=arc-20160816;
        b=ZgFXSTSLfs1wSDPgdZKbReamLhxbfw/RLkPXnLey2FErvlxd+MrmEkttuQSbPehCUy
         otrQGtrn7AV/CVXfxABakiAeoBAI382lyxbLduWxhBPOMZhH2tJ3dirPshOnQ/lWU/kF
         RFLsj9rq4LzPuhz0Wt//4pq4geNqcWFdcceqOQr+nTCZ87whEI0GJKtZZ6/89qhGClhF
         tM3rQYdVpY9Cbuhr0pXLYFHHHMcTY1LU61HV2CwO9IQ1TlEnbxLzCm72lxpl8QiazwVf
         ycZMsCC/ngNZbvZXsrsUPvOiZxY+Zm1QzNFz6A+pXgdTtUqyF73pEqu1B/l0JoMRa3wj
         NTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=G9DzPM5bMFowcbDBzVkT1tGyCpkq5N5JfHzEFhrdwk0=;
        b=DS8BG0RL04lVxgCFGlEdK6JzLZSDYPBkXDwxi10j6DUJuzwOlvhKfJvWChbQ0EfCR+
         yCfc1FBVZUW8ABi0E5mb4l2TtO4ZFJGSV7/x4FApWC9UvGFOv7xXGHxTHfVhQzmnl/lt
         aN5J0ap+vZPphqbohdYD/YTeBIyREr9yC0S/KsMGOKbd3d+WvH43q0cPNVr670umPXza
         DT/XuobVhwTUuqHBGD0dQuwBRV3QkAU/ON3SvGjFBMFkCig3WB7+SHui6srX+zzvJH3i
         fYlJIzGVmBqtpLf4WfSzokgSTB0+3LV6bV6zGlHiTbZyS+jqcZhrmx9Gqx0ucLQtkz8C
         xvsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FvcHVDjN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FvcHVDjN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225zs1wSzE5PZQ6KDuPNZuOzX321y74nefEK+QlnqJj4FcCKHycYlLo0T/dj9W7dfJYgYSVihVuTlMdYgEo269Q=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAK7LNAQm09z7Lus=p-RGW4Q=95U9QzhV42eG3cnAA9nLiD6-Mw@mail.gmail.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
 <1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
 <20180207100726.GB31392@amd> <1518005275.3677.112.camel@infradead.org>
 <20180207131719.4aeb316e@mschwideX1> <CA+55aFwVyCxWkcXk-y0WWo653XYWeZCRo-u4cy4rPWY++LMcgg@mail.gmail.com>
 <CAK7LNAQm09z7Lus=p-RGW4Q=95U9QzhV42eG3cnAA9nLiD6-Mw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 16:05:59 -0800
X-Google-Sender-Auth: XON2WiN3sh6VRCQ9cwcad8PLARE
Message-ID: <CA+55aFwBxcSJmjNd1UUSXH-oXQS0GPpdAGBkDnW9+Q=_90f7AA@mail.gmail.com>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559737732044?=
X-GMAIL-MSGID: =?utf-8?q?1591789077510667697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 3:44 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I agreed this before, and still motivated.
> (because I also motivated to remove kbuild cache.

I actually wish I still had my old "run shell script" thing. I had
some very preliminary patches that actually worked for simple things,
and you could do something like

      config SOME_NAME
            bool
            option shell "true"

and it would act basically like "option env", except it didn't do
"getenv()", it did "system()" and checked the return value. So the
above would make SOME_NAME have the value 'y', because when you
executed "true" it was successful. I have this dim memory of allowing
it to set strings too (filling in the default value with the stdout
output from the shell execution).

So I had some experimental patch like that, and it kind of worked, but
I never finished it.

But the reason I never completed it was that for the compiler option
case, it really wanted more than a shell command, it needed to get the
whole $(CC) etc from the make environment.

I don't remember the exact syntax I used, but I think it was based on
that "option env" syntax, just replacing "env" with "shell". But
searching my mail archives I can't find anything, so I may never have
sent anything out. And so the patch is long gone.

Maybe I'll get frustrated enough and try to recreate it. I don't think
the patch was that big (but as mentioned, it really wasn't in a form
where it was _useful_ yet).

             Linus
