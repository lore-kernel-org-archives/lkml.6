Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeEDPYH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:24:07 -0400
Received: from mail4.tencent.com ([183.57.53.109]:42746 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbeEDPYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:24:06 -0400
From: =?gb2312?B?bGlkb25nY2hlbiizwsGitqsp?= <lidongchen@tencent.com>
To: Leon Romanovsky <leon@kernel.org>
CC: 858585 jemmy <jemmy858585@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "qing.huang@oracle.com" <qing.huang@oracle.com>,
        "artemyko@mellanox.com" <artemyko@mellanox.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adido@mellanox.com" <adido@mellanox.com>,
        Gal Shachaf <galsha@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>
Subject: Re: [PATCH] IB/umem: use tgid instead of pid in ib_umem structure
Thread-Topic: [PATCH] IB/umem: use tgid instead of pid in ib_umem structure
Thread-Index: AQHT47qL+flI5zHncECxlqS3oqs/iw==
Date: Fri, 4 May 2018 15:14:06 +0000
Message-ID: <011606E7-9AE2-4250-A687-307C7D687FA9@tencent.com>
References: <1525356274-736-1-git-send-email-lidongchen@tencent.com>
 <20180503153310.GA9738@ziepe.ca> <20180503181235.GB4473@mtr-leonro.local>
 <20180503182656.GB14956@ziepe.ca> <20180503184301.GD4473@mtr-leonro.local>
 <20180503220148.GC14956@ziepe.ca>
 <CAOGPPbfwOHy547d3attGxMW=muRhHGRhxxtnoSDd_SZYu_c3fg@mail.gmail.com>,<20180504133929.GF4473@mtr-leonro.local>
In-Reply-To: <20180504133929.GF4473@mtr-leonro.local>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w44FOBsq006056



> 在 2018年5月4日，21:39，Leon Romanovsky <leon@kernel.org> 写道：
> 
>> On Fri, May 04, 2018 at 04:32:38PM +0800, 858585 jemmy wrote:
>>> On Fri, May 4, 2018 at 6:01 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>> On Thu, May 03, 2018 at 09:43:01PM +0300, Leon Romanovsky wrote:
>>>>> On Thu, May 03, 2018 at 12:26:56PM -0600, Jason Gunthorpe wrote:
>>>>>> On Thu, May 03, 2018 at 09:12:35PM +0300, Leon Romanovsky wrote:
>>>>>>> On Thu, May 03, 2018 at 09:33:10AM -0600, Jason Gunthorpe wrote:
>>>>>>>> On Thu, May 03, 2018 at 10:04:34PM +0800, Lidong Chen wrote:
>>>>>>>> The userspace may invoke ibv_reg_mr and ibv_dereg_mr by different threads.
>>>>>>>> If when ibv_dereg_mr invoke and the thread which invoked ibv_reg_mr has
>>>>>>>> exited, get_pid_task will return NULL, ib_umem_release does not decrease
>>>>>>>> mm->pinned_vm. This patch fixes it by use tgid.
>>>>>>>> 
>>>>>>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>>>>>>> drivers/infiniband/core/umem.c | 12 ++++++------
>>>>>>>> include/rdma/ib_umem.h         |  2 +-
>>>>>>>> 2 files changed, 7 insertions(+), 7 deletions(-)
>>>>>>> 
>>>>>>> Why are we even using a struct pid for this? Does anyone know?
>>>>>>> 
>>>>>> 
>>>>>> Can it be related to "fork" support?
>>>>> 
>>>>> Not sure..
>>>>> 
>>>>> Ideally we want to hold the struct mm, but we can't hold it long
>>>>> term, so pid is a surrogate for that.
>>>>> 
>>>>>>> I'm surprised that struct task isn't held in the struct ib_umem..
>>>>>>> 
>>>>>> 
>>>>>> I think that this code can be removed and all accesses to mm_struct can
>>>>>> be done with "current->mm".
>>>>> 
>>>>> That sounds wrong for fork support, as the mm used in destroy MUST
>>>>> exactly match the mm used in create..
>>>>> 
>>>>> How does this accounting work in fork anyhow?
>>>> 
>>>> We are not supporting fork, so this is why I proposed to remove it.
>>> 
>>> Er, the new kabi certainly can call reg and dereg across a fork
>> 
>> what is the expect behavior after fork?
>> I write a test code, the dereg just return EACCES in the child
>> process. and have no effect.
> 
> Did you do reg/dereg over write() interface? If yes, this is expected
> behaviour of "not-supported fork()". A couple of months/years ago, your
> test program would work, but we closed this option due to security
> constraints.

the parent process call ibv_reg_mr, and the child process call ibv_dereg_mr.

If fork is not supported now, so use tgid to get mm structure is fine for multithread.

> 
> Thanks
> 
>> 
>>> 
>>> Jason
