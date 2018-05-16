Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeEPVOI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:14:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEPVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:14:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 16 May 2018 14:14:04 -0700
From: Subhash Jadavani <subhashj@codeaurora.org>
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi-owner@vger.kernel.org
Subject: Re: [PATCH v2 08/10] scsi: ufs: make sure all interrupts are
 processed
In-Reply-To: <faa728f587df5372dd78b3d012ed6bf78e92e883.1525343531.git.asutoshd@codeaurora.org>
References: <cover.1525343531.git.asutoshd@codeaurora.org>
 <faa728f587df5372dd78b3d012ed6bf78e92e883.1525343531.git.asutoshd@codeaurora.org>
Message-ID: <e8008a9827f7ef1db917ea03707be5d7@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-03 04:07, Asutosh Das wrote:
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> 
> As multiple requests are submitted to the ufs host controller in
> parallel there could be instances where the command completion
> interrupt arrives later for a request that is already processed
> earlier as the corresponding doorbell was cleared when handling
> the previous interrupt. Read the interrupt status in a loop after
> processing the received interrupt to catch such interrupts and
> handle it.
> 
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c35a076..09b7a3f 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5383,19 +5383,30 @@ static irqreturn_t ufshcd_intr(int irq, void 
> *__hba)
>  	u32 intr_status, enabled_intr_status;
>  	irqreturn_t retval = IRQ_NONE;
>  	struct ufs_hba *hba = __hba;
> +	int retries = hba->nutrs;
> 
>  	spin_lock(hba->host->host_lock);
>  	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
> -	enabled_intr_status =
> -		intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
> 
> -	if (intr_status)
> -		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
> +	/*
> +	 * There could be max of hba->nutrs reqs in flight and in worst case
> +	 * if the reqs get finished 1 by 1 after the interrupt status is
> +	 * read, make sure we handle them by checking the interrupt status
> +	 * again in a loop until we process all of the reqs before returning.
> +	 */
> +	do {
> +		enabled_intr_status =
> +			intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
> +		if (intr_status)
> +			ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
> +		if (enabled_intr_status) {
> +			ufshcd_sl_intr(hba, enabled_intr_status);
> +			retval = IRQ_HANDLED;
> +		}
> +
> +		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
> +	} while (intr_status && --retries);
> 
> -	if (enabled_intr_status) {
> -		ufshcd_sl_intr(hba, enabled_intr_status);
> -		retval = IRQ_HANDLED;
> -	}
>  	spin_unlock(hba->host->host_lock);
>  	return retval;
>  }

Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
