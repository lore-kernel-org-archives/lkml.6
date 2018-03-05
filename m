Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520280912; cv=none;
        d=google.com; s=arc-20160816;
        b=WhkCYhBVStc/UOGszypDjHAXfWFg3CTGR+OkCPp78hfyxUKZDC8gWH4ZHBCbAvq0I0
         TgaD4e6EBNfVi43HdDPolVRQvvlD0mDZVAslHre8Z5H0uzB+etQrs5mzXDwe29N60EGi
         zXtVj0HNxE86dkUneeJgrSdMQzFvWh894QBWOHiwLFo5A5Muz2xoW2QajTzaOP62UId2
         CgiAFphzviV6F08DWqUkhLP9SKVT3B8yCu+ebwKRJkXVxgX19sKEeBVeqgNDlUhz+Km6
         65ecreTrOzPJ1+EDGQX/l/ltap4R4oSbpylMtmA2xTHBV4tLmJqqnzVfVOYtfvZy6UwK
         Oaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Wc1jPfby70Fqn0+j3ceqF9a49SCFg3tHX2IbKKfRbKI=;
        b=CmbzA5F1sI4zna+zmcK/h8CTTqh0zcbA2NrkIoNe3OOpEetlCQ+uDeDuHwJsthg6Sm
         21i11G3lKCyGSl36gcahEcYOSetiuqlCwDy9StBTHK9RnJYuuoMQuxdUG9nMDLdqzCQW
         oGe35mjEHVFtKKmecrxRMW0f9Nj8TBUg2X8zd/aG/0Y3fWrIVOC8AUA3xyd9kKKI+DcT
         aKddN6Jr+Y0m9OiIewDSam+cuzT/EBBxr06cbx6u1G8NTOTi6khKUMwZPYW3DuIKa+hT
         E+guoUtySePhUBjegUfLKhvrZ4MuW2vjLw6g5c43Z++Ahs6STlGjbl7ZYcFWtB4rBDct
         dtvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e7pRKw4x;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=fX11RXtR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e7pRKw4x;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=fX11RXtR;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELuV5Diaz4qKJ2v4a4UGXQPvfR5ACaeHd0TaXxwajsZvAvE4xe4z7/k1Agv1jpx6TVbO8kLNE2gkC6IobRfK6nY=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 12:15:11 -0800
X-Google-Sender-Auth: 2jvvQ3QMRExl8dtDrBW9kARJOwU
Message-ID: <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1594130078382182751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the first I see of any of this, it was apparently not actually
posted to lkml or anything like that.

Honestly, what I see just makes me go "this is security-masturbation".

It doesn't actually seem to help *find* bugs at all. As such, it's
another "paper over and forget" thing that just adds fairly high
overhead when it's enabled.

I'm NAK'ing it sight-unseen (see above) just because I'm tired of
these kinds of pointless things that don't actually strive to improve
on the kernel, just add more and more overhead for nebulous "things
may happen", and that just make the code uglier.

Why wasn't it even posted to lkml?

And why isn't the focus of security people on tools to _analyse_ and
find problems?

                  Linus
