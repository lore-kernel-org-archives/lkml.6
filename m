Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCTOyZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:54:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44948 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:54:21 -0400
X-Google-Smtp-Source: AG47ELuKzfeAR82sm123rv3UpY2nPyLpUSEGkJYD6XreCapcUodIv1nRkMeL+g1Olc+SSXe6GXxiKw==
Date: Tue, 20 Mar 2018 08:54:13 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] IB/nes: Eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <20180320145413.GH19744@ziepe.ca>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-6-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521514068-8856-6-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:47:47PM -0400, Sinan Kaya wrote:
> Code includes barrier() followed by writel(). writel() already has a
> barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Create a new wrapper function with relaxed write operator. Use the new
> wrapper when a write is following a barrier().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>  drivers/infiniband/hw/nes/nes.h       |  5 +++++
>  drivers/infiniband/hw/nes/nes_hw.c    | 21 ++++++++++++++-------
>  drivers/infiniband/hw/nes/nes_mgt.c   | 15 ++++++++++-----
>  drivers/infiniband/hw/nes/nes_nic.c   |  2 +-
>  drivers/infiniband/hw/nes/nes_utils.c |  3 ++-
>  drivers/infiniband/hw/nes/nes_verbs.c |  5 +++--
>  6 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/nes.h
> index 00c27291..85e007d 100644
> +++ b/drivers/infiniband/hw/nes/nes.h
> @@ -387,6 +387,11 @@ static inline void nes_write_indexed(struct nes_device *nesdev, u32 reg_index, u
>  	spin_unlock_irqrestore(&nesdev->indexed_regs_lock, flags);
>  }
>  
> +static inline void nes_write32_relaxed(void __iomem *addr, u32 val)
> +{
> +	writel_relaxed(val, addr);
> +}

This wrapper is pointless, let us not add more..

>  static inline void nes_write32(void __iomem *addr, u32 val)
>  {
>  	writel(val, addr);
> diff --git a/drivers/infiniband/hw/nes/nes_hw.c b/drivers/infiniband/hw/nes/nes_hw.c
> index 18a7de1..568e17d 100644
> +++ b/drivers/infiniband/hw/nes/nes_hw.c
> @@ -1257,7 +1257,8 @@ int nes_destroy_cqp(struct nes_device *nesdev)
>  
>  	barrier();
>  	/* Ring doorbell (5 WQEs) */
> -	nes_write32(nesdev->regs+NES_WQE_ALLOC, 0x05800000 | nesdev->cqp.qp_id);
> +	nes_write32_relaxed(nesdev->regs+NES_WQE_ALLOC,
> +			    0x05800000 | nesdev->cqp.qp_id);

barrier() is not strong enough to order writel, so this doesn't seem
right?

It is probably noteven strong enough for what this driver thinks it is
doing..  This driver is essentially dead and broken, probably just
don't change it.

Jason
