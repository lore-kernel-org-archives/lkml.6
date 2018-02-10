Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeBJAbn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:31:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47786 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeBJAbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:31:41 -0500
MIME-Version: 1.0
Message-ID: <806c274d-5d9a-432a-bf04-f154be89cb7f@default>
Date: Fri, 9 Feb 2018 16:31:22 -0800 (PST)
From: Liran Alon <liran.alon@oracle.com>
To: <chao.gao@intel.com>
Cc: <mingo@redhat.com>, <x86@kernel.org>, <tglx@linutronix.de>,
        <rkrcmar@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2] x86/kvm/vmx: Don't halt vcpu when L1 is injecting
 events to L2
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802100003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1A0VrSS028207


----- chao.gao@intel.com wrote:

> Although L2 is in halt state, it will be in the active state after
> VM entry if the VM entry is vectoring according to SDM 26.6.2
> Activity
> State. Halting the vcpu here means the event won't be injected to L2
> and this decision isn't reported to L1. Thus L0 drops an event that
> should be injected to L2.
> 
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
> Changes in v2:
>  - Remove VID stuff. Only handle event injection in this patch.
> ---
>  arch/x86/kvm/vmx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index bb5b488..42f39d9 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10985,7 +10985,12 @@ static int nested_vmx_run(struct kvm_vcpu
> *vcpu, bool launch)
>  	if (ret)
>  		return ret;
>  
> -	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
> +	/*
> +	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be
> woken
> +	 * by event injection, halt vcpu for optimization.

I would remove the "for optimization." from the comment.

> +	 */
> +	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
> +	    !(vmcs12->vm_entry_intr_info_field &
> VECTORING_INFO_VALID_MASK))

VECTORING_INFO_VALID_MASK is used in KVM code against vmcs12->idt_vectoring_info_field.
I think you should use INTR_INFO_VALID_MASK to be consistent with rest of code.

>  		return kvm_vcpu_halt(vcpu);
>  
>  	vmx->nested.nested_run_pending = 1;
> -- 
> 1.9.1

In addition, commit title should be written in format of:
"KVM: VMX: Don't halt vcpu when L1 is injecting events to L2"
(Makes it easier to grep in git log).

Other than that, seems good to me. :)

Reviewed-by: Liran Alon <liran.alon@oracle.com>

Thanks,
-Liran
