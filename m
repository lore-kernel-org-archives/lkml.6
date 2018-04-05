Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeDERHq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:07:46 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:41775 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeDERHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:07:44 -0400
X-IronPort-AV: E=Sophos;i="5.48,411,1517875200";
   d="scan'208";a="50762941"
Subject: Re: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
 blacklist
To: Long Li <longli@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        KY Srinivasan <kys@microsoft.com>
CC: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180326135651.8193-1-ross.lagerwall@citrix.com>
 <yq17epvj2f1.fsf@oracle.com>
 <MWHPR2101MB0729E7680EDB0EE4886AAED1CEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <2b7a3146-e2e4-699f-5633-13d8b568786d@citrix.com>
Date: Thu, 5 Apr 2018 17:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <MWHPR2101MB0729E7680EDB0EE4886AAED1CEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2018 11:33 PM, Long Li wrote:
>> Subject: Re: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector
>> blacklist
>>
>>
>> Long, KY: Please confirm.
>>
>>> The Windows Server 2016 iSCSI target doesn't work with the Linux
>>> kernel initiator since the kernel started sending larger requests by
>>> default, nor does it implement the block limits VPD page. Apply the
>>> sector limit workaround for these targets.
>>>
>>> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
>>> ---
>>>   drivers/scsi/scsi_devinfo.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
>>> index f3b1172..5cb748a 100644
>>> --- a/drivers/scsi/scsi_devinfo.c
>>> +++ b/drivers/scsi/scsi_devinfo.c
>>> @@ -213,7 +213,7 @@ static struct {
>>>   	{"Medion", "Flash XL  MMC/SD", "2.6D", BLIST_FORCELUN},
>>>   	{"MegaRAID", "LD", NULL, BLIST_FORCELUN},
>>>   	{"MICROP", "4110", NULL, BLIST_NOTQ},
>>> -	{"MSFT", "Virtual HD", NULL, BLIST_NO_RSOC},
>>> +	{"MSFT", "Virtual HD", NULL, BLIST_MAX_1024 | BLIST_NO_RSOC},
> 
> Ross,
> 
> What about storage_channel_properties.max_transfer_bytes returned from VSTOR_OPERATION_QUERY_PROPERTIES (in storvsc_channel_init())
> 
> Does it return correctly the maximum transfer size for iSCSI?
> 

I presume you're referring to the Hyper-V virtual storage driver? This 
has nothing to do with that module -- I don't even have it compiled in. 
It's just simply the Linux kernel initiator connecting over plain 
software iSCSI to a Windows Server 2016 iSCSI target.

This is easy enough to reproduce. Just set up a Windows Server 2016 
target and try and use it from Linux. You get I/O errors as soon as you 
try and format the disk.

Cheers,
-- 
Ross Lagerwall
