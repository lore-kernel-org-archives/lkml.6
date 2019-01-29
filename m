Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703EE20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NMbkgebY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfA2Q4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:56:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41648 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfA2Q4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:56:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so9923717pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vql8U89T/hHjjSzQxptcPZRte1dCUtGT4jirdck/APc=;
        b=NMbkgebY4EHpMOLHRgtVlKvOjuX6dyFymsNZhkYtjK443i2AjiQt+z6bxBHHct8Bww
         wzsMnAoS90uq9JaU2oJNE5Dj2Fv5HyJwccSs2JZtgphXK2yxoG0yPBFToljtFTmEtS1J
         3H6QOdODDPg0gppQzDjVY8zf2ZEMysqVYB9fTESNjD+HSo5sBm9hv1NFY4phiHAh/bFS
         Z896B5MgcgR5WxlxIKu7EXEH8JUxhIRJzQyA+vv6sX3qTwfyyVyofRGenZynTxV/m5Zu
         z7eEt7kT/xq2jWrr4bHJhiZTYNyNozTc2rRc4kRHcEOT9sUrDDzrxgf7FcZMSBGxgwZQ
         PGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vql8U89T/hHjjSzQxptcPZRte1dCUtGT4jirdck/APc=;
        b=CyfhHW0pBUS4E8VmR2ErtIAS9ilp7WmFzA6QWCh5J0qcqSQRmJdCR8mNXS3NI9cEL8
         srfFx8mDcFD1jKgRpzZRxCpdfv1tsGvc/2iJYmlrmKHOBPNh7/I2aylyDS3ba4Gp6tPO
         g3if0mFTQbetdhTfGH+EiG0q2C7taxR+v6qcwCl9OKd71RRgZXCx7re0hJqqVTFVY326
         TFaKJaAlLiMOiU2ibL7FRc7ehR1Cmq72SroeWNtRFAFaG9EOfQLm9CgGAl5NP52D4ARl
         GS+xpa/Xf9kse5bvftR/N78Sjf9lqHld89yqdjzpQIeqIhVnXqz5qIHVTfM094djrC0D
         KBpg==
X-Gm-Message-State: AJcUukcJ3tVI8MAC6coo/pOYk27FvLjuh1BRFYg1rjN7YgOoU9hA6rEe
        qzi1YJ712wEonrtYDNrnls4b1A==
X-Google-Smtp-Source: ALg8bN7ptJmZpJU3paI7ZW9MPDibRYYoJVCL3anlb16ShHdSnpfegJMezROCztjWwoW943HbFr5O6g==
X-Received: by 2002:a63:e915:: with SMTP id i21mr23854042pgh.409.1548780981421;
        Tue, 29 Jan 2019 08:56:21 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v9sm47049062pfe.49.2019.01.29.08.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 08:56:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1goWgO-0003Dw-05; Tue, 29 Jan 2019 09:56:20 -0700
Date:   Tue, 29 Jan 2019 09:56:19 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] RDMA/uverbs: add owner parameter to ib_umem_get
Message-ID: <20190129165619.GC10094@ziepe.ca>
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
 <1548768386-28289-4-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548768386-28289-4-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:26:24PM +0200, Joel Nider wrote:
> ib_umem_get is a core function used by drivers that support RDMA.
> The 'owner' parameter signifies the process that owns the memory.
> Until now, it was assumed that the owning process was the current
> process. This adds the flexibility to specify a process other than
> the current process. All drivers that call this function are also
> updated, but the default behaviour is to keep backwards
> compatibility by assuming the current process is the owner when
> the 'owner' parameter is NULL.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
>  drivers/infiniband/core/umem.c                | 26 ++++++++++++++++++++------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 10 +++++-----
>  drivers/infiniband/hw/cxgb3/iwch_provider.c   |  3 ++-
>  drivers/infiniband/hw/cxgb4/mem.c             |  3 ++-
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_db.c       |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_qp.c       |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  2 +-
>  drivers/infiniband/hw/mlx4/cq.c               |  2 +-
>  drivers/infiniband/hw/mlx4/doorbell.c         |  2 +-
>  drivers/infiniband/hw/mlx4/mr.c               |  2 +-
>  drivers/infiniband/hw/mlx4/qp.c               |  2 +-
>  drivers/infiniband/hw/mlx4/srq.c              |  2 +-
>  drivers/infiniband/hw/mlx5/cq.c               |  4 ++--
>  drivers/infiniband/hw/mlx5/devx.c             |  2 +-
>  drivers/infiniband/hw/mlx5/doorbell.c         |  2 +-
>  drivers/infiniband/hw/mlx5/mr.c               | 15 ++++++++-------
>  drivers/infiniband/hw/mlx5/odp.c              |  5 +++--
>  drivers/infiniband/hw/mlx5/qp.c               |  4 ++--
>  drivers/infiniband/hw/mlx5/srq.c              |  2 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c  |  2 +-
>  drivers/infiniband/hw/nes/nes_verbs.c         |  3 ++-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  3 ++-
>  drivers/infiniband/hw/qedr/verbs.c            |  8 +++++---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  5 +++--
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  2 +-
>  drivers/infiniband/sw/rdmavt/mr.c             |  2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c            |  3 ++-
>  include/rdma/ib_umem.h                        |  3 ++-
>  33 files changed, 80 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index c6144df..9646cee 100644
> +++ b/drivers/infiniband/core/umem.c
> @@ -71,15 +71,21 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>   *
>   * If access flags indicate ODP memory, avoid pinning. Instead, stores
>   * the mm for future page fault handling in conjunction with MMU notifiers.
> + * If the process doing the pinning is the same as the process that owns
> + * the memory being pinned, 'owner' should be NULL. Otherwise, 'owner' should
> + * be the process ID of the owning process. The process ID must be in the
> + * same PID namespace as the calling userspace context.
>   *
> - * @context: userspace context to pin memory for
> + * @context: userspace context that is pinning the memory
>   * @addr: userspace virtual address to start at
>   * @size: length of region to pin
>   * @access: IB_ACCESS_xxx flags for memory being pinned
>   * @dmasync: flush in-flight DMA when the memory region is written
> + * @owner: the ID of the process that owns the memory being pinned
>   */
>  struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
> -			    size_t size, int access, int dmasync)
> +			    size_t size, int access, int dmasync,
> +			    struct pid *owner)

You need to rebase this patch on rdma's for-next tree, the signature is
different.

Jason
