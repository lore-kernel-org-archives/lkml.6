Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeCWTNV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:13:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeCWTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:13:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFE0F60246
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v6] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
To: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
References: <1521736245-23662-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d15cde17-9c09-4812-3adc-940027ba0db6@codeaurora.org>
Date: Fri, 23 Mar 2018 15:13:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521736245-23662-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2018 12:30 PM, Sinan Kaya wrote:
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
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 53f00db..d1cf9a0 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -35,6 +35,7 @@
>  #include <net/ipv6.h>
>  #include <net/udp.h>
>  #include <linux/iommu.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>

what should we do here? change include? drop writeq_relaxed?

>  
>  #include <rdma/ib_verbs.h>
>  #include <rdma/ib_user_verbs.h>
> @@ -860,7 +861,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32 cons, u8 flags)
>  	wmb();
>  	cq->db.data.agg_flags = flags;
>  	cq->db.data.value = cpu_to_le32(cons);
> -	writeq(cq->db.raw, cq->db_addr);
> +	writeq_relaxed(cq->db.raw, cq->db_addr);
>  
>  	/* Make sure write would stick */
>  	mmiowb();
> @@ -3338,7 +3339,7 @@ int qedr_post_recv(struct ib_qp *ibqp, struct ib_recv_wr *wr,
>  
>  		qp->rq.db_data.data.value++;
>  
> -		writel(qp->rq.db_data.raw, qp->rq.db);
> +		writel_relaxed(qp->rq.db_data.raw, qp->rq.db);
>  
>  		/* Make sure write sticks */
>  		mmiowb();
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
