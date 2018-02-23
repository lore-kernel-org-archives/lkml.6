Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeBWHDz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:03:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBWHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:03:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 469CC606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH 1/9] scsi: ufs: Allowing power mode change
To: Kyuho Choi <chlrbgh0@gmail.com>
Cc: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Yaniv Gardi <ygardi@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
 <70df05c82a8624987c76b16c65143f00a111c94d.1519120988.git.asutoshd@codeaurora.org>
 <CAP2JTQK3jNrNvxz=aF9weuO1M38zBCCa8YJfz5tazXF61p257w@mail.gmail.com>
From: "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <13563e4e-1b4d-8791-12ec-8fcb752f3b96@codeaurora.org>
Date: Fri, 23 Feb 2018 12:33:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP2JTQK3jNrNvxz=aF9weuO1M38zBCCa8YJfz5tazXF61p257w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2018 10:40 AM, Kyuho Choi wrote:
> Hi Asutosh,
> 
> I've simple question in below.
> 
> On 2/21/18, Asutosh Das <asutoshd@codeaurora.org> wrote:
>> From: Yaniv Gardi <ygardi@codeaurora.org>
>>
>> Due to M-PHY issues, moving from HS to any other mode or gear or
>> even Hibern8 causes some un-predicted behavior of the device.
>> This patch fixes this issues.
>>
>> Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>   drivers/scsi/ufs/ufshcd.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 011c336..d74d529 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -4167,9 +4167,13 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>>   			goto out;
>>   	} while (ret && retries--);
>>
>> -	if (ret)
>> +	if (ret) {
>>   		/* failed to get the link up... retire */
>>   		goto out;
>> +	} else {
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 0);
>> +		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 1);
>> +	}
>>
> 
> Every ufs host has same issue and affected?.
> 
>>   	if (link_startup_again) {
>>   		link_startup_again = false;
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
>> Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
>> Foundation Collaborative Project.
>>
>>
Hi Choi
Thanks for the review.

No - I can't say if every host has the same issue. However, I get your 
point. It could be done with a quirk.

I'll fix this in v2 after collating all the comments from the rest of 
the patches.

-asd

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
