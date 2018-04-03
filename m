Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeDCOkt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:40:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37773 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDCOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:40:47 -0400
X-Google-Smtp-Source: AIpwx4/tcsjG8H4cW8CyefIC2OTvbCk+OlBc5T/i/7yBOj4Yk4jxHzQf0yV11U73ZsdPatEjpGBhAA==
Date: Tue, 3 Apr 2018 16:40:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>
Subject: Re: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Message-ID: <20180403144043.23o5aijs4hlyj2dj@gmail.com>
References: <20180402183424.48222-1-Yazen.Ghannam@amd.com>
 <20180403110352.izr2kvsd3ys4drjq@gmail.com>
 <CY4PR12MB1557216A1882A4CFC43248D3F8A50@CY4PR12MB1557.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR12MB1557216A1882A4CFC43248D3F8A50@CY4PR12MB1557.namprd12.prod.outlook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:

> > -----Original Message-----
> > From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo Molnar
> > Sent: Tuesday, April 3, 2018 7:04 AM
> > To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> > Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@suse.de
> > Subject: Re: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD
> > systems
> > 
> > 
> > * Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> > 
> > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > >
> > > Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
> > > not allow deeper cstates than C1 on current systems.
> > >
> > > With play_dead() we expect the OS to use the deepest state available.
> > > The deepest state available on AMD systems is reached through SystemIO
> > > or HALT. If MWAIT is available, we use it instead of the other methods,
> > > so we never reach the deepest state.
> > >
> > > Don't try to use MWAIT to play_dead() on AMD systems. Instead, we'll use
> > > CPUIDLE to enter the deepest state advertised by firmware. If CPUIDLE is
> > > not available then we fallback to HALT.
> > >
> > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > ---
> > >  arch/x86/kernel/smpboot.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > > index ff99e2b6fc54..67cf00b25f83 100644
> > > --- a/arch/x86/kernel/smpboot.c
> > > +++ b/arch/x86/kernel/smpboot.c
> > > @@ -1536,6 +1536,9 @@ static inline void mwait_play_dead(void)
> > >  	void *mwait_ptr;
> > >  	int i;
> > >
> > > +	/* Don't try native MWAIT on AMD. Stick to CPUIDLE and HALT. */
> > > +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> > > +		return;
> > 
> > The comment should mainly explain the 'why is this done', not the 'what is done'
> > which is pretty obvious from the code ...
> > 
> 
> Yes, I'll drop that comment since the commit message has the explanation.

Or rather, explain the 'why' in the comment, because otherwise this is a pretty 
obscure condition that is not self-documenting?

Thanks,

	Ingo
