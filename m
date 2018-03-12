Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520872944; cv=none;
        d=google.com; s=arc-20160816;
        b=wXVrQ0T6GDixlQbiAvY0eZLT1asEjLLHZjJOcRIeb9O18Cbyp4HJSGwiCkxokgAsq2
         +jleFzN3Ndhe+RP1CzjSz9kLFL1jyPS6I6pQDMWNCcpFFN24RwMXqksU01isnfXYATlx
         H4jwvQ45oWoyVyWj8TLyeho7c1D6enamkG2xNo+6bmcRydHRpY7YYJCzlgkj4u9nrSVy
         WJ9GADJKWTeE0uyGVK4cAhWujsf3HxnPU8HtoUEGUzWCpYP7Boxh82+LG22l/rYmDZ4i
         7OYXziLVOWfRSDGb47p4Ln3yrtgCvNCHKXfdGie0HWXqJbywL+KBM4rhVIfg+OSPz6Zm
         zH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=V5s4KqeUpR+5g8ry9Hlb2BWcvVMyLeDtgya6c/MSMWc=;
        b=GarsUEIGDtqKbPhmj4Ns9Js/4JfgzoVrrWaWBjjbKQkAX4MIXIC+jyFXDu1WTui98J
         uHxzVwoxZ5Gz0OWrhebfNnD51pG6L39n9QOfv4Ev8DESc1lipSOUW6CKO2JAZFdB6gph
         rf538sCfg045zeAVcCx959tQ/xXo4Ik3jbfpl4cEkK4UEH9gvZB2x6I2/s9n2O2CgAvs
         RdtlSrue+Ertptbmo7RDAAte2CMDJML2mwPTQ66tW4bF5QYycbEO3WLLHK9EQNebBpHm
         ENbe42ge+sVIEHcui5NEdmJDdZvf2015G4ASO4l08hjLM6qfk6uCK64i12peXhEbRy0c
         ibZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=smU3VEvH;
       dkim=pass header.i=@chromium.org header.s=google header.b=a/2SqeKV;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=smU3VEvH;
       dkim=pass header.i=@chromium.org header.s=google header.b=a/2SqeKV;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtDkK90FGfU3p53+u4DLFFUncoEgWra/fSpK4iKwxrRqQgsXkKLu2ylMU1313IAcYpCguI2ol+WEZLGfszm+Vg=
MIME-Version: 1.0
Sender: keescook@google.com
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Mar 2018 09:42:23 -0700
X-Google-Sender-Auth: eYkJnTWhrJsS-JZoTMRdk1Y2dJY
Message-ID: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
Subject: Fully initialized stack usage (was Re: [PATCH RFC v9 4/7] x86/entry:
 Erase kernel stack in syscall_trace_enter())
To: Ingo Molnar <mingo@kernel.org>, P J P <pjp@fedoraproject.org>,
	Florian Weimer <fweimer@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Micay <danielmicay@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1594750868471232540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 2:21 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> > Is it possible to implement this "safe automatic variable initialization" language
>> > feature via a GCC plugin robustly, while still keeping code generation sane? (i.e.
>> > no forced allocation of stack slots, etc.) It should be a superset of
>> > CONFIG_GCC_PLUGIN_STRUCTLEAK=y.
>>
>> I think that should be feasible, yes.
>>
>> It would be worth trying whether the current code can be simplified, though: it
>> currently takes care not to add such an initialization if it can already spot
>> one, but I wonder whether just blindly adding one at the start and letting the
>> compiler optimize it away again is safer.
>
> Absolutely - followed by:
>
>  - a good look at the resulting code generation with a reasonably uptodate GCC
>
>  - a look at the resulting code with older GCCs, to make sure there's no
>    pathological code generation
>
> ... because IMHO in the end it is the practical effects that will make (or break)
> any such attempt.
>
> ( BTW., initializing all automatic variables might even speed up certain
>   optimization passes, FWIIW. )

[attempting to merge threads...]

On Tue, Feb 27, 2018 at 3:15 AM, P J P <ppandit@redhat.com> wrote:
> Please see:
>   -> https://gcc.gnu.org/ml/gcc-patches/2014-06/msg00615.html
>
> This experimental patch by Florian Weimer(CC'd) adds an option
> '-finit-local-vars' to gcc(1) compiler. When a program(or kernel)
> is built using this option, its automatic(local) variables are
> initialised with zero(0). This could significantly reduce the kernel
> information leakage issues.
>
> A dnf(8) repository of the latest gcc-7.3.1 package built with the above
> patch and kernel-4.15.5 package built using '-finit-local-vars' option
> on Fedora-27 is available below
>
>   -> https://pjp.fedorapeople.org/init-vars/
>
> This same kernel is running on my F27 test machine as I write this.
> There is no slowness or notice-able performance impact as such.

Getting this implemented directly in the compiler would be preferred
over a plugin. (Prototyping may be easier in the plugin, though.)

Considerations:

- the kernel needs a way to "opt out" of this for places where later
functions will do the initialization. Something like
__attribute__((no_automatic_variable_init)) ?

- initialization _must include structure padding_. Without this, we're
only solving part of the exposure. Does -finit-local-vars do this?

- Can we retain the uninitialized variable usage warning? (with an
updated text; maybe "variable used without explicit initialization,
using zero-initialization"?)

It sounds like Fedora-27's default kernel build is already using this
option, is that correct?

-Kees

-- 
Kees Cook
Pixel Security
