Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZqf1bwUwVDwGYI8sfnh2kGSxw/qkUCH/QcVD4mwJ6Ek34kUGAxfC2UaZoMGAL17qhfFNC8Q
ARC-Seal: i=1; a=rsa-sha256; t=1526218553; cv=none;
        d=google.com; s=arc-20160816;
        b=nEjPhcg+7kOtjnvqwcQ/KPARukYQxRYpMEirNW3j4wdO66vc2hAas/cSeuX+H7EtcG
         VmEC7XQnWz2BTl4Xnw42a4jA75rgscNK+QJfbt0jJEFmIFGVsjfEPPXzTJ4e8ca0hIzc
         cNYHts1HHy9LsC7sXh87g2KSGxOY1SUEKCu8AkNgJ3QitW4A1beb6Wp4pXcBvh1SBfDL
         4opq+zQAfoX4TL2H0AM1IaSTkeznI6wRVvJtdcAYx7fyhoUJceUHxBlvH6yHx4B5AYdp
         sMHVJ5bFddrQQzCm0vHS6gDCTFWmZyG7a/en0gopDA1DjK4qPFs3Rrrho/NZuPx9jnrn
         STzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=Z+AWO1aejnbS4pIJO1qjiC8kmwaR3Fs3fIt3ZYXQ420=;
        b=g5uGZoEIBv0xZmJM/thXrxHMPl18U76DxfrGHdBVFT9txf/gpgZ+LcJ0l6pw01qYho
         28sRXHe4eYnZ8jVJGfHHlxNA+DSuktDJWeihLAFmt6JoiFIlROjnbBMIsknSAKqHA4OP
         Pc8Jjd+m3sNHJJ9y3svSuwg9ZU4vSmoWsDFDq2AsljpA/5YQVDDwrEBgEffBxKw/CwMR
         KXiwFTw3O0WrYu40N/NOL7oxc2Um5kimAlkmKqFMMPpVjzXnE5i6awyEPc0OCq95IYds
         AhX9+EXE5ZIEPjAPLJeDP/P3AxwD4W0eN5zESYXQMA7CtkdkLpCcbANXcijhZtBk8gMW
         jQNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Sun, 13 May 2018 15:35:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Dexuan Cui <decui@microsoft.com>, Ingo Molnar <mingo@kernel.org>,
    Alexey Dobriyan <adobriyan@gmail.com>,
    Peter Zijlstra <peterz@infradead.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Rakib Mullick <rakib.mullick@gmail.com>,
    "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: for_each_cpu() is buggy for UP kernel?
In-Reply-To: <20180509162027.95ffa21312f7363d13d5ea1e@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1805131517170.1582@nanos.tec.linutronix.de>
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM> <20180509162027.95ffa21312f7363d13d5ea1e@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1600356146125137198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 9 May 2018, Andrew Morton wrote:

> On Wed, 9 May 2018 06:24:16 +0000 Dexuan Cui <decui@microsoft.com> wrote:
> 
> > In include/linux/cpumask.h, for_each_cpu is defined like this for UP kernel (CONFIG_NR_CPUS=1):
> > 
> > #define for_each_cpu(cpu, mask)                 \
> >         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> > 
> > Here 'mask' is ignored, but what if 'mask' contains 0 CPU? -- in this case, the for loop should not
> > run at all, but with the current code, we run the loop once with cpu==0.
> > 
> > I think I'm seeing a bug in my UP kernel that is caused by the buggy for_each_cpu():
> > 
> > in kernel/time/tick-broadcast.c: tick_handle_oneshot_broadcast(), tick_broadcast_oneshot_mask
> > contains 0 CPU, but due to the buggy for_each_cpu(), the variable 'next_event' is changed from
> > its default value KTIME_MAX to "next_event = td->evtdev->next_event"; as a result,
> > tick_handle_oneshot_broadcast () -> tick_broadcast_set_event() -> clockevents_program_event()
> > -> pit_next_event() is programming the PIT timer by accident, causing an interrupt storm of PIT
> > interrupts in some way: I'm seeing that the kernel is receiving ~8000 PIT interrupts per second for
> > 1~5 minutes when the UP kernel boots, and it looks the kernel hangs, but in 1~5 minutes, finally
> > somehow the kernel can recover and boot up fine. But, occasionally, the kernel just hangs there
> > forever, receiving ~8000 PIT timers per second. 
> > 
> > With the below change in kernel/time/tick-broadcast.c, the interrupt storm will go away:
> > 
> > +#undef for_each_cpu
> > +#define for_each_cpu(cpu, mask)                        \
> > +       for ((cpu) = 0; (((cpu) < 1) && ((mask)[0].bits[0] & 1)); (cpu)++, (void)mask)
> > 
> > Should we fix the for_each_cpu() in include/linux/cpumask.h for UP?
> 
> I think so, yes.  That might reveal new peculiarities, but such is life.
> 
> I guess we should use bitmap_empty() rather than open-coding it.

Agreed.

FWIW, this had been discussed before, but there was no real conclusion:

  https://lkml.kernel.org/r/alpine.DEB.2.20.1709161850010.2105@nanos

Thanks,

	tglx
