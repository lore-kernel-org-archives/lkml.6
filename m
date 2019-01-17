Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6034A206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAQANP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:13:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:2994 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbfAQANP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:13:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 16:13:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="115253174"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2019 16:13:14 -0800
Date:   Wed, 16 Jan 2019 16:07:31 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 3/3] x86/umwait: Control umwait maximum time
Message-ID: <20190117000731.GA226938@romley-ivt3.sc.intel.com>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrVenEpKH5O=Z6J+faWTcdZpa1xx4-dYwdWu1OSEDyiUWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVenEpKH5O=Z6J+faWTcdZpa1xx4-dYwdWu1OSEDyiUWw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:00:29PM -0800, Andy Lutomirski wrote:
> On Wed, Jan 16, 2019 at 1:24 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
> > that processor can stay in C0.1 or C0.2.
> >
> > The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which
> > means there is no global time limit for UMWAIT and TPAUSE instructions.
> > Each process sets its own umwait maximum time as the instructions operand.
> >
> > User can specify global umwait maximum time through interface:
> > /sys/devices/system/cpu/umwait_control/umwait_max_time
> > The value in the interface is in decimal in TSC-quanta. Bits[1:0]
> > are cleared when the value is stored.
> >
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >  arch/x86/include/asm/msr-index.h |  2 ++
> >  arch/x86/power/umwait.c          | 42 +++++++++++++++++++++++++++++++-
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index b56bfecae0de..42b9104fc15b 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -62,6 +62,8 @@
> >  #define MSR_IA32_UMWAIT_CONTROL                0xe1
> >  #define UMWAIT_CONTROL_C02_BIT         0x0
> >  #define UMWAIT_CONTROL_C02_MASK                0x00000001
> > +#define UMWAIT_CONTROL_MAX_TIME_BIT    0x2
> > +#define UMWAIT_CONTROL_MAX_TIME_MASK   0xfffffffc
> >
> >  #define MSR_PKG_CST_CONFIG_CONTROL     0x000000e2
> >  #define NHM_C3_AUTO_DEMOTE             (1UL << 25)
> > diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
> > index 95b3867aac1e..4a1a507d3bb7 100644
> > --- a/arch/x86/power/umwait.c
> > +++ b/arch/x86/power/umwait.c
> > @@ -10,6 +10,7 @@
> >  #include <asm/msr.h>
> >
> >  static int umwait_enable_c0_2 = 1; /* 0: disable C0.2. 1: enable C0.2. */
> > +static u32 umwait_max_time; /* In TSC-quanta. Only bits [31:2] are used. */
> >  static DEFINE_MUTEX(umwait_lock);
> >
> >  /* Return value that will be used to set umwait control MSR */
> > @@ -20,7 +21,8 @@ static inline u32 umwait_control_val(void)
> >          * When bit 0 is 1, C0.2 is disabled. Otherwise, C0.2 is enabled.
> >          * So value in bit 0 is opposite of umwait_enable_c0_2.
> >          */
> > -       return ~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK;
> > +       return (~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK) |
> > +              umwait_max_time;
> >  }
> >
> >  static ssize_t umwait_enable_c0_2_show(struct device *dev,
> > @@ -61,8 +63,46 @@ static ssize_t umwait_enable_c0_2_store(struct device *dev,
> >
> >  static DEVICE_ATTR_RW(umwait_enable_c0_2);
> >
> > +static ssize_t umwait_max_time_show(struct device *kobj,
> > +                                   struct device_attribute *attr, char *buf)
> > +{
> > +       return sprintf(buf, "%u\n", umwait_max_time);
> > +}
> > +
> > +static ssize_t umwait_max_time_store(struct device *kobj,
> > +                                    struct device_attribute *attr,
> > +                                    const char *buf, size_t count)
> > +{
> > +       u32 msr_val, max_time;
> > +       int cpu, ret;
> > +
> > +       ret = kstrtou32(buf, 10, &max_time);
> > +       if (ret)
> > +               return ret;
> > +
> > +       mutex_lock(&umwait_lock);
> > +
> > +       /* Only get max time value from bits [31:2] */
> > +       max_time &= UMWAIT_CONTROL_MAX_TIME_MASK;
> > +       /* Update the max time value in memory */
> > +       umwait_max_time = max_time;
> > +       msr_val = umwait_control_val();
> > +       get_online_cpus();
> > +       /* All CPUs have same umwait max time */
> > +       for_each_online_cpu(cpu)
> > +               wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
> > +       put_online_cpus();
> > +
> > +       mutex_unlock(&umwait_lock);
> > +
> > +       return count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(umwait_max_time);
> > +
> >  static struct attribute *umwait_attrs[] = {
> >         &dev_attr_umwait_enable_c0_2.attr,
> > +       &dev_attr_umwait_max_time.attr,
> >         NULL
> >  };
> 
> You need something to make sure that newly onlined CPUs get the right
> value in the MSR.

Onlined CPU takes the umwait_control value in umwait_cpu_online() in
patch 2. Please check if it's correct.

> You also need to make sure you restore it on resume
> from suspend.  Something like cpu_init() might be the right place.
> 
> Also, as previously discussed, I think we should set the default to
> something quite small, maybe 100 microseconds.  IMO the goal is to
> pick a value that is a high enough multiple of the C0.2 entry+exit
> latency that we get most of the power and SMT resource savings while
> being small enough that no one things that UMWAIT is more than a
> glorified, slightly improved, and far more misleading version of REP
> NOP.
> 
> Andrew, would having Linux default to a small value do much to
> mitigate your concerns that UMWAIT is problematic for hypervisors?
> 
> Also, can someone who understands the hardware clarify just how
> dangerous UMWAIT is from a perspective of making speculation attacks
> more dangerous than they already are?  I'm wondering what events will
> wake up a UMONITOR.  I bet that CLFLUSH does.  I wonder if a faulting
> write to a read-only page also does.  Or a load from a remote node.
> Or a speculative store that does not subsequently retire.  This
> instruction seems quite delightful as a tool to create a
> highish-bandwidth covert channel, and it's possibly quite nice to
> agument Spectre-like attacks.  If it ends up being bad enough, we
> might need to set the default timeout to the absolute minimum value
> and possibly ask Intel to give us a way to turn it off entirely.

If CR4.TSD=1 and CPL>0, umwait and tpause generate #GP. So if user thinks
the instructions are dangerous, he can disable TSC.

Is this the right handling for security concerns?

Thanks.

-Fenghua
