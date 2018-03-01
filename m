Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935710AbeCAB6E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:58:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43610 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeCAB6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:58:02 -0500
Subject: Re: [PATCH V2] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
References: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
 <1519840355.2777.8.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <624cedc6-9658-7b76-9c63-61c30fdfe6be@oracle.com>
Date: Thu, 1 Mar 2018 09:57:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519840355.2777.8.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

Thanks for your precious time to review this and kindly detailed response.

On 03/01/2018 01:52 AM, Bart Van Assche wrote:
> On Wed, 2018-02-28 at 16:55 +0800, Jianchao Wang wrote:
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index a86df9c..6fa7b0c 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -191,7 +191,8 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
>>  	 */
>>  	cmd->result = 0;
>>  	if (q->mq_ops) {
>> -		scsi_mq_requeue_cmd(cmd);
>> +		blk_mq_requeue_request(cmd->request, true);
>> +		put_device(&device->sdev_gendev);
>>  		return;
>>  	}
>>  	spin_lock_irqsave(q->queue_lock, flags);
> 
> Anyone who sees the put_device() call that follows the blk_mq_requeue_request()
> call will wonder why that call occurs there. So I think we need a comment above
> that call that explains where the matching get_device() call is.

Yes, I will add this.

> For the legacy code path, there is a get_device() call in scsi_prep_fn() but no
> put_device() call in scsi_unprep_fn() - the matching put_device() calls occur in
> scsi_end_request() and after blk_requeue_request().
> 
> For scsi-mq however there is a get_device() call in scsi_mq_get_budget() and a
> put_device() call in scsi_mq_put_budget(). So why do we need the put_device()
> calls after blk_mq_requeue_request() and in the mq path for scsi_end_request()?
> 

>From the source code, we know the scsi_mq_get_budget will be invoked every time when we issue a request.
But scsi_mq_put_budget is just in the fail path.

scsi_queue_rq // if any error
  -> scsi_mq_put_budget

blk_mq_dispatch_rq_list // if no driver tags
  -> blk_mq_put_dispatch_budget
    -> scsi_mq_put_budget
blk_mq_do_dispatch_sched/blk_mq_do_dispatch_ctx // if no requests
  -> blk_mq_put_dispatch_budget
    -> scsi_mq_put_budget

So we have to add put_device after  blk_mq_requeue_request() and in scsi_end_request() to match the
scsi_mq_get_budget.

Thanks
Jianchao
