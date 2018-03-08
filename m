Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935800AbeCHNLz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:11:55 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35509 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935769AbeCHNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:11:54 -0500
X-Google-Smtp-Source: AG47ELuJojnHY/0zJPdxQTGDF+7sqlxXYZWUBk2wTZJeaHVRATd7V0BcZ87/+eRGpuVww10mBcdiP1oRSGYFOUPOJvs=
MIME-Version: 1.0
In-Reply-To: <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com> <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 8 Mar 2018 21:11:51 +0800
Message-ID: <CACVXFVPWLu8son4UgnXCH4XGFmLt9x6BYbQqYVG4wSk_Or+WmQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] nvme: add helper interface to flush in-flight requests
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 2:19 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, we use nvme_cancel_request to complete the request
> forcedly. This has following defects:
>  - It is not safe to race with the normal completion path.
>    blk_mq_complete_request is ok to race with timeout path,
>    but not with itself.

The irq path shouldn't be raced with nvme_cancel_request()
because io queues are suspended before calling nvme_cancel_request().

Could you please explain a bit why one same request can be
completed at the same time via blk_mq_complete_request()?

>  - Cannot ensure all the requests have been handled. The timeout
>    path may grab some expired requests, blk_mq_complete_request
>    cannot touch them.
>
> add two helper interface to flush in-flight requests more safely.
> - nvme_abort_requests_sync
> use nvme_abort_req to timeout all the in-flight requests and wait
> until timeout work and irq completion path completes. More details
> please refer to the comment of this interface.
> - nvme_flush_aborted_requests
> complete the requests 'aborted' by nvme_abort_requests_sync. It will
> be invoked after the controller is disabled/shutdown.

IMO, the helper's name of 'abort' is very misleading since the request
isn't aborted actually, it is just cancelled from dispatched state, once
it is cancelled, most of times the request is just re-inserted to sw
queue or scheduler queue. After NVMe controller is resetted successfully,
these request will be dispatched again.

So please keep the name of 'cancel' or use sort of name.

Thanks,
Ming Lei
