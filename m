Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FB5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2A420834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="fQ7aylHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2A420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeLDPAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:00:43 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:38668 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeLDPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=To2gXBVKx5nXbklZ7Qdd2Jaq2DAZvE9cf5jUMTIS9Hc=;
        b=fQ7aylHblWr8uGJADtdvJ+jneDLVOaCOIy684WwdTPIeQoC6ga8zvJJ4Rclk2TCcP+YAie5YdewOPei6co9pmnWytMovobX5ayfqOFdgesIn3ZGoS7Iym7uaAcJMpXPbqeKxRCy54voNU2dhyc9cFp5eRIM1M0ujyrF4t5H688BLIQdTklfueDyuHZTKqqTuNfwVazGyTajNccq+1MmVwF/9dmuLETEnb2YYy4PeiPV4REDDmcNgcEoiGrhxtnopCya8IbxgZ4rrQcJpwxssYAgPKIoQ0BWVIfPs5w8G5G57e1xhNDD+OqVWhOkKiE7LbrcD3lyqcKnFawDH+da8IQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53776 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gUCBj-0002Wc-Qx; Tue, 04 Dec 2018 16:00:39 +0100
Subject: Re: [PATCH -next] drm/tinydrm: Use kmemdup rather than duplicating
 its implementation in repaper_spi_transfer()
To:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1543471233-159568-1-git-send-email-yuehaibing@huawei.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b12a3f2a-deec-5da6-931c-884686b96e9d@tronnes.org>
Date:   Tue, 4 Dec 2018 16:00:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <1543471233-159568-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 29.11.2018 07.00, skrev YueHaibing:
> use kmemdup rather than duplicating its implementation
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Thanks, applied to drm-misc-next.

Noralf.

>   drivers/gpu/drm/tinydrm/repaper.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tinydrm/repaper.c b/drivers/gpu/drm/tinydrm/repaper.c
> index 07f45a0..54d6fe0 100644
> --- a/drivers/gpu/drm/tinydrm/repaper.c
> +++ b/drivers/gpu/drm/tinydrm/repaper.c
> @@ -108,12 +108,11 @@ static int repaper_spi_transfer(struct spi_device *spi, u8 header,
>   
>   	/* Stack allocated tx? */
>   	if (tx && len <= 32) {
> -		txbuf = kmalloc(len, GFP_KERNEL);
> +		txbuf = kmemdup(tx, len, GFP_KERNEL);
>   		if (!txbuf) {
>   			ret = -ENOMEM;
>   			goto out_free;
>   		}
> -		memcpy(txbuf, tx, len);
>   	}
>   
>   	if (rx) {
>
>
>
