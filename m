Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEOXOt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:14:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45851 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeEOXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:14:47 -0400
X-Google-Smtp-Source: AB8JxZpzIGo0oH4vAffpcWIZLu8R584i8o28P1zCSqvxdF7N2SszroPTMwbGWBPtmPsM1kmcc1LC/Q==
Date: Tue, 15 May 2018 17:14:45 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: dledford@redhat.com, akpm@linux-foundation.org, qing.huang@oracle.com,
        leon@kernel.org, artemyko@mellanox.com, dan.j.williams@intel.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        adido@mellanox.com, galsha@mellanox.com, aviadye@mellanox.com,
        Lidong Chen <lidongchen@tencent.com>
Subject: Re: [PATCH v2] IB/umem: ib_ucontext already have tgid, remove pid
 from ib_umem structure
Message-ID: <20180515231445.GA15921@ziepe.ca>
References: <1525769416-14596-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525769416-14596-1-git-send-email-lidongchen@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 04:50:16PM +0800, Lidong Chen wrote:
> The userspace may invoke ibv_reg_mr and ibv_dereg_mr by different threads.
> If when ibv_dereg_mr invoke and the thread which invoked ibv_reg_mr has
> exited, get_pid_task will return NULL, ib_umem_release does not decrease
> mm->pinned_vm. This patch fixes it by use tgid in ib_ucontext struct.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  [v2]
>  - use ib_ucontext tgid instread of tgid in ib_umem structure
>  
>  drivers/infiniband/core/umem.c | 7 +------
>  include/rdma/ib_umem.h         | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)

Applied to for-rc, thanks.

It would be nice to send a cleanup to have all the users of tgid doing
this pattern

	task = get_pid_task(umem->context->tgid, PIDTYPE_PID);
  	if (!task)
  		goto out;
  	mm = get_task_mm(task);

To call some kind of common function like ib_get_mr_mm(), just to make
it really clear what is happening. 

Jason
