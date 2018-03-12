Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520875063; cv=none;
        d=google.com; s=arc-20160816;
        b=cQjpEhXUGF1BXEbYdgCB1rybC4hE6pVtFnfKvlRlUNuOeuzVWsm+OjA3leAwNYH2i1
         Tx9E/JP7YN2HAHhQjCz9jj8Vueu9iEV0/SFex5bJl5tym/i/Yk4t8ZSZKw5gfiiLoXDW
         yeg8wLCeAA2LoEBCwfN/Q1wJ2pOw81ux31rZ9F06ktTsDUNGDjoLokSn6PUfzpWkBoeZ
         pXGuzUgZf+eqvpEI4L3fwcTBbUaZF88ij0hDv5+3MLbduZm5YTCneqojYe0lH4e6Epzm
         89fwFBkBhnSZRkRuh61GKqXnQJnIO0LnJQKTsdABmr9L14jsusE2BUubKaM2NFQj5oE2
         A0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Go2rHmF7V1bwWo4h2/Y/TvwUySmL/5kzrxpZqEw1Oy4=;
        b=S3O4vQsVryYf17A/KiL0Jxd4eEj+evAmLfrZNA8CIb4gm28wVyqJH7k0zONnQnA4zx
         xThq5AOgHLHx7RQUV4iCJutnEe+1+JIG6vtRvN2qm1fnMQpCYnOZK5eMq8AN5EVwqJFp
         cCT7k5vD8lWJ8TE4/wjWu49lGHT9r+J8a5E1ZeQdDYm8AXlc4kYe8SYLzxgB9zrsCwUv
         89/kw0fVAxIeZNuwJJKvY0yk6Lg/Rzqm+HCMR1uClVKhavZ6Z2+fmoY7Lmf3u5EcDSZh
         Pkyj4az9GVuuelooK8xIclRm0TVLBpEd/TEorer4H9RMZGCJq1NL+qJGNvyLSyPmp4zv
         T9yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=MVrMzxWQ;
       dkim=pass header.i=@chromium.org header.s=google header.b=VqIh6iiu;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=MVrMzxWQ;
       dkim=pass header.i=@chromium.org header.s=google header.b=VqIh6iiu;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsM0SmnyZapeYIH6N7kx4RxuM1YM9WOl8NlSfMI8yE4pdXaNcOWaN3lG3/2ORyFH60WlRmfxh6+ODOupFeo+/o=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com>
References: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
 <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Mar 2018 10:17:41 -0700
X-Google-Sender-Auth: cBlyptLmhQIRqN5d6siE4jaLZfg
Message-ID: <CAGXu5jJVSG7ZuftTRGZjgKqetpmxNpeqwxAzhY8BJ4_H-oUw5w@mail.gmail.com>
Subject: Re: Fully initialized stack usage (was Re: [PATCH RFC v9 4/7]
 x86/entry: Erase kernel stack in syscall_trace_enter())
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, P J P <pjp@fedoraproject.org>,
	Florian Weimer <fweimer@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	Daniel Micay <danielmicay@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>,
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
	Josh Poimboeuf <jpoimboe@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594750868471232540?=
X-GMAIL-MSGID: =?utf-8?q?1594753090540137610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:09 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 12, 2018 at 9:42 AM, Kees Cook <keescook@chromium.org> wrote:
>> - initialization _must include structure padding_. Without this, we're
>> only solving part of the exposure. Does -finit-local-vars do this?
>
> Good point. It uses build_constructor() with an empty constructor, so
> it *should* be 100% equivalent to
>
>     struct xyz var = { };
>
> if I understand correctly, but I'm not sure what that will do with padding.

AIUI, this does not guarantee padding initialization (yet another
"undefined behavior"). This is why we've had to sprinkle memset(&var,
0, sizeof(var)) in places where a structure has padding and got
leaked. :(

I assume this may be orthogonal to -finit-local-vars, and maybe we'll
need some -finit-padding or something. (Though, honestly, is there
anyone that wants to get _padding_ correct, but not variable
initialization?)

>> - Can we retain the uninitialized variable usage warning? (with an
>> updated text; maybe "variable used without explicit initialization,
>> using zero-initialization"?)
>
> I think that fundamentally goes away, because all later phases see
> fully initialized state.

I'm fine with it going away, though I share Jeff Law's observation in
Florian's gcc thread that we lose some potentially useful warnings
("oops, it took a while to track down this bug, since that variable
had been zero initialized; I wish I knew that had happened", etc.) And
when the kernel entirely depends on auto-zero-init, we could just add
-Wno-maybe-uninitialized. *shrug*

-Kees

-- 
Kees Cook
Pixel Security
