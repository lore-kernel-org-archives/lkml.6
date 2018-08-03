Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB132152D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="e3UVP/rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB132152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeHCOlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:41:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43202 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeHCOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:41:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id f135-v6so3941908lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lzB0MxuiKo8m4aNSw/9mDyHA8+MdSWqwcGZKnlGrT/U=;
        b=e3UVP/rnnPhdP8EXWqIJR069skfZxmPaWh6e4bYRNLF/gjH9X/AW6f44xW/MD4ia3V
         04rFiDaZAUd/erGwuxGXD033TIwJ21eGzHjK0XaI2JWaacTXiywCxQBRxomnIpwgCP4E
         +1CB2NyhWe01jo/w40cDB1aY6Ua2y5cu+MH0h4xRn2xKlmjeoN9UoiduzFPJbc8GbGJx
         vJ5KRpacl9W90xzd4i/FtdpUsb7NQjLYxapjWRwYc5yMwZrXOH5727zKPAMhPCUeWrL/
         l0Pjt6o2D+a0qzKZpC6C8RB2gVlmnZhd+5QCHho30/hnKHC81mzoDNG2baElcdKOYFA6
         9eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzB0MxuiKo8m4aNSw/9mDyHA8+MdSWqwcGZKnlGrT/U=;
        b=U1tffQJ5amCBZvNKRgxH3RuceSFGx5IH44tPHlMp7QVDOjtEgODcGC/pEYuBc5nzPd
         wJ/hrwFeJfh06cMZ7VApXBVz64cLVpDb4xrt9wP8B/bqa5Bl45tinqDb1ogbnFpgrTxH
         HUG6gcaplmzeX29aoaqHSCWYunbyKhNxILgJv01iOLN08z6JrQnw19RSnT6RMVcSAeCT
         eMU/o4CQ7JVPxnq+idzeNvfVT6cr4ezUlzTBPTf7M2Z4HZDeqONvpLl6RBAwQ9kf5J1Z
         kd6rq1XnsgO906LvJPVPtubPVewy38yLo/lQTUf0fjPr7DKhZ3HjML7laSyqUXUSNV5G
         PxgA==
X-Gm-Message-State: AOUpUlHBrxGFy7cQsrpugZ7Sxf1/V/iO+pjWakMqM/OnqcfSq+ZOTGcC
        VzC493/CeyrGOxTy1GczzF4++aICq60vOw==
X-Google-Smtp-Source: AAOMgpdpkW2OdG/gDl2bn03T8xslAStKkipyp0zxTPF9d0Xk4y76CyJHk3N6YkEXO1J7V6cq0kgejQ==
X-Received: by 2002:a19:e4c1:: with SMTP id x62-v6mr4601512lfi.76.1533300306649;
        Fri, 03 Aug 2018 05:45:06 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id j26-v6sm894914ljc.54.2018.08.03.05.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:45:05 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ff9b6206-8316-dd48-4df3-73b122e3afd3@lightnvm.io>
Date:   Fri, 3 Aug 2018 14:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 02:05 PM, Javier González wrote:
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
> 
> Since metadata I/O is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
> 
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metdatada scheme could cause
> ordering issues.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>   drivers/lightnvm/pblk.h      |  1 +
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 00984b486fea..160b54d26bfa 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
>   	return nvm_submit_io_sync(dev, rqd);
>   }
>   
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	if (rqd->opcode != NVM_OP_PWRITE)
> +		pblk_submit_io_sync(pblk, rqd);
> +

Why should the write be issued twice?

> +	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +	pblk_submit_io_sync(pblk, rqd);
> +	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +}
> +
>   static void pblk_bio_map_addr_endio(struct bio *bio)
>   {
>   	bio_put(bio);
> @@ -737,7 +747,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>   		}
>   	}
>   
> -	ret = pblk_submit_io_sync(pblk, &rqd);
> +	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>   	if (ret) {
>   		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> @@ -842,7 +852,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>   	 * the write thread is the only one sending write and erase commands,
>   	 * there is no need to take the LUN semaphore.
>   	 */
> -	ret = pblk_submit_io_sync(pblk, &rqd);
> +	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>   	if (ret) {
>   		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 4760af7b6499..6ccc6ad8e1ce 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -782,6 +782,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>   void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
>   struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
>   			      unsigned int nr_secs, unsigned int len,
> 

