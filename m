Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBHBlO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:41:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45872 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeBHBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:41:12 -0500
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
 <c5ae0bc0-260e-3a72-5c47-304c0b5034a6@oracle.com>
 <20180207161345.GB1337@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <1826ebc1-d419-23da-12d4-dd7b1b3fe598@oracle.com>
Date: Thu, 8 Feb 2018 09:40:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207161345.GB1337@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080013
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith


Really thanks for your your precious time and kindly directive.
That's really appreciated. :)

On 02/08/2018 12:13 AM, Keith Busch wrote:
> On Wed, Feb 07, 2018 at 10:13:51AM +0800, jianchao.wang wrote:
>> What's the difference ? Can you please point out.
>> I have shared my understanding below.
>> But actually, I don't get the point what's the difference you said.
> 
> It sounds like you have all the pieces. Just keep this in mind: we don't
> want to fail IO if we can prevent it.
> 
Yes, absolutely.

> A request is allocated from an hctx pool of tags. Once the request is
> allocated, it is permently tied to that hctx because that's where its
> tag came from. If that hctx becomes invalid, the request has to be ended
> with an error, and we can't do anything about that[*].
> 
> Prior to a reset, we currently halt new requests from being allocated by
> freezing the request queues. We unfreeze the queues after the new state
> of the hctx's is established. This way all IO requests that were gating
> on the unfreeze are guaranteed to enter into a valid context.
> 
> You are proposing to skip freeze on a reset. New requests will then be
> allocated before we've established the hctx map. Any request allocated
> will have to be terminated in failure if the hctx is no longer valid
> once the reset completes.
Yes, if any previous hctx doesn't come back, the requests on that hctx
will be drained with BLK_STS_IOERR.
__blk_mq_update_nr_hw_queues
  -> blk_mq_freeze_queue
    -> blk_freeze_queue
      -> blk_mq_freeze_queue_wait 
But the nvmeq's cq_vector is -1.
 
> Yes, it's entirely possible today a request allocated prior to the reset
> may need to be terminated after the reset. There's nothing we can do
> about those except end them in failure, but we can prevent new ones from
> sharing the same fate. You are removing that prevention, and that's what
> I am complaining about.

Thanks again for your precious time to detail this.
So I got what you concern about is that this patch doesn't freeze the queue for reset case
any more. And there maybe new requests enter, which will be failed when the associated
hctx doesn't come back during reset procedure. And this should be avoided.

I will change this in next V3 version.


>  * Future consideration: we recently obtained a way to "steal" bios that
> looks like it may be used to back out certain types of requests and let
> the bio create a new one.
> 
Yeah, that will be a great idea to reduce the loss when hctx is gone.

Sincerely
Jianchao
