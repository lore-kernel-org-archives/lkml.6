Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeCOKKe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:10:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751405AbeCOKKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:10:32 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor Assist Pages
References: <20180309140249.2840-1-vkuznets@redhat.com>
        <20180309140249.2840-5-vkuznets@redhat.com>
        <alpine.DEB.2.21.1803141611300.2481@nanos.tec.linutronix.de>
Date: Thu, 15 Mar 2018 11:10:27 +0100
In-Reply-To: <alpine.DEB.2.21.1803141611300.2481@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Wed, 14 Mar 2018 16:15:58 +0100 (CET)")
Message-ID: <87bmfpbqek.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:
>> @@ -198,6 +218,12 @@ static int hv_cpu_die(unsigned int cpu)
>>  	struct hv_reenlightenment_control re_ctrl;
>>  	unsigned int new_cpu;
>>  
>> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
>> +		vfree(hv_vp_assist_page[cpu]);
>> +		hv_vp_assist_page[cpu] = NULL;
>
> So this is freed before the CPU is actually dead. And this runs in
> preemtible context. Is the wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0); enough to
> prevent eventual users of the assist page on the outgoing CPU from
> accessing it?
>

After we do wrmsrl() the page is no longer 'magic' so in case eventual
users try using it they'll most likely misbehave -- so changing the
shutdown order won't help.

The only user of these pages is currently KVM. Can we still have vCPUs
running on the outgoing CPU at this point? If case we can we're in
trouble and we need to somehow kick them out first.

>>  	if (hv_reenlightenment_cb == NULL)
>>  		return 0;
>>  
>> @@ -241,6 +267,13 @@ void hyperv_init(void)
>>  	if (!hv_vp_index)
>>  		return;
>>  
>> +	hv_vp_assist_page = kcalloc(num_possible_cpus(),
>> +				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
>> +	if (!hv_vp_assist_page) {
>> +		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>> +		return;
>> +	}
>> +
>>  	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
>>  			      hv_cpu_init, hv_cpu_die) < 0)
>>  		goto free_vp_index;
>
> Shouldn't you free hv_vp_assist_page in the error path?
>

Yep, will do.

>> +extern struct hv_vp_assist_page **hv_vp_assist_page;
>> +
>> +static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>> +{
>> +	return hv_vp_assist_page[cpu];
>
> Shouldn't that check hv_vp_assist_page != NULL?
>

Not strictly required as we clean HV_X64_ENLIGHTENED_VMCS_RECOMMENDED
above so KVM won't use it but I can add the check to make the API
better.

Thanks,

-- 
  Vitaly
