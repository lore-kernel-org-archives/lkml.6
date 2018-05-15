Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEOLLS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:11:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752059AbeEOLLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:11:16 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC v2 3/5] KVM: nVMX: add enlightened VMCS state
References: <20180511133751.13414-1-vkuznets@redhat.com>
        <20180511133751.13414-4-vkuznets@redhat.com>
        <a4277986-1633-c39c-43a6-b056ae489230@redhat.com>
Date: Tue, 15 May 2018 13:11:13 +0200
In-Reply-To: <a4277986-1633-c39c-43a6-b056ae489230@redhat.com> (Paolo
        Bonzini's message of "Mon, 14 May 2018 18:22:29 +0200")
Message-ID: <87zi11jhri.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/05/2018 15:37, Vitaly Kuznetsov wrote:
>> -	if (enable_shadow_vmcs)
>> -		to_vmx(vcpu)->nested.sync_shadow_vmcs = true;
>> +
>> +	if (vmx->nested.hv_evmcs)
>> +		vmx->nested.sync_enlightened_vmcs = true;
>> +	else if (enable_shadow_vmcs)
>> +		vmx->nested.sync_shadow_vmcs = true;
>>  }
>
> These four lines are a bit repeated.  Perhaps change them to
>
> 	if (enable_shadow_vmcs || vmx->nested.hv_evmcs)
> 		vmx->nested.need_vmcs12_sync = true;
>
> and elsewhere
>
> 	if (vmx->nested.need_vmcs12_sync) {
> 	       if (vmx->nested.hv_evmcs) {
> 	               copy_vmcs12_to_enlightened(vmx);
> 	               /* All fields are clean */
> 	               vmx->nested.hv_evmcs->hv_clean_fields |=
> 				HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
> 			vmx->nested.sync_enlightened_vmcs = false;
> 		} else {
> 	                copy_vmcs12_to_shadow(vmx);
> 		}
> 		vmx->nested.need_vmcs12_sync = false;
> 	}
>
> ?

True, we always know which VMCS we currently use so we can use a single
flag. Will do, thanks!

-- 
  Vitaly
