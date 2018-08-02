Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056A821509
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056A821509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbeHBLgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:36:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60341 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHBLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:36:48 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1flABa-0007re-Eh; Thu, 02 Aug 2018 11:46:22 +0200
Message-ID: <1533203182.3516.12.camel@pengutronix.de>
Subject: Re: [PATCH v3 05/14] gpu: ipu-v3: Allow negative offsets for
 interlaced scanning
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Aug 2018 11:46:22 +0200
In-Reply-To: <1533150747-30677-6-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
         <1533150747-30677-6-git-send-email-steve_longerbeam@mentor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 12:12 -0700, Steve Longerbeam wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The IPU also supports interlaced buffers that start with the bottom field.
> To achieve this, the the base address EBA has to be increased by a stride
> length and the interlace offset ILO has to be set to the negative stride.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>  drivers/gpu/ipu-v3/ipu-cpmem.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
> index e68e473..8cd9e37 100644
> --- a/drivers/gpu/ipu-v3/ipu-cpmem.c
> +++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
> @@ -269,9 +269,20 @@ EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
>  
>  void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
>  {
> +	u32 ilo, sly;
> +
> +	if (stride < 0) {
> +		stride = -stride;
> +		ilo = 0x100000 - (stride / 8);
> +	} else {
> +		ilo = stride / 8;
> +	}
> +
> +	sly = (stride * 2) - 1;
> +
>  	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
> -	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, stride / 8);
> -	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, (stride * 2) - 1);
> +	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
> +	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
>  };
>  EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);

This patch is merged in drm-next: 4e3c5d7e05be ("gpu: ipu-v3: Allow
negative offsets for interlaced scanning")

regards
Philipp
