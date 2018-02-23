Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeBWCbv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:31:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBWCbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:31:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19AE5606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH 5/9] scsi: ufs: add reference counting for scsi block
 requests
To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
 <ff8f06512eca0c6275d3d486af0d430d8111c451.1519120988.git.asutoshd@codeaurora.org>
 <MWHPR04MB1137BE3E48766435570460689ACE0@MWHPR04MB1137.namprd04.prod.outlook.com>
From: "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <5f0ed265-2c2a-2734-7ab1-b71d29ff2ad6@codeaurora.org>
Date: Fri, 23 Feb 2018 08:01:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <MWHPR04MB1137BE3E48766435570460689ACE0@MWHPR04MB1137.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/2018 6:48 PM, Stanislav Nijnikov wrote:
> 
> 
>> -----Original Message-----
>> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
>> owner@vger.kernel.org] On Behalf Of Asutosh Das
>> Sent: Wednesday, February 21, 2018 6:57 AM
>> To: subhashj@codeaurora.org; cang@codeaurora.org;
>> vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
>> vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
>> martin.petersen@oracle.com
>> Cc: linux-scsi@vger.kernel.org; Asutosh Das <asutoshd@codeaurora.org>;
>> open list <linux-kernel@vger.kernel.org>
>> Subject: [PATCH 5/9] scsi: ufs: add reference counting for scsi block requests
>>
>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>
>> Currently we call the scsi_block_requests()/scsi_unblock_requests()
>> whenever we want to block/unblock scsi requests but as there is no
>> reference counting, nesting of these calls could leave us in undesired state
>> sometime. Consider following call flow sequence:
>> 1. func1() calls scsi_block_requests() but calls func2() before
>>     calling scsi_unblock_requests()
>> 2. func2() calls scsi_block_requests()
>> 3. func2() calls scsi_unblock_requests() 4. func1() calls
>> scsi_unblock_requests()
>>
>> As there is no reference counting, we will have scsi requests unblocked after
>> #3 instead of it to be unblocked only after #4. Though we may not have
>> failures seen with this, we might run into some failures in future.
>> Better solution would be to fix this by adding reference counting.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>   drivers/scsi/ufs/ufshcd.c | 44
>> +++++++++++++++++++++++++++++++++++++-------
>>   drivers/scsi/ufs/ufshcd.h |  5 +++++
>>   2 files changed, 42 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
>> 7a4df95..987b81b 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -264,6 +264,36 @@ static inline void ufshcd_disable_irq(struct ufs_hba
>> *hba)
>>   	}
>>   }
>>
>> +void ufshcd_scsi_unblock_requests(struct ufs_hba *hba) {
>> +	unsigned long flags;
>> +	bool unblock = false;
>> +
>> +	spin_lock_irqsave(hba->host->host_lock, flags);
>> +	hba->scsi_block_reqs_cnt--;
>> +	unblock = !hba->scsi_block_reqs_cnt;
>> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
>> +	if (unblock)
>> +		scsi_unblock_requests(hba->host);
>> +}
>> +EXPORT_SYMBOL(ufshcd_scsi_unblock_requests);
>> +
>> +static inline void __ufshcd_scsi_block_requests(struct ufs_hba *hba) {
>> +	if (!hba->scsi_block_reqs_cnt++)
>> +		scsi_block_requests(hba->host);
>> +}
>> +
>> +void ufshcd_scsi_block_requests(struct ufs_hba *hba) {
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(hba->host->host_lock, flags);
>> +	__ufshcd_scsi_block_requests(hba);
>> +	spin_unlock_irqrestore(hba->host->host_lock, flags); }
>> +EXPORT_SYMBOL(ufshcd_scsi_block_requests);
>> +
>>   /* replace non-printable or non-ASCII characters with spaces */  static inline
>> void ufshcd_remove_non_printable(char *val)  { @@ -1079,12 +1109,12 @@
>> static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
>>   	 * make sure that there are no outstanding requests when
>>   	 * clock scaling is in progress
>>   	 */
>> -	scsi_block_requests(hba->host);
>> +	ufshcd_scsi_block_requests(hba);
>>   	down_write(&hba->clk_scaling_lock);
>>   	if (ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
>>   		ret = -EBUSY;
>>   		up_write(&hba->clk_scaling_lock);
>> -		scsi_unblock_requests(hba->host);
>> +		ufshcd_scsi_unblock_requests(hba);
>>   	}
>>
>>   	return ret;
>> @@ -1093,7 +1123,7 @@ static int ufshcd_clock_scaling_prepare(struct
>> ufs_hba *hba)  static void ufshcd_clock_scaling_unprepare(struct ufs_hba
>> *hba)  {
>>   	up_write(&hba->clk_scaling_lock);
>> -	scsi_unblock_requests(hba->host);
>> +	ufshcd_scsi_unblock_requests(hba);
>>   }
>>
>>   /**
>> @@ -1413,7 +1443,7 @@ static void ufshcd_ungate_work(struct work_struct
>> *work)
>>   		hba->clk_gating.is_suspended = false;
>>   	}
>>   unblock_reqs:
>> -	scsi_unblock_requests(hba->host);
>> +	ufshcd_scsi_unblock_requests(hba);
>>   }
>>
>>   /**
>> @@ -1469,7 +1499,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
>>   		 * work and to enable clocks.
>>   		 */
>>   	case CLKS_OFF:
>> -		scsi_block_requests(hba->host);
>> +		__ufshcd_scsi_block_requests(hba);
>>   		hba->clk_gating.state = REQ_CLKS_ON;
>>   		trace_ufshcd_clk_gating(dev_name(hba->dev),
>>   					hba->clk_gating.state);
>> @@ -5197,7 +5227,7 @@ static void ufshcd_err_handler(struct work_struct
>> *work)
>>
>>   out:
>>   	spin_unlock_irqrestore(hba->host->host_lock, flags);
>> -	scsi_unblock_requests(hba->host);
>> +	ufshcd_scsi_unblock_requests(hba);
>>   	ufshcd_release(hba);
>>   	pm_runtime_put_sync(hba->dev);
>>   }
>> @@ -5299,7 +5329,7 @@ static void ufshcd_check_errors(struct ufs_hba
>> *hba)
>>   		/* handle fatal errors only when link is functional */
>>   		if (hba->ufshcd_state == UFSHCD_STATE_OPERATIONAL) {
>>   			/* block commands from scsi mid-layer */
>> -			scsi_block_requests(hba->host);
>> +			__ufshcd_scsi_block_requests(hba);
>>
>>   			hba->ufshcd_state =
>> UFSHCD_STATE_EH_SCHEDULED;
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h index
>> 7a2dad3..4385741 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -498,6 +498,7 @@ struct ufs_stats {
>>    * @urgent_bkops_lvl: keeps track of urgent bkops level for device
>>    * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
>>    *  device is known or not.
>> + * @scsi_block_reqs_cnt: reference counting for scsi block requests
>>    */
>>   struct ufs_hba {
>>   	void __iomem *mmio_base;
>> @@ -690,6 +691,7 @@ struct ufs_hba {
>>
>>   	struct rw_semaphore clk_scaling_lock;
>>   	struct ufs_desc_size desc_size;
>> +	int scsi_block_reqs_cnt;
>>   };
>>
>>   /* Returns true if clocks can be gated. Otherwise false */ @@ -862,6 +864,9
>> @@ int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum
>> desc_idn desc_id,
>>
>>   u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba);
>>
>> +void ufshcd_scsi_block_requests(struct ufs_hba *hba); void
>> +ufshcd_scsi_unblock_requests(struct ufs_hba *hba);
>> +
>>   /* Wrapper functions for safely calling variant operations */  static inline
>> const char *ufshcd_get_var_name(struct ufs_hba *hba)  {
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
>> Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
>> Linux Foundation Collaborative Project.
> 
> 1. The atomic variable and operations could be used for the reference counting.
>       This will allow to avoid usage of the locks.
> 2. Why are the ufshcd_scsi_block_requests/ ufshcd_scsi_unblock_requests
>      functions not defined as static? They are not used outside ufshcd.c.
> 
> Regards
> Stanislav
> 
Hi
Thanks. Let me check this and get back.
I'll wait for comments on the other patches before posting a v2.

-asd

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
