Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeA3NVf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:21:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeA3NVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:21:33 -0500
Subject: Re: [9/8] KVM: x86: limit MSR_IA32_SPEC_CTRL access based on CPUID
 availability
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: rkrcmar@redhat.com, liran.alon@oracle.com, jmattson@google.com,
        aliguori@amazon.com, thomas.lendacky@amd.com, dwmw@amazon.co.uk,
        bp@alien8.de, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20180109120311.27565-10-pbonzini@redhat.com>
From: Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <6dc02278-7004-1794-3705-69c8cad86be4@oracle.com>
Date: Tue, 30 Jan 2018 15:21:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180109120311.27565-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8789 signatures=668655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=809
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801300169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paolo,

I've back ported this patch on 4.1, after adding the per-vcpu MSR 
bitmap. Also enabled the SPEC_CTRL_MSR intercept if qemu instructed so [1].

Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>

[1]
+++ b/arch/x86/kvm/vmx.c
@@ -8391,6 +8391,16 @@ static struct kvm_vcpu *vmx_create_vcpu(struct 
kvm *kvm, unsigned int id)
         vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PRED_CMD, 
MSR_TYPE_R | MSR_TYPE_W);
         vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_BNDCFGS, 
MSR_TYPE_R | MSR_TYPE_W);

+       /*
+        * If the physical CPU or the vCPU of this VM doesn't
+        * support SPEC_CTRL feature, catch each access to it.
+        */
+       if (!static_cpu_has(X86_FEATURE_SPEC_CTRL) ||
+            !guest_cpuid_has_spec_ctrl(&vmx->vcpu))
+               vmx_enable_intercept_for_msr(
+                       msr_bitmap,
+                       MSR_IA32_SPEC_CTRL,
+                       MSR_TYPE_R | MSR_TYPE_W);

         /*
          * If PML is turned on, failure on enabling PML just results in 
failure


On 09.01.2018 14:03, Paolo Bonzini wrote:
> MSR_IA32_SPEC_CTRL is not available unless CPU[7,0].EDX[26] is 1.
> Check that against host CPUID or guest CPUID, respectively for
> host-initiated and guest-initiated accesses.
> 
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	This is for after X86_FEATURE_SPEC_CTRL is added to Linux, but
> 	I still wanted to ack Jim's improvement.
> 
>   arch/x86/kvm/svm.c | 8 ++++++++
>   arch/x86/kvm/vmx.c | 8 ++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 97126c2bd663..3a646580d7c5 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -3648,6 +3648,10 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		msr_info->data = svm->nested.vm_cr_msr;
>   		break;
>   	case MSR_IA32_SPEC_CTRL:
> +		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL) ||
> +	    	    (!msr_info->host_initiated &&
> +       		     !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL)))
> +			return 1;
>   		msr_info->data = svm->spec_ctrl;
>   		break;
>   	case MSR_IA32_UCODE_REV:
> @@ -3806,6 +3810,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>   		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
>   		break;
>   	case MSR_IA32_SPEC_CTRL:
> +		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL) ||
> +	    	    (!msr_info->host_initiated &&
> +       		     !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL)))
> +			return 1;
>   		svm->spec_ctrl = data;
>   		break;
>   	case MSR_IA32_APICBASE:
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 49b4a2d61603..42bc7ee293e4 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -3368,6 +3368,10 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		msr_info->data = guest_read_tsc(vcpu);
>   		break;
>   	case MSR_IA32_SPEC_CTRL:
> +		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL) ||
> +		    (!msr_info->host_initiated &&
> +		     !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL)))
> +			return 1;
>   		msr_info->data = to_vmx(vcpu)->spec_ctrl;
>   		break;
>   	case MSR_IA32_SYSENTER_CS:
> @@ -3510,6 +3514,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		kvm_write_tsc(vcpu, msr_info);
>   		break;
>   	case MSR_IA32_SPEC_CTRL:
> +		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL) ||
> +		    (!msr_info->host_initiated &&
> +		     !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL)))
> +			return 1;
>   		to_vmx(vcpu)->spec_ctrl = data;
>   		break;
>   	case MSR_IA32_CR_PAT:
> 
