Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBXHXG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:23:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750844AbeBXHXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:23:05 -0500
Date: Sat, 24 Feb 2018 15:22:57 +0800
From: Dave Young <dyoung@redhat.com>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        sgoel@codeaurora.org, takahiro.akashi@linaro.org, timur@codeaurora.org
Subject: Re: [PATCH 2/2] efi/esrt: mark ESRT memory region as nomap
Message-ID: <20180224072257.GB3264@dhcp-128-65.nay.redhat.com>
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
 <1519414953-5478-3-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519414953-5478-3-git-send-email-tbaicar@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/18 at 12:42pm, Tyler Baicar wrote:
> The ESRT memory region is being exposed as System RAM in /proc/iomem
> which is wrong because it cannot be overwritten. This memory is needed
> for kexec kernels in order to properly initialize ESRT, so if it is
> overwritten it will cause ESRT failures in the kexec kernel. Mark this
> region as nomap so that it is not overwritten.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/firmware/efi/esrt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 504f3c3..f5f79c7 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -335,6 +335,14 @@ void __init efi_esrt_init(void)
>  	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
>  	efi_mem_reserve(esrt_data, esrt_data_size);
>  
> +	/*
> +	 * Mark the ESRT memory region as nomap to avoid it being exposed as
> +	 * System RAM in /proc/iomem. Otherwise this block can be overwritten
> +	 * which will then cause failures in kexec'd kernels since the ESRT
> +	 * information is no longer there.
> +	 */
> +	memblock_mark_nomap(esrt_data, esrt_data_size);
> +

On my X86 machine, esrt region was marked as reserved /proc/iomem,
this issue could be a arm64 only problem, it is better to handle this in
arm init code.


>  	pr_debug("esrt-init: loaded.\n");
>  err_memunmap:
>  	early_memunmap(va, size);
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Dave
