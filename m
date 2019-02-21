Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11522077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfBUTbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:31:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:4720 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfBUTbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:31:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 11:31:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,396,1544515200"; 
   d="scan'208";a="135335881"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2019 11:31:01 -0800
Date:   Thu, 21 Feb 2019 11:24:24 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tao Xu <tao3.xu@intel.com>, jingqi.liu@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait instructions
Message-ID: <20190221192424.GA158428@romley-ivt3.sc.intel.com>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-6-git-send-email-fenghua.yu@intel.com>
 <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:37:27PM -0800, Andy Lutomirski wrote:
> On Wed, Feb 20, 2019 at 7:44 PM Tao Xu <tao3.xu@intel.com> wrote:
> >
> > From: Fenghua Yu <fenghua.yu@intel.com>
> 
> >
> > From patchwork Wed Jan 16 21:18:41 2019
> > Content-Type: text/plain; charset="utf-8"
> 
> [snipped more stuff like this]
> 
> What happened here?

I don't know either:(

Tao never talked to me before he sent out this patch set. And the email
format is totally wrong and he didn't change any code in this patch set.

I have no idea why he sent out this patch set. As of now I haven't got
any response from him yet.

I believe he made a mistake here.

> 
> > +/* Return value that will be used to set umwait control MSR */
> > +static inline u32 umwait_control_val(void)
> > +{
> > +       /*
> > +        * Enable or disable C0.2 (bit 0) based on global setting on all CPUs.
> > +        * When bit 0 is 1, C0.2 is disabled. Otherwise, C0.2 is enabled.
> > +        * So value in bit 0 is opposite of umwait_enable_c0_2.
> > +        */
> > +       return ~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK;
> > +}
> 
> This function is horribly named.  How about something like
> umwait_compute_msr_value() or something liek that?
OK. Will change the name.

> Also, what
> happened to the maximum wait time?
> 
> > +
> > +static ssize_t umwait_enable_c0_2_show(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      char *buf)
> > +{
> > +       return sprintf(buf, "%d\n", umwait_enable_c0_2);
> 
> I realize that it's traditional to totally ignore races in sysfs and
> such, but it's a bad tradition.  Please either READ_ONCE it with a
> comment or take the mutex.

Will change to READ_ONCE.

> 
> > +static ssize_t umwait_enable_c0_2_store(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       const char *buf, size_t count)
> > +{
> > +       int enable_c0_2, cpu, ret;
> > +       u32 msr_val;
> > +
> > +       ret = kstrtou32(buf, 10, &enable_c0_2);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (enable_c0_2 != 1 && enable_c0_2 != 0)
> > +               return -EINVAL;
> 
> How about if (enable_c0_2 > 1)?
Ok. Will change to this.

> 
> > +
> > +       mutex_lock(&umwait_lock);
> > +
> > +       umwait_enable_c0_2 = enable_c0_2;
> > +       msr_val = umwait_control_val();
> > +       get_online_cpus();
> > +       /* All CPUs have same umwait control setting */
> > +       for_each_online_cpu(cpu)
> > +               wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
> > +       put_online_cpus();
> > +
> > +       mutex_unlock(&umwait_lock);
> 
> Please factor this thing out into a helper like
> umwait_update_all_cpus().  That helper can assert that the lock is
> held.
Ok.

> 
> > +/* Set up umwait control MSR on this CPU using the current global setting. */
> > +static int umwait_cpu_online(unsigned int cpu)
> > +{
> > +       u32 msr_val;
> > +
> > +       mutex_lock(&umwait_lock);
> > +
> > +       msr_val = umwait_control_val();
> > +       wrmsr(MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
> > +
> > +       mutex_unlock(&umwait_lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __init umwait_init(void)
> > +{
> > +       struct device *dev;
> > +       int ret;
> > +
> > +       if (!boot_cpu_has(X86_FEATURE_WAITPKG))
> > +               return -ENODEV;
> > +
> > +       /* Add CPU global user wait interface to control umwait. */
> > +       dev = cpu_subsys.dev_root;
> > +       ret = sysfs_create_group(&dev->kobj, &umwait_attr_group);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait/intel:online",
> > +                               umwait_cpu_online, NULL);
> 
> This hotplug notifier thing is awful.  Thomas, do we have a function
> that gets called every time a CPU is brought up (via BSP boot, AP
> boot, hotplug, hibernation resume, etc) where we can just put all
> these things?  cpu_init() is almost appropriate, except that it's
> called at somewhat erratic times (quite different for BSP and AP IIRC)
> and it's not called AFAICT during hibernation restore.  I suppose we
> could add a new thing that is called by cpu_init() and
> restore_processor_state().
> 
> Also, surely you should actually write the MSR in this function, too.
> 
> >
> >  static int umwait_enable_c0_2 = 1; /* 0: disable C0.2. 1: enable C0.2. */
> > +static u32 umwait_max_time; /* In TSC-quanta. Only bits [31:2] are used. */
> 
> I still think the default should be some reasonable nonzero value.  It
> should be long enough that we get decent C0.2 residency and short
> enough that UMWAIT never gives the impression that it is anything
> other than a fancy way to save a bit of power and SMT resources when
> spinning.  I don't want to see a situation where some library uses
> UMWAIT under the expectation that it genuinely waits for an event,
> appears to work well on bare metal on an otherwise idle system, and
> falls apart when it's run in a VM guest or with other software
> running.  IOW, programs more or less must be written to expect many
> spurious wakeups, so I think we should pick a default value so that
> there are essentially always many spurious wakeups.
> 
> As a guess, I think that the default wait time should be well under 1
> ms but at least 20x the C0.2 entry+exit latency.

It's hard to agree on a global maximum wait time value as we discussed
before:
1. Andrew doesn't like the short wait time value
2. C0.1/C0.2 entry/exit latency is hardware implementation specific and
may vary from platform to platform. My measurement on one machine is
about hundreds of cycles. It's hard to justify why 1ms or any value is
right value on one machine. Or simply set it as 1ms (converted to tsc).

Or to simplify the situation, how about we still use zero as global max wait
time (i.e. no limitation for global wait time) as implemented in this
patch set? User can still change the value to any value based on their
usage. Isn't this a right way to take care of any usage?

Thanks.

-Fenghua
