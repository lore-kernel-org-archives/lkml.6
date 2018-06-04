Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeFDQm5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:42:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40845 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFDQmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:42:55 -0400
X-Google-Smtp-Source: ADUXVKI6vI6a8d6AQ8bSFu44lU+DO3C+CtQtKFl3MXam5M/xdtsNGcF3soT44LJd1KjHhT3VCJwu8Q==
Date: Mon, 4 Jun 2018 10:42:49 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, noamr@beyondsecurity.com,
        Sean Hefty <sean.hefty@intel.com>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] infiniband: fix a possible use-after-free bug
Message-ID: <20180604164249.GA32294@ziepe.ca>
References: <20180601183144.17374-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601183144.17374-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:31:44AM -0700, Cong Wang wrote:
> ucma_process_join() will free the new allocated "mc" struct,
> if there is any error after that, especially the copy_to_user().
> 
> But in parallel, ucma_leave_multicast() could find this "mc"
> through idr_find() before ucma_process_join() frees it, since it
> is already published.
> 
> So "mc" could be used in ucma_leave_multicast() after it is been
> allocated and freed in ucma_process_join(), since we don't refcnt
> it.
> 
> Fix this by separating "publish" from ID allocation, so that we
> can get an ID first and publish it later after copy_to_user().
> 
> Fixes c8f6a362bf3e ("RDMA/cma: Add multicast communication support")
> Reported-by: Noam Rathaus <noamr@beyondsecurity.com>
> Cc: Sean Hefty <sean.hefty@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  drivers/infiniband/core/ucma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Looks good to me, and we already fixed the same sort of bug in the
non-multicast IDs.. Applied to for-next

Jason
