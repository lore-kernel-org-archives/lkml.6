Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeB1CyA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:54:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50794 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeB1Cx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:53:59 -0500
Subject: Re: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180227151311.GD10832@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>
Date: Wed, 28 Feb 2018 10:53:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227151311.GD10832@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=851
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your precious time to review this.

On 02/27/2018 11:13 PM, Keith Busch wrote:
> On Tue, Feb 27, 2018 at 04:46:17PM +0800, Jianchao Wang wrote:
>> Currently, adminq and ioq0 share the same irq vector. This is
>> unfair for both amdinq and ioq0.
>>  - For adminq, its completion irq has to be bound on cpu0.
>>  - For ioq0, when the irq fires for io completion, the adminq irq
>>    action has to be checked also.
> 
> This change log could use some improvements. Why is it bad if admin
> interrupts affinity is with cpu0?

adminq interrupts should be able to fire everywhere.
do we have any reason to bound it on cpu0 ?

> 
> Are you able to measure _any_ performance difference on IO queue 1 vs IO
> queue 2 that you can attribute to IO queue 1's sharing vector 0?

Actually, I didn't get any performance improving on my own NVMe card.
But it may be needed on some enterprise card, especially the media is persist memory.
nvme_irq will be invoked twice when ioq0 irq fires, this will introduce another unnecessary DMA
accessing on cq entry.

>  
>> @@ -1945,11 +1947,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>  	 * setting up the full range we need.
>>  	 */
>>  	pci_free_irq_vectors(pdev);
>> -	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
>> -			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
>> -	if (nr_io_queues <= 0)
>> +	ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
>> +			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>> +	if (ret <= 0)
>>  		return -EIO;
>> -	dev->max_qid = nr_io_queues;
>> +	dev->max_qid = ret - 1;
> 
> So controllers that have only legacy or single-message MSI don't get any
> IO queues?
> 

Yes. At the moment, we have to share the only one irq vector.

Thanks for your directive. :)
Jianchao
