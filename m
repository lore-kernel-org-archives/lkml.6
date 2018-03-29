Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeC2QwR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:52:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44432 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2QwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:52:16 -0400
X-Google-Smtp-Source: AIpwx4+q1yG1csEoWeWWvIH1VaEXPUBb7JDDEVWgbEdzI6OhAXJPOIWsCHxfYF8znBm9r35jvO0n4A==
Subject: Re: [PATCH 4/4] nvmet-fc: Use new SGL alloc/free helper for requests
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-5-logang@deltatee.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <15f4d135-7600-02b3-f50f-ed8deddd7b98@broadcom.com>
Date: Thu, 29 Mar 2018 09:52:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329160721.4691-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

overall - I'm a little concerned about the replacement.

I know the code depends on the null/zero checks in 
nvmet_fc_free_tgt_pgs() as there are paths that can call them twice.  
Your replacement in that routine is fine, but you've fully removed any 
initialization to zero or setting to zero on free. Given the structure 
containing the req structure is reused, I'd rather that that code was 
left in some way... or that nvmet_req_free_sgl() or 
nvmet_fc_free_tgt_pgs() was updated to set req->sg to null and (not sure 
necessary if req->sg is null) set req->sg_cnt to 0.

also - sg_cnt isn't referenced as there is an assumption that: transfer 
length meant there would be (transfer length / PAGESIZE + 1 if partial 
page) pages allocated and sg_cnt would always equal that page cnt  thus 
the fcpreq->sgXXX setting behavior in nvmet_fc_transfer_fcp_data().   Is 
that no longer valid ?   I may not have watched closely enough when the 
sgl_alloc() common routine was introduced as it may have invalidated 
these assumptions that were true before.

-- james


On 3/29/2018 9:07 AM, Logan Gunthorpe wrote:
> Use the new helpers introduced earlier to allocate the SGLs for
> the request.
>
> To do this, we drop the appearantly redundant data_sg and data_sg_cnt
> members as they are identical to the existing req.sg and req.sg_cnt.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/fc.c | 38 +++++++++++---------------------------
>   1 file changed, 11 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 9f2f8ab83158..00135ff7d1c2 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -74,8 +74,6 @@ struct nvmet_fc_fcp_iod {
>   	struct nvme_fc_cmd_iu		cmdiubuf;
>   	struct nvme_fc_ersp_iu		rspiubuf;
>   	dma_addr_t			rspdma;
> -	struct scatterlist		*data_sg;
> -	int				data_sg_cnt;
>   	u32				offset;
>   	enum nvmet_fcp_datadir		io_dir;
>   	bool				active;
> @@ -1696,43 +1694,34 @@ EXPORT_SYMBOL_GPL(nvmet_fc_rcv_ls_req);
>   static int
>   nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
>   {
> -	struct scatterlist *sg;
> -	unsigned int nent;
>   	int ret;
>   
> -	sg = sgl_alloc(fod->req.transfer_len, GFP_KERNEL, &nent);
> -	if (!sg)
> -		goto out;
> +	ret = nvmet_req_alloc_sgl(&fod->req, &fod->queue->nvme_sq);
> +	if (ret < 0)
> +		return NVME_SC_INTERNAL;
>   
> -	fod->data_sg = sg;
> -	fod->data_sg_cnt = nent;
> -	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
> +	ret = fc_dma_map_sg(fod->tgtport->dev, fod->req.sg, fod->req.sg_cnt,
>   			    ((fod->io_dir == NVMET_FCP_WRITE) ?
>   				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
>   			    /* note: write from initiator perspective */
>   	if (!ret)
> -		goto out;
> +		return NVME_SC_INTERNAL;
>   
>   	return 0;
> -
> -out:
> -	return NVME_SC_INTERNAL;
>   }
>   
>   static void
>   nvmet_fc_free_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
>   {
> -	if (!fod->data_sg || !fod->data_sg_cnt)
> +	if (!fod->req.sg || !fod->req.sg_cnt)
>   		return;
>   
> -	fc_dma_unmap_sg(fod->tgtport->dev, fod->data_sg, fod->data_sg_cnt,
> +	fc_dma_unmap_sg(fod->tgtport->dev, fod->req.sg, fod->req.sg_cnt,
>   				((fod->io_dir == NVMET_FCP_WRITE) ?
>   					DMA_FROM_DEVICE : DMA_TO_DEVICE));
> -	sgl_free(fod->data_sg);
> -	fod->data_sg = NULL;
> -	fod->data_sg_cnt = 0;
> -}
>   
> +	nvmet_req_free_sgl(&fod->req);
> +}handl
>   
>   static bool
>   queue_90percent_full(struct nvmet_fc_tgt_queue *q, u32 sqhd)
> @@ -1871,7 +1860,7 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
>   	fcpreq->fcp_error = 0;
>   	fcpreq->rsplen = 0;
>   
> -	fcpreq->sg = &fod->data_sg[fod->offset / PAGE_SIZE];
> +	fcpreq->sg = &fod->req.sg[fod->offset / PAGE_SIZE];
>   	fcpreq->sg_cnt = DIV_ROUND_UP(tlen, PAGE_SIZE);
>   
>   	/*
> @@ -2083,7 +2072,7 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
>   		 * There may be a status where data still was intended to
>   		 * be moved
>   		 */
> -		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
> +		if ((fod->io_dir == NVMET_FCP_READ) && (fod->req.sg_cnt)) {
>   			/* push the data over before sending rsp */
>   			nvmet_fc_transfer_fcp_data(tgtport, fod,
>   						NVMET_FCOP_READDATA);
> @@ -2153,9 +2142,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>   	/* clear any response payload */
>   	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
>   
> -	fod->data_sg = NULL;
> -	fod->data_sg_cnt = 0;
> -
>   	ret = nvmet_req_init(&fod->req,
>   				&fod->queue->nvme_cq,
>   				&fod->queue->nvme_sq,
> @@ -2178,8 +2164,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>   			return;
>   		}
>   	}
> -	fod->req.sg = fod->data_sg;
> -	fod->req.sg_cnt = fod->data_sg_cnt;
>   	fod->offset = 0;
>   
>   	if (fod->io_dir == NVMET_FCP_WRITE) {
