Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754242AbeEWHG4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:06:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754056AbeEWHGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:06:52 -0400
Date: Wed, 23 May 2018 15:06:41 +0800
From: Dave Young <dyoung@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Cong Wang <xiyou.wangcong@gmail.com>, Neil Horman <nhorman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>, dzickus@redhat.com,
        bhe@redhat.com
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> >  
> > +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
> > +	int "System memory size threshold for kdump memory default reserving"
> > +	depends on CRASH_CORE
> > +	default 0
> > +	help
> > +	  CRASHKERNEL_DEFAULT_MB is used as default crashkernel value if
> > +	  the system memory size is equal or bigger than the threshold.
> 
> "the threshold" is rather vague.  Can it be clarified?
> 
> In fact I'm really struggling to understand the logic here....
> 
> 
> > +config CRASHKERNEL_DEFAULT_MB
> > +	int "Default crashkernel memory size reserved for kdump"
> > +	depends on CRASH_CORE
> > +	default 0
> > +	help
> > +	  This is used as the default kdump reserved memory size in MB.
> > +	  crashkernel=X kernel cmdline can overwrite this value.
> > +
> >  config HAVE_IMA_KEXEC
> >  	bool
> >  
> > @@ -143,6 +144,24 @@ static int __init parse_crashkernel_simp
> >  	return 0;
> >  }
> >  
> > +static int __init get_crashkernel_default(unsigned long long system_ram,
> > +					  unsigned long long *size)
> > +{
> > +	unsigned long long sz = CONFIG_CRASHKERNEL_DEFAULT_MB;
> > +	unsigned long long thres = CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB;
> > +
> > +	thres *= SZ_1M;
> > +	sz *= SZ_1M;
> > +
> > +	if (sz >= system_ram || system_ram < thres) {
> > +		pr_debug("crashkernel default size can not be used.\n");
> > +		return -EINVAL;
> 
> In other words,
> 
> 	if (system_ram <= CONFIG_CRASHKERNEL_DEFAULT_MB ||
> 	    system_ram < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB)
> 		fail;
> 
> yes?
> 
> How come?  What's happening here?  Perhaps a (good) explanatory comment
> is needed.  And clearer Kconfig text.
> 
> All confused :(

Andrew, I tuned it a bit, removed the check of sz >= system_ram, so if
the size is too large and kernel can not find enough memory it will
still fail in latter code.

Is below version looks clearer?
---

This is a rework of the crashkernel=auto patches back to 2009 although
I'm not sure if below is the last version of the old effort:
https://lkml.org/lkml/2009/8/12/61
https://lwn.net/Articles/345344/

I changed the original design, instead of adding the auto reserve logic
in code, in this patch just introduce two kernel config options for
the default crashkernel value in MB and the threshold of system memory
in MB so that only reserve default when system memory is equal or
above the threshold.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
Another difference is with original design the crashkernel size scales
with system memory, according to test, large machine may need more
memory in kdump kernel because of several factors:
1. cpu numbers, because of the percpu memory allocated for cpus.
   (kdump can use nr_cpus=1 to workaround this, but some
    arches do not support nr_cpus=X for example powerpc) 
2. IO devices, large system can have a lot of io devices, although we
   can try to only add those device drivers we needed, it is still a
   problem because of some built-in drivers, some stacked logical devices
   eg. device mapper devices, acpi etc.  Even if only considering the
   meta data for driver model it will still be a big number eg. sysfs
   files etc.
3. The minimum memory requirement for some device drivers are big, even
   if some of them have implemented low meory profile.  It is usual to see
   10M memory use for a storage driver.
4. user space initramfs size growing.  Busybox is not usable if we need
   to add udev support and some complicate storage support.  Use dracut
   with systemd, especially networking stuff need more memory.

So probably add another kernel config option to scale the memory size
eg.  CRASHKERNEL_DEFAULT_SCALE_RATIO is also good to have,  in RHEL we
use base_value + system_mem >> (2^14) for x86.  I'm still hesatating
how to describe and add this option. Any suggestions will be appreciated.

 arch/Kconfig        |   17 +++++++++++++++++
 kernel/crash_core.c |   19 ++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

--- linux-x86.orig/arch/Kconfig
+++ linux-x86/arch/Kconfig
@@ -10,6 +10,23 @@ config KEXEC_CORE
 	select CRASH_CORE
 	bool
 
+config CRASHKERNEL_DEFAULT_THRESHOLD_MB
+	int "System memory size threshold for using CRASHKERNEL_DEFAULT_MB"
+	depends on CRASH_CORE
+	default 0
+	help
+	  CRASHKERNEL_DEFAULT_MB will be reserved for kdump if the system
+	  memory is above or equal to CRASHKERNEL_DEFAULT_THRESHOLD_MB MB.
+	  It is only effective in case no crashkernel=X parameter is used.
+
+config CRASHKERNEL_DEFAULT_MB
+	int "Default crashkernel memory size reserved for kdump"
+	depends on CRASH_CORE
+	default 0
+	help
+	  This is used as the default kdump reserved memory size in MB.
+	  crashkernel=X kernel cmdline can overwrite this value.
+
 config HAVE_IMA_KEXEC
 	bool
 
--- linux-x86.orig/kernel/crash_core.c
+++ linux-x86/kernel/crash_core.c
@@ -143,6 +143,21 @@ static int __init parse_crashkernel_simp
 	return 0;
 }
 
+static int __init get_crashkernel_default(unsigned long long system_ram,
+					  unsigned long long *size)
+{
+	unsigned long long system_ram_mb = system_ram >> 20;
+
+	if (system_ram_mb < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB) {
+		pr_debug("crashkernel: system memory size is lower than %d\n",
+			 CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB);
+		return -EINVAL;
+	}
+	*size = (unsigned long long)CONFIG_CRASHKERNEL_DEFAULT_MB << 20;
+
+	return 0;
+}
+
 #define SUFFIX_HIGH 0
 #define SUFFIX_LOW  1
 #define SUFFIX_NULL 2
@@ -240,8 +255,10 @@ static int __init __parse_crashkernel(ch
 	*crash_size = 0;
 	*crash_base = 0;
 
-	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
+	if (!strstr(cmdline, "crashkernel="))
+		return get_crashkernel_default(system_ram, crash_size);
 
+	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
 	if (!ck_cmdline)
 		return -EINVAL;
 
