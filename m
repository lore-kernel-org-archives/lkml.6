Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AB8JxZr0KB3MV4VHYrXYHGJJ6oKp4cWKipG264AILRAVAQ+1P6A+l3E9d9cVJUT/adMSQflCUH8b
ARC-Seal: i=1; a=rsa-sha256; t=1525344361; cv=none;
        d=google.com; s=arc-20160816;
        b=jYiMTyrmCqoyb+zLMfVxcF0ZXhGd8atW95lam+/wRu4FGKmg0nFWP7iIyDgG88SWFo
         UKRwD/BtE1vMxBboy9tqJZtZMlYMVqRyLYUsz1XDTakx0qSXJhGR9DKsVUx5G4sMtZvT
         M6F8mCP6n1Z3145KaaUCqOalgMWl/THUY5ZTyBxMIFrQ0SNR2xDqevxh5sXVonvcm1F3
         05gMMRoq2NnuZce9aitUzsV3SMnPnzj1jfwZLjhgD/UVEMjrjGvaUn05uTHaae8940M2
         ewogKxnfkiwU3p/qUSXtGc/qEQnU7KtQ/gcWA+AChZF3NVWRFvpHpRwBD7eLhcF1eSA0
         1E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=V3ub3gDp2azT6+ObeiBAFisZvOyKLhYuyTrRW4Q5Cns=;
        b=zUMnKHLOaT0NjY8a6j+2nUhofVoAVj40WUoCVA/XA5ZxCROkUSO1wNeikHF39vocjl
         0L/G0rDSGz/xLnfEFUWuyXIx4MIEng3VtlROPQDbVr8ddttU0HIgmkQFjRaJ1KGodsCD
         lYZBHosvqdVv0YXkRWdss9s++B0fugBfLgDfYsUgbeNP/JH4N3wz9Iyr/IKq3SWyeqTI
         KsM6+SnnuiI55Gc1u0jYEa5Q+RaMjdwnYaVm5tilKhD+/XN6yTt+vn9ThsRMKXTEo6Mx
         z6sYnuTAG3vTznGUJhQlwLGHFMszE1xm7EFCWFUAbjlyXTJelzzB9JPbAoADkf5xXr3+
         Gr8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36550198"
Message-ID: <1525344358.21176.643.camel@linux.intel.com>
Subject: Re: [PATCH v1 4/6] x86/boot: Assume MMIO if serial base address
 supplied via earlyprintk
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin"
	 <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	 <mingo@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 May 2018 13:45:58 +0300
In-Reply-To: <20180116155520.gqdztulncpsmu5zp@gmail.com>
References: <20180114143254.15429-1-andriy.shevchenko@linux.intel.com>
	 <20180114143254.15429-4-andriy.shevchenko@linux.intel.com>
	 <20180116031342.bxczth3ylbzdvk2r@gmail.com>
	 <1516100104.7000.1001.camel@linux.intel.com>
	 <20180116155520.gqdztulncpsmu5zp@gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1589717159850476715?=
X-GMAIL-MSGID: =?utf-8?q?1599439489280788032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-01-16 at 16:55 +0100, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, 2018-01-16 at 04:13 +0100, Ingo Molnar wrote:
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > If user supplied serial base address via kernel command line and
> > > > value
> > > > is higher than IO space limit (64k boundary), assume for now
> > > > that
> > > > MMIO
> > > > byte access is required.
> > > > 
> > > > Later we might expand or modify this if needed.
> > > 
> > > Is this a standard pattern for serial code configuration values?
> > 
> > I didn't get what you meant under "standard" here.
> > 
> > IO space limit comes from generic io.h header and AFAIU is a
> > hardware
> > limitation (outN (%dx), ...; inX (%dx); dx is 16 bit register).
> > 
> > Using mmio8 out of the IO space is dictated by the (modern) x86
> > platforms with non-standard (okay, high speed) UART location in
> > address
> > space.
> 
> So I was wondering whether we should just make mmio configuration an
> explicit 
> parameter instead of a 'range hack'.

I _think_ it can be done later without breaking any existed
configurations.

> Since we are introducing something entirely new the choice is ours.
> 
> Doing it that way would technically be cleaner, as, at least
> theoretically,
> there could be platforms with mmio addresses below 64k physical,
> right?

Correct, though we are talking about x86 world where I have no example
like this. Either we have LPC ports (I/O 0x3f8 and alike) or HS UARTS on
higher MMIO addresses. Note, that PCI code guarantees that range bump as
well when resources would be allocated for unassigned, by firmware, PCI
UART controllers.

> It's also more self-documenting if the new configuration/parameter
> says 'mmio' 
> explicitly.

I would look at it, though it might make things much more complicated to
implement. And yes, it wouldn't reduce fragility of the parser anyway.

Perhaps we can unify earlycon parser with earlyprintk one (not sure if
it's possible since this nice trick with sharing same code between
compressed and boot code).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
