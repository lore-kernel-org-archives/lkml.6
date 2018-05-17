Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEQDSI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 23:18:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751395AbeEQDSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 23:18:07 -0400
Date: Thu, 17 May 2018 11:18:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Travis <mike.travis@hpe.com>, rja@hpe.com, frank.ramsay@hpe.com
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        thgarnie@google.com, keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, sivanich@hpe.com, dyoung@redhat.com
Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Do not adapt the size of the
 direct mapping section for SGI UV system
Message-ID: <20180517031802.GK24627@MiWiFi-R3L-srv>
References: <1504770150-25456-1-git-send-email-bhe@redhat.com>
 <1504770150-25456-3-git-send-email-bhe@redhat.com>
 <20170928075605.g74zm5xeglosmvct@gmail.com>
 <20170928083112.GN16025@x1>
 <20170928090143.m6sog2am2ccz5dm4@gmail.com>
 <25fc5345-3273-447e-de6a-2ac7c56d0f00@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fc5345-3273-447e-de6a-2ac7c56d0f00@hpe.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike, Russ and Frank,

On 09/28/17 at 07:10am, Mike Travis wrote:
> 
> 
> On 9/28/2017 2:01 AM, Ingo Molnar wrote:
> > 
> > * Baoquan He <bhe@redhat.com> wrote:
> > 
> > > > > @@ -123,7 +124,7 @@ void __init kernel_randomize_memory(void)
> > > > >   		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> > > > >   	/* Adapt phyiscal memory region size based on available memory */
> > > > > -	if (memory_tb < kaslr_regions[0].size_tb)
> > > > > +	if (memory_tb < kaslr_regions[0].size_tb && !is_early_uv_system())
> > > > >   		kaslr_regions[0].size_tb = memory_tb;
> > > > This is really an ugly hack. Is kaslr_regions[] incorrect? If so then it should be
> > > > corrected instead of uglifying the code that uses it...
> > > 
> > > Thanks for looking into this!
> > > 
> > > If on SGI UV system, the kaslr_regions[0].size_tb, namely the size of
> > > the direct mapping section, is incorrect.
> > > 
> > > Its direct mapping size includes two parts:
> > > #1 RAM size of system
> > > #2 MMIOH region size which only SGI UV system has.
> > > 
> > > However, the #2 can only be got till uv_system_init() is called in
> > > native_smp_prepare_cpus(). That is too late for mm KASLR calculation.
> > > That's why I made this hack.
> > > 
> > > I checked uv_system_init() code, seems not easy to know the size of
> > > MMIOH region before or inside kernel_randomize_memory(). I have CCed UV
> > > devel experts, not sure if they have any idea about this. Otherwise,
> > > this patch could be the only way I can think of.
> > > 
> > > Hi Mike and Russ,
> > > 
> > > Is there any chance we can get the size of MMIOH region before mm KASLR
> > > code, namely before we call kernel_randomize_memory()?
> 
> The sizes of the MMIOL and MMIOH areas are tied into the HUB design and how
> it is communicated to BIOS and the kernel.  This is via some of the config
> MMR's found in the HUB and it would be impossible to provide any access to
> these registers as they change with each new UV architecture.
> 
> The kernel does reserve the memory in the EFI memmap.  I can send you a
> console log of the full startup that includes the MMIOH reservations. Note
> that it is dependent on what I/O devices are actually present as UV does not
> map empty slots unless forced (because we'd quickly run out of resources.)
> Also, the EFI memmap entries do not specify the exact usage of the contained
> areas.

This one is still a regression bug in our newer rhel since I just fixed
them with rhel-only patch. Now I still need the console log which
includes the MMIOH reservations. 

Could you help provide a console log with MMIOH info, or I need request
one from redhat's lab?

Or expert from HPE UV team can make a patch based on the finding and
analysis?

Thanks
Baoquan
> 
> > 
> > I don't mind system specific quirks to hardware enumeration details, as long as
> > they don't pollute generic code with such special hacks.
> > 
> > I.e. in this case it's wrong to allow kaslr_regions[0].size_tb to be wrong. Any
> > other code that relies on it in the future will be wrong as well on UV systems.
> 
> Which may come into play on other arches with the new upcoming memory
> technologies.
> > 
> > The right quirk would be to fix that up where it gets introduced, or something
> > like that.
> 
> Yes, does make sense.
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
