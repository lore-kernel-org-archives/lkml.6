Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDRIW0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:22:26 -0400
Received: from zxshcas1.zhaoxin.com ([180.169.121.91]:31419 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752927AbeDRIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:22:24 -0400
From: David Wang <davidwang@zhaoxin.com>
To: "'Thomas Gleixner'" <tglx@linutronix.de>
CC: <mingo@redhat.com>, <hpa@zytor.com>, <mingo@kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>
Subject: Re: [PATCH] x86/centaur: report correct CPU/cache topology
Date: Wed, 18 Apr 2018 16:21:48 +0800
Message-ID: <000001d3d6ee$4bfc9000$e3f5b000$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPW7erdIYHYcKndRkWw0z4fCzKc0g==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Mail-----
> Sender: Thomas Gleixner [mailto:tglx@linutronix.de]
> Time : 2018/4/17 18:16
> Receiver: David Wang <davidwang@zhaoxin.com>
> CC: mingo@redhat.com; hpa@zytor.com; mingo@kernel.org;
> x86@kernel.org; linux-kernel@vger.kernel.org; brucechang@via-
> alliance.com; cooperyan@zhaoxin.com; qiyuanwang@zhaoxin.com;
> benjaminpan@viatech.com; lukelin@viacpu.com; timguo@zhaoxin.com
> Subject: Re: [PATCH] x86/centaur: report correct CPU/cache topology
> 
> On Wed, 4 Apr 2018, David Wang wrote:
> 
> > This patch is used to support multi-core Centaur CPU. After using this
> > patch, we can get correct CPU topology and correct cache topology.
> 
> David. This changelog is pretty useless. First of all, please do not use
'This
> patch ..'. We all know already that this is a patch.
> Documentation/process/submitting-patches.rst has a good explanation
> about writing changelogs.
> 
> The changelog should explain why it does something. Let me give you an
> example:
> 
>   Centaur CPUs enumerate the cache topology in the same way as Intel CPUs,
>   but the functionality is unused so far. The Centaur init code also
misses
>   to initialize x86_cpuinfo::max_cores so the CPU topology cannot be
>   desribed correctly,
> 
>   Initialize x86_cpuinfo::max_cores and invoke init_intel_cacheinfo() to
>   make CPU and cache topology information available and correct.
> 
> See? I'm neither using 'this patch' nor 'We/I' as I'm not impersonatimg
the
> code. It's all factual instead.
> > Signed-off-by: David Wang <davidwang@zhaoxin.com>
> > ---
> >  arch/x86/kernel/cpu/centaur.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/centaur.c
> > b/arch/x86/kernel/cpu/centaur.c index e5ec0f1..713e4db 100644
> > --- a/arch/x86/kernel/cpu/centaur.c
> > +++ b/arch/x86/kernel/cpu/centaur.c
> > @@ -112,6 +112,19 @@ static void early_init_centaur(struct cpuinfo_x86
> *c)
> >  	}
> >  }
> >
> > +static int centaur_num_cpu_cores(struct cpuinfo_x86 *c) {
> > +	unsigned int eax, ebx, ecx, edx;
> > +
> > +	if (c->cpuid_level < 4)
> > +		return 1;
> > +	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
> > +	if (eax & 0x1f)
> > +		return (eax >> 26) + 1;
> > +	else
> > +		return 1;
> 
> This is a bad copy of intel_num_cpu_cores(). See for the subtle
difference.
> Please rename the intel function and move it to common.c
> 
> >  static void init_centaur(struct cpuinfo_x86 *c)  {  #ifdef
> > CONFIG_X86_32 @@ -128,6 +141,13 @@ static void init_centaur(struct
> > cpuinfo_x86 *c)
> >  	clear_cpu_cap(c, 0*32+31);
> >  #endif
> >  	early_init_centaur(c);
> > +
> > +	init_intel_cacheinfo(c);
> > +	c->x86_max_cores = centaur_num_cpu_cores(c); #ifdef
> CONFIG_X86_32
> > +	detect_ht(c);
> > +#endif
> 
> Can you please create a stub inline of detect_ht() for the !32bit case and
get
> rid of these #ifdefs in the code. That wants to be a separate patch which
also
> cleans up the existing call sites.
> 
> Thanks,
> 
> 	tglx

I will send patch v2 to solve all problems you listed.
Thanks,
---
David
