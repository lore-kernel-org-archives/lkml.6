Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33632ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61EA20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uYDtV0WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61EA20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeINP4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:56:14 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34484 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeINP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:56:14 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12E93CE;
        Fri, 14 Sep 2018 12:42:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536921738;
        bh=Y7BBUWFNKzWeij4lfuU8+qJ4pxvD8ijWkZd3yFLlpBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYDtV0WPqa+QA62fogTlTMDnqulcaDewHcmxzfu6etM86aCIsPtM9k10HzCenxOR8
         ElbrP15RR13wzvdDaQuD6V6hZbo7Rc6h816iDXtFohOEY7gwM5GvPSb1YUu5Czaj1h
         SYO89m21K09c3kL79xMRKfqoq1yDjTAM05f5AGuc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] media: vsp1: Document max_width restriction on SRU
Date:   Fri, 14 Sep 2018 13:42:31 +0300
Message-ID: <2947729.faakk1MfnN@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180831144044.31713-5-kieran.bingham+renesas@ideasonboard.com>
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com> <20180831144044.31713-5-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 31 August 2018 17:40:42 EEST Kieran Bingham wrote:
> The SRU is currently restricted to 256 pixels as part of the current
> partition algorithm. Document that the actual capability of this
> component is 288 pixels, but don't increase the implementation.
> 
> The extended partition algorithm may later choose to utilise a larger
> input to support overlapping partitions.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_sru.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_sru.c
> b/drivers/media/platform/vsp1/vsp1_sru.c index f277700e5cc2..2a40e09b9aa7
> 100644
> --- a/drivers/media/platform/vsp1/vsp1_sru.c
> +++ b/drivers/media/platform/vsp1/vsp1_sru.c
> @@ -314,6 +314,10 @@ static unsigned int sru_max_width(struct vsp1_entity
> *entity, output = vsp1_entity_get_pad_format(&sru->entity,
> sru->entity.config, SRU_PAD_SOURCE);
> 
> +	/*
> +	 * The maximum width of the SRU is 288 input pixels, but to support the
> +	 * partition algorithm, this is currently kept at 256.
> +	 */

s/maximum width/maximum input width/

I think you should also explain why we restrict it to 256 pixels (unless I'm 
mistaken the idea is that up to 32 pixels can be used for overlapping 
partitions, so each partition will process up to 256 useful pixels).

Patch 5/6 should also be updated in a similar way to better document the 
rationale.

>  	if (input->width != output->width)
>  		return 512;
>  	else

-- 
Regards,

Laurent Pinchart



