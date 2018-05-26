Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755060AbeEZOtw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 10:49:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753991AbeEZOtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 10:49:51 -0400
Date: Sat, 26 May 2018 16:49:47 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] KVM: introduce kvm_make_vcpus_request_mask() API
Message-ID: <20180526144946.GF23390@flask>
References: <20180516152131.30689-1-vkuznets@redhat.com>
 <20180516152131.30689-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516152131.30689-6-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-16 17:21+0200, Vitaly Kuznetsov:
> Hyper-V style PV TLB flush hypercalls inmplementation will use this API.
> To avoid memory allocation in CONFIG_CPUMASK_OFFSTACK case add
> cpumask_var_t argument.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> -bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
> +bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
> +				 unsigned long *vcpu_bitmap, cpumask_var_t tmp)
>  {
>  	int i, cpu, me;
> -	cpumask_var_t cpus;
> -	bool called;
>  	struct kvm_vcpu *vcpu;
> -
> -	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
> +	bool called;
>  
>  	me = get_cpu();
> +

Two optimizations come to mind: First is to use for_each_set_bit instead
of kvm_for_each_vcpu to improve the sparse case.

>  	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (!test_bit(i, vcpu_bitmap))

And the second is to pass vcpu_bitmap = NULL instead of building the
bitmap with all VCPUs.  Doesn't looks too good in the end, though:

#define kvm_for_each_vcpu_bitmap(idx, vcpup, kvm, bitmap, len) \
	for (idx = (bitmap ? find_first_bit(bitmap, len) : 0); \
	     idx < len && (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
	     bitmap ? find_next_bit(bitmap, len, idx + 1) : idx++)
