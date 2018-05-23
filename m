Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbeEWPyW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:54:22 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54393 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeEWPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:54:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Young <dyoung@redhat.com>
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
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
        <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
        <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
Date: Wed, 23 May 2018 10:53:55 -0500
In-Reply-To: <20180523070641.GA1689@dhcp-128-65.nay.redhat.com> (Dave Young's
        message of "Wed, 23 May 2018 15:06:41 +0800")
Message-ID: <877enucqr0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLW5T-0003oi-Uf;;;mid=<877enucqr0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+II67YpHvKG4PtURWk/hVIGkP7P537KOw=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dave Young <dyoung@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 463 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 7 (1.5%), b_tie_ro: 5 (1.2%), parse: 1.67 (0.4%),
        extract_message_metadata: 28 (6.0%), get_uri_detail_list: 6 (1.4%),
        tests_pri_-1000: 12 (2.6%), tests_pri_-950: 1.58 (0.3%), tests_pri_-900: 1.30
        (0.3%), tests_pri_-400: 38 (8.2%), check_bayes: 37 (7.9%), b_tokenize: 16
        (3.5%), b_tok_get_all: 10 (2.2%), b_comp_prob: 3.4 (0.7%), b_tok_touch_all:
        4.1 (0.9%), b_finish: 0.69 (0.1%), tests_pri_0: 363 (78.4%),
        check_dkim_signature: 0.64 (0.1%), check_dkim_adsp: 3.6 (0.8%),
        tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config options
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Young <dyoung@redhat.com> writes:

> [snip]
>
>> >  
>> > +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
>> > +	int "System memory size threshold for kdump memory default reserving"
>> > +	depends on CRASH_CORE
>> > +	default 0
>> > +	help
>> > +	  CRASHKERNEL_DEFAULT_MB is used as default crashkernel value if
>> > +	  the system memory size is equal or bigger than the threshold.
>> 
>> "the threshold" is rather vague.  Can it be clarified?
>> 
>> In fact I'm really struggling to understand the logic here....
>> 
>> 
>> > +config CRASHKERNEL_DEFAULT_MB
>> > +	int "Default crashkernel memory size reserved for kdump"
>> > +	depends on CRASH_CORE
>> > +	default 0
>> > +	help
>> > +	  This is used as the default kdump reserved memory size in MB.
>> > +	  crashkernel=X kernel cmdline can overwrite this value.
>> > +
>> >  config HAVE_IMA_KEXEC
>> >  	bool
>> >  
>> > @@ -143,6 +144,24 @@ static int __init parse_crashkernel_simp
>> >  	return 0;
>> >  }
>> >  
>> > +static int __init get_crashkernel_default(unsigned long long system_ram,
>> > +					  unsigned long long *size)
>> > +{
>> > +	unsigned long long sz = CONFIG_CRASHKERNEL_DEFAULT_MB;
>> > +	unsigned long long thres = CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB;
>> > +
>> > +	thres *= SZ_1M;
>> > +	sz *= SZ_1M;
>> > +
>> > +	if (sz >= system_ram || system_ram < thres) {
>> > +		pr_debug("crashkernel default size can not be used.\n");
>> > +		return -EINVAL;
>> 
>> In other words,
>> 
>> 	if (system_ram <= CONFIG_CRASHKERNEL_DEFAULT_MB ||
>> 	    system_ram < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB)
>> 		fail;
>> 
>> yes?
>> 
>> How come?  What's happening here?  Perhaps a (good) explanatory comment
>> is needed.  And clearer Kconfig text.
>> 
>> All confused :(
>
> Andrew, I tuned it a bit, removed the check of sz >= system_ram, so if
> the size is too large and kernel can not find enough memory it will
> still fail in latter code.
>
> Is below version looks clearer?

What is the advantage of providing this in a kconfig option rather
than on the kernel command line as we can now?

Eric

> ---
>
> This is a rework of the crashkernel=auto patches back to 2009 although
> I'm not sure if below is the last version of the old effort:
> https://lkml.org/lkml/2009/8/12/61
> https://lwn.net/Articles/345344/
>
> I changed the original design, instead of adding the auto reserve logic
> in code, in this patch just introduce two kernel config options for
> the default crashkernel value in MB and the threshold of system memory
> in MB so that only reserve default when system memory is equal or
> above the threshold.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
> Another difference is with original design the crashkernel size scales
> with system memory, according to test, large machine may need more
> memory in kdump kernel because of several factors:
> 1. cpu numbers, because of the percpu memory allocated for cpus.
>    (kdump can use nr_cpus=1 to workaround this, but some
>     arches do not support nr_cpus=X for example powerpc) 
> 2. IO devices, large system can have a lot of io devices, although we
>    can try to only add those device drivers we needed, it is still a
>    problem because of some built-in drivers, some stacked logical devices
>    eg. device mapper devices, acpi etc.  Even if only considering the
>    meta data for driver model it will still be a big number eg. sysfs
>    files etc.
> 3. The minimum memory requirement for some device drivers are big, even
>    if some of them have implemented low meory profile.  It is usual to see
>    10M memory use for a storage driver.
> 4. user space initramfs size growing.  Busybox is not usable if we need
>    to add udev support and some complicate storage support.  Use dracut
>    with systemd, especially networking stuff need more memory.
>
> So probably add another kernel config option to scale the memory size
> eg.  CRASHKERNEL_DEFAULT_SCALE_RATIO is also good to have,  in RHEL we
> use base_value + system_mem >> (2^14) for x86.  I'm still hesatating
> how to describe and add this option. Any suggestions will be appreciated.
>
>  arch/Kconfig        |   17 +++++++++++++++++
>  kernel/crash_core.c |   19 ++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> --- linux-x86.orig/arch/Kconfig
> +++ linux-x86/arch/Kconfig
> @@ -10,6 +10,23 @@ config KEXEC_CORE
>  	select CRASH_CORE
>  	bool
>  
> +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
> +	int "System memory size threshold for using CRASHKERNEL_DEFAULT_MB"
> +	depends on CRASH_CORE
> +	default 0
> +	help
> +	  CRASHKERNEL_DEFAULT_MB will be reserved for kdump if the system
> +	  memory is above or equal to CRASHKERNEL_DEFAULT_THRESHOLD_MB MB.
> +	  It is only effective in case no crashkernel=X parameter is used.
> +
> +config CRASHKERNEL_DEFAULT_MB
> +	int "Default crashkernel memory size reserved for kdump"
> +	depends on CRASH_CORE
> +	default 0
> +	help
> +	  This is used as the default kdump reserved memory size in MB.
> +	  crashkernel=X kernel cmdline can overwrite this value.
> +
>  config HAVE_IMA_KEXEC
>  	bool
>  
> --- linux-x86.orig/kernel/crash_core.c
> +++ linux-x86/kernel/crash_core.c
> @@ -143,6 +143,21 @@ static int __init parse_crashkernel_simp
>  	return 0;
>  }
>  
> +static int __init get_crashkernel_default(unsigned long long system_ram,
> +					  unsigned long long *size)
> +{
> +	unsigned long long system_ram_mb = system_ram >> 20;
> +
> +	if (system_ram_mb < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB) {
> +		pr_debug("crashkernel: system memory size is lower than %d\n",
> +			 CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB);
> +		return -EINVAL;
> +	}
> +	*size = (unsigned long long)CONFIG_CRASHKERNEL_DEFAULT_MB << 20;
> +
> +	return 0;
> +}
> +
>  #define SUFFIX_HIGH 0
>  #define SUFFIX_LOW  1
>  #define SUFFIX_NULL 2
> @@ -240,8 +255,10 @@ static int __init __parse_crashkernel(ch
>  	*crash_size = 0;
>  	*crash_base = 0;
>  
> -	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
> +	if (!strstr(cmdline, "crashkernel="))
> +		return get_crashkernel_default(system_ram, crash_size);
>  
> +	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
>  	if (!ck_cmdline)
>  		return -EINVAL;
>  
