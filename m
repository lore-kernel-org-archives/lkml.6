Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935589AbeEJALv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:11:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44877 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:11:50 -0400
X-Google-Smtp-Source: AB8JxZqttZiYi6kWJ5FmLUzFQbgCD075lT38/3OhwuUMvRfJsOdaRmRXtPc1veRIPtQemZWy5CquLw==
Date: Wed, 9 May 2018 17:11:46 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Pallardy <loic.pallardy@st.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 02/13] remoteproc: add rproc_va_to_pa function
Message-ID: <20180510001146.GB29093@builder>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-3-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519921440-21356-3-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:

> This new function translates CPU virtual address in
> CPU physical one according to virtual address location.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 56b33e4..eb1b779 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -139,6 +139,22 @@ static void rproc_disable_iommu(struct rproc *rproc)
>  	iommu_domain_free(domain);
>  }
>  
> +static phys_addr_t rproc_va_to_pa(void *cpu_addr)
> +{
> +	/*
> +	 * Return physical address according to virtual address location
> +	 * - in vmalloc: if region ioremapped or defined as dma_alloc_coherent
> +	 * - in kernel: if region allocated in generic dma memory pool
> +	 */
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		return page_to_phys(vmalloc_to_page(cpu_addr)) +
> +				    offset_in_page(cpu_addr);
> +	}
> +
> +	WARN_ON(!virt_addr_valid(cpu_addr));
> +	return virt_to_phys(cpu_addr);
> +}
> +
>  /**
>   * rproc_da_to_va() - lookup the kernel virtual address for a remoteproc address
>   * @rproc: handle of a remote processor
> @@ -708,7 +724,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	 * In this case, the device address and the physical address
>  	 * are the same.
>  	 */
> -	rsc->pa = dma;
> +	rsc->pa = (u32)rproc_va_to_pa(va);
>  
>  	carveout->va = va;
>  	carveout->len = rsc->len;
> -- 
> 1.9.1
> 
