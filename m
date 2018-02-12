Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeBLHzD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 02:55:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43654 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932819AbeBLHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 02:55:01 -0500
Subject: Re: [PATCH 8/9] nvme-pci: break up nvme_timeout and nvme_dev_disable
To: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-9-git-send-email-jianchao.w.wang@oracle.com>
 <4f2268ba-6b6a-8273-594c-b63fdb7b6a96@grimberg.me>
 <992179f4-becc-f0bf-867a-e49adbd756ee@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b8748837-616e-7e92-bf58-38246ae8ca0f@oracle.com>
Date: Mon, 12 Feb 2018 15:51:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <992179f4-becc-f0bf-867a-e49adbd756ee@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi

Just make some supplement here.

On 02/12/2018 10:16 AM, jianchao.wang wrote:
>> I think this is going in the wrong direction. Every state that is needed
>> to handle serialization should be done in core ctrl state. Moreover,
>> please try to avoid handling this locally in nvme-pci, place common
>> helpers in nvme-core and use them. I won't be surprised if fc would
>> need some of these.
>>
>> Also, can we try and not disable the controller from nvme_timeout?
> In fact, that is what this patch what to do. For the previous outstanding requests,
> this patch return BLK_EH_NOT_HANDLED and defer the work to nvme_dev_disable.
> 
>  I'm
>> not sure I understand why is this needed at all. What's wrong with
>> scheduling a controller reset/delete? Why is something like
>> nvme_pci_disable_ctrl_directly needed?
> Keith used to point out to me that, we cannot complete and free a request
> before we close the controller and pci master bus, otherwise, there will
> be somethings wrong in DMA accessing, because when we complete a request, 
> the associated DMA mapping will be freed.
> 
> For the previous outstanding requests, this patch could grab them with blk_abort_request
> in nvme_dev_disable, and complete them after we disable/shutdown the controller.
> 
> But for the adminq requests in nvme_dev_disable and nvme_reset_work, we cannot do this.
> We cannot schedule another reset_work->nvme_dev_disable to do that, because we are in it.
> So I use this nvme_pci_disable_ctrl_directly which looks like very ugly, to disable the
> controller and then we could complete the request with failure to move progress forward.
> 
>> I'd like to see an effort to consolidate error handling paths rather
>> than enhancing the current skew...
> Yes, absolutely. That is also what I expect. :)
> 
> This patch has two aspects:
> 1. grab all the previous outstanding requests with blk_abort_request.
>    It is safe when race with the irq completion path. And then complete them
>    after we disable/shutdown the controller completely.
>    I think this part could be placed in nvme ctrl core.

The 'grab' here is to avoid the timeout path to be triggered during nvme_dev_disable.
This is important, because nvme_timeout may issue IOs on adminq or invoke nvme_pci_disable_ctrl_directly
which could race with nvme_dev_disable.

> 2. avoid nvme_timeout invoke nvme_dev_disable. this is the most tricky part.

And also, this will introduce some dangerous scenarios. I have reported some of them before.

>    as I shared above, we have to _disable_ the controller _before_ we compete the adminq request
>    from the nvme_dev_disable and nvme_reset_work. Consequently, we cannot do as the
>    nvme_rdma_timeout, schedule a recovery work and then return. 

Actually, the nvme_timeout have a similar pattern with nvme_rdma_timeout.
When adminq/IOq request timeout, we can schedule reset_work for it. But if the requests from the reset_work
procedure timeout, we cannot schedule reset_work any more. At the moment, we have to close the controller
directly and fail the requests.

Looking forward some advice on this.
That's really appreciated.

Thanks
Jianchao
