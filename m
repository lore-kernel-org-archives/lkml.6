Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AH8x224jFVRnXtMnk5wXGiQXLjf1uDdPrggGAv8qFrlyjj7zhAqmaCUT4389/lD554euKm0JFubL
ARC-Seal: i=1; a=rsa-sha256; t=1518110428; cv=none;
        d=google.com; s=arc-20160816;
        b=VI2rEqqzY1K+PC9iSeea0oHXQJyJSXyZd9gwWHhR82bFfLZWuQ7olHiVueSI98C2nm
         DrF5WSeQkYfEiW9jD8CK3rDLNrQciYnSASmVZAik4iAoplVkoOFtfUXsu8LhNxLzsAun
         ke/bXPFPj8bGYDYggFoGasqFC18WCJ59KOMYLLCWqfa7/Uy9vrgKux3nBwcpFcUBL021
         QhuRC+/5oo22AjUur3Px4sERwDMpgWdFM3CNrIZ/KRuNGVR4gXb//2nHyNFYQwIwrchq
         fJDYjr5ZIJH2z9zT8Dvq67bQPy+5pofzab6acb1mHelJdF8SZf8jZZ4OcGokdnN/SUr9
         iFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=LcxM6LwT3A6d1QrmKAKOcZRAHpwwjadFO0BxoltoyeI=;
        b=0u39xsPVzwt5Ge7Ji8CvZHDynwN8//YLhqaYPXFafFJ5wLTMVKtUr0WcafLD5HAJh2
         3mhUKkn9y3Nvji3LUEl3N0/1FbF/RZNPDW7QYAMT9o7sK0KR1bLK8VZ6D0hZrpD+bv7x
         rDao4HpKmxawxwOtKM9lvVWf9YbQsDUf00n2YKDQUwHuD1qAfeCxWl7QoxIaGJt/NDbs
         ndEujziEaZmr2texusRKnpv+OGcnYeO9oSHgpJ/g0lJ9/UijTfjHAxAYAjjAJTK51wpk
         IL54d2fALUon8585t/eyMNwb5azvQfQ0dknu+qRyjmUvhRTiV2VmknKq8AvpPETl+Fec
         EZDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 8 Feb 2018 11:20:26 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Juergen Gross <jgross@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Mathias Krause <minipli@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev <kasan-dev@googlegroups.com>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC] x86: KASAN: Sanitize unauthorized irq stack access
Message-ID: <20180208172026.6kqimndwyekyzzvl@treble>
References: <151802005995.4570.824586713429099710.stgit@localhost.localdomain>
 <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
 <d1b8c22c-79bf-55a1-37a1-2ce508881f3d@virtuozzo.com>
 <20180208163041.zy7dbz4tlbit4i2h@treble>
 <CACT4Y+bZ2JtwTK+a2=wuTm3891Zu1qksreyO63i6whKqFv66Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bZ2JtwTK+a2=wuTm3891Zu1qksreyO63i6whKqFv66Cw@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591759437440105803?=
X-GMAIL-MSGID: =?utf-8?q?1591854160331376384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 05:41:19PM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 8, 2018 at 5:30 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Thu, Feb 08, 2018 at 01:03:49PM +0300, Kirill Tkhai wrote:
> >> On 07.02.2018 21:38, Dave Hansen wrote:
> >> > On 02/07/2018 08:14 AM, Kirill Tkhai wrote:
> >> >> Sometimes it is possible to meet a situation,
> >> >> when irq stack is corrupted, while innocent
> >> >> callback function is being executed. This may
> >> >> happen because of crappy drivers irq handlers,
> >> >> when they access wrong memory on the irq stack.
> >> >
> >> > Can you be more clear about the actual issue?  Which drivers do this?
> >> > How do they even find an IRQ stack pointer?
> >>
> >> I can't say actual driver making this, because I'm still investigating the guilty one.
> >> But I have couple of crash dumps with the crash inside update_sd_lb_stats() function,
> >> where stack variable sg becomes corrupted. This time all scheduler-related not-stack
> >> variables are in ideal state. And update_sd_lb_stats() is the function, which can't
> >> corrupt its own stack. So, I thought this functionality may be useful for something else,
> >> especially because of irq stack is one of the last stacks, which are not sanitized.
> >> Task's stacks are already covered, as I know
> >>
> >> [1595450.678971] Call Trace:
> >> [1595450.683991]  <IRQ>
> >> [1595450.684038]
> >> [1595450.688926]  [<ffffffff81320005>] cpumask_next_and+0x35/0x50
> >> [1595450.693984]  [<ffffffff810d91d3>] find_busiest_group+0x143/0x950
> >> [1595450.699088]  [<ffffffff810d9b7a>] load_balance+0x19a/0xc20
> >> [1595450.704289]  [<ffffffff810cde55>] ? sched_clock_cpu+0x85/0xc0
> >> [1595450.709457]  [<ffffffff810c29aa>] ? update_rq_clock.part.88+0x1a/0x150
> >> [1595450.714711]  [<ffffffff810da770>] rebalance_domains+0x170/0x2b0
> >> [1595450.719997]  [<ffffffff810da9d2>] run_rebalance_domains+0x122/0x1e0
> >> [1595450.725321]  [<ffffffff816bb10f>] __do_softirq+0x10f/0x2aa
> >> [1595450.730746]  [<ffffffff816b62ac>] call_softirq+0x1c/0x30
> >> [1595450.736169]  [<ffffffff8102d325>] do_softirq+0x65/0xa0
> >> [1595450.741754]  [<ffffffff81093ec5>] irq_exit+0x105/0x110
> >> [1595450.747279]  [<ffffffff816baad2>] smp_apic_timer_interrupt+0x42/0x50
> >> [1595450.752905]  [<ffffffff816b7a62>] apic_timer_interrupt+0x232/0x240
> >> [1595450.758519]  <EOI>
> >> [1595450.758569]
> >> [1595450.764100]  [<ffffffff8152f282>] ? cpuidle_enter_state+0x52/0xc0
> >> [1595450.769652]  [<ffffffff8152f3c8>] cpuidle_idle_call+0xd8/0x210
> >> [1595450.775198]  [<ffffffff8103540e>] arch_cpu_idle+0xe/0x30
> >> [1595450.780813]  [<ffffffff810effba>] cpu_startup_entry+0x14a/0x1c0
> >> [1595450.786286]  [<ffffffff810523e6>] start_secondary+0x1d6/0x250
> >
> > I'm not seeing how this patch would help.  If you're running on the irq
> > stack, the *entire* irq stack would be unpoisoned.  So there's still no
> > KASAN protection.  Or am I missing something?
> >
> > Seems like it would be more useful for KASAN to detect redzone accesses
> > on the irq stack (if it's not doing that already).
> 
> KASAN should do this already (unless there is something terribly
> broken). Compiler instrumentation adds redzones around all stack
> variables and injects code to poision/unpoison these redzones on
> function entry/exit.
> KASAN can also detect use-after-scope bugs for stack variables, but
> this requires a more recent gcc (6 or 7, don't remember exactly now)
> and CONFIG_KASAN_EXTRA since recently.
> User-space ASAN can also detect so called use-after-return bugs
> (dangling references to stack variables), but this requires manual
> management of stack frames and quarantine for stack frames. This is
> more tricky to do inside of kernel, so this was never implemented in
> KASAN. KASAN still can detect some of these, if it will happen so that
> the dangling reference happen to point to a redzone in a new frame.

Ok, that's good.  And it seems this patch doesn't change that.

So it looks like the purpose of the patch is to protect the irq stack
from code which is *not* running on the irq stack.  Which seems a bit
far-fetched and theoretical.  Though I don't see any harm in it.

The patch description is confusing.  It talks about "crappy drivers irq
handlers when they access wrong memory on the stack".  But if I
understand correctly, the patch doesn't actually protect against that
case, because irq handlers run on the irq stack, and this patch only
affects code which *isn't* running on the irq stack.

-- 
Josh
