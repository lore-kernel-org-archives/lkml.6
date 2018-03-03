Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965023AbeCCBlt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 20:41:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964973AbeCCBlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 20:41:47 -0500
Subject: Re: [PATCH V3] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
References: <1519961474-15236-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520008291.2855.7.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e867f55a-a027-4658-1e11-50a65f383626@oracle.com>
Date: Sat, 3 Mar 2018 09:41:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520008291.2855.7.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803030015
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

Thanks for your kindly response and directive.

On 03/03/2018 12:31 AM, Bart Van Assche wrote:
> On Fri, 2018-03-02 at 11:31 +0800, Jianchao Wang wrote:
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index a86df9c..d2f1838 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -191,7 +191,13 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
>>  	 */
>>  	cmd->result = 0;
>>  	if (q->mq_ops) {
>> -		scsi_mq_requeue_cmd(cmd);
>> +		/*
>> +		 * scsi_device.sdev_gendev will be get every time in .get_budget and
>> +		 * be put in scsi_end_request. Hence we need to put the reference
>> +		 * here when we decide to requeue request.
>> +		 */
>> +		blk_mq_requeue_request(cmd->request, true);
>> +		put_device(&device->sdev_gendev);
>>  		return;
>>  	}
>>  	spin_lock_irqsave(q->queue_lock, flags);
> 
> Please consider to change the new comment into something like the following:
> "Before a SCSI command is dispatched, get_device(&sdev->sdev_gendev) is called
> and the host, target and device busy counters are increased. Since requeuing a
> request causes these actions to be repeated and since scsi_device_unbusy() has
> already been called, put_device(&device->sdev_gendev) must still be called. Call
> put_device() after blk_mq_requeue_request() to avoid that removal of the SCSI
> device can start before requeueing has happened."

Yes, your comment is more detailed and clearly.

Sincerely
Jianchao
