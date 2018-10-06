Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDBC00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A052E21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Yr8eY8BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A052E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeJFIG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:06:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46755 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeJFIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:06:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so13054356edg.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2qMMOare7cgO2+eNOjzh84cVx1gGysxYtb7rp+Gqx8=;
        b=Yr8eY8BM3qAScMpuvpBRJfzBeAg+AHV8qLkD91i9GcKoxUmS9OT0lMPL9Rf4gXrxFo
         vjub/abdxi5aQY2mWrv9ydoV54I/g977lhjJs+SQ8rUHowTpNzWqeXbECeE4S5MC0Lmc
         7Oa5o+SHl8Iutb7m2LqGosnVdhm8TERFLHhoG/GGif5FWHt7BhWjBkI24pywTae8NQv8
         Dsw0izu3Y9Ubxvou773ZveimdDwRUrIrybXgo/trcLdbvDAHInqX0M/1lV7O/KvXcK0V
         HDnf/b8up5El33LM+ayV9oMv86j2TdKvtHQKu/E+roHKi4zZwS4jmjgF8pEUHcDYjbHQ
         +BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2qMMOare7cgO2+eNOjzh84cVx1gGysxYtb7rp+Gqx8=;
        b=iO+pONG5fHrZ3rTyfmAdt7s10wpVuHTJzlVC3ZPx9jxo4zPkSdQubiOudwOr2fW87o
         3BHjdmhOxWWXog3ONgWBuy3dznjs2RnrKs4TwM+ckKuYj/2y6LRAhu0OAy1d8DWs2s7c
         gbhudoZVhmV8gex9yFDeMWo9Sm+on/rKndVgWBCUhgr/Q5Z9MyZo099dTYBD0D/aBI2M
         FBHR+DCmsEuGnS+DD9tqFDANKFtc/qIdEzY+PSIdqMkyqJL3wLNhxWtGl/S2h60w7PMU
         ooXY8HHyJVCGvHGPBbZAPKJZQdDaw5u+pk6ONwSV4Il810vrZ0pGHx7b4HQ8NQ2Zu3A8
         P3jw==
X-Gm-Message-State: ABuFfogxyqLXttFCak4SeHMwUry/on1HwDg3za0H1Awr2Bfmemnum6LK
        ZcDBCBAh3o7NsI6HDo8rt6322A==
X-Google-Smtp-Source: ACcGV60cYS57IsngXDrgMTFEG99UoRcHeiJOP3iioFD7nNd0MUNMk3MflSI4RWgBweQDsq8pHKS1yQ==
X-Received: by 2002:a50:d49e:: with SMTP id s30-v6mr17126411edi.127.1538787910079;
        Fri, 05 Oct 2018 18:05:10 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id w8-v6sm2898548edq.81.2018.10.05.18.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 18:05:09 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: guarantee that backpointer is respected
 on writer stall
To:     javier@javigon.com
Cc:     hlitz@ucsc.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1538637968-28032-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a63d3e8f-df14-f707-8960-7ad3f9ae069a@lightnvm.io>
Date:   Sat, 6 Oct 2018 03:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538637968-28032-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 09:26 AM, Javier González wrote:
> pblk's write buffer must guarantee that it respects the device's
> constrains for reads (i.e., mw_cunits). This is done by maintaining a
> backpointer that updates the L2P table as entries wrap up, making them
> point to the media instead of pointing to the write buffer.
> 
> This mechanism can race in case that the write thread stalls, as the
> write pointer will protect the last written entry, thus disregarding the
> read constrains.
> 
> This patch adds an extra check on wrap up, making sure that the
> threshold is respected at all times, preventing new entries to overwrite
> committed data, also in case of write thread stall.
> 
> Reported-by: Heiner Litz <hlitz@ucsc.edu>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c | 5 +++--
>   drivers/lightnvm/pblk-rb.c   | 9 +++++++--
>   drivers/lightnvm/pblk.h      | 8 +++++++-
>   3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index e3573880dbda..deaeb4649294 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -193,8 +193,9 @@ static int pblk_rwb_init(struct pblk *pblk)
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
>   	unsigned long buffer_size;
> -	int pgs_in_buffer;
> +	int pgs_in_buffer, threshold;
>   
> +	threshold = geo->mw_cunits * geo->all_luns;
>   	pgs_in_buffer = (max(geo->mw_cunits, geo->ws_opt) + geo->ws_opt)
>   								* geo->all_luns;
>   
> @@ -203,7 +204,7 @@ static int pblk_rwb_init(struct pblk *pblk)
>   	else
>   		buffer_size = pgs_in_buffer;
>   
> -	return pblk_rb_init(&pblk->rwb, buffer_size, geo->csecs);
> +	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
>   }
>   
>   /* Minimum pages needed within a lun */
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index f653faa6a9ed..b1f4b51783f4 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -56,7 +56,8 @@ static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
>    * allocated and their size must be a power of two
>    * (Documentation/core-api/circular-buffers.rst)
>    */
> -int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
> +int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
> +		 unsigned int seg_size)
>   {
>   	struct pblk *pblk = container_of(rb, struct pblk, rwb);
>   	struct pblk_rb_entry *entries;
> @@ -79,6 +80,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
>   	rb->seg_size = (1 << power_seg_sz);
>   	rb->nr_entries = (1 << power_size);
>   	rb->mem = rb->subm = rb->sync = rb->l2p_update = 0;
> +	rb->back_thres = threshold;
>   	rb->flush_point = EMPTY_ENTRY;
>   
>   	spin_lock_init(&rb->w_lock);
> @@ -404,11 +406,14 @@ static int __pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
>   {
>   	unsigned int mem;
>   	unsigned int sync;
> +	unsigned int threshold;
>   
>   	sync = READ_ONCE(rb->sync);
>   	mem = READ_ONCE(rb->mem);
>   
> -	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < nr_entries)
> +	threshold = nr_entries + rb->back_thres;
> +
> +	if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < threshold)
>   		return 0;
>   
>   	if (pblk_rb_update_l2p(rb, nr_entries, mem, sync))
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 34c9c1dbeed9..c1665e39829d 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -203,6 +203,11 @@ struct pblk_rb {
>   					 * will be 4KB
>   					 */
>   
> +	unsigned int back_thres;	/* Threshold that shall be maintained by
> +					 * the backpointer in order to respect
> +					 * geo->mw_cunits on a per chunk basis
> +					 */
> +
>   	struct list_head pages;		/* List of data pages */
>   
>   	spinlock_t w_lock;		/* Write lock */
> @@ -734,7 +739,8 @@ struct pblk_line_ws {
>   /*
>    * pblk ring buffer operations
>    */
> -int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_sz);
> +int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
> +		 unsigned int seg_sz);
>   int pblk_rb_may_write_user(struct pblk_rb *rb, struct bio *bio,
>   			   unsigned int nr_entries, unsigned int *pos);
>   int pblk_rb_may_write_gc(struct pblk_rb *rb, unsigned int nr_entries,
> 

Thanks. Applied for 4.20.
