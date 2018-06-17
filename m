Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F49EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 09:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04EC20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 09:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04EC20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeFQJNC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 05:13:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38692 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932672AbeFQJNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 05:13:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 11398206D8; Sun, 17 Jun 2018 11:13:00 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB934203EB;
        Sun, 17 Jun 2018 11:12:59 +0200 (CEST)
Date:   Sun, 17 Jun 2018 11:12:59 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/atmel-hlcdc: check stride values in the first
 plane
Message-ID: <20180617111259.556378e1@bbrezillon>
In-Reply-To: <20180617084826.31885-1-stefan@agner.ch>
References: <20180617084826.31885-1-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2018 10:48:22 +0200
Stefan Agner <stefan@agner.ch> wrote:

> The statement always evaluates to true since the struct fields
> are arrays. This has shown up as a warning when compiling with
> clang:
>   warning: address of array 'desc->layout.xstride' will always
>       evaluate to 'true' [-Wpointer-bool-conversion]
> 
> Check for values in the first plane instead.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I'll add

Fixes: 1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
Cc: stable@vger.kernel.org

when applying.

Thanks,

Boris

> ---
> Changes in v2:
> - Check for first value instead of dropping if statement
>   (subject was: drm/atmel-hlcdc: remove unnecessary if statement)
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 73c875db45f4..47e0992f3908 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -839,7 +839,7 @@ static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
>  			return ret;
>  	}
>  
> -	if (desc->layout.xstride && desc->layout.pstride) {
> +	if (desc->layout.xstride[0] && desc->layout.pstride[0]) {
>  		int ret;
>  
>  		ret = drm_plane_create_rotation_property(&plane->base,

