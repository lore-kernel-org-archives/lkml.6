Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520286023; cv=none;
        d=google.com; s=arc-20160816;
        b=AmQF2T58s/P60tn5+AncGQR//ZKmsr1XnzEw/g0SzgrUIKzTyZgYYUCe+E98ev+7q1
         uH1yZ8QT3idsl0MqxcbChuF1OPeAovsoNtgj6dJ91gjxlAn6mv2GmbGoO7umIddgah9B
         NX20diaNXp1JomERMXNdpeDQUCF66ZVcbxAEhHuhTDKHVlvO6ZiG3z8g6PBQSuWJdx20
         c1FH5N7qopVQdrXBhoyFey6Rm0JH9ZiFoCRRimW8Qx/7xniUKLCJYGLB7WdRnwnyGVrQ
         INTTvzCSgxCOPiRH99LARwkkwtfvnpOJ+J9HeZTZxJXnaonx5R8ZNbtUHomoD+THfplt
         75vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=BZZ7skrKzQkU1wLaqnUYR997KZuDAzym6EIv74R5qp8=;
        b=RjHKagPweHq8d0RgEzYEh6KWD+w6JwUdBbpk2ZN7t1wSrhC7ecuZM6/wH8Rbp6lNBR
         W4h5YYjlQZjcNBCgr0XXIS2vLvpw4qpbgQ2aSPISCQp0oNcc84tcEcHaWBI2KGc0LG6K
         uite2uUC2bRhTjolKPhe9CrRdQ5v2MCQPgtt5mxo8w4Y89SMPc64FBJp13maOJKdA+Vm
         0tffyVrMpfnLeMdP/GeziUHk+8iUUcS4vZNQXlXbQ/yJzmA6SnpWpRSUyBxctKmQbxj5
         gCYqOFVD1IYRVy5dhzm9ssHOUcVEXFzVf4VUFoHg47jPtZyB/A4Ni9RkMt3IznJ4pQuU
         Zhvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kM/lmOQh;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=GZjCgYyu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kM/lmOQh;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=GZjCgYyu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELtWt5qokjfOXe9tLukIvDDyt4M5JSdbVw5k7bG51UfeIi76cxO7Cx0b5++d1iXkrGQtUWqgkrejBbOmxQ+1cOg=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com> <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 13:40:21 -0800
X-Google-Sender-Auth: -49My8DnY2wgSzeVO64u2GqWIw0
Message-ID: <CA+55aFxpzgQiJg8XyQTH-hDHd7A0jRAtOJ8b6krrvNDQX96Vrw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1594135436760859407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:02 PM, Kees Cook <keescook@chromium.org> wrote:
> This specific class of flaw ("uninitialized" stack contents being used
> or leaked) is already being looked for by tons of tools like KASan.
> There are teams of people working on it, and they still haven't found
> all the cases where these flaws appear.

Right.

So let's do the *smart* thing, not the *stupid* thing.

This "mindlessly clear stack after use" is stupid.

There are smart things we can do, and it's not just about "find the
problems" like KASAN, but also "avoid undefined behavior".

I absolutely detest undefined compiler behavior. We should fix it. One
of the biggest mistakes C ever did was to have "undefined" in the
standard, and we already obviously limit that kind of broken behavior
with -fwrapv and -fno-strict-alias.

Both of those disable what I consider to be just bugs in the C
standard that should not be allowed for system software - it's a class
of "stupid compiler tricks to generate bad code", which by definition
a compiler shouldn't do. A compiler should generate *good* code, not
random bad code.

And yes:

> We've already seen multiple cases of this just with the by-ref
> initialization plugin, where a stack content leak goes away because we
> asked the compiler to please initialize the memory for us when we
> forgot to do it ourselves. Getting the compiler to help us seems like
> the obviously correct thing to do, since we're using such a
> memory-safety-unfriendly language. :)

This is more of the *smart* kind of behavior - I'm also perfectly
willing to say that automatic variables should just always initialize
to zero, exactly the same way static variables do.

And it doesn't necessarily generate any worse code.

Why? Because it's the _intelligent_ thing to do - unlike some
completely mindless idiotic "clear the stack" patch.

Now, I haven't actually seen the patches, I've only seen signs of
them, but the signs I have seen very much seem to say "this is the
mindless and *stupid* kind of crap that we should not do".

Things like adding hundreds of lines of new asm code, just because.

So by all means, push the zero initializations of automatic variables.
That's just good sense.

But don't push this crap.

              Linus
