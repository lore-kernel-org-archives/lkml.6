Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F291021850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfBZUsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:48:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:45302 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBZUsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:48:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 12:48:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,416,1544515200"; 
   d="scan'208";a="137421991"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2019 12:48:41 -0800
Date:   Tue, 26 Feb 2019 12:41:56 -0800
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
Message-ID: <20190226204156.GB192131@romley-ivt3.sc.intel.com>
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
> umwait_compute_msr_value() or something liek that?  Also, what
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

Seems the current patch set misses pm_notifier for hibernation on BSP.
All APs are all updated by the online funciton in the current patch set.
If adding hiberation pm_notifier to update MSR 0xe1 on BSP, is that good
enough?

Thanks.

-Fenghua
