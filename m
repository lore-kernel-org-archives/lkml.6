Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935566AbeEXBtW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:49:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935218AbeEXBtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:49:17 -0400
Date: Thu, 24 May 2018 09:49:05 +0800
From: Dave Young <dyoung@redhat.com>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, dzickus@redhat.com,
        Neil Horman <nhorman@redhat.com>, Tony Luck <tony.luck@intel.com>,
        bhe@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180523222236.5a96732e@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523222236.5a96732e@ezekiel.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 05/23/18 at 10:22pm, Petr Tesarik wrote:
> On Wed, 23 May 2018 10:53:55 -0500
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > Dave Young <dyoung@redhat.com> writes:
> > 
> > > [snip]
> > >  
> > >> >  
> > >> > +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
> > >> > +	int "System memory size threshold for kdump memory default reserving"
> > >> > +	depends on CRASH_CORE
> > >> > +	default 0
> > >> > +	help
> > >> > +	  CRASHKERNEL_DEFAULT_MB is used as default crashkernel value if
> > >> > +	  the system memory size is equal or bigger than the threshold.  
> > >> 
> > >> "the threshold" is rather vague.  Can it be clarified?
> > >> 
> > >> In fact I'm really struggling to understand the logic here....
> > >> 
> > >>   
> > >> > +config CRASHKERNEL_DEFAULT_MB
> > >> > +	int "Default crashkernel memory size reserved for kdump"
> > >> > +	depends on CRASH_CORE
> > >> > +	default 0
> > >> > +	help
> > >> > +	  This is used as the default kdump reserved memory size in MB.
> > >> > +	  crashkernel=X kernel cmdline can overwrite this value.
> > >> > +
> > >> >  config HAVE_IMA_KEXEC
> > >> >  	bool
> > >> >  
> > >> > @@ -143,6 +144,24 @@ static int __init parse_crashkernel_simp
> > >> >  	return 0;
> > >> >  }
> > >> >  
> > >> > +static int __init get_crashkernel_default(unsigned long long system_ram,
> > >> > +					  unsigned long long *size)
> > >> > +{
> > >> > +	unsigned long long sz = CONFIG_CRASHKERNEL_DEFAULT_MB;
> > >> > +	unsigned long long thres = CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB;
> > >> > +
> > >> > +	thres *= SZ_1M;
> > >> > +	sz *= SZ_1M;
> > >> > +
> > >> > +	if (sz >= system_ram || system_ram < thres) {
> > >> > +		pr_debug("crashkernel default size can not be used.\n");
> > >> > +		return -EINVAL;  
> > >> 
> > >> In other words,
> > >> 
> > >> 	if (system_ram <= CONFIG_CRASHKERNEL_DEFAULT_MB ||
> > >> 	    system_ram < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB)
> > >> 		fail;
> > >> 
> > >> yes?
> > >> 
> > >> How come?  What's happening here?  Perhaps a (good) explanatory comment
> > >> is needed.  And clearer Kconfig text.
> > >> 
> > >> All confused :(  
> > >
> > > Andrew, I tuned it a bit, removed the check of sz >= system_ram, so if
> > > the size is too large and kernel can not find enough memory it will
> > > still fail in latter code.
> > >
> > > Is below version looks clearer?  
> > 
> > What is the advantage of providing this in a kconfig option rather
> > than on the kernel command line as we can now?
> 
> Yeah, I was about to ask the very same question.
> 
> Having spent quite some time on estimating RAM required to save a crash
> dump, I can tell you that there is no silver bullet. My main objection
> is that core dumps are saved from user space, and the kernel cannot
> have a clue what it is going to be.
> 
> First, the primary kernel cannot know how much memory will be needed
> for the panic kernel (not necessarily same as the primary kernel) and
> the panic initrd. If you build a minimal initrd for your system, then
> at least it depends on which modules must be included, which in turn
> depends on where you want to store the resulting dump. Mounting a local
> ext2 partition will require less software than mounting an LVM logical
> volume in a PV accessed through iSCSI over two bonded Ethernet NICs.
> 
> Second, run-time requirements may vary wildly. While sending the data
> over a simple TCP connection (e.g. using FTP) consumes just a few
> megabytes even on 10G Ethernet, dm block devices tend to consume much
> more, because of the additional buffers allocated by device mapper.
> 
> Third, systems should be treated as "big" not so much because of the
> amount of RAM, but more so because of the amount of attached devices.
> I've seen a machine with devices from /dev/sda to /dev/sdvm; try to
> calculate how much kernel memory is taken just by their in-kernel
> representation...
> 
> Fourth, quite often there is a trade-off between how much memory is
> reserved for the panic environment, and how long dumping will take. For
> example, you may take advantage of multi-threading in makedumpfile, but
> obviously, the additional threads need more memory (or makedumpfile
> will have to do its job in more cycles, reducing speed again). Oh, did
> I mention that even bringing up more CPUs has an impact on kernel
> runtime memory requirements?
> 
> In short, if one size fits none, what good is it to hardcode that "one
> size" into the kernel image?

I agreed with all the things that we can not know the exact memory
requirement for 100% use cases.  But that does not means this is useless
it is still useful for common use cases of no special and memory hog
requirements as I mentioned in another reply it can simplify the kdump
deployment for those people who do not need the special setup.

For example, if this is a workstation I just want to break into a shell
to collect some panic info, then I just need a very minimal initrd, then
the Kconfig will work just fine.

Thanks
Dave
