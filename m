Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934739AbeBMQVG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:21:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933927AbeBMQVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:21:04 -0500
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting
 MSR-based features
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <45f3c26d-9580-7336-6c74-a0c1cd1e8963@redhat.com>
Date: Tue, 13 Feb 2018 17:21:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 23:58, Tom Lendacky wrote:
> Provide a new KVM capability that allows bits within MSRs to be recognized
> as features.  Two new ioctls are added to the VM ioctl routine to retrieve
> the list of these MSRs and their values. The MSR features can optionally
> be exposed based on a CPU and/or a CPU feature.

Yes, pretty much.  Just two changes:

> +struct kvm_msr_based_features {
> +	u32 msr;			/* MSR to query */
> +	u64 mask;			/* MSR mask */
> +	const struct x86_cpu_id *match;	/* Match criteria */
> +	u64 value;			/* MSR value */

1) These two should be replaced by a kvm_x86_ops callback, because
computing the value is sometimes a bit more complicated than just rdmsr
(for example, MSRs for VMX capabilities depend on the kvm_intel.ko
module parameters).


> +	case KVM_CAP_GET_MSR_FEATURES:

This should be KVM_GET_MSR.

> +		r = msr_io(NULL, argp, do_get_msr_features, 1);
> +		break;


Bonus points for writing documentation :) and for moving the MSR
handling code to arch/x86/kvm/msr.{c,h}.

Thanks,

Paolo
