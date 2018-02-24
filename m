Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeBXATk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:19:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751455AbeBXATi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:19:38 -0500
Subject: Re: [PATCH] KVM: SVM: no need to call access_ok() in LAUNCH_MEASURE
 command
To: Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
References: <20180223183650.92983-1-brijesh.singh@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22ea04d1-52f0-fba8-1a34-6d4f6468d4ef@redhat.com>
Date: Sat, 24 Feb 2018 01:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223183650.92983-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2018 19:36, Brijesh Singh wrote:
> Using the access_ok() to validate the input before issuing the SEV
> command does not buy us anything in this case. If userland is
> giving us a garbage pointer then copy_to_user() will catch it when we try
> to return the measurement.
> 
> Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
> Fixes: 0d0736f76347 (KVM: SVM: Add support for KVM_SEV_LAUNCH_MEASURE ...)
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
> 
> We no longer need patch [1]. This patch implements Al Viro's recommendation [2]
> 
> [1] https://marc.info/?l=linux-kernel&m=151905677729098&w=2.
> [2] https://marc.info/?l=linux-kernel&m=151923536116467&w=2
> 
>  arch/x86/kvm/svm.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b3e488a74828..ca69d53d7e6d 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6236,16 +6236,18 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  {
> +	void __user *measure = (void __user *)(uintptr_t)argp->data;
>  	struct kvm_sev_info *sev = &kvm->arch.sev_info;
>  	struct sev_data_launch_measure *data;
>  	struct kvm_sev_launch_measure params;
> +	void __user *p = NULL;
>  	void *blob = NULL;
>  	int ret;
>  
>  	if (!sev_guest(kvm))
>  		return -ENOTTY;
>  
> -	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
> +	if (copy_from_user(&params, measure, sizeof(params)))
>  		return -EFAULT;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> @@ -6256,17 +6258,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	if (!params.len)
>  		goto cmd;
>  
> -	if (params.uaddr) {
> +	p = (void __user *)(uintptr_t)params.uaddr;
> +	if (p) {
>  		if (params.len > SEV_FW_BLOB_MAX_SIZE) {
>  			ret = -EINVAL;
>  			goto e_free;
>  		}
>  
> -		if (!access_ok(VERIFY_WRITE, params.uaddr, params.len)) {
> -			ret = -EFAULT;
> -			goto e_free;
> -		}
> -
>  		ret = -ENOMEM;
>  		blob = kmalloc(params.len, GFP_KERNEL);
>  		if (!blob)
> @@ -6290,13 +6288,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  		goto e_free_blob;
>  
>  	if (blob) {
> -		if (copy_to_user((void __user *)(uintptr_t)params.uaddr, blob, params.len))
> +		if (copy_to_user(p, blob, params.len))
>  			ret = -EFAULT;
>  	}
>  
>  done:
>  	params.len = data->len;
> -	if (copy_to_user((void __user *)(uintptr_t)argp->data, &params, sizeof(params)))
> +	if (copy_to_user(measure, &params, sizeof(params)))
>  		ret = -EFAULT;
>  e_free_blob:
>  	kfree(blob);
> 

Queued, thanks Brijesh and Al.

Paolo
