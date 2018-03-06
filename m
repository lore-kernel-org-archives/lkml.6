Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520362619; cv=none;
        d=google.com; s=arc-20160816;
        b=c3ySDI4K5+aIH+cYR/7zTo9ZCY75GHSOiQ8h7yKBmMS5FD5So2T3ZwjUNlLgS2SxQ9
         4cYnq74DsBTelVYraM10usJP+EUEiRPYZwTtOqJiy2vZALcCMLGuX1L666OxwNwLToOi
         4s88Xe0+ujpFTYu9yoVDpKZMbQgTouokMzuIjYegaYkpKCqQ3u3zY8bkuMEz/nT+2JLG
         Iay5vsje4uEsqBNlrpY/8y99RYG3RLZRyy/StIT5e0FgPATW2GFnEe8l44wTnRRQ+Yh9
         jquLSMdzr8eKwr4XOSUhPA5Bb4m0hwF2NKSijz8nQmOikivkrWd5is9JXyPJFZW5eSu1
         7N7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7KiD5QGFy+Kgrpj28STV/gGjfGOhyND9lDbocr7r3KY=;
        b=FgIjMBlwB9ZW3blDppaTpozcZW++vdAPVfIwSSpX4eXaTtt0FaooMDKTbtxpxtOFrP
         1aqBNu8GxiQzaAtGkraR0YnDh96GN3jy6t20S5BwKOonLKzsRk14yebQsyiVimr6jCeV
         75IezkV1ZVdkA7eJ0gn6zYEx+chmqOOn3mYwLEjiFStycsGNYZ5IKRugNW6l4WVC7XvI
         lfYSMB0Hq4NIgeGV2FcvHuEcdrkuJnt5+VRPHeC359Lbsb2QIJgdOgAzbGapZarwqB0C
         REjml8JWmkl0oDJKWUB2F4opcAd/IPtU3yPY0RE1JJlI61G5LsnZW1s1/cDIrHkcA0Dk
         2ZLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hgI6FkxX;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Lti24G7X;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hgI6FkxX;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Lti24G7X;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELv5FQTit8AaMaLusHmWKWQhbd7jBEUuLUxDDV9nvu4hTjZdPUsqfuG75WFQQlzOPKHGtICm6kHhyRG3ZK0l2nA=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com> <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 10:56:58 -0800
X-Google-Sender-Auth: h3cSxJcB6hsOwTPs3OqhiYYMPwE
Message-ID: <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Daniel Micay <danielmicay@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594215754247859554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 7:16 AM, Daniel Micay <danielmicay@gmail.com> wrote:
>
> Zeroing locals isn't very expensive because the compiler has a chance
> to optimize it out when it can figure out it isn't needed and they're
> almost always used.

I thought I saw Kees with some stats, and it wasn't even noticeable.
But maybe I mis-remember.

I definitely like the "zero local variables", and would actually
prefer something even stronger than GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
(although I can't actually read gcc plugins, so I'm just going by
name).

It's not necessarily just struct, it can very much be arrays and
regular automatic variables too.

And yes, we might want to have some override switch for individual
variables ("I really know what I'm doing and I promise I fill it
myself, but the compiler doesn't understand me, look here:").

                Linus
