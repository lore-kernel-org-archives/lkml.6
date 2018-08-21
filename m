Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE15C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF275217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF275217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHUUTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:19:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43282 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHUUTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:19:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id AEB66265B85
Message-ID: <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
Subject: Re: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>, tfiga@chromium.org,
        posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Date:   Tue, 21 Aug 2018 13:58:38 -0300
In-Reply-To: <20180613140714.1686-2-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
         <20180613140714.1686-2-maxime.ripard@bootlin.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> From: Pawel Osciak <posciak@chromium.org>
> 
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> Tested-by: Tomasz Figa <tfiga@chromium.org>
> [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
> 
[..]
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 242a6bfa1440..4b4a1b25a0db 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -626,6 +626,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
>  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
>  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
> +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */

As pointed out by Tomasz, the Rockchip VPU driver expects start codes [1], so the userspace
should be aware of it. Perhaps we could document this pixel format better as:

#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices with start codes */

And introduce another pixel format:

#define V4L2_PIX_FMT_H264_SLICE_NO_SC v4l2_fourcc(TODO) /* H264 parsed slices without start codes */

For cedrus to use, as it seems it doesn't need start codes.

How does it sound? 

[1] https://cs.chromium.org/chromium/src/media/gpu/v4l2/v4l2_slice_video_decode_accelerator.cc?rcl=63129434aeacf0f54bbae96814f10cf64e3e6c35&l=2438
