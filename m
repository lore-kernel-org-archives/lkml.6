Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519063310; cv=none;
        d=google.com; s=arc-20160816;
        b=I7yJjfTcM3mV3R1Yk0ILdEYF4RI1+u4OFjGW/JUdzHB9G7OdwYE1PJsue4HBIjqUK0
         ygm6xtApOg5vhVWGvNebpaOmqralQ8mto0+HwYi7cvdvEdbDfRjOv0ippYJxeRbh9uab
         ODVpmrm7oXRrEIZfxr7x2061lEpIJhKBBWyUvC1bSLayINCrfjpv6jaPsBKfVnTgeOIK
         hiEoWTUWZnLxnyDBKECIhOQO89Ojtl/NG6tNIYexG4OnCjs7K3wZ22Y+KARUW2P3XmGl
         obtYpnKOab+ZDVq30zyCxC/98TBwyKCo7osljE5CamN/OuVhWS6N5Eh8eiLunWQ+yINj
         319Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=D431nH4uraH26hudm9RfCf6WzTWGjisC1tteRyGypHM=;
        b=NWY3lu5OQo/GJvuYaSMQsKoNeLkgCdezneUC39WY82jzUZR+axcpMv73pjHirVGIeO
         tNJr1yiTZ+bkYc1p8Qzf87zhZ6q7KsePj6wHeUyj2OrxI48DpU3sQHb+IT6/NBai/bG4
         cSoW9Vqj9ANb2u5axNituSgZFD/MX/nSBbRC4epWMDF3TA098I9B3N4JdOpt2m2ifww7
         5AOrXGo4978pN06dr71c2gm05W5V6tnFVkvoq6k0VA75hPGdxv9fmfuUUYxOLey6RJ7l
         /niHDYqQ3eivAb5CC16WNEqd71SkBGgeDYEfmcMf/sdBdWD5rHamHBifNePaRgoNC2jO
         iGgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=S9Q0hnVt;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=S9Q0hnVt;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225oRXn/Ip0pCejJuA8Lq1ZlysdcTzyli/DJw7Xt6wVkM/5P/9k7kYxDOTAWwNQdHeIcW5a3cF9uyLLs1Jo3t4w=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFwiRzpSRW8xhoMs9cbFFXZGmEyyVa4a7aeZzQGYuO211w@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
 <CA+55aFwQLrrBeXZXK_qUXiGVFNv3qPJS4tNKFacuk0Y0WgZjCA@mail.gmail.com>
 <20180219044845.7cnqpgyiinn6hkyb@huvuddator> <CA+55aFwiRzpSRW8xhoMs9cbFFXZGmEyyVa4a7aeZzQGYuO211w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Feb 2018 10:01:49 -0800
X-Google-Sender-Auth: e-scQpScvHKUmUEpO5iY3zDvhww
Message-ID: <CA+55aFzu8+yaAGvdZMRYJWWZmv_OnFnocnvUiSKcAyNQ1z9kmQ@mail.gmail.com>
Subject: Re: [PATCH 11/23] kconfig: add 'shell-stdout' function
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935341216706?=
X-GMAIL-MSGID: =?utf-8?q?1592853330204976586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 9:44 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do like your "success"/"stdout" more than "shell"/"shell-stdout",
> because with that naming I don't get the feeling that one should
> subsume the other.

Hmm. Thinking about it some more, I really would prefer just "$(shell
...)" everywhere.

But it would be nice if perhaps the error handling would match the
context somehow.

I'm wondering if this might tie into the whole quoting discussion in
the other thread.

Because the rule could be:

(a) unquoted $(shell ) is a bool, and failing is ok (and turns into
y/n depending on whether successful or failing)

So

  config CC_IS_GCC
          bool
          default $(shell $CC --version | grep -q gcc)

works automatically.

(b) but with quoting, $(shell ) is a string, and failing is an error

So

  config GCC_VERSION
          int
          default "$(shell-stdout $srctree/scripts/gcc-version.sh $CC
| sed 's/^0*//')" if CC_IS_GCC
          default 0

would need those quotes, and if the shell-script returns a failure,
we'd _abort_.

Which is actually what we want there.

Hmm? Is that too nasty?

                Linus
