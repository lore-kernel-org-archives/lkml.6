Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCTOze (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:55:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45210 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:55:31 -0400
X-Google-Smtp-Source: AG47ELsoEZqSGBGj1jNn27KE/efpjMZd8DCS1wO66CrYn7WUMthIzHH2vcXVMwN07GDSuxyAa0MhTQ==
Date: Tue, 20 Mar 2018 08:55:26 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
Message-ID: <20180320145526.GI19744@ziepe.ca>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-7-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521514068-8856-7-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:47:48PM -0400, Sinan Kaya wrote:
> Code includes wmb() followed by writel() in multiple places. writel()
> already has a barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>  drivers/infiniband/hw/qedr/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index ccd55f4..db60360 100644
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32 cons, u8 flags)
>  	wmb();
>  	cq->db.data.agg_flags = flags;
>  	cq->db.data.value = cpu_to_le32(cons);
> -	writeq(cq->db.raw, cq->db_addr);
> +	writeq_relaxed(cq->db.raw, cq->db_addr);
>  
>  	/* Make sure write would stick */
>  	mmiowb();
> @@ -3338,7 +3338,7 @@ int qedr_post_recv(struct ib_qp *ibqp, struct ib_recv_wr *wr,
>  
>  		qp->rq.db_data.data.value++;
>  
> -		writel(qp->rq.db_data.raw, qp->rq.db);
> +		writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
>  
>  		/* Make sure write sticks */
>  		mmiowb();

Looks fine, but the next lines should be relaxed too:


                /* Make sure write sticks */
                mmiowb();

                if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
                        writel(qp->rq.iwarp_db2_data.raw, qp->rq.iwarp_db2);
                        mmiowb();       /* for second doorbell */
                }

mmiowb() is strong enough to order writel, IIRC.

Jason
