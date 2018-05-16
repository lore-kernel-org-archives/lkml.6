Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeEPHcu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:32:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54476 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeEPHct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:32:49 -0400
X-Google-Smtp-Source: AB8JxZqJkWSGF+iQp1C6wJHdc9pPAaJiFHsPF4v/shA9lRopmMsPHNPzaw/ejvWyYU3W3kUmzoQj9ozSY/2/0l63MxE=
MIME-Version: 1.0
In-Reply-To: <20180515231445.GA15921@ziepe.ca>
References: <1525769416-14596-1-git-send-email-lidongchen@tencent.com> <20180515231445.GA15921@ziepe.ca>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 16 May 2018 15:32:48 +0800
Message-ID: <CAOGPPbf-gQLd93mZ6pLCw4-QgcBqQOhDf33zj+3Rb2SEfk=VNw@mail.gmail.com>
Subject: Re: [PATCH v2] IB/umem: ib_ucontext already have tgid, remove pid
 from ib_umem structure
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: dledford@redhat.com, akpm@linux-foundation.org, qing.huang@oracle.com,
        Leon Romanovsky <leon@kernel.org>, artemyko@mellanox.com,
        dan.j.williams@intel.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, adido@mellanox.com,
        Gal Shachaf <galsha@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Lidong Chen <lidongchen@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 7:14 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, May 08, 2018 at 04:50:16PM +0800, Lidong Chen wrote:
>> The userspace may invoke ibv_reg_mr and ibv_dereg_mr by different threads.
>> If when ibv_dereg_mr invoke and the thread which invoked ibv_reg_mr has
>> exited, get_pid_task will return NULL, ib_umem_release does not decrease
>> mm->pinned_vm. This patch fixes it by use tgid in ib_ucontext struct.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  [v2]
>>  - use ib_ucontext tgid instread of tgid in ib_umem structure
>>
>>  drivers/infiniband/core/umem.c | 7 +------
>>  include/rdma/ib_umem.h         | 1 -
>>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> Applied to for-rc, thanks.
>
> It would be nice to send a cleanup to have all the users of tgid doing
> this pattern
>
>         task = get_pid_task(umem->context->tgid, PIDTYPE_PID);
>         if (!task)
>                 goto out;
>         mm = get_task_mm(task);
>
> To call some kind of common function like ib_get_mr_mm(), just to make
> it really clear what is happening.

OK, I will submit a patch for this.

>
> Jason
