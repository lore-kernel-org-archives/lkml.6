Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeE3O4I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:56:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeE3O4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:56:06 -0400
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: Ming Lei <tom.leiming@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader>
 <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
 <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
 <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com>
 <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
 <08921b9d-0f31-f31d-096f-6c4f3a1e4d4f@oracle.com>
 <CACVXFVPKdqb7p-xMQ_8c7Wa26s6O-36Pi0xNHMRDDR1Ar+bDhA@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ee4c1872-e78d-d41c-6d57-284ca1d37592@oracle.com>
Date: Wed, 30 May 2018 22:55:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVPKdqb7p-xMQ_8c7Wa26s6O-36Pi0xNHMRDDR1Ar+bDhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=521
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

Thanks for your kindly and detailed response. :)

On 05/30/2018 05:44 PM, Ming Lei wrote:
> On Wed, May 30, 2018 at 5:20 PM, jianchao.wang
> <jianchao.w.wang@oracle.com> wrote:
>> Hi ming
>>
>> On 05/30/2018 05:13 PM, Ming Lei wrote:
>>>> Yes, it maybe good for merging of 'none', because the rq_list is split into 3
>>>> lists, and not need to iterate the whole rq_list any more.
>>>> But what's about the dispatch when there is no io scheduler.
>>> blk_mq_flush_busy_ctxs() and blk_mq_dequeue_from_ctx() should work
>>> fine in case of 'none' if per-domain list is added to ctx. Then we can make
>>> none to be a bit fair on READ/WRITE.
>>>
>>
>> But how to determine when to dispatch READ, WRITE or other more, when there is no io scheduler ?
>>
> 
> For blk-mq, no io scheduler means 'none' actually, and it works like a
> scheduler too, but just shares driver tags, IMO.
> > Wrt. the current code of 'none', blk-mq just picks up one request from
> ctx->rq_list
> directly in FIFO style. If READ/WRITE lists are introduced, only
> blk_mq_dequeue_from_ctx() is effected, there are several choices
> left for us:
> 
> 1) keep the FIFO style of current behaviour by using req->start_time_ns
> 
> 2) READ/WRIRE fair style by picking up request from the lists in round-robin
> order
> 
> 3) or others
> 
> It just will make more choices for us, :-)

OK, I got the point.

But is it necessary to introduce kind of dispatch policy which is more complicated 
than current simple FIFO style in ctx rq_list dispatching ? 
If we have this kind of requirement, why not introduce an io scheduler ?
ITOW, shouldn't we keep the blk-mq core code as simple as possible, and put most of the policy
into io scheduler ?

Thanks
Jianchao
