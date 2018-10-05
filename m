Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA83C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9A206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD9A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJERvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:51:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48013 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJERvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:51:04 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8Nix-0005Dj-Dq; Fri, 05 Oct 2018 12:52:47 +0200
Message-ID: <1538736767.3545.20.camel@pengutronix.de>
Subject: Re: [PATCH v4 11/11] media: imx.rst: Update doc to reflect fixes to
 interlaced capture
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 05 Oct 2018 12:52:47 +0200
In-Reply-To: <20181004185401.15751-12-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
         <20181004185401.15751-12-slongerbeam@gmail.com>
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

Hi Steve,

On Thu, 2018-10-04 at 11:54 -0700, Steve Longerbeam wrote:
> Also add an example pipeline for unconverted capture with interweave
> on SabreAuto.
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> ---
> Changes since v3:
> - none.
> Changes since v2:
> - expand on idmac interweave behavior in CSI subdev.
> - switch second SabreAuto pipeline example to PAL to give
>   both NTSC and PAL examples.
> - Cleanup some language in various places.
> ---
>  Documentation/media/v4l-drivers/imx.rst | 93 ++++++++++++++++---------
>  1 file changed, 60 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/media/v4l-drivers/imx.rst b/Documentation/media/v4l-drivers/imx.rst
> index 65d3d15eb159..1f6279d418ed 100644
> --- a/Documentation/media/v4l-drivers/imx.rst
> +++ b/Documentation/media/v4l-drivers/imx.rst
> @@ -22,8 +22,8 @@ memory. Various dedicated DMA channels exist for both video capture and
>  display paths. During transfer, the IDMAC is also capable of vertical
>  image flip, 8x8 block transfer (see IRT description), pixel component
>  re-ordering (for example UYVY to YUYV) within the same colorspace, and
> -even packed <--> planar conversion. It can also perform a simple
> -de-interlacing by interleaving even and odd lines during transfer
> +packed <--> planar conversion. The IDMAC can also perform a simple
> +de-interlacing by interweaving even and odd lines during transfer
>  (without motion compensation which requires the VDIC).
>  
>  The CSI is the backend capture unit that interfaces directly with
> @@ -173,15 +173,19 @@ via the SMFC and an IDMAC channel, bypassing IC pre-processing. This
>  source pad is routed to a capture device node, with a node name of the
>  format "ipuX_csiY capture".
>  
> -Note that since the IDMAC source pad makes use of an IDMAC channel, it
> -can do pixel reordering within the same colorspace. For example, the
> +Note that since the IDMAC source pad makes use of an IDMAC channel, the
> +CSI can do pixel reordering within the same colorspace. For example, the

This change is unrelated to interlacing, and sounds like the CSI
hardware does pixel reordering, which only partially correct.
The CSI either passes through its input unchanged, or turns any known
input format into either 32-bit ARGB or AYUV.

>  sink pad can take UYVY2X8, but the IDMAC source pad can output YUYV2X8.
>  If the sink pad is receiving YUV, the output at the capture device can
>  also be converted to a planar YUV format such as YUV420.
>  
> -It will also perform simple de-interlace without motion compensation,
> -which is activated if the sink pad's field type is an interlaced type,
> -and the IDMAC source pad field type is set to none.
> +The CSI will also perform simple interweave without motion compensation,

Again the CSI. It is the IDMAC that interweaves, not the CSI.

> +which is activated if the source pad's field type is sequential top-bottom
> +or bottom-top or alternate, and the capture interface field type is set
> +to interlaced (t-b, b-t, or unqualified interlaced). The capture interface
> +will enforce the same field order if the source pad field type is seq-bt
> +or seq-tb. However if the source pad's field type is alternate, any
> +interlaced type at the capture interface will be accepted.

This part is fine, though, as are the following changes. I'd just like
to avoid giving the wrong impression that the CSI does line interweaving
or pixel reordering into the output pixel format.

regards
Philipp
