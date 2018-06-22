Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEBEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9562F24767
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9562F24767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934343AbeFVSqe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:46:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:7323 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933878AbeFVSqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:46:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 11:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="scan'208";a="61417239"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2018 11:46:31 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 22 Jun 2018 11:46:31 -0700
Received: from crsmsx102.amr.corp.intel.com (172.18.63.137) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 22 Jun 2018 11:46:31 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.79]) by
 CRSMSX102.amr.corp.intel.com ([169.254.2.58]) with mapi id 14.03.0319.002;
 Fri, 22 Jun 2018 12:46:29 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Ingo Molnar" <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/7] x86/vdso: Introduce CPU number helper functions
Thread-Topic: [PATCH v4 6/7] x86/vdso: Introduce CPU number helper functions
Thread-Index: AQHUCOybRPGJl8Bq10OSvRa4GMCSkqRsygwA///TMoI=
Date:   Fri, 22 Jun 2018 18:46:28 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BDB8A6@CRSMSX101.amr.corp.intel.com>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
 <1529536506-26237-7-git-send-email-chang.seok.bae@intel.com>,<alpine.DEB.2.21.1806221644090.2402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806221644090.2402@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.137]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 22 Jun 2018, Thomas Gleixner wrote: 
> On Wed, 20 Jun 2018, Chang S. Bae wrote:
> > CPU number initialization in vDSO is now a bit cleaned up by
> > the new helper functions. The helper functions will take
> > care of combing CPU and node number and reading each from

> s/combing/combining/ please

Will fix.

> > @@ -18,9 +18,9 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
> >       p = __getcpu();

> While we are touching this, can we please as a first step change __getcpu()
> to something else? I've tripped over this several times in the past and
> confused it with a (nonexisting) variant of get_cpu().

How about __vdso_get_cpudata()?

> >  #ifdef CONFIG_NUMA
> >       node = cpu_to_node(cpu);
> >  #endif

> While at it please get rid of the ifdeffery. If CONFIG_NUMA=n then
> cpu_to_node(cpu) resolves to (0).

Okay, will fix this.


> >
> >       if (cpu)
> > -             *cpu = p & VGETCPU_CPU_MASK;
> > +             *cpu = lsl_tscp_to_cpu(p);
> >
> >       if (node)
> > -             *node = p >> 12;
> > +             *node = lsl_tscp_to_node(p);
>
> Are these new helpers going to be used at some other place than this? If
> not, then there is really no point at all. Then just go and make this:
>
> __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
> {
>         vdso_read_cpu_and_node(cpu, node);
>         return 0;
> }

> > @@ -340,19 +340,19 @@ static void vgetcpu_cpu_init(void *arg)
> >       int cpu = smp_processor_id();
> >       struct desc_struct d = { };
> >       unsigned long node = 0;
> > +     unsigned long cpu_number = 0;
>
> That's hardly a CPU number. It's encoded CPU and node information.
>
> > +     cpu_number = make_lsl_tscp(cpu, node);
>
> So the whole thing can be reduced to:
>
>         u64 cpudata = vdso_encode_cpu_and_node(cpu, cpu_to_node(cpu));
>
> Or some other sensible function name.

Now, for these helper function renaming, I would like to check it from Andy.

Thanks, 
Chang
