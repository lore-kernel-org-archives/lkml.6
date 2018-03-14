Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521044949; cv=none;
        d=google.com; s=arc-20160816;
        b=o/+f7p2Pu/1dI03/QT9EvRBInKOrn4PTHnTJ39RDJFdKquF6EG1U7vg5tuXVsms22+
         o02jzflRcyPSdmwedlG8GNwM8iFcTeY8iFk11vnkF1R9c5NdTRTwAZPD8ufl49xZzMBV
         PnPKfmObjvrdearQQc6/ZTatsAuEmEvvHqEfoemjs9dejSwGEK0WtKTJBOSadl4REcG9
         kY3ssvxSspJTiFloYRRJnpD0iy9mRZ8pG5whCvR8bZLTnCpPu7cZkuRLxfJSIZmPGX2/
         l/RGdBdP44lzHsHMa10z5N/oyNJrR8Xm+HpWgln2OhX97Xxwl/VYajUiuFuTeB8i3jYF
         qZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kYyjyZPiQ47opiQed1zK0u2el8jE51RG2K61YQJ3f2g=;
        b=lMDMjHGihxZOfRibUzDzD86GuEmNYjhXESJLSx+3lJhdrjsHW/KwCD3JHa3XLtyJ3W
         ISRnc9F2MWR3nlC3q9zusveZaBoNAXBX6rfvAHuMjKZ1S7hzYIhA2FvWfaWt7bUurVW/
         tSmi4PW72e+/h/R9ReU+8bf6/thR1ZcmOuhazookXmQfxPYessjHBJz/WljEA985/ETI
         73d5I3hSwMTaCJEPnA/wruMhifV177pymGvHqvEaElLbe2mhOSvTRwx+r5QeZJ3PH3Jh
         OC1G2tNeb0xgLO8o9wfwZDLVYOX0kdhRKbRwTkSmxezssqskOtaMA+G0taUX0sx9iA3k
         enmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MdIziRl9;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ZVzZKxbS;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MdIziRl9;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ZVzZKxbS;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELuthSxSSthMc8H2Mm30SU+rrAUXvRNMzEQ14C6z+y2M4sCjBND7UKXLgJL2fGaGZWLexqNPYyk+KCWnr5HoTGo=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <fe00723e-bdd0-3558-a137-da5f4f3d6127@redhat.com>
References: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
 <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com>
 <CAGXu5jJVSG7ZuftTRGZjgKqetpmxNpeqwxAzhY8BJ4_H-oUw5w@mail.gmail.com>
 <CA+55aFyfW901QRpdmgEsaY8b4+AOPf2SKKVo7mNs2iRUTHND3w@mail.gmail.com> <fe00723e-bdd0-3558-a137-da5f4f3d6127@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Mar 2018 09:29:07 -0700
X-Google-Sender-Auth: MT0a5giixQoEv3USrxA1XnojysU
Message-ID: <CA+55aFx45SM4VxD-V4qLo8=hxqYtGH+qBeB74KekwCkJK7D=xA@mail.gmail.com>
Subject: Re: Fully initialized stack usage (was Re: [PATCH RFC v9 4/7]
 x86/entry: Erase kernel stack in syscall_trace_enter())
To: Florian Weimer <fweimer@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	P J P <pjp@fedoraproject.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1594931228439310282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 7:21 AM, Florian Weimer <fweimer@redhat.com> wrote:
>
> What would be the model for the kernel?  Write zero to the padding
> initially, and on copying structs, make sure that you either copy the
> padding from the source, or clear the target?
>
> Clearing the padding while copying might be somewhat expensive.

Oh, no, I wouldn't expect that at all. A structure copy assignment
should act as a memcpy.

I think the semantics should be that any padding is basically "unnamed content".

So copying copies the whole struct, padding and all.

Just as an example:

  struct a {
        char a;
        int b;
  };

  int fn(struct a *);

  int test(struct a *dummy)
  {
        struct a a1 = { 1, 2 };
        struct a a2 = { };
        struct a a3 = *dummy;

        a2.b = 123;

        return fn(&a1) + fn(&a2) + fn(&a3);
  }

and you can see examples of the bug, but also examples of right
behavior. My current gcc (7.3.1-2 from F27) does

        movb    $1, 8(%rsp)
        movl    $2, 12(%rsp)

for that first one - which is problematic because it will pass
uninitialized state to 'fn()'.

The second one results in good code:

        movl    $0, 16(%rsp)
        movl    $123, 20(%rsp)

which is good and doesn't leave the padding uninitialized, and the
third one results in

        movq    (%rdi), %rax
        movq    %rax, 24(%rsp)

which is again fine.

So it mostly works as expected, but things that initialize the
structure one member at a time end up entirely skipping the padding,
resulting in uninitialized parts on the stack being passed around.

That's why I say that I think the semantics we would want is that
padding acts as unnamed entries, ie it should _act_ as if the
structure declaration was

  struct a {
        char a;
        char __padding[3];
        int b;
  };

and that initialization of 'a1' then only iterated over the actual
named entries, so that a1 = { 1, 2 } initializer would act like:

        struct a a1 = { .a = 1, .b = 2 };

which currently makes gcc generate

        movl    $0, 8(%rsp)
        movl    $2, 12(%rsp)
        movb    $1, 8(%rsp)

and initializes things properly. Ok, so gcc is admittedly oddly
_stupid_ about it (a little bit clever, a little bit stupid), but that
would still be quite acceptablke for the kernel.

Note that the "unnamed padding" fields would automatically do the
right thing for structure copies and everything else. It would
literally only affect the case of assigning fields one by one, and
force the padding to be zeroed too.

So as far as implementation would go, I would suggest that one
possible implementation is literally to create those dummy padding
entries in the struct definition, and add a flag for "real" entries,
and make unnamed initializers skip padding ones.

But I haven't looked at how the initializer generation works in gcc,
there may be some clever place that already knows about "oh, we
skipped over padding, so let's just initialize it".

                    Linus
