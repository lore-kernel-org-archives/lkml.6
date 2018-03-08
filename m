Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754881AbeCHOpV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:45:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCHOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:45:20 -0500
Subject: Re: [PATCH V4 2/5] nvme: add helper interface to flush in-flight
 requests
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPWLu8son4UgnXCH4XGFmLt9x6BYbQqYVG4wSk_Or+WmQ@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <965e5e7c-3bbd-8569-c40a-d29310d0f3be@oracle.com>
Date: Thu, 8 Mar 2018 22:44:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVPWLu8son4UgnXCH4XGFmLt9x6BYbQqYVG4wSk_Or+WmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

Thanks for your precious time for reviewing and comment.

On 03/08/2018 09:11 PM, Ming Lei wrote:
> On Thu, Mar 8, 2018 at 2:19 PM, Jianchao Wang
> <jianchao.w.wang@oracle.com> wrote:
>> Currently, we use nvme_cancel_request to complete the request
>> forcedly. This has following defects:
>>  - It is not safe to race with the normal completion path.
>>    blk_mq_complete_request is ok to race with timeout path,
>>    but not with itself.
> 
> The irq path shouldn't be raced with nvme_cancel_request()
> because io queues are suspended before calling nvme_cancel_request().
> 
> Could you please explain a bit why one same request can be
> completed at the same time via blk_mq_complete_request()?

In fact, this interface will be used before suspend ioqs and disable controller.
Then the timeout path could be more clearly when we issue adminq commands during
nvme_dev_disable. Otherwise, it is hard to distinguish which is from previous workload
, which is from nvme_dev_disable. We will take different action for them.

>>  - Cannot ensure all the requests have been handled. The timeout
>>    path may grab some expired requests, blk_mq_complete_request
>>    cannot touch them.
>>
>> add two helper interface to flush in-flight requests more safely.
>> - nvme_abort_requests_sync
>> use nvme_abort_req to timeout all the in-flight requests and wait
>> until timeout work and irq completion path completes. More details
>> please refer to the comment of this interface.
>> - nvme_flush_aborted_requests
>> complete the requests 'aborted' by nvme_abort_requests_sync. It will
>> be invoked after the controller is disabled/shutdown.
> 
> IMO, the helper's name of 'abort' is very misleading since the request
> isn't aborted actually, it is just cancelled from dispatched state, once
> it is cancelled, most of times the request is just re-inserted to sw
> queue or scheduler queue. After NVMe controller is resetted successfully,
> these request will be dispatched again.
> 
> So please keep the name of 'cancel' or use sort of name.

Yes, it is indeed misleading.
In fact, this 'abort' inherits from the blk_abort_request which is invoked by
nvme_abort_req.
 
Thanks
Jianchao
