Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbeDQQq6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:46:58 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35857 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeDQQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:46:52 -0400
X-Google-Smtp-Source: AIpwx4+P/sP+xZtNH2WCKFtE62jTvKVtrI210VrlxtQ+Mh6yLszqyf1ofn8I5wH1qViyeNR5fqgD/Q==
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Kees Cook <keescook@chromium.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com>
 <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
 <2864697.7uzmEJovl2@natalenko.name>
 <CAGXu5jLSmJv9AstzsgSscrv-wA7FwfrxAKRxj-FVBmihQvnj1g@mail.gmail.com>
 <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
 <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
 <CAGXu5jKuZwicyyXH2gB3vp-OjtS+MkG+hqxV1cq1jaG9vAAO=g@mail.gmail.com>
 <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com>
 <CAGXu5jLsX+nmc8hRSdOa28js7=ggPSGkUuTHbc3DUEcKSpEDbw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <001d538b-dfc1-b39e-56ad-cd54c807f247@kernel.dk>
Date: Tue, 17 Apr 2018 10:46:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLsX+nmc8hRSdOa28js7=ggPSGkUuTHbc3DUEcKSpEDbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/18 10:42 AM, Kees Cook wrote:
> On Mon, Apr 16, 2018 at 8:12 PM, Kees Cook <keescook@chromium.org> wrote:
>> With a hardware watchpoint, I've isolated the corruption to here:
>>
>> bfq_dispatch_request+0x2be/0x1610:
>> __bfq_dispatch_request at block/bfq-iosched.c:3902
>> 3900            if (rq) {
>> 3901    inc_in_driver_start_rq:
>> 3902                    bfqd->rq_in_driver++;
>> 3903    start_rq:
>> 3904                    rq->rq_flags |= RQF_STARTED;
>> 3905            }
> 
> FWIW, the stacktrace here (removing the ? lines) is:
> 
> [   34.311980] RIP: 0010:bfq_dispatch_request+0x2be/0x1610
> [   34.452491]  blk_mq_do_dispatch_sched+0x1d9/0x260
> [   34.454561]  blk_mq_sched_dispatch_requests+0x3da/0x4b0
> [   34.458789]  __blk_mq_run_hw_queue+0xae/0x130
> [   34.460001]  __blk_mq_delay_run_hw_queue+0x192/0x280
> [   34.460823]  blk_mq_run_hw_queue+0x10b/0x1b0
> [   34.463240]  blk_mq_sched_insert_request+0x3bd/0x4d0
> [   34.467342]  blk_execute_rq+0xcf/0x140
> [   34.468483]  sg_io+0x2f7/0x730
> 
> Can anyone tell me more about the memory allocation layout of the
> various variables here? It looks like struct request is a header in
> front of struct scsi_request? How do struct elevator_queue, struct
> blk_mq_ctx, and struct blk_mq_hw_ctx overlap these?

The scsi_request is a payload item for the block request, it's
located right after the request in memory. These are persistent
allocations, we don't allocate/free them per IO.

blk_mq_ctx are the blk-mq software queues, they are percpu and
allocated when the queue is setup.

blk_mq_hw_ctx is the hardware queue. You probably have just one,
it's allocated when the queue is setup.

struct elevator_queue is allocated when the scheduler is attached
to the queue. This can get freed and allocated if you switch
the scheduler on a queue, otherwise it persists until the queue
is torn down (and the scheduler data is freed).

> Regardless, I'll check for elevator data changing too...

It should not change unless you switch IO schedulers. If you're
using BFQ and not switching, then it won't change.

-- 
Jens Axboe
