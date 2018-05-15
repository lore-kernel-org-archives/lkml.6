Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526404913; cv=none;
        d=google.com; s=arc-20160816;
        b=Ux1NLi3WNX4pSLUX7lfepMRwOkpC7c9c2CRMGcXC+aCYrrmqg5Fm+ym1imXC6+iQvN
         /ZzP34N/e7F9lNn7DxJjkq3yHPOvhU+p1hzFSqDVU06h0LU7f4z3KXBIuu/OEC6fZfRE
         T5tVWVAUktD0OcZHQZUz6VmJBR5FS3DT2UzC8NOvrP8ZKYuwECNmswQFLPTiMhQU9PEa
         3NozaOO+duKwOmLuktIUosimoRHdy8wbwx4KlKhZx8a6CJnSgCYwmfmbnQ79HuxcOTWx
         GRileevv34hqa5EITpCS7boHAicsTvOAYc7BusYpkGAREeG1K0+cqAgJz3qaN1/Kp7+T
         IxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wfTa3sLa5fI37fQTxkhBr548wzWfK1TIPSmwhMwQfxo=;
        b=Bfsu45yPaZdJv0rpxxTCTCVb5PENzUZ14zx1cX17pt8Jz/MJW2N69xEtPCxefYTBvZ
         yPJcT52b9QFvbQcDt9MQT4xAUoG2oXxX960Rx9rWtJIjidN9bNrKUN5dbC5eBlR62IB1
         aiayUGCZd4oz4oHH6TrTxgEyNYfvXpOSbXht5AAcTVmbWUbCinpg5Ky3DQhvauwSldum
         XGL8Kqrf10JYswYzVKhlP2psRZE3kV9hUhggwka29VQ5Mpb4scNSrLFSVjw3tZ9iA5vL
         GWETbSOA7+eijljg99ASCDs+YjluBM+40rH8G39tlUKXPjAn1mz3ssyV9q3+FBBj5s0l
         FcIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=TDqhFPXX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=TDqhFPXX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZqjdPaOwpyjzrxBVIGnaRBXmB3F8MDID0pSFWe31zFensN8wiBT+NmiHGGTMnfwZqNUgb7AA74HPMEzAsaSfnk=
MIME-Version: 1.0
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <CA+55aFx5_qcUHBQ50RfOnH+pS=jqA_Wg2YYCcm=fTXRFJjs3rg@mail.gmail.com> <SG2P15301MB0015F23FF0E44BE991E8C38EBF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P15301MB0015F23FF0E44BE991E8C38EBF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 10:21:41 -0700
Message-ID: <CA+55aFziNcDmN=DT7efKYGU-AZC535GDVKh57bC7UHaFff3vRw@mail.gmail.com>
Subject: Re: for_each_cpu() is buggy for UP kernel?
To: Dexuan Cui <decui@microsoft.com>
Cc: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rakib Mullick <rakib.mullick@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1600551557990686339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 8:02 PM Dexuan Cui <decui@microsoft.com> wrote:

> If you're OK with the below fix (not tested yet), I'll submit a patch for
it:

> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -616,6 +616,10 @@ static void tick_handle_oneshot_broadcast(struct
clock_event_device *dev)
>          now = ktime_get();
>          /* Find all expired events */
>          for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
> +#ifndef CONFIG_SMP
> +               if (cpumask_empty(tick_broadcast_oneshot_mask))
> +                       break;
> +#endif

I'm certainly ok with this. It's hacky, but maybe being explicitly hacky is
good to "document" this gotcha.

And I really do agree that this special UP case is nasty nasty and much too
subtle, and I hope that some day we won't care about UP at all, and maybe
kill it, or maybe just make for_each_cpu() generate the extra code to have
the actual same semantics as the SMP case.

                  Linus
