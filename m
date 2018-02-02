Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBBDXT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:23:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBBDXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:23:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F8CB605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
To: Avri Altman <Avri.Altman@wdc.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1517288066-13171-1-git-send-email-asutoshd@codeaurora.org>
 <DM5PR04MB1085C5039CA525D6FB77DBE3FCFB0@DM5PR04MB1085.namprd04.prod.outlook.com>
From: "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <6ca20a27-3c10-bf0e-35e7-542b7ab77356@codeaurora.org>
Date: Fri, 2 Feb 2018 08:53:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <DM5PR04MB1085C5039CA525D6FB77DBE3FCFB0@DM5PR04MB1085.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2018 1:09 PM, Avri Altman wrote:
> Hi,
> Can you elaborate how this can even happen?
> Isn't the interrupt aggregation capability should attend for those cases?
> 
> Thanks,
> Avri
> 
>> -----Original Message-----
>> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
>> owner@vger.kernel.org] On Behalf Of Asutosh Das
>> Sent: Tuesday, January 30, 2018 6:54 AM
>> To: subhashj@codeaurora.org; cang@codeaurora.org;
>> vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
>> vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
>> martin.petersen@oracle.com
>> Cc: linux-scsi@vger.kernel.org; Venkat Gopalakrishnan
>> <venkatg@codeaurora.org>; Asutosh Das <asutoshd@codeaurora.org>; open
>> list <linux-kernel@vger.kernel.org>
>> Subject: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
>>
>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>
>> As multiple requests are submitted to the ufs host controller in parallel there
>> could be instances where the command completion interrupt arrives later for a
>> request that is already processed earlier as the corresponding doorbell was
>> cleared when handling the previous interrupt. Read the interrupt status in a
>> loop after processing the received interrupt to catch such interrupts and handle
>> it.
>>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>   drivers/scsi/ufs/ufshcd.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
>> 8af2af3..58d81de 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -5357,19 +5357,30 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
>>   	u32 intr_status, enabled_intr_status;
>>   	irqreturn_t retval = IRQ_NONE;
>>   	struct ufs_hba *hba = __hba;
>> +	int retries = hba->nutrs;
>>
>>   	spin_lock(hba->host->host_lock);
>>   	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
>> -	enabled_intr_status =
>> -		intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
>>
>> -	if (intr_status)
>> -		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
>> +	/*
>> +	 * There could be max of hba->nutrs reqs in flight and in worst case
>> +	 * if the reqs get finished 1 by 1 after the interrupt status is
>> +	 * read, make sure we handle them by checking the interrupt status
>> +	 * again in a loop until we process all of the reqs before returning.
>> +	 */
>> +	do {
>> +		enabled_intr_status =
>> +			intr_status & ufshcd_readl(hba,
>> REG_INTERRUPT_ENABLE);
>> +		if (intr_status)
>> +			ufshcd_writel(hba, intr_status,
>> REG_INTERRUPT_STATUS);
>> +		if (enabled_intr_status) {
>> +			ufshcd_sl_intr(hba, enabled_intr_status);
>> +			retval = IRQ_HANDLED;
>> +		}
>> +
>> +		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
>> +	} while (intr_status && --retries);
>>
>> -	if (enabled_intr_status) {
>> -		ufshcd_sl_intr(hba, enabled_intr_status);
>> -		retval = IRQ_HANDLED;
>> -	}
>>   	spin_unlock(hba->host->host_lock);
>>   	return retval;
>>   }
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
>> Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
>> Foundation Collaborative Project.
> 

Hi
yes - interrupt aggregation makes sense here. But there were some 
performance concerns with it; well, I don't have the data to back that 
up now though.
However, I can code it up and check it.
Will post it in some time.

-asd

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
