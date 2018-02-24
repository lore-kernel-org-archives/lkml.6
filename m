Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeBXJEq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 04:04:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeBXJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 04:04:42 -0500
Subject: Re: [PATCH V2] nvme-pci: set cq_vector to -1 if io queue setup fails
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <204f523b-b4dd-d0d4-a5c8-8f0a744eb54f@oracle.com>
Date: Sat, 24 Feb 2018 17:04:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802240117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Can you take a review on this ?

Thanks in advance
Really appreciate
Jianchao

On 02/15/2018 07:13 PM, Jianchao Wang wrote:
> nvme cq irq is freed based on queue_count. When the sq/cq creation
> fails, irq will not be setup. free_irq will warn 'Try to free
> already-free irq'.
> 
> To fix it, set the nvmeq->cq_vector to -1, then nvme_suspend_queue
> will ignore it.
> 
> Change log:
> V1 -> V2
>  - Follow Keith's suggestion, just set cq_vector to -1 if io queue setup
>    fails.
>  - Change patch name and comment
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/nvme/host/pci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4a7c420..f4528ef 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1452,7 +1452,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>  	nvmeq->cq_vector = qid - 1;
>  	result = adapter_alloc_cq(dev, qid, nvmeq);
>  	if (result < 0)
> -		return result;
> +		goto clean_cq_vector;
>  
>  	result = adapter_alloc_sq(dev, qid, nvmeq);
>  	if (result < 0)
> @@ -1461,14 +1461,17 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>  	nvme_init_queue(nvmeq, qid);
>  	result = queue_request_irq(nvmeq);
>  	if (result < 0)
> -		goto release_sq;
> +		goto offline;
>  
>  	return result;
>  
> - release_sq:
> +offline:
> +	dev->online_queues--;
>  	adapter_delete_sq(dev, qid);
> - release_cq:
> +release_cq:
>  	adapter_delete_cq(dev, qid);
> +clean_cq_vector:
> +	nvmeq->cq_vector = -1;
>  	return result;
>  }
>  
> 
