Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeB0D2s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:28:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeB0D2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:28:47 -0500
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
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
Date: Tue, 27 Feb 2018 11:28:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519700898.3120.3.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802270036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

Thanks for your kindly response.

On 02/27/2018 11:08 AM, Bart Van Assche wrote:
> On Mon, 2018-02-26 at 15:58 +0800, Jianchao Wang wrote:
>> In scsi core, __scsi_queue_insert should just put request back on
>> the queue and retry using the same command as before. However, for
>> blk-mq, scsi_mq_requeue_cmd is employed here which will unprepare
>> the request. To align with the semantics of __scsi_queue_insert,
>> just use blk_mq_requeue_request with kick_requeue_list == true.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  drivers/scsi/scsi_lib.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index a86df9c..06d8110 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -191,7 +191,7 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
>>  	 */
>>  	cmd->result = 0;
>>  	if (q->mq_ops) {
>> -		scsi_mq_requeue_cmd(cmd);
>> +		blk_mq_requeue_request(cmd->request, true);
>>  		return;
>>  	}
>>  	spin_lock_irqsave(q->queue_lock, flags);
> 
> I think this patch will break the code in the aacraid driver that iterates
> over sdev->cmd_list because commands are added to and removed from that
> list in the prep / unprep code.

If that is true, what if aacraid driver uses block legacy instead of blk-mq ?
w/ blk-mq disabled, __scsi_queue_insert just requeue the request with blk_requeue_request.

__scsi_queue_insert
...
	if (q->mq_ops) {
		scsi_mq_requeue_cmd(cmd);
		return;
	}
	spin_lock_irqsave(q->queue_lock, flags);
	blk_requeue_request(q, cmd->request);
	kblockd_schedule_work(&device->requeue_work);
	spin_unlock_irqrestore(q->queue_lock, flags);
...

no prep/unprep code there for block legacy code.

Thanks
Jianchao

> 
> Bart.
> 
