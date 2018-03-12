Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520874553; cv=none;
        d=google.com; s=arc-20160816;
        b=EsUEwb4Z5B5oDqpOiwFdhflG9FLrUL0lRWd9LKnTkIb1QLBVMY2ddaksr4JRUXyh9X
         HcJ2kspWicPEAyV8QT2XFuY8wR4ERG9Z9NgkPhlu9iJ4Wrqviho303viYDURMQv2LltD
         IQMF9A9ir9ynD358px2mfKul5Y+BW/j2kxj7Q2yZwja7N2yZB3grdQ1mRNDXeUXW/h3Q
         prehj2KMXOGdkcWeXbBCtGHAc86Ftnb7zws1HURmUDVdy9gX8tFDh8TaMKFq8TfnTULM
         TYw1y+v91gkUaswFvzVg6nM4oZPCD3/+pHzN/0EypEws6x0VlxKuxn6YsDD/Drpzbfus
         47Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/ftXgZIAc9DsuIREBJiwUyfQ7yQc1YhLjoDOdI87e24=;
        b=D0SCWb3zpf8W4NKMtNX7v/Z7tQUSLTDKTiLr2Om+ogVROBE8x2CAFd1XwA+PkJyR4M
         wV6/2cSuYs7d0IpWW+g39yMw3YMqIpTi7Q67+/dHqvlCUQjlFzw0Ipr10ns/PVYOj06x
         8nIEntGkT3GnZT0/Iux3/nh34saSHMkDPvwJ+RLbiAV35BLaZsU3CZWcAzqs1TjzQ+c3
         L/h0pFomAXYDZj+04JFsXUXC3KTNCgM6P5GDUuglTxDte2u17SLer+XJyhhsxB2mfXnV
         VdOHNH41hadM8A3N5W/VgfU4fj1bqUNHIoFcg00DE9GPUwcecQ34Rj/A5oPr+szWxpba
         +bOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fMBXQrMk;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Oyeq0Ij5;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fMBXQrMk;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Oyeq0Ij5;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELsXVaRUV7nt0orENxZIeECfu1V7wILLe6iyWbYl2x7Dse5+aFIcE6Hswo0xWigWTcTqFmmN4Q++K/8PEOBMJ2Q=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
References: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 10:09:12 -0700
X-Google-Sender-Auth: Fg_alnkpvI2Pxx0NfFSAzqi9Xqw
Message-ID: <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com>
Subject: Re: Fully initialized stack usage (was Re: [PATCH RFC v9 4/7]
 x86/entry: Erase kernel stack in syscall_trace_enter())
To: Kees Cook <keescook@chromium.org>
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
X-GMAIL-MSGID: =?utf-8?q?1594752555401908784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 9:42 AM, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Feb 27, 2018 at 3:15 AM, P J P <ppandit@redhat.com> wrote:
>> Please see:
>>   -> https://gcc.gnu.org/ml/gcc-patches/2014-06/msg00615.html
>>
>> This experimental patch by Florian Weimer(CC'd) adds an option
>> '-finit-local-vars' to gcc(1) compiler. When a program(or kernel)
>> is built using this option, its automatic(local) variables are
>> initialised with zero(0). This could significantly reduce the kernel
>> information leakage issues.

Oh, I love that patch.

THAT is the kind of thing we should do. It's small, it's trivial, and
it's done early in the parsing stage, so later stages will almost
certainly end up optimizing things away.

The only complaint I have is that the Fortran front-end already has
(some of) that functionality, and calls it something else, and allows
you to specify more exactly what you want to clear.

Florian, are you aware of the Fortran flags?

  -finit-local-zero
  -finit-derived
  -finit-integer=n
  -finit-real=<zero|inf|-inf|nan|snan>
  -finit-logical=<true|false>
  -finit-character=n

they aren't perfect for C, but some of them do make sense at least
conceptually: things like being able to specify whether arrays and
structures should be initialized (-finit-derived is kind of relevant)
might make sense.

In the kernel we'd likely always do it unconditionally (apart from
optional per-function or per-declaration considerations) but I could
easily see some other projects saying "do it for scalars but not for
aggregate types". Because they might want the convenience, but not the
expense.

> Getting this implemented directly in the compiler would be preferred
> over a plugin. (Prototyping may be easier in the plugin, though.)

Absolutely.  I think it's better in gcc simply because I suspect a
number of other projects might use this flag too. A plugin is rather
cumbersome.

That said, the patch is literally right at the PLUGIN_FINISH_DECL, so
doing it as a plugin for older compiler versions, or for just testing,
might still be useful.

> Considerations:
>
> - the kernel needs a way to "opt out" of this for places where later
> functions will do the initialization. Something like
> __attribute__((no_automatic_variable_init)) ?

Yes, that's going to make it more palatable to some uses.

However, somebody who knows gcc needs to verify that it does the right
things when inlining happens.

And honestly, it would be better to make it per-variable, not per
function. That would fit the structure of that patch too, I think. It
iterates over variables anyway to generate the initialization.

> - initialization _must include structure padding_. Without this, we're
> only solving part of the exposure. Does -finit-local-vars do this?

Good point. It uses build_constructor() with an empty constructor, so
it *should* be 100% equivalent to

    struct xyz var = { };

if I understand correctly, but I'm not sure what that will do with padding.

> - Can we retain the uninitialized variable usage warning? (with an
> updated text; maybe "variable used without explicit initialization,
> using zero-initialization"?)

I think that fundamentally goes away, because all later phases see
fully initialized state.

               Linus
