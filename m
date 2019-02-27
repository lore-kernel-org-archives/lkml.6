Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8624B213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfB0MvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:51:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:39776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfB0MvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:51:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68D10AFAF;
        Wed, 27 Feb 2019 12:51:10 +0000 (UTC)
Subject: Re: [PATCH -next] scsi: libfc: Fix potential NULL pointer dereference
To:     YueHaibing <yuehaibing@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190130101141.20132-1-yuehaibing@huawei.com>
 <09c3242f-9a41-65f4-7dc6-f1c8aa6425f1@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <33f93c39-3dd5-ef95-0fc2-6fc40f6b3d4b@suse.de>
Date:   Wed, 27 Feb 2019 13:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <09c3242f-9a41-65f4-7dc6-f1c8aa6425f1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 7:09 AM, YueHaibing wrote:
> 
> Friendly ping:
> 
> Who can review or take this, please?
> 
> Thanks
> 
> On 2019/1/30 18:11, YueHaibing wrote:
>> There is a potential NULL pointer dereference in case
>> fc_rport_create() fails and returns NULL.
>>
>> Fixes: 2580064b5ec6 ("scsi: libfc: Replace ->rport_create callback with function call")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/scsi/libfc/fc_lport.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
>> index ff943f4..e2a3551 100644
>> --- a/drivers/scsi/libfc/fc_lport.c
>> +++ b/drivers/scsi/libfc/fc_lport.c
>> @@ -250,6 +250,10 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
>>   	}
>>   	mutex_lock(&lport->disc.disc_mutex);
>>   	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
>> +	if (!lport->ptp_rdata) {
>> +		mutex_unlock(&lport->disc.disc_mutex);
>> +		return;
>> +	}
>>   	kref_get(&lport->ptp_rdata->kref);
>>   	lport->ptp_rdata->ids.port_name = remote_wwpn;
>>   	lport->ptp_rdata->ids.node_name = remote_wwnn;
>>
> 
I don't think this is correct.
While it's true that fc_rport_create() might fail, fc_lport_ptp_setup() 
will still assumed to have worked by the caller.
So we should rather return an error code here from fc_lport_ptp_setup() 
and ensure it's handled properly in the caller, too.

Cheers,

Hannes

