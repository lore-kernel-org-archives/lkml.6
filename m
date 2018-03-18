Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeCRPmq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:42:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeCRPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:42:43 -0400
Date: Sun, 18 Mar 2018 16:42:34 +0100 (CET)
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
        Bandan Das <bsd@redhat.com>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] x86/hyper-v: allocate and use Virtual Processor
 Assist Pages
In-Reply-To: <20180316142220.32506-5-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1803181638190.1509@nanos.tec.linutronix.de>
References: <20180316142220.32506-1-vkuznets@redhat.com> <20180316142220.32506-5-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Vitaly Kuznetsov wrote:
>  static int hv_cpu_init(unsigned int cpu)
> @@ -101,6 +104,23 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (msr_vp_index > hv_max_vp_index)
>  		hv_max_vp_index = msr_vp_index;
>  
> +	if (!hv_vp_assist_page)
> +		return 0;
> +
> +	if (!hv_vp_assist_page[smp_processor_id()])
> +		hv_vp_assist_page[smp_processor_id()] =
> +			__vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);

Please avoid the ugly line break which makes the statement appear as
multiline - which would require curly braces for readability - and simply
have a local variable

	struct hv_vp_assist_page **hvp = hv_vp_assist_page[smp_processor_id()];

and use that throughout the function.
     
> +	if (hv_vp_assist_page[smp_processor_id()]) {
> +		u64 val;
> +
> +		val = vmalloc_to_pfn(hv_vp_assist_page[smp_processor_id()]);
> +		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> +			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
> +
> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +	}
> +
>  	return 0;

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
