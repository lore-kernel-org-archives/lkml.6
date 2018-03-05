Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520287678; cv=none;
        d=google.com; s=arc-20160816;
        b=kGurR5lk0nOFWeYnD95WnAsqS6R1OuKCUV8QyX3LVngvnym1QrsvbeW4K74f4iw/cR
         pxDDsqLZ/JtBkbUo1gOz+AK8PaHq5TuKBALNnJ9P0gYS9d/1y1q384OMX4A4uAshP3J5
         qPtMu483SFWl6DwI70tAsjhH0+E752zF3+BCXnjHWTgRPV6cK6tsg7URoWcs6Zw28eFl
         64OxohtjHmsCQSsOZT2g3qvVkqB0xEfioK1MJNV5EmfmouqWDTkboxKB/sYyFO7YmIZ/
         iSC2zHHOiHbD6e0dsjDawVo/iqoiJXE5W45XGma1I46qsB3y5kVcRPZl+01JLl42Dsb6
         r6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Sw7wBQ0hh2kCl41V9Y2CWsprBU3/fFK1ewF52qLGNKQ=;
        b=AwAO1esATPEmDbBfQzJKzK4VptQboU5rQd4cBFedgfYwXcEfHC8UHXqyuLsXPiCmOv
         s2F0vsHf8rQwA5rffJb/tdv08ov+vZjB+/8YdWRFAR4EJ03fRdjxnYKvtjWzTIh72SUQ
         s7dV6HvuNmyaa6uLAJxHtsHx9R15fkG9lMlUahLaTgwd/zv1tgwP+SBLsI0paErj4/Z9
         zigasyc8y3+CxodllZ8T1xqLxrevZKgA/kAZPvr5+iXXJ3Dou3jhi8dptB1X384FE32w
         kgpurl+eBsuEpTkmCIuagzjmmpzjYR8VBK3c2E1JW70SosT5IAmHAiQaHtPVsmpabHsM
         mAvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LOq1P3iG;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=JrWW3HrN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LOq1P3iG;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=JrWW3HrN;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELsKtlmXxBu+O5w9gsd3lSQiCD0Qz9XoHkWQsYGoFyCMIwjTtJygzUQMpj1nT51SI4VikihbwDcPVsrHCFevBcA=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxpzgQiJg8XyQTH-hDHd7A0jRAtOJ8b6krrvNDQX96Vrw@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com> <CA+55aFxpzgQiJg8XyQTH-hDHd7A0jRAtOJ8b6krrvNDQX96Vrw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 14:07:57 -0800
X-Google-Sender-Auth: t0_WIklvxSEz1XG6AnrMMzw5KTQ
Message-ID: <CA+55aFytLJfSzdQvoYNxdhH6sY+Bbk21iLn7d-73hT4dDR9y2w@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1594137172842721900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:40 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is more of the *smart* kind of behavior - I'm also perfectly
> willing to say that automatic variables should just always initialize
> to zero, exactly the same way static variables do.

.. and perhaps even a build flag or plugin to make sure that the
compiler doesn't remove "dead" writes to those automatic variables
that got allocated on the stack?

Honestly, with clearing of automatic variables, what stack leaks
really exists in practice that this all would help against?

                          Linus
