Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeBGCOx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 21:14:53 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48376 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbeBGCOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 21:14:52 -0500
Subject: Re: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown and
 reset case
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180202182413.GH24417@localhost.localdomain>
 <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
 <20180205151314.GP24417@localhost.localdomain>
 <d218f5f5-45f7-6036-00a5-48769101080f@oracle.com>
 <20180206151335.GE31110@localhost.localdomain>
 <e1994613-3cb6-f82b-3296-0f4afdb16314@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c5ae0bc0-260e-3a72-5c47-304c0b5034a6@oracle.com>
Date: Wed, 7 Feb 2018 10:13:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e1994613-3cb6-f82b-3296-0f4afdb16314@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070022
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Sorry for bothering you again.

On 02/07/2018 10:03 AM, jianchao.wang wrote:
> Hi Keith
> 
> Thanks for your time and kindly response on this.
> 
> On 02/06/2018 11:13 PM, Keith Busch wrote:
>> On Tue, Feb 06, 2018 at 09:46:36AM +0800, jianchao.wang wrote:
>>> Hi Keith
>>>
>>> Thanks for your kindly response.
>>>
>>> On 02/05/2018 11:13 PM, Keith Busch wrote:
>>>>  but how many requests are you letting enter to their demise by
>>>> freezing on the wrong side of the reset?
>>>
>>> There are only two difference with this patch from the original one.
>>> 1. Don't freeze the queue for the reset case. At the moment, the outstanding requests will be requeued back to blk-mq queues.
>>>    The new entered requests during reset will also stay in blk-mq queues. All this requests will not enter into nvme driver layer
>>>    due to quiescent request_queues. And they will be issued after the reset is completed successfully.
>>> 2. Drain the request queue before nvme_dev_disable. This is nearly same with the previous rule which will also unquiesce the queue
>>>    and let the requests be able to be drained. The only difference is this patch will invoke wait_freeze in nvme_dev_disable instead
>>>    of nvme_reset_work.
>>>
>>> We don't sacrifice any request. This patch do the same thing with the previous one and make things clearer.
>>
>> No, what you're proposing is quite different.

What's the difference ? Can you please point out.
I have shared my understanding below.
But actually, I don't get the point what's the difference you said.
Or what you refer to is about the 4th patch ? If yes, I also explain this below.

Really appreciate your precious time to explain this. :)
Many thanks
Jianchao

>>
>> By "enter", I'm referring to blk_queue_enter. 
> When a request is allocated, it will hold a request_queue->q_usage_counter until it is freed.
> Please refer to 
> blk_mq_get_request -> blk_queue_enter_live
> blk_mq_free_request -> blk_exit_queue
> 
> Regarding to 'request enters into an hctx', I cannot get the point.
> I think you should mean it enter into nvme driver layer.
> 
>> Once a request enters
>> into an hctx, it can not be backed out to re-enter a new hctx if the
>> original one is invalidated.
> 
> I also cannot get the point here. We certainly will not issue a request which
> has been issued to other hctx.
> What this patch and also the original one does is that disable/shutdown controller, 
> cancel and requeue  or fail the outstanding requests.
> 
> The requeue mechanism will ensure the requests to be inserted to the ctx where req->mq_ctx->cpu
> points to. 
> 
>>
>> Prior to a reset, all requests that have entered the queue are committed
>> to that hctx, 
> 
> A request could be on 
> - blk-mq per-cpu ctx->rq_list, IO scheduler list\
> - hctx->dispatch list or
> - request_queue->requeue_list (will be inserted to 1st case again)
> 
> When requests are issued, they will be dequeued from 1st or 2nd case and submitted to nvme driver layer.
> These requests are _outstanding_ ones.
> 
> When the request queue is quiesced, the request will be stayed in  blk-mq per-cpu ctx->rq_list, IO scheduler list
> or hctx->dispatch list, and cannot be issued to driver layer any more.
> When the request queue is frozen, it will gate the bio out of generic_make_request, so new request cannot enter
> blk-mq layer any more, and certainly the nvme driver layer.
> 
> For the reset case, the nvme controller will be back soon, we needn't freeze the queue, just quiescing is enough.
> The outstanding ones will be canceled and _requeued_ to request_queue->requeue_list, then they will be inserted into
> blk-mq layer again by requeue_work. When reset_work completes and start queues again, all the requests will be
> issued again. :)
> 
> For the shutdown case, freezing and quiescing is safer. Also we will wait them to be completed if the controller is still
> alive. If dead, we need to fail them directly instead of requeue them, otherwise, IO hung will come up, because controller
> will be offline for some time.
>   
> 
> and we can't do anything about that. The only thing we can
>> do is prevent new requests from entering until we're sure that hctx is
>> valid on the other side of the reset.
>>
> yes, that's is what this patch does.
> 
> Add some explaining about the 4th patch nvme-pci: break up nvme_timeout and nvme_dev_disable here.
> Also thanks for your time to look into this. That's really appreciated!
> 
> The key point is blk_abort_request. It will force the request to be expired and then handle the request
> in timeout work context. It is safe to race with the irq completion path. This is the most important reason
> to use blk_abort_request. 
> We don't _complete_ the request or _rearm_ the time, but just set a CANCELED flag. So request will not be freed.
> Then these requests cannot be taken away by irq completion path and time out path is also be avoid (no outstanding requests any more).
> So we say 'all the outstanding requests are grabbed'. When we close the controller totally, we could complete
> these requests safely. This is the core idea of the 4th patch.
> 
> Many thanks
> Jianchao
>  
> 
