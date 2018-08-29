Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5200C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94F20847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="HkJIq2uR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B94F20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeH2Q5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:57:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43292 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeH2Q5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:57:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so2229339pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iOOOYWH2XRzoaBRjUkKPjrUh1QXhWvIARSCjzaTfzzM=;
        b=HkJIq2uRAaoL5pD28eL5xMpsv1++16v4vmLz9FRnyhnpuuGaC/H+/aaqah+ejIRKZn
         H+mkzsQs5/S5UHThbmRufwEL8BmtgmN1D6H/hq0C5Ftw8q2qrduwwi7EcwvrHjl0EFxQ
         2gtQQy1Cwfp2vNdVt51ufMXgXZMd5fHfOhcNS2bH64+IkouDHLMfnOdTgf7hLks6QuS3
         iRbPxefSRvQLbBDqXAx38ApgOiS1WCY7Bi37TvvqChejmm2gGOYAga/vTvrxtYAZFUVk
         w4RO7q12JZUs4pg1UcPu+d43j5zJjH/GaVJm8sXZGcfquNyg7Cd9nfWwHA4sLu6Dfn+t
         cZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iOOOYWH2XRzoaBRjUkKPjrUh1QXhWvIARSCjzaTfzzM=;
        b=Bnp/JjmcxlKYOmv6awe8ytbsk1DqKjb9+YsSiMNEHs5HP5R/405GYDhEKh9G6AhHle
         gtaoGIJHcTXzPCrk6OFbLb74Oel+O5NyDkMrULfk45DO5vGoA/cvpRsVlSmVhTW6CRrI
         AAfw4QCG3cY0IPEbCUG0qRzeWaed9W5G09I8CHUPJ+b77g0B4fksb9RxBKTsTeNUmRE7
         uk2EVJLRiFGGsiP0Urhoxr25z6+ugnxR+vKDp0699FJQxPO79JZJIomKh9d1ywARlp9U
         WoL5ryozwEgqpK6/zxTrOLcJkH6oo1X3GDHLL3qOUIXiRBJt9cNeNfDKLLzruf0vn0P6
         cMIw==
X-Gm-Message-State: APzg51CPqy2O9+O+8u2q+5pPaCIZbSCrUxR/3NHHWHaHAX7w1delZJGy
        v4w89jWiCgPMQp7QTlTQAvpH7Q==
X-Google-Smtp-Source: ANB0VdaRLJLbnQzVAWcdPmf9c3PJo580ZvJ0sjb5iqvATSEkDB/XfAbDXEP8bj8ONonakr4c00NKdA==
X-Received: by 2002:a63:1551:: with SMTP id 17-v6mr5636187pgv.383.1535547632033;
        Wed, 29 Aug 2018 06:00:32 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id b64-v6sm5962962pfg.66.2018.08.29.06.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:00:30 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
To:     javier@javigon.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:00:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 10:56 AM, Javier González wrote:
> dma allocations for ppa_list and meta_list in rqd are replicated in
> several places across the pblk codebase. Make helpers to encapsulate
> creation and deletion to simplify the code.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c     | 69 +++++++++++++++++++++++++---------------
>   drivers/lightnvm/pblk-read.c     | 35 ++++++++++----------
>   drivers/lightnvm/pblk-recovery.c | 29 ++++++-----------
>   drivers/lightnvm/pblk-write.c    | 15 ++-------
>   drivers/lightnvm/pblk.h          |  3 ++
>   5 files changed, 74 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 09160ec02c5f..767178185f19 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -237,6 +237,34 @@ static void pblk_invalidate_range(struct pblk *pblk, sector_t slba,
>   	spin_unlock(&pblk->trans_lock);
>   }
>   
> +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t mem_flags,
> +		   bool is_vector)


The mem_flags argument can be removed. It is GFP_KERNEL from all the 
places it is called.

is_vector, will be better to do nr_ppas (or similar name). Then 
pblk_submit_read/pblk_submit_read_gc are a bit cleaner.

> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +
> +	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, mem_flags,
> +							&rqd->dma_meta_list);
> +	if (!rqd->meta_list)
> +		return -ENOMEM;
> +
> +	if (!is_vector)
> +		return 0;
> +
> +	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> +	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;

Wrt to is_vector, does it matter if we just set ppa_list and 
dma_ppa_list? If we have them, we use them, else leave them alone?

> +
> +	return 0;
> +}
> +
> +void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +
> +	if (rqd->meta_list)
> +		nvm_dev_dma_free(dev->parent, rqd->meta_list,
> +				rqd->dma_meta_list);
> +}

Looks like setup/clear is mainly about managing the metadata. Would 
pblk_alloc_rqd_meta()/pblk_free/rqd_meta be better names? Unless we can 
fold it all into pblk_alloc_rqd/pblk_free_rqd.

> +
>   /* Caller must guarantee that the request is a valid type */
>   struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type)
>   {
> @@ -268,7 +296,6 @@ struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type)
>   /* Typically used on completion path. Cannot guarantee request consistency */
>   void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>   {
> -	struct nvm_tgt_dev *dev = pblk->dev;
>   	mempool_t *pool;
>   
>   	switch (type) {
> @@ -289,9 +316,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>   		return;
>   	}
>   
> -	if (rqd->meta_list)
> -		nvm_dev_dma_free(dev->parent, rqd->meta_list,
> -				rqd->dma_meta_list);
> +	pblk_clear_rqd(pblk, rqd);
>   	mempool_free(rqd, pool);
>   }
>   
> @@ -687,18 +712,14 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>   
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
>   
> -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd.dma_meta_list);
> -	if (!rqd.meta_list)
> -		return -ENOMEM;
> -
> -	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
> -	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
> +	ret = pblk_setup_rqd(pblk, &rqd, GFP_KERNEL, true);
> +	if (ret)
> +		return ret;
>   
>   	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
>   		ret = PTR_ERR(bio);
> -		goto free_ppa_list;
> +		goto clear_rqd;
>   	}
>   
>   	bio->bi_iter.bi_sector = 0; /* internal bio */
> @@ -716,7 +737,7 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>   	if (ret) {
>   		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> -		goto free_ppa_list;
> +		goto clear_rqd;
>   	}
>   
>   	atomic_dec(&pblk->inflight_io);
> @@ -724,8 +745,8 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>   	if (rqd.error)
>   		pblk_log_read_err(pblk, &rqd);
>   
> -free_ppa_list:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +clear_rqd:
> +	pblk_clear_rqd(pblk, &rqd);
>   	return ret;
>   }
>   
> @@ -742,18 +763,14 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>   
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
>   
> -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd.dma_meta_list);
> -	if (!rqd.meta_list)
> -		return -ENOMEM;
> -
> -	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
> -	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
> +	ret = pblk_setup_rqd(pblk, &rqd, GFP_KERNEL, true);
> +	if (ret)
> +		return ret;
>   
>   	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
>   		ret = PTR_ERR(bio);
> -		goto free_ppa_list;
> +		goto clear_rqd;
>   	}
>   
>   	bio->bi_iter.bi_sector = 0; /* internal bio */
> @@ -775,7 +792,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>   	if (ret) {
>   		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> -		goto free_ppa_list;
> +		goto clear_rqd;
>   	}
>   
>   	atomic_dec(&pblk->inflight_io);
> @@ -785,8 +802,8 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>   		ret = -EIO;
>   	}
>   
> -free_ppa_list:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +clear_rqd:
> +	pblk_clear_rqd(pblk, &rqd);
>   	return ret;
>   }
>   
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 6d13763f2f6a..57d3155ef9a5 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -452,19 +452,15 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   	 */
>   	bio_init_idx = pblk_get_bi_idx(bio);
>   
> -	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd->dma_meta_list);
> -	if (!rqd->meta_list) {
> -		pblk_err(pblk, "not able to allocate ppa list\n");
> -		goto fail_rqd_free;
> -	}
> -
>   	if (nr_secs > 1) {
> -		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> -		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
> +		if (pblk_setup_rqd(pblk, rqd, GFP_KERNEL, true))
> +			goto fail_rqd_free;
>   
>   		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
>   	} else {
> +		if (pblk_setup_rqd(pblk, rqd, GFP_KERNEL, false))
> +			goto fail_rqd_free;
> +
>   		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
>   	}
>   
> @@ -593,14 +589,10 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
>   
> -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd.dma_meta_list);
> -	if (!rqd.meta_list)
> -		return -ENOMEM;
> -
>   	if (gc_rq->nr_secs > 1) {
> -		rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
> -		rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
> +		ret = pblk_setup_rqd(pblk, &rqd, GFP_KERNEL, true);
> +		if (ret)
> +			return ret;
>   
>   		gc_rq->secs_to_gc = read_ppalist_rq_gc(pblk, &rqd, gc_rq->line,
>   							gc_rq->lba_list,
> @@ -609,6 +601,10 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   		if (gc_rq->secs_to_gc == 1)
>   			rqd.ppa_addr = rqd.ppa_list[0];
>   	} else {
> +		ret = pblk_setup_rqd(pblk, &rqd, GFP_KERNEL, false);
> +		if (ret)
> +			return ret;
> +
>   		gc_rq->secs_to_gc = read_rq_gc(pblk, &rqd, gc_rq->line,
>   							gc_rq->lba_list[0],
>   							gc_rq->paddr_list[0]);
> @@ -622,7 +618,8 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   						PBLK_VMALLOC_META, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
>   		pblk_err(pblk, "could not allocate GC bio (%lu)\n",
> -				PTR_ERR(bio));
> +								PTR_ERR(bio));
> +		ret = PTR_ERR(bio);
>   		goto err_free_dma;
>   	}
>   
> @@ -657,12 +654,12 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   #endif
>   
>   out:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +	pblk_clear_rqd(pblk, &rqd);
>   	return ret;
>   
>   err_free_bio:
>   	bio_put(bio);
>   err_free_dma:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +	pblk_clear_rqd(pblk, &rqd);
>   	return ret;
>   }
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 95ea5072b27e..fdc770f2545f 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -241,13 +241,11 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	struct ppa_addr *ppa_list;
>   	struct pblk_sec_meta *meta_list;
>   	struct pblk_pad_rq *pad_rq;
>   	struct nvm_rq *rqd;
>   	struct bio *bio;
>   	void *data;
> -	dma_addr_t dma_ppa_list, dma_meta_list;
>   	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
>   	u64 w_ptr = line->cur_sec;
>   	int left_line_ppas, rq_ppas, rq_len;
> @@ -281,20 +279,11 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>   
>   	rq_len = rq_ppas * geo->csecs;
>   
> -	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
> -	if (!meta_list) {
> -		ret = -ENOMEM;
> -		goto fail_free_pad;
> -	}
> -
> -	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> -
>   	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
>   						PBLK_VMALLOC_META, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
>   		ret = PTR_ERR(bio);
> -		goto fail_free_meta;
> +		goto fail_free_pad;
>   	}
>   
>   	bio->bi_iter.bi_sector = 0; /* internal bio */
> @@ -302,17 +291,19 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>   
>   	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
>   
> +	ret = pblk_setup_rqd(pblk, rqd, GFP_KERNEL, true);
> +	if (ret)
> +		goto fail_free_bio;
> +
>   	rqd->bio = bio;
>   	rqd->opcode = NVM_OP_PWRITE;
>   	rqd->is_seq = 1;
> -	rqd->meta_list = meta_list;
>   	rqd->nr_ppas = rq_ppas;
> -	rqd->ppa_list = ppa_list;
> -	rqd->dma_ppa_list = dma_ppa_list;
> -	rqd->dma_meta_list = dma_meta_list;
>   	rqd->end_io = pblk_end_io_recov;
>   	rqd->private = pad_rq;
>   
> +	meta_list = rqd->meta_list;
> +
>   	for (i = 0; i < rqd->nr_ppas; ) {
>   		struct ppa_addr ppa;
>   		int pos;
> @@ -346,7 +337,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>   	if (ret) {
>   		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>   		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> -		goto fail_free_bio;
> +		goto fail_free_rqd;
>   	}
>   
>   	left_line_ppas -= rq_ppas;
> @@ -370,10 +361,10 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
>   	kfree(pad_rq);
>   	return ret;
>   
> +fail_free_rqd:
> +	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>   fail_free_bio:
>   	bio_put(bio);
> -fail_free_meta:
> -	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
>   fail_free_pad:
>   	kfree(pad_rq);
>   	vfree(data);
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 8ea66bb83c29..767618eba4c2 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -322,11 +322,8 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
>   }
>   
>   static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
> -			   unsigned int nr_secs,
> -			   nvm_end_io_fn(*end_io))
> +			   unsigned int nr_secs, nvm_end_io_fn(*end_io))
>   {
> -	struct nvm_tgt_dev *dev = pblk->dev;
> -
>   	/* Setup write request */
>   	rqd->opcode = NVM_OP_PWRITE;
>   	rqd->nr_ppas = nr_secs;
> @@ -334,15 +331,7 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
>   	rqd->private = pblk;
>   	rqd->end_io = end_io;
>   
> -	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> -							&rqd->dma_meta_list);
> -	if (!rqd->meta_list)
> -		return -ENOMEM;
> -
> -	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> -	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
> -
> -	return 0;
> +	return pblk_setup_rqd(pblk, rqd, GFP_KERNEL, true);
>   }
>   
>   static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index e29fd35d2991..c0d9eddd344b 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -778,6 +778,9 @@ ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char *buf);
>    */
>   struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type);
>   void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type);
> +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t mem_flags,
> +		   bool is_vecto);
> +void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd);
>   void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
>   int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
>   			struct pblk_c_ctx *c_ctx);
> 

