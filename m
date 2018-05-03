Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeECWBx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:01:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35872 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeECWBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:01:51 -0400
X-Google-Smtp-Source: AB8JxZoQ7dUSqEPNerzpnD9lNBg/JY3HIBLxOQLs6EkCjtHRe2F0Lqddz8ipwVDY9OH4fD7x5h0tgQ==
Date: Thu, 3 May 2018 16:01:48 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Lidong Chen <jemmy858585@gmail.com>, dledford@redhat.com,
        akpm@linux-foundation.org, qing.huang@oracle.com,
        artemyko@mellanox.com, dan.j.williams@intel.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        adido@mellanox.com, galsha@mellanox.com, aviadye@mellanox.com,
        Lidong Chen <lidongchen@tencent.com>
Subject: Re: [PATCH] IB/umem: use tgid instead of pid in ib_umem structure
Message-ID: <20180503220148.GC14956@ziepe.ca>
References: <1525356274-736-1-git-send-email-lidongchen@tencent.com>
 <20180503153310.GA9738@ziepe.ca>
 <20180503181235.GB4473@mtr-leonro.local>
 <20180503182656.GB14956@ziepe.ca>
 <20180503184301.GD4473@mtr-leonro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503184301.GD4473@mtr-leonro.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 09:43:01PM +0300, Leon Romanovsky wrote:
> On Thu, May 03, 2018 at 12:26:56PM -0600, Jason Gunthorpe wrote:
> > On Thu, May 03, 2018 at 09:12:35PM +0300, Leon Romanovsky wrote:
> > > On Thu, May 03, 2018 at 09:33:10AM -0600, Jason Gunthorpe wrote:
> > > > On Thu, May 03, 2018 at 10:04:34PM +0800, Lidong Chen wrote:
> > > > > The userspace may invoke ibv_reg_mr and ibv_dereg_mr by different threads.
> > > > > If when ibv_dereg_mr invoke and the thread which invoked ibv_reg_mr has
> > > > > exited, get_pid_task will return NULL, ib_umem_release does not decrease
> > > > > mm->pinned_vm. This patch fixes it by use tgid.
> > > > >
> > > > > Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> > > > >  drivers/infiniband/core/umem.c | 12 ++++++------
> > > > >  include/rdma/ib_umem.h         |  2 +-
> > > > >  2 files changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > Why are we even using a struct pid for this? Does anyone know?
> > > >
> > >
> > > Can it be related to "fork" support?
> >
> > Not sure..
> >
> > Ideally we want to hold the struct mm, but we can't hold it long
> > term, so pid is a surrogate for that.
> >
> > > > I'm surprised that struct task isn't held in the struct ib_umem..
> > > >
> > >
> > > I think that this code can be removed and all accesses to mm_struct can
> > > be done with "current->mm".
> >
> > That sounds wrong for fork support, as the mm used in destroy MUST
> > exactly match the mm used in create..
> >
> > How does this accounting work in fork anyhow?
> 
> We are not supporting fork, so this is why I proposed to remove it.

Er, the new kabi certainly can call reg and dereg across a fork

Jason
