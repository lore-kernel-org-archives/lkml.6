Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518031935; cv=none;
        d=google.com; s=arc-20160816;
        b=Dnoc4G6zhC8hE/5836Blgu3icT/3xvI4t6spRgMxQmjbCNmpJhjheyhgOPvg2Yzwqk
         OvOBWxV6ObAZBVYtw3fyq8whxEydstj3aOH3/l9xujIwWj857/GTPYpfA3MPy/0yh6iU
         +xNEivVJY0Wy1Xs0UBsEe5W11jbH1RWy+rWqyP14Je9VjOzV+E+KssooDozLVSbPAunT
         iJHa2ZLcOQVaxLTPebig6WdPqwcoEgB3CYKDGPoXdzYC4fmqQrnJJcHW7BMGVN6GpHKH
         kUUMsoAKjtXdylyQz6i2jtm2MsDJbUNfJD8OCUHms8Wjlud757eOCupIKdVrQVPhMCyT
         XU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1UPDVcM33QqAZbKJDNwvQdAP7wasP2cEl2W5jdX1GZs=;
        b=vCKfeGiVPio6mu+ZJqu19HoAYMJMEG+ixndkpykGNWowmzdWIjufkECpytvy2+JNuy
         k4kN4usEgAqqry/dz7FQwhWptRJBJcOeUlPBcHxn1xsgNm3rqoPihwzjKnhZCzdYSmwZ
         isAwqRCh4PsZxKUVIddhUblne7zUIrMAmhX508HfpHcK5SdgwZtanSmgfSIjnav9ReLc
         8ab8AV8O6Ru280f1HEEvC/i6A1MyOUVSzQG39Mr0jiKFxA8h9peDdjq8uOSeY3q4GrTw
         J3kdwUQJdB4j+WHkyuSK70wMHU8Q37lSqg16rw/PwP7Qkdf+vOoHnzOkWpz4Gtcl752I
         xKqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sjHRiMXi;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sjHRiMXi;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x226A9XcL/n2AD1ZRmCCEnmpq3j/r+xfyNopPoazI+ffg20jlBwH+xQoxvEDeTbjaZVPukwKy3au+176wdxB9P34=
MIME-Version: 1.0
In-Reply-To: <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
References: <151802005995.4570.824586713429099710.stgit@localhost.localdomain> <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 Feb 2018 20:31:53 +0100
Message-ID: <CACT4Y+bbVRpdUJsK9pZshbJW-0D7bvquK2QVpzrpomw5cS1X_g@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: KASAN: Sanitize unauthorized irq stack access
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kees Cook <keescook@chromium.org>, Mathias Krause <minipli@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591759437440105803?=
X-GMAIL-MSGID: =?utf-8?q?1591771854540715683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 7:38 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> On 02/07/2018 08:14 AM, Kirill Tkhai wrote:
>> Sometimes it is possible to meet a situation,
>> when irq stack is corrupted, while innocent
>> callback function is being executed. This may
>> happen because of crappy drivers irq handlers,
>> when they access wrong memory on the irq stack.
>
> Can you be more clear about the actual issue?  Which drivers do this?
> How do they even find an IRQ stack pointer?
>
>> This patch aims to catch such the situations
>> and adds checks of unauthorized stack access.
>
> I think I forgot how KASAN did this.  KASAN has metadata that says which
> areas of memory are good or bad to access, right?  So, this just tags
> IRQ stacks as bad when we are not _in_ an interrupt?

Correct.
kasan_poison/unpoison_shadow effectively memset separate "shadow"
memory range, which is then checked by memory accesses to understand
if it's OK to access corresponding memory.


>> +#define KASAN_IRQ_STACK_SIZE \
>> +     (sizeof(union irq_stack_union) - \
>> +             (offsetof(union irq_stack_union, stack_canary) + 8))
>
> Just curious, but why leave out the canary?  It shouldn't be accessed
> either.
>
>> +#ifdef CONFIG_KASAN
>> +void __visible x86_poison_irq_stack(void)
>> +{
>> +     if (this_cpu_read(irq_count) == -1)
>> +             kasan_poison_irq_stack();
>> +}
>> +void __visible x86_unpoison_irq_stack(void)
>> +{
>> +     if (this_cpu_read(irq_count) == -1)
>> +             kasan_unpoison_irq_stack();
>> +}
>> +#endif
>
> It might be handy to point out here that -1 means "not in an interrupt"
> and >=0 means "in an interrupt".
>
> Otherwise, this looks pretty straightforward.  Would it be something to
> extend to the other stacks like the NMI or double-fault stacks?  Or are
> those just not worth it?
