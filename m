Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbeC0EkA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:40:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC0Ej6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:39:58 -0400
Date: Tue, 27 Mar 2018 00:38:41 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 1/2] KVM: VMX: Introduce handle_ud()
Message-ID: <20180327043841.GA16974@char.us.oracle.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522116735-4861-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R4e597027819

On Mon, Mar 26, 2018 at 07:12:14PM -0700, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Introduce handle_ud() to handle invalid opcode, this function will be 
> used by later patches.
> 
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
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
> @@ -6215,6 +6215,18 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
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
> @@ -6233,14 +6245,8 @@ static int handle_exception(struct kvm_vcpu *vcpu)
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
> 
