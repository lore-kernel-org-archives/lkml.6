Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeEaD0X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:26:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932637AbeEaD0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:26:19 -0400
Date: Thu, 31 May 2018 11:26:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Travis <mike.travis@hpe.com>
Cc: "Anderson, Russ" <russ.anderson@hpe.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, keescook@chromium.org,
        "Ramsay, Frank" <frank.ramsay@hpe.com>
Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Do not adapt the size of the
 direct mapping section for SGI UV system
Message-ID: <20180531032613.GB4327@MiWiFi-R3L-srv>
References: <1504770150-25456-1-git-send-email-bhe@redhat.com>
 <1504770150-25456-3-git-send-email-bhe@redhat.com>
 <20170928075605.g74zm5xeglosmvct@gmail.com>
 <20170928083112.GN16025@x1>
 <20170928090143.m6sog2am2ccz5dm4@gmail.com>
 <25fc5345-3273-447e-de6a-2ac7c56d0f00@hpe.com>
 <20180517031802.GK24627@MiWiFi-R3L-srv>
 <53301a1e-e817-912f-cf7d-0000b078c7a3@hpe.com>
 <20180523000306.GY24627@MiWiFi-R3L-srv>
 <7ce3cc80-3991-f914-c539-9fa38256ea4b@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce3cc80-3991-f914-c539-9fa38256ea4b@hpe.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/18 at 01:50pm, Mike Travis wrote:
> Hi Baoquan,
> 
> My apologies for my delay, we are going through a network reconfig so mail
> to me was not available for a bit.  Comments below...

Not at all.

> > > > > > > Is there any chance we can get the size of MMIOH region before mm KASLR
> > > > > > > code, namely before we call kernel_randomize_memory()?
> > > > > 
> > > > > The sizes of the MMIOL and MMIOH areas are tied into the HUB design and how
> > > > > it is communicated to BIOS and the kernel.  This is via some of the config
> > > > > MMR's found in the HUB and it would be impossible to provide any access to
> > > > > these registers as they change with each new UV architecture.
> > > > > 
> > > > > The kernel does reserve the memory in the EFI memmap.  I can send you a
> >        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > console log of the full startup that includes the MMIOH reservations. Note
> > 
> > What I want is if we can get the MMIOH region from EFI memmap before
> > kernel_randomize_memory() in setup_kernel(), if yes how we can get it.
> 
> The problem is that EFI memmap only shows "reserved memory" and not what it
> is reserved for.  Most reservations are for things like BIOS reserved
> memory, and exchanged info from EFI to the kernel.

Ok, then we might not be able to achieve the goal Ingo suggested if can
not get the size UV reserved for MMIOH region.

> 
> > Because Ingo doesn't like hacking UV inside kernel_randomize_memory(),
> > seems I have to get the MMIOH region specifically before
> > kernel_randomize_memory(), then count it in when do mm regions
> > reandomization.
> 
> Perhaps calling a function prior, to see if memory is "eligible" for
> inclusion into your randomize memory scheme?  Adding UV to the list of
> systems to support this would bea very good thing, I'm just not sure how to
> help you do this.

Do you mean adding a function to check if the size of direct mapping is 
allowed to adapt or not, any ineligible system need be checked there,
and UV system is the 1st one for now?

I am not sure what a list looks like, e.g DMI table we are using?

> 
> > 
> > > > > that it is dependent on what I/O devices are actually present as UV does not
> > > > > map empty slots unless forced (because we'd quickly run out of resources.)
> > > > > Also, the EFI memmap entries do not specify the exact usage of the contained
> > > > > areas.
> > > > 
> > > > This one is still a regression bug in our newer rhel since I just fixed
> > > > them with rhel-only patch. Now I still need the console log which
> > > > includes the MMIOH reservations.
> > > > 
> > > > Could you help provide a console log with MMIOH info, or I need request
> > > > one from redhat's lab?
> > > 
> > > Hi,  I've forgotten exactly what info you need?  I have attached a gzipped
> > > console log (private email since attachments are frowned upon in LKML.  You
> > > can see the MMIOH0/1 areas reserved though because there is no "large" MMIOH
> > > devices, no specific memory has been assigned.  (See MMIOH1 base == NULL
> > > line).
> > 
> > Yes, I checked the console log you provided, seems you have enabled the
> > pr_debug printing, and I saw the lines telling it's NULL.
> > 
> > 00:01:17 00:00.0 [    2.196015] UV: MMIOH0 base:0xfff00000000 shift:52 M_IO:26 MAX_IO:63
> > 00:01:17 00:00.0 [    2.200000] UV: Map MMIOH0_HI base address NULL
> > 	......
> > 00:01:17 00:00.0 [    2.344001] UV: MMIOH1 base:0x100000000000 shift:52 M_IO:37 MAX_IO:127
> > 00:01:17 00:00.0 [    2.348000] UV: Map MMIOH1_HI base address NULL
> > 
> 
> Right.  Because there was no devices in these regions, none of them needed
> to be mapped.  This is handled by the UV BIOS.
> 
> > > 
> > > You can grep UV: to get UV specific messages.  I also looked though the efi
> > > memmap entries and they don't have MMIO areas distinctively mentioned.
> > > 
> > > I'm looking now for a lab system that has at least a single large MMIOH
> > > device (a GPU has a large MMIO aperture).  I'll let you know.  The GPU
> > > system we had was shipped to the HPE GPU support group down in Houston and I
> > > haven't heard from them yet.  I don't think the UV's at Redhat have any I/O
> > > except for the Base I/O (required) devices.
> > > 
> > > > 
> > > > Or expert from HPE UV team can make a patch based on the finding and
> > > > analysis?
> > > 
> > > Again, I'm not exactly sure what you need.  Is it only the physical
> > > addresses reserved for MMIOH areas?  (MMIOL is in the 2nd 2GB half in the
> > > lower 32 bits.)  As I mentioned, we don't have fixed MMIOH addresses and
> > > BIOS sets up all MMIO areas in (I believe) the ACPI tables.  So that should
> > > have the authoritative answers to your questions.  (Sorry, I don't know
> > > which table has that specific info.)
> > 
> > I don't get it very clearly what is the difference between MMHOH and
> > MMIOL. From the code flow, the bug is reported on MMIOH mapping. I
> > haven't found where MMIOL region need be mapped. Could you pointed it
> > out so that I can check the code where MMIOL is being handled, if it
> > need be handled.
> 
> The only difference is MMIOL is 32 bit based addressing, while MMIOH is 64
> bit addressing.
> > 
> > Let me list thoughts I had about MMIOH region and the bug, please help
> > check if I am right, and anything I missed:
> > 
> > Now what I found from code:
> > 1) There's a UVsystab in EFI
> 
> True.  There are many "EFI" pointers declared to pass info from BIOS to the
> kernel via EFI.
> 
> > 2) MMIOH region need be mapped to the direct mapping region which is
> > 64TB, surely here I mean nokaslr case.
> 
> Yes, but these regions are in the ACPI tables, and I print the regions in
> the early startup messages strictly as informational.  But this is well
> within the "start_kernel()" called functions.  Much before you need the
						      ~~~~~
						      'after'
> info.



> > 
> > ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
> > 
> > 3) With kaslr, we may shrink size of the direct mapping region because
> > usually system RAM is very small, we need reserve enough area for system
> > ram mapping, then take the left out for better randomization. For UV
> > system, we need find out their MMIOH region size (possibly MMIOIL too if
> > it need be mapped) before kernel_randomize_memory() and add it to size
> > of system RAM to join the mm region randomization.
> 
> The MMIOL addresses are already mapped as they are fixed in the 2-4GB 32-bit
> range.  The MMIOH mapped regions can be placed anywhere within the 64 bit
> address space.
> > 
> > If my above understanding is right, the only thing would be finding the
> > MMIOH region size from efi/acpi table, sorry I really don't know where
> > it should be, as Ingo suggested. If we have no way to find it out at
> > right time, then the old post will be the only choice.
> 
> The ACPI tables should have any and all info.  How are you getting them now?
> Certainly even whitebox PC's (what we call "non-UV" boxes) would have that
> info in the ACPI tables?  I have not had an occasion to find this info in
> the myriad of ACPI tables, so I'm not sure which specific ones to look at.

Seems we can't get info from ACPI table before kernel_randomize_memory().

> 
> > 
> > (I noticed you always mentioned I/O devices, its relationship with
> > MMIOH/L region is? I am a little confused. UV system could have
> > MMIOH/L region which size and addr are  written into efi/acpi table,
> > while later actually they are not mapped, e.g the address is NULL case.)
> 
> As I mentioned, the UV BIOS scans the PCI buses for devices for a lot of
> reasons.  One is, if there are no devices needing MMIOH regions on a PCI
> host controller, it does not ask for memory to be reserved for that.
> > 
> > Thanks a lot for your help!
> > 
> > Thanks
> > Baoquan
> 
> Btw, I'm going on a vacation soon so my replies may be even more delayed.

It's OK, only if it's convenient to you, or after your vacation.

Thanks a lot!

> 
> 
> > > > > 
> > > > > > 
> > > > > > I don't mind system specific quirks to hardware enumeration details, as long as
> > > > > > they don't pollute generic code with such special hacks.
> > > > > > 
> > > > > > I.e. in this case it's wrong to allow kaslr_regions[0].size_tb to be wrong. Any
> > > > > > other code that relies on it in the future will be wrong as well on UV systems.
> > > > > 
> > > > > Which may come into play on other arches with the new upcoming memory
> > > > > technologies.
> > > > > > 
> > > > > > The right quirk would be to fix that up where it gets introduced, or something
> > > > > > like that.
> > > > > 
> > > > > Yes, does make sense.
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > 	Ingo
> > > > > > 
> > 
> > 
