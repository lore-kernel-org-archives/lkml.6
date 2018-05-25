Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935778AbeEYCn6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:43:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751358AbeEYCnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:43:52 -0400
Date: Fri, 25 May 2018 10:43:39 +0800
From: Dave Young <dyoung@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Cong Wang <xiyou.wangcong@gmail.com>, Neil Horman <nhorman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>, dzickus@redhat.com,
        bhe@redhat.com
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180525024339.GA2720@dhcp-128-65.nay.redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180524014234.GA2031@dhcp-128-65.nay.redhat.com>
 <87bmd53t0p.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmd53t0p.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 05/24/18 at 11:41am, Eric W. Biederman wrote:
> Dave Young <dyoung@redhat.com> writes:
> 
> > Hi Eric,
> > On 05/23/18 at 10:53am, Eric W. Biederman wrote:
> >> Dave Young <dyoung@redhat.com> writes:
> >> 
> >> > [snip]
> >> >
> >> >> >  
> >> >> > +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
> >> >> > +	int "System memory size threshold for kdump memory default reserving"
> >> >> > +	depends on CRASH_CORE
> >> >> > +	default 0
> >> >> > +	help
> >> >> > +	  CRASHKERNEL_DEFAULT_MB is used as default crashkernel value if
> >> >> > +	  the system memory size is equal or bigger than the threshold.
> >> >> 
> >> >> "the threshold" is rather vague.  Can it be clarified?
> >> >> 
> >> >> In fact I'm really struggling to understand the logic here....
> >> >> 
> >> >> 
> >> >> > +config CRASHKERNEL_DEFAULT_MB
> >> >> > +	int "Default crashkernel memory size reserved for kdump"
> >> >> > +	depends on CRASH_CORE
> >> >> > +	default 0
> >> >> > +	help
> >> >> > +	  This is used as the default kdump reserved memory size in MB.
> >> >> > +	  crashkernel=X kernel cmdline can overwrite this value.
> >> >> > +
> >> >> >  config HAVE_IMA_KEXEC
> >> >> >  	bool
> >> >> >  
> >> >> > @@ -143,6 +144,24 @@ static int __init parse_crashkernel_simp
> >> >> >  	return 0;
> >> >> >  }
> >> >> >  
> >> >> > +static int __init get_crashkernel_default(unsigned long long system_ram,
> >> >> > +					  unsigned long long *size)
> >> >> > +{
> >> >> > +	unsigned long long sz = CONFIG_CRASHKERNEL_DEFAULT_MB;
> >> >> > +	unsigned long long thres = CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB;
> >> >> > +
> >> >> > +	thres *= SZ_1M;
> >> >> > +	sz *= SZ_1M;
> >> >> > +
> >> >> > +	if (sz >= system_ram || system_ram < thres) {
> >> >> > +		pr_debug("crashkernel default size can not be used.\n");
> >> >> > +		return -EINVAL;
> >> >> 
> >> >> In other words,
> >> >> 
> >> >> 	if (system_ram <= CONFIG_CRASHKERNEL_DEFAULT_MB ||
> >> >> 	    system_ram < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB)
> >> >> 		fail;
> >> >> 
> >> >> yes?
> >> >> 
> >> >> How come?  What's happening here?  Perhaps a (good) explanatory comment
> >> >> is needed.  And clearer Kconfig text.
> >> >> 
> >> >> All confused :(
> >> >
> >> > Andrew, I tuned it a bit, removed the check of sz >= system_ram, so if
> >> > the size is too large and kernel can not find enough memory it will
> >> > still fail in latter code.
> >> >
> >> > Is below version looks clearer?
> >> 
> >> What is the advantage of providing this in a kconfig option rather
> >> than on the kernel command line as we can now?
> >
> > It is not a replacement of the cmdline, this can be a supplement to
> > the crashkernel command line.  For a lot of common use cases if we have
> > the auto reservation user just do not need to manually set the cmdline
> > for example on a virtual machine and usual setup (except of the
> > comlicate storage and very large machines).  The crashkernel=auto
> > has been used for long time, Red Hat QE tested it on a lot of different
> > lab machines and proved it works well.  Kdump usually just works so admin
> > do little work to enable kdump.
> >
> > But the crashkernel=auto implementation has some drawbacks that is it
> > is more like embed policy in the code and it is not flexible like a
> > config option.
> 
> Have you considered using the builtin command line aka CONFIG_CMDLINE?
> If as you are reserving a fixed amount of memory as your patch does that
> should be sufficient, and doable without any kernel changes.

Hmm, even in builtin cmdline it is same as a explict used crashkernel=.
If we think from a distribution point of view, it will be hard to
differentiate the builtin provided param and bootloader provided
params. It looks odd to see two crashkernel= when `cat /proc/cmdline`,
it will confuse people and there could cause compatibility problems
because it is explict value visible in kernel cmdline. 

Thanks
Dave
