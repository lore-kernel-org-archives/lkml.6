Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeBXHVE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:21:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750710AbeBXHVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:21:03 -0500
Date: Sat, 24 Feb 2018 15:20:54 +0800
From: Dave Young <dyoung@redhat.com>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        sgoel@codeaurora.org, takahiro.akashi@linaro.org, timur@codeaurora.org
Subject: Re: [PATCH 1/2] efi/esrt: fix unsupported version initialization
 failure
Message-ID: <20180224072054.GA3264@dhcp-128-65.nay.redhat.com>
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
 <1519414953-5478-2-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519414953-5478-2-git-send-email-tbaicar@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/18 at 12:42pm, Tyler Baicar wrote:
> If ESRT initialization fails due to an unsupported version, the
> early_memremap allocation is never unmapped. This will cause an
> early ioremap leak. So, make sure to unmap the memory allocation
> before returning from efi_esrt_init().
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/firmware/efi/esrt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index c47e0c6..504f3c3 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -285,7 +285,7 @@ void __init efi_esrt_init(void)
>  	} else {
>  		pr_err("Unsupported ESRT version %lld.\n",
>  		       tmpesrt.fw_resource_version);
> -		return;
> +		goto err_memunmap;
>  	}
>  
>  	if (tmpesrt.fw_resource_count > 0 && max - size < entry_size) {
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
