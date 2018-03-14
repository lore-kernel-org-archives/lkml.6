Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCNPQG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:16:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51506 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCNPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:16:03 -0400
Date: Wed, 14 Mar 2018 16:15:58 +0100 (CET)
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
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor
 Assist Pages
In-Reply-To: <20180309140249.2840-5-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1803141611300.2481@nanos.tec.linutronix.de>
References: <20180309140249.2840-1-vkuznets@redhat.com> <20180309140249.2840-5-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:
> @@ -198,6 +218,12 @@ static int hv_cpu_die(unsigned int cpu)
>  	struct hv_reenlightenment_control re_ctrl;
>  	unsigned int new_cpu;
>  
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +		vfree(hv_vp_assist_page[cpu]);
> +		hv_vp_assist_page[cpu] = NULL;

So this is freed before the CPU is actually dead. And this runs in
preemtible context. Is the wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0); enough to
prevent eventual users of the assist page on the outgoing CPU from
accessing it?

>  	if (hv_reenlightenment_cb == NULL)
>  		return 0;
>  
> @@ -241,6 +267,13 @@ void hyperv_init(void)
>  	if (!hv_vp_index)
>  		return;
>  
> +	hv_vp_assist_page = kcalloc(num_possible_cpus(),
> +				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
> +	if (!hv_vp_assist_page) {
> +		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> +		return;
> +	}
> +
>  	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
>  			      hv_cpu_init, hv_cpu_die) < 0)
>  		goto free_vp_index;

Shouldn't you free hv_vp_assist_page in the error path?

> +extern struct hv_vp_assist_page **hv_vp_assist_page;
> +
> +static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
> +{
> +	return hv_vp_assist_page[cpu];

Shouldn't that check hv_vp_assist_page != NULL?

Thanks,

	tglx
