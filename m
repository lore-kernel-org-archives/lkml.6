Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520876732; cv=none;
        d=google.com; s=arc-20160816;
        b=k6kTSfGJmX1vbFcIPxqcnZEpQzKEL92h6Tc8xkVrBmmcihRylzZ2MrMjvbsvovj+VA
         1tc/iCHqS9v0TgHokLrVO2NJujFyJlFO2BX18QhMCPWkszmdUbmsW09GCcmSWduQkqXN
         SN+hXymOXcAiemIAauS7ebxcMoi3gaHaaAHcPmiukOMhzJLIM0RiM39XjlGN0+B5fV9W
         Kpyz8TYSBJ6qXlK/MttLWgDxDZ/52Ejg1PYSs3+SBB82ooYDrMo3NCFaLeS0arKLOaEz
         NP7SycSKHNUUfk5wI9uWhr82peTwF4lEbcCcFp+9MmmsSYPATzeVW6bn3vLAt4SKYjpy
         MIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=+5kCJd64W55uh9DN17wic9TvDF+zK+YFHJMdWwr69Zw=;
        b=rkrhWJa6hByIeUSEDs3O+hcK1QfpDbf3pL3MhjomiMfjfBE1IRzQHItWvwQBnujgrp
         k/yt00qMg9wvDlCV+oH9tyNbar/9RdWiHS83k0xhMMz2KMRCY+ibjPdA94Qsbc4QS2SZ
         5qWhDL708U0Sweg2YplpxPaaLPtUGYAkB3ZI/tphDBBE72EFL5OlvlC7AvBx8eCEXJSz
         QYL5nLL5ehMh7CebAbdik90lLyvZu6QbIO0uGnwkMJ4w2mnGHetXGcmIGU7mTnvDfHXt
         LTTEPObdgfE/8KZW7+80ZgaM9sqPzKWRgHqLYRtznYuTkFfg2aPHtcIZWXuqcv6vN3bi
         ieKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sHG6TU7/;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=S33l3CAe;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sHG6TU7/;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=S33l3CAe;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELufY2Ij6F53be1luXdBNmKZSHR2ik5HVyA0M1zNUBfDi+CHTf0n6iZNI1QtTrHBNj6jMZsjasW2VduGpmLdgJk=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jJVSG7ZuftTRGZjgKqetpmxNpeqwxAzhY8BJ4_H-oUw5w@mail.gmail.com>
References: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
 <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com> <CAGXu5jJVSG7ZuftTRGZjgKqetpmxNpeqwxAzhY8BJ4_H-oUw5w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 10:45:30 -0700
X-Google-Sender-Auth: 8iLcURV2E0kG_VY9AEPMoW28AZE
Message-ID: <CA+55aFyfW901QRpdmgEsaY8b4+AOPf2SKKVo7mNs2iRUTHND3w@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1594754840034188713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:17 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Mar 12, 2018 at 10:09 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>     struct xyz var = { };
>>
>> I'm not sure what that will do with padding.
>
> AIUI, this does not guarantee padding initialization (yet another
> "undefined behavior"). This is why we've had to sprinkle memset(&var,
> 0, sizeof(var)) in places where a structure has padding and got
> leaked. :(
>
> I assume this may be orthogonal to -finit-local-vars, and maybe we'll
> need some -finit-padding or something. (Though, honestly, is there
> anyone that wants to get _padding_ correct, but not variable
> initialization?)

We would definitely have wanted it over the years, yes. And
conceptually it's a separate issue, so a separate flag makes sense.

But for the kernel, if we have -finit-local-vars, we'd just use that,
so you're right that _we_ don't care, and I don't know if anybody else
does either.

Maybe some security-conscious project would, though. I can definitely
see some project going "we always initialize our stuff ourselves, but
we still worry about padding".

So a separate flag for that would make a lot of sense.

> I'm fine with it going away, though I share Jeff Law's observation in
> Florian's gcc thread that we lose some potentially useful warnings
> ("oops, it took a while to track down this bug, since that variable
> had been zero initialized; I wish I knew that had happened", etc.) And
> when the kernel entirely depends on auto-zero-init, we could just add
> -Wno-maybe-uninitialized. *shrug*

I think it's actually _fundamentally_ hard to give the "might be used
uninitialized" warning together with "-finit-local-vars".

You have to introduce a whole new "zero but counts as uninitialized" model.

So I suspect the gcc people would be better off doing the reverse of
what you suggest: tell people to simply do test builds without
"-finit-local-vars".

For example, for the kernel, we already have that
"CONFIG_COMPILE_TEST" explicitly for the case of "build but don't use"
for build coverage. So it would make sense for us to only use
"-finit-local-vars" when COMPILE_TEST is _not_ set. That would give us
the warnings for our coverage, but all "real" builds would be built
with the initializations.

                    Linus
