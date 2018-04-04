Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeDDMnd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:43:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36439 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeDDMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:43:29 -0400
X-Google-Smtp-Source: AIpwx49d1uMjvLsun/S9ksxIBwfJ9q44QiCZAl6Z/8JKXTgXwswmHzO9Bswe2Sb7Hr2dWLFeuWu/gQ==
Subject: Re: [PATCH 2/4] nvmet-rdma: Use new SGL alloc/free helper for
 requests
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-3-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2fbc3260-6682-f789-9500-2961293ff3b4@grimberg.me>
Date: Wed, 4 Apr 2018 15:43:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329160721.4691-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -565,24 +565,24 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
>   {
>   	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
>   	u64 addr = le64_to_cpu(sgl->addr);
> -	u32 len = get_unaligned_le24(sgl->length);
>   	u32 key = get_unaligned_le32(sgl->key);
>   	int ret;
>   
> +	rsp->req.transfer_len = get_unaligned_le24(sgl->length);
> +

IIRC, this might result in nvmet-rdma executing data-transfer even
for failed requests in some error cases. I'm not sure this is the
only case, but have you tested what happens in error cases?

See nvmet_rdma_need_data_in()/nvmet_rdma_need_data_out() which look
at transfer_len.

>   	/* no data command? */
> -	if (!len)
> +	if (!rsp->req.transfer_len)
>   		return 0;
>   
> -	rsp->req.sg = sgl_alloc(len, GFP_KERNEL, &rsp->req.sg_cnt);
> -	if (!rsp->req.sg)
> -		return NVME_SC_INTERNAL;
> +	ret = nvmet_req_alloc_sgl(&rsp->req, &rsp->queue->nvme_sq);
> +	if (ret < 0)
> +		goto error_out;
>   
>   	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
>   			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
>   			nvmet_data_dir(&rsp->req));
>   	if (ret < 0)
> -		return NVME_SC_INTERNAL;
> -	rsp->req.transfer_len += len;
> +		goto error_out;
>   	rsp->n_rdma += ret;
>   
>   	if (invalidate) {
> @@ -591,6 +591,10 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
>   	}
>   
>   	return 0;
> +
> +error_out:
> +	rsp->req.transfer_len = 0;
> +	return NVME_SC_INTERNAL;
>   }
>   
>   static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
> 
