Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518825108; cv=none;
        d=google.com; s=arc-20160816;
        b=pJ9XoENFctACmoO3nKduSK42qbrWtQK4v/nSKWaJxmYE0v6RmrAdeB53zrVhOVh61Z
         z3SN5PTUcYTAD2ZR18HnfMBHtb23VLJENafxM3+t6n5yBHyCuGYHXWNYaZsxndx4Q3n0
         gAidffa+QD9fcBID2jQ29JT4a1E6ESXTvpDH7/WfMUzMmw+VYRThma7Y9QKAc8oKlyIu
         EWDZVcdnymgLmHnVUIMW62gQs/IVYXaa+V/mWSQ6OPV2Q11eXsFf95KJAdbRLPDp4LK6
         I+8BAYXqlmvQtyUF4LGIyyDo2MiHtiNlk5nPi8w9OcXsDSjzFxZEH6zL+pgBACCuTSxd
         2UVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mYMah6JIv7PpClB4G+rqbgOej+tPCuvOjOa/pPkncRU=;
        b=LB+cSjbo3Ss7zZvh/P22lCPdDlqpeO44unVM7yd6q5J86YKy/jwz54JS3HGV6EtLuq
         11d6AvI6TiI2BB7KDaQrzv82FUho0W6Pf5utcNuWMjoFfm/uKC9OQXR82SCKXQjaU0x7
         ImZ6h674rYXhDiw/Dbgnz0rk2O+h94//DOtrmO7kJNIJUs8Hto9DVU3VLlYRU2Ql9SvR
         +b66WFPxV0eQeg6cJPdf6CHJ6z8thwlID8FEllbnUBqG3S4cXcXHJ6+dmPbrM6wSFT3t
         M4kDIHuNPZ0cyo8mblAOeT55rpN6atbz4i+uNdeieNVesLnxrK0pmBvhAIahTc01VUSa
         D5tA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Oav4AF7B;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Oav4AF7B;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224bzST9+Abo1h1UpP9IPEex/scQRCHaLCnGuf0AMX+/A9QHIBHRV8IqVdVg8xgSwEtxoMh7qw==
Date: Sat, 17 Feb 2018 00:51:38 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	linux-kbuild@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/23] kconfig: add 'macro' keyword to support
 user-defined function
Message-ID: <20180216235138.b4p6q62auvnzb2sy@huvuddator>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-9-git-send-email-yamada.masahiro@socionext.com>
 <nycvar.YSQ.7.76.1802161438470.31719@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1802161438470.31719@knanqh.ubzr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925591879125?=
X-GMAIL-MSGID: =?utf-8?q?1592603557055885844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 02:49:31PM -0500, Nicolas Pitre wrote:
> On Sat, 17 Feb 2018, Masahiro Yamada wrote:
> 
> > Now, we got a basic ability to test compiler capability in Kconfig.
> > 
> > config CC_HAS_STACKPROTECTOR
> >         bool
> >         default $(shell $CC -Werror -fstack-protector -c -x c /dev/null -o /dev/null)
> > 
> > This works, but it is ugly to repeat this long boilerplate.
> > 
> > We want to describe like this:
> > 
> > config CC_HAS_STACKPROTECTOR
> >         bool
> >         default $(cc-option -fstack-protector)
> > 
> > It is straight-forward to implement a new function, but I do not like
> > to hard-code specialized functions like this.  Hence, here is another
> > feature to add functions from Kconfig files.
> > 
> > A user-defined function can be defined as a string type symbol with
> > a special keyword 'macro'.  It can be referenced in the same way as
> > built-in functions.  This feature was also inspired by Makefile where
> > user-defined functions are referenced by $(call func-name, args...),
> > but I omitted the 'call' to makes it shorter.
> > 
> > The macro definition can contain $(1), $(2), ... which will be replaced
> > with arguments from the caller.
> > 
> > Example code:
> > 
> >   config cc-option
> >           string
> >           macro $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
> 
> I think this syntax for defining a macro shouldn't start with the 
> "config" keyword, unless you want it to be part of the config symbol 
> space and land it in .config. And typing it as a "string" while it 
> actually returns y/n (hence a bool) is also strange.
> 
> What about this instead:
> 
> macro cc-option
> 	bool $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
> 
> This makes it easier to extend as well if need be.
> 
> 
> Nicolas

I haven't gone over the patchset in detail yet and might be missing
something here, but if this is just meant to be a textual shorthand,
then why give it a type at all?

Do you think a simpler syntax like this would make sense?

	macro cc-option "$(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)"

That's the most general version, where you could use it for other stuff
besides $(shell ...) as well, just to keep parity.

You could then always just expand $() as a string, and maybe spit out
"n" and "y" in the cases Linus suggested for $(shell ...). The existing
logic for constant symbols should then take care of converting that into
a tristate value where appropriate.

If you go with that and want to support $() outside quotes, then

	$(foo)

would just be a shorthand for

	"$(foo)"

Are there any cases where something more advanced than that might be
warranted (e.g., macros that expand to complete expressions)? It seems
pretty nice and nonmagical otherwise.

Cheers,
Ulf
