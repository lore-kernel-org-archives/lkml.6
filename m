Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932880AbeEHIch (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:32:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56332 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754799AbeEHIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:32:34 -0400
Subject: Re: [PATCH] nvme-rdma: fix double free in nvme_rdma_free_queue
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1525420938-9492-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180507122736.GC27843@lst.de>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <65152af5-9dc1-d6fb-6790-6055535f8048@oracle.com>
Date: Tue, 8 May 2018 16:31:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507122736.GC27843@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On 05/07/2018 08:27 PM, Christoph Hellwig wrote:
> On Fri, May 04, 2018 at 04:02:18PM +0800, Jianchao Wang wrote:
>> BUG: KASAN: double-free or invalid-free in nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
>> Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
>> Call Trace:
>>  dump_stack+0x91/0xeb
>>  print_address_description+0x6b/0x290
>>  kasan_report_invalid_free+0x55/0x80
>>  __kasan_slab_free+0x176/0x190
>>  kfree+0xeb/0x310
>>  nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
>>  nvme_rdma_configure_admin_queue+0x1a3/0x4d0 [nvme_rdma]
>>  nvme_rdma_reset_ctrl_work+0x4e/0xd0 [nvme_rdma]
>>  process_one_work+0x3ca/0xaa0
>>  worker_thread+0x4e2/0x6c0
>>  kthread+0x18d/0x1e0
>>  ret_from_fork+0x24/0x30
>>
>> The double free is on ctrl->async_event_sqe.
>> If nvme_rdma_start_queue in nvme_rdma_configure_admin_queue fails,
>> nvme_rdma_free_queue will be invoked. However, at the moment, the
>> ctrl->async_event_sqe has not been allocated and it has been freed
>> in
>> nvme_rdma_reset_ctrl_work
>>   -> nvme_rdma_shutdown_ctrl
>>     ->nvme_rdma_destroy_admin_queue
>>       -> nvme_rdma_free_queue
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> 
> Can you handle this in the caller instead, maybe including a comment?
> 
Yes, that will be clearer.
Thanks for your suggestion.

Jianchao
