Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518026148; cv=none;
        d=google.com; s=arc-20160816;
        b=Ayq3LI+UN/z95fR2AjTcs0TaFq+IgNgCUwNL5QcJazMigR754bOFqnGbQjIcs0t83W
         Fqqqbe9hZt9KMxFEP8FB5ghJDsut769zhww2EcFmIl5PUJxiW2lczvdCIvcsBvB682gY
         BZ+iUvcjp+8MbKnhTFK/D+H1zSUOGnUey5T3980lVkN7Pan8+iVDaopRtR4c/Xe0km1z
         43N2yid3ezka+NlJcCA/Wfcr5NEOXJVj/aHbKmwRNfw7/u1fX4OH1rk1eiPQkxYZDkGL
         gU1nkZKNF2Ux+M6vo0wT7sypKiXA4dmnr8Zd/nufLSZpTt1htbwUyuNtltI79qszOJYf
         4ezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eAmQPKhS94027lyhfvDt2LRCq/7BR7nQbHUNSijzlw8=;
        b=l0JGtQCkDFZpwMtmfgIeoQ4s6EGKS+gg2oLy8b/3m/MNklsPPTfTgzjGgciSgkXgTt
         jzsWOWwgGevvrH2q3LrOi4AhZyH0rc+o90h8ig6dxKHAkpQWxiFK3kzm3S2lyQ2mE2u8
         hTf87V1rnImwiDrkoKsTiiAVJ55YSGhnf6krn8YKe0JUhOoHQS3UWviIZwBrPfMml3rH
         NeS05mk9Z8rQSorIgzlzKq/RqHlYRLxs9JMqQSipeaiOc2xVWwlVptReKKNTeovuK6VY
         M6//KwO41Dj2tzLbyPCH3sA1GC+N63ypiSCq6kqaWQ7CzXYWuIr2/eWeybtE9UHqi3dw
         cf/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GMu94hRu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GMu94hRu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x2264YXVLWvOeqb9Ym1hb2ORteJTMqkzT+UpRVBVlYbb0KDjSe1D9RppPgfI1zbdXg9Rmtqhy+XpP/As6/3JVEeY=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180207131719.4aeb316e@mschwideX1>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
 <1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
 <20180207100726.GB31392@amd> <1518005275.3677.112.camel@infradead.org> <20180207131719.4aeb316e@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 09:55:47 -0800
X-Google-Sender-Auth: RTtF7ZTBb-XWPP2pE1lElQo9geU
Message-ID: <CA+55aFwVyCxWkcXk-y0WWo653XYWeZCRo-u4cy4rPWY++LMcgg@mail.gmail.com>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>,
	Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559737732044?=
X-GMAIL-MSGID: =?utf-8?q?1591765786161864103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 4:17 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>> That isn't, though. Linus asked us to drop the $(warning) part.
>>
>> ... and then spent a week building with a non-retpoline compiler and
>> not noticing, so he might have changed his mind ;)
>
> I found the warning to have some value, it helps for the case where my
> fingers are faster than my brain and I type "make" instead of "smake"
> which uses the alternative compiler with the required support.
>
> @Linus: do you want a warning or prefer not to have one ?

Honestly, I think I'd be much happier with the warning as part of the
"make config" phase.

What really annoyed me was that it showed up at every build.

What I would really want - and this is entirely unrelated to this
particular case - is to have those damn compiler option tests as part
of the config phase in general. We now have about a million of these
crazy things, where we have config options that simply depend on which
compiler we have, and we have no sane way to show them at
configuration time.

Though Andrew's tree I got yet another ugly hack
(CONFIG_CC_STACKPROTECTOR_AUTO) that handles just _one_ special case
by turning it into a special magic Kconfig entry in the main Makefile.
See commit 44c6dc940b19 ("Makefile: introduce
CONFIG_CC_STACKPROTECTOR_AUTO"). I wasn't sure if I really wanted it,
and honestly, I'm still thinking of just reverting it, because it's
_so_ ugly and _so_ wrong.

What we need is an extension to the Kconfig language itself so that we can do

   config CC_HAS_RETPOLINE
        cc_option "-mindirect-branch=thunk -mindirect-branch-table"

or something. And then we can make sane _conditional_ dependencies at
Kconfig time, and our makefiles would be much cleaner too when you
could just do

     cflags-$(USE_RETPOLINE) += -mfunction-return=thunk -mindirect-branch-table

because the validity of the C compiler flag has been tested when configuring.

And then we could add that warning at configure time (or just disable
the option there thanks to "depends on CC_HAS_xyz" logic).

All our compiler option handling right now is just nasty nasty nasty crud.

Adding more people in the hopes that somebody gets motivated.. I've
talked about this before, so far we haven't made any progress.

              Linus
