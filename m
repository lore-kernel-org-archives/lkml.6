Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeB0EAe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 23:00:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33550 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeB0EAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 23:00:32 -0500
Subject: Re: [PATCH] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
References: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
 <1519700898.3120.3.camel@wdc.com>
 <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
 <1519702875.3120.7.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <db9c47e6-d8ea-1e9e-609a-ff1b1db3769c@oracle.com>
Date: Tue, 27 Feb 2018 12:00:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519702875.3120.7.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802270043
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

Thanks for your kindly response.

On 02/27/2018 11:41 AM, Bart Van Assche wrote:
> On Tue, 2018-02-27 at 11:28 +0800, jianchao.wang wrote:
>> If that is true, what if aacraid driver uses block legacy instead of blk-mq ?
>> w/ blk-mq disabled, __scsi_queue_insert just requeue the request with blk_requeue_request.
>>
>> __scsi_queue_insert
>> ...
>> 	if (q->mq_ops) {
>> 		scsi_mq_requeue_cmd(cmd);
>> 		return;
>> 	}
>> 	spin_lock_irqsave(q->queue_lock, flags);
>> 	blk_requeue_request(q, cmd->request);
>> 	kblockd_schedule_work(&device->requeue_work);
>> 	spin_unlock_irqrestore(q->queue_lock, flags);
>> ...
>>
>> no prep/unprep code there for block legacy code.
> 
> Hello Jianchao,
> 
> For the legacy block layer preparing and unpreparing a request happens from
> inside the block layer core. Please have a look at block/blk-core.c and the
> code in that file that handles the request flag RQF_DONTPREP.
Yes, thanks for your directive.

On the other hand, this patch is to align the actions between blk-mq and block legacy code in __scsi_queue_insert.
As we know, __scsi_queue_insert is just to requeue the request back to queue, as the block legacy code segment above:
for block legacy, it just blk_requeue_request for the request and kick the queue run.
However, for the blk-mq, scsi_mq_requeue_cmd will be invoked, it not only requeue the request, but also unprep request.
This is not what __scsi_queue_insert should do, but scsi_io_completion.
When the request is not finished completely, and scsi_io_completion finds it need a ACTION_REPREP, at the moment,
we need requeue and unprep there.

If I missed something, please feel free to point out. :)

Thanks
Jianchao

 

> 
> Thanks,
> 
> Bart.
> 
> 
> 
