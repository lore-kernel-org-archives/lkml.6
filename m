Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518808673; cv=none;
        d=google.com; s=arc-20160816;
        b=gzluqy2q7H+OcwgZdznVD+mM+c6ijAid2SB+lgXWdgsttb6FGyP6ZMGO20CQjiq/+/
         QiAaiAbX5i9ENU55+W/Mz0xT0ZcTs9VYlsib/7G0h/XP/QwvIHXpEI4GEvS+KRVVxkD6
         BjAYLEHmG6fSGakw0TNJFoKKFKRQ5MwQABsskFPiB5+ECpAq61smORk33DHDqJNsr9c+
         8isThHaEB47ipoc2HJnWQOJFdvnVNkmuyBcD4USQcIlYideM1HXirGgOGB7+11k+RMbq
         l4sI0A761L0hDu0dSd6VWIXZ45Z/17DKEVoyTSgq77NbIAJCXtnnDh2y3nFZJiyHfdfm
         uiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=sodw03NpQu1cnO7enjixBMXFMH+aKOKqCRxdHoRmIEI=;
        b=Jr24G3cjuuos0DXxvgm5h3rpVHe9+bZsb2lazeE6R+PK7AiJh+yKY8G7X4msmj2EOb
         e5nBuNoJHq+pIxmh5KHveVgaC/QDFo01EU+Ma0/wUyfSzZs9YllCdZ2+WWwkjYuabUBZ
         +uDD0lNKu/JmysshgclCUNtjaniLTLIHFifjpXZqlZfljXJ9aKH3pemKB3KycFLmdeh1
         nPnZKKWzj2BpzDhH0WA+2lHhlBMhbqSjR2Bqg1I/Ds5pufCQiUZrWCvrWhMFULnWldmB
         iorphxga+pvjy5d6h07BzUU/dlZS2/ibgr/q9zrqsSPSGGHJehov9odJ9uG5aBwyf0mH
         e9lA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oMxI9B9h;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oMxI9B9h;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224MqifRD8kan11YlZtTMydiYYW7mJrus/51W7LI/UpsjHlKjg91of2OrOyPfo1ppccKC8ur/1sq5Yea7P3411U=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com> <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 11:17:52 -0800
X-Google-Sender-Auth: XR3ZjpXv7JOPiZjvVq8BU4XNpCs
Message-ID: <CA+55aFwQLrrBeXZXK_qUXiGVFNv3qPJS4tNKFacuk0Y0WgZjCA@mail.gmail.com>
Subject: Re: [PATCH 11/23] kconfig: add 'shell-stdout' function
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935341216706?=
X-GMAIL-MSGID: =?utf-8?q?1592586323637721479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 10:38 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This is the second built-in function, which retrieves the first line
> of stdout from the given shell command.

This is the only part I really don't much like in your patch series.

Most of it is just lovely and looks very nice and powerful, but the
difference between "$(shell ..." and "$(shell-stdout ..." to me is
bvery ugly.

Can we *please* make "shell-stdout" go away, and make this just be "shell"?

The rule would be very simple:

 - if the result of the shell command is a failure, the result is 'n'

 - otherwise, the result is the first line of stdout

 - if the result is empty, we replace it with 'y'.

So doing $(shell true) would be 100% equivalent to $(shell echo y),
and you could still do that

          default $(shell $CC --version | grep -q gcc)

because it would just automatically do the right thing.

Basically, the only difference is how $(shell ) works in the success
case: the result won't necessarily be 'y', it will be whatever output.
But if you want to always turn it into 'y' (say, you don't have a "-q"
flag for the grep equivalent above), you can always do so with

          default $(shell $CC --version | noqgrep gcc > /dev/null)

So it seems to me that there is never any fundamental reason why we'd
want both "shell" and "shell-stdout", since "shell-stdout" is
fundamentally more powerful than "shell", and can always be used as
such (and just renamed to "shell").

Because I really think that it's just much prettier and more intuitive
to be able to say

        default "/boot/config-$(shell uname --release)"

without that "-stdout" thing.

Hmm?

But I do want to say how much I liked this series. Just this part
seemed to result in uglier Kconfig scripts.

         Linus
