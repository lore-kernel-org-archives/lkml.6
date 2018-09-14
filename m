Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C00FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DCB2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HOX9PlMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DCB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeINUD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:03:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36860 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeINUD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:03:29 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 067FBCE;
        Fri, 14 Sep 2018 16:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536936517;
        bh=I3jIGTFykQBjIvpKZbrw1vomp4uqIDLnN4ToDHg/VRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOX9PlMt9EmQnYIzUD/n6tnzx7wP/V+W3dsyioccOQv0jlfoxeLPVS7ydjdgkKHEr
         60+wHTStw20cUJh7MKSzCkzTQ9h4E+ZQ0cjBaqCS4jQfOvDYdXUMFFYY7CUZ2uKoPq
         RMV+Oy/Y7E+Ed7TR3mQa/029VvK4BWdJCNBZTMrc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v2 2/2] media: vsp1: Document max_width restriction on UDS
Date:   Fri, 14 Sep 2018 17:48:50 +0300
Message-ID: <7357198.ccT2EWLa9U@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180914142652.30484-2-kieran.bingham+renesas@ideasonboard.com>
References: <20180914142652.30484-1-kieran.bingham+renesas@ideasonboard.com> <20180914142652.30484-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 14 September 2018 17:26:52 EEST Kieran Bingham wrote:
> The UDS is currently restricted based on a partition size of 256 pixels.
> Document the actual restrictions, but don't increase the implementation.
> 
> The extended partition algorithm may later choose to utilise a larger
> partition size to support overlapping partitions which will improve the
> quality of the output images.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/vsp1/vsp1_uds.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_uds.c
> b/drivers/media/platform/vsp1/vsp1_uds.c index 75c613050151..e8340de85813
> 100644
> --- a/drivers/media/platform/vsp1/vsp1_uds.c
> +++ b/drivers/media/platform/vsp1/vsp1_uds.c
> @@ -342,6 +342,14 @@ static unsigned int uds_max_width(struct vsp1_entity
> *entity, UDS_PAD_SOURCE);
>  	hscale = output->width / input->width;
> 
> +	/*
> +	 * The maximum width of the UDS is 304 pixels. These are input pixels
> +	 * in the event of up-scaling, and output pixels in the event of
> +	 * downscaling.
> +	 *
> +	 * To support overlapping parition windows we clamp at units of 256 and
> +	 * the remaining pixels are reserved.
> +	 */
>  	if (hscale <= 2)
>  		return 256;
>  	else if (hscale <= 4)


-- 
Regards,

Laurent Pinchart



