Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032342AbeBOAij (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:38:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032243AbeBOAih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:38:37 -0500
Subject: Re: [PATCH RESENT] nvme-pci: suspend queues based on online_queues
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518440713-1031-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180213215229.GF20962@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a48dd697-f635-2d58-d7f0-638295635c9e@oracle.com>
Date: Thu, 15 Feb 2018 08:33:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213215229.GF20962@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150006
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your kindly response and directive.
And 恭喜发财 大吉大利！！

On 02/14/2018 05:52 AM, Keith Busch wrote:
> On Mon, Feb 12, 2018 at 09:05:13PM +0800, Jianchao Wang wrote:
>> @@ -1315,9 +1315,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
>>  	nvmeq->cq_vector = -1;
>>  	spin_unlock_irq(&nvmeq->q_lock);
>>  
>> -	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
>> -		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
>> -
> 
> This doesn't look related to this patch.
> 
>>  	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
>>  
>>  	return 0;
>> @@ -1461,13 +1458,14 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>>  	nvme_init_queue(nvmeq, qid);
>>  	result = queue_request_irq(nvmeq);
>>  	if (result < 0)
>> -		goto release_sq;
>> +		goto offline;
>>  
>>  	return result;
>>  
>> - release_sq:
>> +offline:
>> +	dev->online_queues--;
>>  	adapter_delete_sq(dev, qid);
> 
> In addition to the above, set nvmeq->cq_vector to -1.

Yes, absolutely.

> 
> Everything else that follows doesn't appear to be necessary.

Yes, nvme_suspend_queues will return when it finds the cq_vector is -1.


Sincerely
Jianchao

> 
>> @@ -2167,6 +2167,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>  	int i;
>>  	bool dead = true;
>>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>> +	int onlines;
>>  
>>  	mutex_lock(&dev->shutdown_lock);
>>  	if (pci_is_enabled(pdev)) {
>> @@ -2175,8 +2176,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>  		if (dev->ctrl.state == NVME_CTRL_LIVE ||
>>  		    dev->ctrl.state == NVME_CTRL_RESETTING)
>>  			nvme_start_freeze(&dev->ctrl);
>> -		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
>> -			pdev->error_state  != pci_channel_io_normal);
>> +
>> +		dead = !!((csts & NVME_CSTS_CFS) ||
>> +				!(csts & NVME_CSTS_RDY) ||
>> +				(pdev->error_state  != pci_channel_io_normal) ||
>> +				(dev->online_queues == 0));
>>  	}
>>  
>>  	/*
>> @@ -2200,9 +2204,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>  		nvme_disable_io_queues(dev);
>>  		nvme_disable_admin_queue(dev, shutdown);
>>  	}
>> -	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
>> +
>> +	onlines = dev->online_queues;
>> +	for (i = onlines - 1; i >= 0; i--)
>>  		nvme_suspend_queue(&dev->queues[i]);
>>  
>> +	if (dev->ctrl.admin_q)
>> +		blk_mq_quiesce_queue(dev->ctrl.admin_q);
>> +
>>  	nvme_pci_disable(dev);
>>  
>>  	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
>> @@ -2341,16 +2350,18 @@ static void nvme_reset_work(struct work_struct *work)
>>  	if (result)
>>  		goto out;
>>  
>> -	/*
>> -	 * Keep the controller around but remove all namespaces if we don't have
>> -	 * any working I/O queue.
>> -	 */
>> -	if (dev->online_queues < 2) {
>> +
>> +	/* In case of online_queues is zero, it has gone to out */
>> +	if (dev->online_queues == 1) {
>> +		/*
>> +		 * Keep the controller around but remove all namespaces if we
>> +		 * don't have any working I/O queue.
>> +		 */
>>  		dev_warn(dev->ctrl.device, "IO queues not created\n");
>>  		nvme_kill_queues(&dev->ctrl);
>>  		nvme_remove_namespaces(&dev->ctrl);
>>  		new_state = NVME_CTRL_ADMIN_ONLY;
>> -	} else {
>> +	} else if (dev->online_queues > 1) {
>>  		nvme_start_queues(&dev->ctrl);
>>  		nvme_wait_freeze(&dev->ctrl);
>>  		/* hit this only when allocate tagset fails */
>> -- 
> 
