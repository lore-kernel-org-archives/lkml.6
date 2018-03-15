Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCOLpK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:45:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53138 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:45:09 -0400
Date: Thu, 15 Mar 2018 12:45:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor
 Assist Pages
In-Reply-To: <87bmfpbqek.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1803151240030.1525@nanos.tec.linutronix.de>
References: <20180309140249.2840-1-vkuznets@redhat.com> <20180309140249.2840-5-vkuznets@redhat.com> <alpine.DEB.2.21.1803141611300.2481@nanos.tec.linutronix.de> <87bmfpbqek.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:
> >> @@ -198,6 +218,12 @@ static int hv_cpu_die(unsigned int cpu)
> >>  	struct hv_reenlightenment_control re_ctrl;
> >>  	unsigned int new_cpu;
> >>  
> >> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> >> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> >> +		vfree(hv_vp_assist_page[cpu]);
> >> +		hv_vp_assist_page[cpu] = NULL;
> >
> > So this is freed before the CPU is actually dead. And this runs in
> > preemtible context. Is the wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0); enough to
> > prevent eventual users of the assist page on the outgoing CPU from
> > accessing it?
> >
> 
> After we do wrmsrl() the page is no longer 'magic' so in case eventual
> users try using it they'll most likely misbehave -- so changing the
> shutdown order won't help.
> 
> The only user of these pages is currently KVM. Can we still have vCPUs
> running on the outgoing CPU at this point? If case we can we're in
> trouble and we need to somehow kick them out first.

The first thing we do in unplug is to mark the CPU inactive, but I'm not
sure whether that prevents something which was on the CPU before and
perhaps preempted or is affine to that CPU to be scheduled in
again. Peter????

Thanks,

	tglx
