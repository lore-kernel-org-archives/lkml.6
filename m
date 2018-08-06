Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ACEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2757A21A16
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l4L6vyqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2757A21A16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeHGCJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:09:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47740 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeHGCJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:09:16 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0C3157;
        Tue,  7 Aug 2018 01:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533599864;
        bh=xp4B6yJQBpkhKKnt2O6K7WK2Z4I3CNAn83p9oTHIKyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4L6vyqU8+8x1FsVnBXldp12ELnK3gK0yrTO69bpOYdWm9mORnJyt8jqSF2AnsT+h
         3HaHIOnWSPSsliWOAf3RoH08aURtiCfyx6O+evcXXCeJDumlLIFEZbN2AVvqnW46bC
         9T7kjNHtcyVcwBel2oBh6WpsP3xVlS4sO/lGT+jo=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: fix uvc_alloc_entity() allocation alignment
Date:   Tue, 07 Aug 2018 02:58:27 +0300
Message-ID: <15813968.YrTFj7ZbY9@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180604134713.101064-1-namit@vmware.com>
References: <20180604134713.101064-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

Thank you for the patch.

On Monday, 4 June 2018 16:47:13 EEST Nadav Amit wrote:
> The use of ALIGN() in uvc_alloc_entity() is incorrect, since the size of
> (entity->pads) is not a power of two. As a stop-gap, until a better
> solution is adapted, use roundup() instead.
> 
> Found by a static assertion. Compile-tested only.
> 
> Fixes: 4ffc2d89f38a ("uvcvideo: Register subdevices for each entity")
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c
> b/drivers/media/usb/uvc/uvc_driver.c index 2469b49b2b30..6b989d41c034
> 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -909,7 +909,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u8
> id, unsigned int size;
>  	unsigned int i;
> 
> -	extra_size = ALIGN(extra_size, sizeof(*entity->pads));
> +	extra_size = roundup(extra_size, sizeof(*entity->pads));
>  	num_inputs = (type & UVC_TERM_OUTPUT) ? num_pads : num_pads - 1;
>  	size = sizeof(*entity) + extra_size + sizeof(*entity->pads) * num_pads
>  	     + num_inputs;

The purpose of this alignment is to make sure that entity->pads will be 
properly aligned. In theory the size of uvc_entity should be taken into 
account too, but the structure contains pointers, so its size should already 
be properly aligned. This patch thus looks good to me. What made you say it's 
a stop-gap measure ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

-- 
Regards,

Laurent Pinchart



