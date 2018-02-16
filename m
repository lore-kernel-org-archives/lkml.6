Return-Path: <nico@fluxnic.net>
X-Google-Smtp-Source: AH8x227D6HN0HN+SVwpQjef2FKX2XqCvob8vagPjpOhKjIXRvFz4NqaAUb+wVpjVPmRKitWpkdib
ARC-Seal: i=1; a=rsa-sha256; t=1518810573; cv=none;
        d=google.com; s=arc-20160816;
        b=0t3H3soYGeJ4zkt37tBm74LSiQvTGs7X/ZdVDq08WCceD0vmOdI87gPzPgTAvkjbO9
         sM/qF7l/8UGriuqq0kp4N66kcw7jSKZEMqa0ODAMzCHWuT9bSeIWsqE5fUSEZ/SPMvGC
         61rwH+KYuNzCwDcGlAPwtLVuJjLB+33Z3d85Q5tDo1HMyiEf6iWumRCGykiNEuVK7PBb
         MCPAU5eVn9lTx/StmMAGp7rFoP6SsFwlbs6oDNw4R5VVH93MIgDluxcm/0sLadAxdGLh
         CzOpnty1Cylk6s/DKrxmjyxo6ZuV870Fw8pymInzwAfSOecWOC1K91lkpFICZ3ZqfveD
         WR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=4JQSPGiKxYLflk9BrMigDN51Y0jDv17eMkl4bKzIspM=;
        b=VjN4HPYS0jOodB/92ET9JWlWcSHZBHyumty8S5XMgZMzkIqDVomwyTXSo4uCBL9QuC
         5PaOhm10Bd+GcFqWvJCHk75beoMklQuKm18l/rmTi6BmYLtp4P947swm7BfERHc5RUeu
         cW2xDMMqFKhlhFr73G0pPd/n9QhYTcd4J6Saof6tcyEFoRsK8w62zJgjHtn2QDBz+9Q2
         mZgOb4Mw1hwqw8RPQphKrWFWmzDOPqHBjOxpZ8M1viB3wekz7aP3r/5PpCIsAo3zunqz
         7bKf/7mXJRJVN09TzueDX0tBZ5LeOwyiyABynTF3s93PxaIH3wscZHF/JT3jTDlmqKzF
         rfnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@pobox.com header.s=sasl header.b=exO+RsIV;
       dkim=temperror (no key for signature) header.i=@fluxnic.net header.s=2016-12.pbsmtp header.b=xpfO5M+O;
       spf=pass (google.com: domain of nico@fluxnic.net designates 64.147.108.70 as permitted sender) smtp.mailfrom=nico@fluxnic.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@pobox.com header.s=sasl header.b=exO+RsIV;
       dkim=temperror (no key for signature) header.i=@fluxnic.net header.s=2016-12.pbsmtp header.b=xpfO5M+O;
       spf=pass (google.com: domain of nico@fluxnic.net designates 64.147.108.70 as permitted sender) smtp.mailfrom=nico@fluxnic.net
Date: Fri, 16 Feb 2018 14:49:31 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-kbuild@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
    Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>,
    Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/23] kconfig: add 'macro' keyword to support user-defined
 function
In-Reply-To: <1518806331-7101-9-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1802161438470.31719@knanqh.ubzr>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com> <1518806331-7101-9-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 8201AC4E-1352-11E8-B5B2-692D1A68708C-78420484!pb-smtp1.pobox.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925591879125?=
X-GMAIL-MSGID: =?utf-8?q?1592588315700219617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Feb 2018, Masahiro Yamada wrote:

> Now, we got a basic ability to test compiler capability in Kconfig.
> 
> config CC_HAS_STACKPROTECTOR
>         bool
>         default $(shell $CC -Werror -fstack-protector -c -x c /dev/null -o /dev/null)
> 
> This works, but it is ugly to repeat this long boilerplate.
> 
> We want to describe like this:
> 
> config CC_HAS_STACKPROTECTOR
>         bool
>         default $(cc-option -fstack-protector)
> 
> It is straight-forward to implement a new function, but I do not like
> to hard-code specialized functions like this.  Hence, here is another
> feature to add functions from Kconfig files.
> 
> A user-defined function can be defined as a string type symbol with
> a special keyword 'macro'.  It can be referenced in the same way as
> built-in functions.  This feature was also inspired by Makefile where
> user-defined functions are referenced by $(call func-name, args...),
> but I omitted the 'call' to makes it shorter.
> 
> The macro definition can contain $(1), $(2), ... which will be replaced
> with arguments from the caller.
> 
> Example code:
> 
>   config cc-option
>           string
>           macro $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)

I think this syntax for defining a macro shouldn't start with the 
"config" keyword, unless you want it to be part of the config symbol 
space and land it in .config. And typing it as a "string" while it 
actually returns y/n (hence a bool) is also strange.

What about this instead:

macro cc-option
	bool $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)

This makes it easier to extend as well if need be.


Nicolas
