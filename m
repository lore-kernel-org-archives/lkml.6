Return-Path: <nico@fluxnic.net>
X-Google-Smtp-Source: AH8x224sWQHeSN+iYFBDaLzUugpt1/kRAovG6v8F1m+jn6nbosN4AvQV0FkVHaWuPymgqoz70iGg
ARC-Seal: i=1; a=rsa-sha256; t=1518834642; cv=none;
        d=google.com; s=arc-20160816;
        b=hRuTYyUxP0Ftwz9PuF1ny+vvscHHBBhHunip1nChsgumxa0F7x+CMvs0veE5+02HC5
         PY5fYjYalvtUnt9Epz6wkvwoGsCBXcZYetodZwHkT7Y+oHCOIRikO82CVBEscWoTxFVs
         TkOThdsgc6i1CBhfhuT3epElf0ePiJ2+P0CnVe5K8QK9BijRzgkwmyj1XFpgqVAY1Khd
         YlBv4z8jc6Zefkfl03sBrtkG44vD67KvOZJYOvFtOOTCkoAw18d504elCe+WJpmOAabb
         KglDPuZzpGfyYV8o52n0MpwHOiTqoKLcY4ZV8eomqzY0L8O2RO5JZ7VnlwQshf1aYvoq
         Z9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=3f/XPqpDnuNubalyESIZDSlf8meTFzL09HSNd0pjPjA=;
        b=BNI6KaeRBZwcWAbWHy88J9x7ok2qXaqShxI9Ck4oc+a+GSVK5UwxEpvoDOe87QJz7Y
         iPYvCcjadroBF1w+uEpOefeytQoNU8XmJOn0x6uCs7AFBwi7PNf2/vWNCGv79CyO/0N8
         hMFkEhlzVNAw/10Lnoi3G8QXS7sh/ZCW+HWonyzvc/7ZsbXB/23/Xa7+7nxbnYgnsJhA
         hD204ezJZYi/kdYHWBJcjZmLIAdD/ieBZD9fkcgRJ2teRCAp9sPO576mTnacidtZnqQq
         dwJS68/SfDsDrvCZJ6pi8bbrsydXFlxMJd48SfEoHeUAjdKt/TsN2i2/agsKFpud7FBr
         TTIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@pobox.com header.s=sasl header.b=ka4y8e2O;
       dkim=temperror (no key for signature) header.i=@fluxnic.net header.s=2016-12.pbsmtp header.b=hKe6c8cP;
       spf=pass (google.com: domain of nico@fluxnic.net designates 64.147.108.70 as permitted sender) smtp.mailfrom=nico@fluxnic.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@pobox.com header.s=sasl header.b=ka4y8e2O;
       dkim=temperror (no key for signature) header.i=@fluxnic.net header.s=2016-12.pbsmtp header.b=hKe6c8cP;
       spf=pass (google.com: domain of nico@fluxnic.net designates 64.147.108.70 as permitted sender) smtp.mailfrom=nico@fluxnic.net
Date: Fri, 16 Feb 2018 21:30:38 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Ulf Magnusson <ulfalizer@gmail.com>
cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
    linux-kbuild@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
    Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
    Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/23] kconfig: add 'macro' keyword to support user-defined
 function
In-Reply-To: <20180216235138.b4p6q62auvnzb2sy@huvuddator>
Message-ID: <nycvar.YSQ.7.76.1802162118010.31644@knanqh.ubzr>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com> <1518806331-7101-9-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1802161438470.31719@knanqh.ubzr> <20180216235138.b4p6q62auvnzb2sy@huvuddator>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 8C40FE8E-138A-11E8-AE94-692D1A68708C-78420484!pb-smtp1.pobox.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925591879125?=
X-GMAIL-MSGID: =?utf-8?q?1592613553650582149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Feb 2018, Ulf Magnusson wrote:

> On Fri, Feb 16, 2018 at 02:49:31PM -0500, Nicolas Pitre wrote:
> > On Sat, 17 Feb 2018, Masahiro Yamada wrote:
> > 
> > > Now, we got a basic ability to test compiler capability in Kconfig.
> > > 
> > > config CC_HAS_STACKPROTECTOR
> > >         bool
> > >         default $(shell $CC -Werror -fstack-protector -c -x c /dev/null -o /dev/null)
> > > 
> > > This works, but it is ugly to repeat this long boilerplate.
> > > 
> > > We want to describe like this:
> > > 
> > > config CC_HAS_STACKPROTECTOR
> > >         bool
> > >         default $(cc-option -fstack-protector)
> > > 
> > > It is straight-forward to implement a new function, but I do not like
> > > to hard-code specialized functions like this.  Hence, here is another
> > > feature to add functions from Kconfig files.
> > > 
> > > A user-defined function can be defined as a string type symbol with
> > > a special keyword 'macro'.  It can be referenced in the same way as
> > > built-in functions.  This feature was also inspired by Makefile where
> > > user-defined functions are referenced by $(call func-name, args...),
> > > but I omitted the 'call' to makes it shorter.
> > > 
> > > The macro definition can contain $(1), $(2), ... which will be replaced
> > > with arguments from the caller.
> > > 
> > > Example code:
> > > 
> > >   config cc-option
> > >           string
> > >           macro $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
> > 
> > I think this syntax for defining a macro shouldn't start with the 
> > "config" keyword, unless you want it to be part of the config symbol 
> > space and land it in .config. And typing it as a "string" while it 
> > actually returns y/n (hence a bool) is also strange.
> > 
> > What about this instead:
> > 
> > macro cc-option
> > 	bool $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
> > 
> > This makes it easier to extend as well if need be.
> > 
> > 
> > Nicolas
> 
> I haven't gone over the patchset in detail yet and might be missing
> something here, but if this is just meant to be a textual shorthand,
> then why give it a type at all?

It is meant to be like a user-defined function.

> Do you think a simpler syntax like this would make sense?
> 
> 	macro cc-option "$(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)"
> 
> That's the most general version, where you could use it for other stuff
> besides $(shell ...) as well, just to keep parity.

This is not extendable.  Let's imagine that you might want to implement 
some kind of conditionals some day e.g.:

macro complex_test
	bool $(shell foo) if LOCKDEP_SUPPORT
	bool y if DEBUG_DRIVER
	bool n

There is no real advantage to simplify the macro definition to its 
simplest expression, unlike its actual usage.

> Are there any cases where something more advanced than that might be
> warranted (e.g., macros that expand to complete expressions)?

Maybe not now, but there is no need to close the door on the possibility 
either.


Nicolas
