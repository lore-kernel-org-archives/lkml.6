Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7857ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8805B20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8805B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeJ1AzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:55:16 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:36747 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbeJ1AzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:55:16 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58869 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gGRDe-0008HI-4H; Sat, 27 Oct 2018 18:13:46 +0200
Subject: Re: [PATCH 3/3] drm/tinydrm: Fix setting of the column/page end
 addresses.
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20181024184313.2967-1-eric@anholt.net>
 <20181024184313.2967-4-eric@anholt.net>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <6cc67180-c844-566a-cb59-b06e9e2ff72a@tronnes.org>
Date:   Sat, 27 Oct 2018 18:13:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024184313.2967-4-eric@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 24.10.2018 20.43, skrev Eric Anholt:
> If the clipped dirty region's x/y happened to align to 256, we would
> have set the top 8 bits wrong.  Noticed by inspection, not by
> reproducing a bug.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

Good catch.
Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

>   drivers/gpu/drm/tinydrm/mipi-dbi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index cb3441e51d5f..1bb870021f6e 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -240,10 +240,10 @@ static int mipi_dbi_fb_dirty(struct drm_framebuffer *fb,
>   
>   	mipi_dbi_command(mipi, MIPI_DCS_SET_COLUMN_ADDRESS,
>   			 (clip.x1 >> 8) & 0xFF, clip.x1 & 0xFF,
> -			 (clip.x2 >> 8) & 0xFF, (clip.x2 - 1) & 0xFF);
> +			 ((clip.x2 - 1) >> 8) & 0xFF, (clip.x2 - 1) & 0xFF);
>   	mipi_dbi_command(mipi, MIPI_DCS_SET_PAGE_ADDRESS,
>   			 (clip.y1 >> 8) & 0xFF, clip.y1 & 0xFF,
> -			 (clip.y2 >> 8) & 0xFF, (clip.y2 - 1) & 0xFF);
> +			 ((clip.y2 - 1) >> 8) & 0xFF, (clip.y2 - 1) & 0xFF);
>   
>   	ret = mipi_dbi_command_buf(mipi, MIPI_DCS_WRITE_MEMORY_START, tr,
>   				(clip.x2 - clip.x1) * (clip.y2 - clip.y1) * 2);

