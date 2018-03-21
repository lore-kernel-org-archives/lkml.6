Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeCUUC5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:02:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45451 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbeCUUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:02:55 -0400
X-Google-Smtp-Source: AG47ELvadzyAC3PbNc9xiDEiTa83irrOuzZ2qr6hKFj7Z97If9DL6Wl1Ckkddnz9JMt1aAMOYDoxTQ==
Date: Wed, 21 Mar 2018 14:02:53 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] RDMA/i40iw: Eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <20180321200253.GA21453@ziepe.ca>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:47:45PM -0400, Sinan Kaya wrote:
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> index 8afa5a6..7f0ebed 100644
> +++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
> @@ -723,7 +723,7 @@ static void i40iw_cq_request_notification(struct i40iw_cq_uk *cq,
>  
>  	wmb(); /* make sure WQE is populated before valid bit is set */
>  
> -	writel(cq->cq_id, cq->cqe_alloc_reg);
> +	writel_relaxed(cq->cq_id, cq->cqe_alloc_reg);
>  }

Ah, this one is probably not OK, i40iw_cq_request_notification is
called here:

	spin_lock_irqsave(&iwcq->lock, flags);
	ukcq->ops.iw_cq_request_notification(ukcq, cq_notify);
	spin_unlock_irqrestore(&iwcq->lock, flags);

So this needs to add mmmiomb(); to keep the same semantics.

Generally I think you need to be very careful to ensure that any
conversion to _relaxed isn't contained by a spinlock, or the mmiomb()
is present.

Maybe even do a first series with this obviously correct pattern:

 wmb();
 writel() -> writel_relaxed()
 writel() -> writel_relaxed()
 [..]
 mmiowmb();

Jason
