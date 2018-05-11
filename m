Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeEKPpc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:45:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34642 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeEKPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:45:29 -0400
Date: Fri, 11 May 2018 11:44:58 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Allow I/O port 0x80 bypass when userspace
 prefer
Message-ID: <20180511154458.GI27459@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <1523943962-25415-4-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523943962-25415-4-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8890 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4BFjaXX021245

On Mon, Apr 16, 2018 at 10:46:02PM -0700, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Tim Shearer reported that "There is a guest which is running a packet 
> forwarding app based on the DPDK (dpdk.org). The packet receive routine 
> writes to 0xc070 using glibc's "outw_p" function which does an additional 
> write to I/O port 80. It does this write for every packet that's received, 
> causing a flood of KVM userspace context switches". He uses mpstat to 
> observe a CPU performing L2 packet forwarding on a pinned guest vCPU, 
> the guest time is 95 percent when allowing I/O port 0x80 bypass, however, 
> it is 65.78 percent when I/O port 0x80 bypss is disabled.  
> 
> This patch allows I/O port 0x80 bypass when userspace prefer.

s/prefer/requests it/
> 

Perhaps:

Reported-by: Tim Shearer as well?

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Tim Shearer <tshearer@advaoptical.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index ebf1140..d3e5fef 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10118,6 +10118,13 @@ static int vmx_vm_init(struct kvm *kvm)
>  			goto out;
>  		memset(kvm_vmx->vmx_io_bitmap[i], 0xff, PAGE_SIZE);
>  	}
> +	if (kvm->arch.ioport_disable_intercept)	{
> +		/*
> +		 * Allow direct access to the PC debug port (it is often used for I/O
> +		 * delays, but the vmexits simply slow things down).
> +		 */
> +		clear_bit(0x80, kvm_vmx->vmx_io_bitmap[VMX_IO_BITMAP_A]);
> +	}
>  	return 0;
>  
>  out:
> -- 
> 2.7.4
> 
