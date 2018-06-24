Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A32524E36
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A32524E36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeFXH5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:57:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:39496 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbeFXH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:57:49 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1fWzu7-0002z2-Kq; Sun, 24 Jun 2018 09:57:47 +0200
Received: from [188.174.114.87] (helo=[192.168.178.37])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fWzu7-0002b9-Bj; Sun, 24 Jun 2018 09:57:47 +0200
Subject: Re: [PATCH 16/26] dmaengine: Convert to new IDA API
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-17-willy@infradead.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c198586d-ab68-63f5-99fc-39401ee20cad@metafoo.de>
Date:   Sun, 24 Jun 2018 09:57:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621212835.5636-17-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (Could not determine AV Version)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 11:28 PM, Matthew Wilcox wrote:
> Simpler and shorter code.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
[...]>  {
> -	int rc;
> -
> -	do {
> -		if (!ida_pre_get(&dma_ida, GFP_KERNEL))
> -			return -ENOMEM;
> -		mutex_lock(&dma_list_mutex);
> -		rc = ida_get_new(&dma_ida, &device->dev_id);
> -		mutex_unlock(&dma_list_mutex);
> -	} while (rc == -EAGAIN);
> +	int rc = ida_alloc(&dma_ida, GFP_KERNEL);
>  
> +	if (rc >= 0)
> +		device->dev_id = rc;
>  	return rc;

This used to return 0 on success, now it returns the ID. That wont work
considering that it is used like this

    rc = get_dma_id(device);
    if (rc != 0) ...


>  }
>  
> @@ -1090,9 +1082,7 @@ int dma_async_device_register(struct dma_device *device)
>  err_out:
>  	/* if we never registered a channel just release the idr */
>  	if (atomic_read(idr_ref) == 0) {
> -		mutex_lock(&dma_list_mutex);
> -		ida_remove(&dma_ida, device->dev_id);
> -		mutex_unlock(&dma_list_mutex);
> +		ida_free(&dma_ida, device->dev_id);
>  		kfree(idr_ref);
>  		return rc;
>  	}
> 

