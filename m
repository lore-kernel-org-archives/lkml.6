Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeBKIvh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 03:51:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeBKIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 03:51:35 -0500
MIME-Version: 1.0
Message-ID: <3bf7f0af-cfdf-4daa-8230-240e7e63f099@default>
Date: Sun, 11 Feb 2018 00:51:14 -0800 (PST)
From: Liran Alon <liran.alon@oracle.com>
To: <chao.gao@intel.com>
Cc: <mingo@redhat.com>, <x86@kernel.org>, <tglx@linutronix.de>,
        <rkrcmar@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v3] KVM: VMX: Don't halt vcpu when L1 is injecting events
 to L2
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802110116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1B8pf9u021403


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
> changes in v3:
>  - s/VECTORING_INFO_VALID_MASK/INTR_INFO_VALID_MASK
>  - Changes of subject, comments.
> 
> Changes in v2:
>  - Remove VID stuff. Only handle event injection in this patch.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index bb5b488..cf7c2fc 100644
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
> +	 * by event injection, halt vcpu.
> +	 */
> +	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
> +	    !(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))
>  		return kvm_vcpu_halt(vcpu);
>  
>  	vmx->nested.nested_run_pending = 1;
> -- 
> 1.9.1

Reviewed-by: Liran Alon <liran.alon@oracle.com>

(Paolo: I would recommend changing commit title from "KVM: VMX: ..." to "KVM: nVMX: ..."
when applying for convention. Easier to grep nVMX changes.)
