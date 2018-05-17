Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEQEGu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 00:06:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeEQEGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 00:06:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B2E7601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH 1/4] scsi: ufs: add quirk to fix mishandling
 utrlclr/utmrlclr
To: Alim Akhtar <alim.akhtar@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinholikatti@gmail.com, olof@lixom.net
References: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
 <CGME20180506102638epcas1p17bea76e1a5dbac535d5d6a10181f7e29@epcas1p1.samsung.com>
 <1525601658-31989-2-git-send-email-alim.akhtar@samsung.com>
From: "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <f84870f6-234e-9854-fe6d-968a876dca6f@codeaurora.org>
Date: Thu, 17 May 2018 09:36:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525601658-31989-2-git-send-email-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/2018 3:44 PM, Alim Akhtar wrote:
> In the right behavior, setting the bit to '0' indicates clear and
> '1' indicates no change. If host controller handles this the other way,
> UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR can be used.
> 
> Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 21 +++++++++++++++++++--
>   drivers/scsi/ufs/ufshcd.h |  5 +++++
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 00e7905..9898ce5 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -675,7 +675,24 @@ static inline void ufshcd_put_tm_slot(struct ufs_hba *hba, int slot)
>    */
>   static inline void ufshcd_utrl_clear(struct ufs_hba *hba, u32 pos)
>   {
> -	ufshcd_writel(hba, ~(1 << pos), REG_UTP_TRANSFER_REQ_LIST_CLEAR);
> +	if (hba->quirks & UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR)
> +		ufshcd_writel(hba, (1 << pos), REG_UTP_TRANSFER_REQ_LIST_CLEAR);
> +	else
> +		ufshcd_writel(hba, ~(1 << pos),
> +				REG_UTP_TRANSFER_REQ_LIST_CLEAR);
> +}
> +
> +/**
> + * ufshcd_utmrl_clear - Clear a bit in UTRMLCLR register
> + * @hba: per adapter instance
> + * @pos: position of the bit to be cleared
> + */
> +static inline void ufshcd_utmrl_clear(struct ufs_hba *hba, u32 pos)
> +{
> +	if (hba->quirks & UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR)
> +		ufshcd_writel(hba, (1 << pos), REG_UTP_TASK_REQ_LIST_CLEAR);
> +	else
> +		ufshcd_writel(hba, ~(1 << pos), REG_UTP_TASK_REQ_LIST_CLEAR);
>   }
>   
>   /**
> @@ -5398,7 +5415,7 @@ static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag)
>   		goto out;
>   
>   	spin_lock_irqsave(hba->host->host_lock, flags);
> -	ufshcd_writel(hba, ~(1 << tag), REG_UTP_TASK_REQ_LIST_CLEAR);
> +	ufshcd_utmrl_clear(hba, tag);
>   	spin_unlock_irqrestore(hba->host->host_lock, flags);
>   
>   	/* poll for max. 1 sec to clear door bell register by h/w */
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 8110dcd..43035f8 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -595,6 +595,11 @@ struct ufs_hba {
>   	 */
>   	#define UFSHCD_QUIRK_PRDT_BYTE_GRAN			0x80
>   
> +	/*
> +	 * Cleaer handling for transfer/task request list is just opposite.
> +	 */
Spell check - should be 'Clear'
> +	#define UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR		0x100
> +
>   	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */
>   
>   	/* Device deviations from standard UFS device spec. */
> 

Looks good to me, except the spell-check.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
