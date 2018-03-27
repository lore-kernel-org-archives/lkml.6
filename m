Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC0Hnw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:43:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58552 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeC0Hnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:43:50 -0400
MIME-Version: 1.0
Message-ID: <9f084c44-d394-473f-906d-f11036dc48d9@default>
Date: Tue, 27 Mar 2018 00:43:27 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <kernellwp@gmail.com>
Cc: <rkrcmar@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <andrew.cooper3@citrix.com>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: VMX: Introduce handle_ud()
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R7htSC020032


----- kernellwp@gmail.com wrote:

> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Introduce handle_ud() to handle invalid opcode, this function will be
> 
> used by later patches.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 9bc05f5..0f99833 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -6215,6 +6215,18 @@ static int handle_machine_check(struct kvm_vcpu
> *vcpu)
>  	return 1;
>  }
>  
> +static int handle_ud(struct kvm_vcpu *vcpu)
> +{
> +	enum emulation_result er;
> +
> +	er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
> +	if (er == EMULATE_USER_EXIT)
> +		return 0;
> +	if (er != EMULATE_DONE)
> +		kvm_queue_exception(vcpu, UD_VECTOR);
> +	return 1;
> +}
> +
>  static int handle_exception(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -6233,14 +6245,8 @@ static int handle_exception(struct kvm_vcpu
> *vcpu)
>  	if (is_nmi(intr_info))
>  		return 1;  /* already handled by vmx_vcpu_run() */
>  
> -	if (is_invalid_opcode(intr_info)) {
> -		er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
> -		if (er == EMULATE_USER_EXIT)
> -			return 0;
> -		if (er != EMULATE_DONE)
> -			kvm_queue_exception(vcpu, UD_VECTOR);
> -		return 1;
> -	}
> +	if (is_invalid_opcode(intr_info))
> +		return handle_ud(vcpu);
>  
>  	error_code = 0;
>  	if (intr_info & INTR_INFO_DELIVER_CODE_MASK)
> -- 
> 2.7.4

Reviewed-By: Liran Alon <liran.alon@oracle.com>
