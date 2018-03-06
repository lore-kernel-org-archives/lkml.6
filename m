Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520363812; cv=none;
        d=google.com; s=arc-20160816;
        b=MUob/6LDsyDNOMC9l3UBV+5+BbzT/XKl50YhJhHq+mPjXwhlW3zie+9KhXUsFiJC09
         jC9hUirUZzHAO0TCBU43j6Koxv0YW37+783PLYJucRChi2B/Yp/3kKxlJcHyme78hQUC
         hbUAbIkLoGlYmH1n9fQl8MDt34ZfD+p4j0CH1S5jALlAQ6CDx1zj/zBgICqkaCfprqFL
         0k6moAsGj0M7q22cZ8Yi5FwinRjZNiSsb1AucwsOU6I2glhkcq0VlvBKRxdB+sN5JvTW
         rG3keUF5DNLSfR6flqaefmzzswf/AVvSNfrvhMbxKElBB77rhtNg9xxuep10hnEVQIMg
         EbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7OX/whab0tznd91CH8HmlbegMWms0HPzOcHiqM9EF3w=;
        b=V4lVHg50qxLVm5rYkn+7LwnJi5C69rbcRznnU07gflBhhOOTOmCIAEFimEI/8gXTOn
         qzu/QFl5Pwtfiq9NfoOXvEXWQPOR6bWr2ChsuBxuVfiKw5N5XIqPxYCcoNdVx45WsXg7
         ZiS415Zt+5RrL8YqcQEsD7DDW62MVkt1DgIzy/wbrY7flV7YQtD43vmzr9D8ym3f6F/W
         Odl3L51w8tBiuiXuFo4NytAa7eWBRfClPVEQ+AXk5jRZbwqN3h3f026N5tdb2Z+dExvy
         Sxw4B0nA54+LFdgLpOOXKhICudJMB9nyniUkTFl1pokACuG8mO/7BlWbMy5HHQZLFSZa
         B+XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fJbi+VSS;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=fnvG2Ex+;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fJbi+VSS;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=fnvG2Ex+;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELsmqsB1REuPKvfC8UFkKTGBAorLeqTh46IX7nWxDrhgdLTdALt8b0meSbM2T+RUhMuBDW0P1tgcgnCJlCP5Uv0=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com> <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
 <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com> <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 11:16:51 -0800
X-Google-Sender-Auth: LY33epd1IVZAIEtM8vDiCeD7k4k
Message-ID: <CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Borislav Petkov <bp@alien8.de>, Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
X-GMAIL-MSGID: =?utf-8?q?1594217004445381062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 11:07 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> The compiler usually does a pretty good job of detecting which scalar
> variables are never initialized by regular assignment.

Sure, but "usually" is not really the same as always. Sometimes scalar
types are initialized by passing a reference to them too.

> We could easily extend this to scalar and array types, but we'd first
> need to see what the performance impact is, because I don't think it
> will be negligible.

For scalar types, I suspect it will be entirely unnoticeable, because
they are not only small, but it's rare that this kind of "initialize
by passing a reference" happens in the first place.

For arrays, I agree. We very well may have arrays that we really want
to do magic things about. But even then I'd rather have a "don't
initialize this" flag for critical stuff that really *does* get
initialized some other way. Then we can grep for those things and be
more careful.

If somebody has big arrays on the stack, that's often a problem
anyway. It may be common in non-kernel code, but kernel code is very
special.

                    Linus
