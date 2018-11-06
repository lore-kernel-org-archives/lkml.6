Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014EAC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C390F2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C390F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbeKFXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:09:48 -0500
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:44644 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388029AbeKFXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:09:48 -0500
Received: from [IPv6:2001:420:44c1:2579:ecb0:41c2:bbc4:5915] ([IPv6:2001:420:44c1:2579:ecb0:41c2:bbc4:5915])
        by smtp-cloud9.xs4all.net with ESMTPA
        id K1eZgJ5frSskCK1ecgVutb; Tue, 06 Nov 2018 14:44:28 +0100
Subject: Re: [PATCH] media: v4l: fix uapi mpeg slice params definition
To:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102110945.191868-1-arnd@arndb.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d1ba33ad-ca69-1cbc-bd14-4935426c0abf@xs4all.nl>
Date:   Tue, 6 Nov 2018 14:44:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181102110945.191868-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBmjqFi9M3wDEpLQBlOkvFF/FlC4AaZWq62zYKIltv5LVfU3G2VPPwbS/lOHo++lUO1iIUaSBJfKMfgn0JEHRUCZE8nKzeoOXz7le1W+AaJs4WWty1tR
 EgBC2GhR6PsFzwBBBIKksafwYUp38FQHHzGs2gaBQ1ZlF9csFeSEpIFsU2X9sp8MYWw1ijLRTkC7XHeeTLj1U4n6aMIZQjYPiWNeD25ntucsMv6f9S0tnLrt
 f3IYKlrM3sCJrxeX9DoQJqWjWr/Z04xjmUVCBBuae+RiU1LX16cufkM8++Io3NoOacWlEKa0+LIV+hAWdD4lk8Iu1OKLHTHqYZtdVvHdDuMW0RFhs/E7jEga
 xTw+GQHcvRc/XG3aaxOuexJJe22Oh+we1KuHem03w2w9FwRJ33snZ+Ihs5swDmdtYVDTRUoblmYgam9Y2B7FIDc6UWCf/euosR2jmsxppK8GGiBoEgn1kvEI
 G7pKRlh2lslrNUNEjtJxtuZm0JHTsCwQHVImGuRSZDkZJFKhAhnY4b6EI/pNuP/JeTt0p8uw4mWsU99dzMnqYJKWFf/7tq9IjD63uHT3ZK1HmfSBG7t8OZ4r
 CDw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Maxime, Paul,

Sorry for the late reply, I was on vacation and only saw this patch now.

On 11/02/18 12:09, Arnd Bergmann wrote:
> We get a headers_check warning about the newly defined ioctl command
> structures:
> 
> ./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64} type without #include <linux/types.h>
> 
> This is resolved by including linux/types.h, as suggested by the
> warning, but there is another problem: Three of the four structures
> have an odd number of __u8 headers, but are aligned to 32 bit in the
> v4l2_ctrl_mpeg2_slice_params, so we get an implicit padding byte
> for each one. To solve that, let's add explicit padding that can
> be set to zero and verified in the kernel.
> 
> Fixes: c27bb30e7b6d ("media: v4l: Add definitions for MPEG-2 slice format and metadata")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 5 +++++
>  include/uapi/linux/v4l2-controls.h   | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index 6e37950292cd..5f2b033a7a42 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -1664,6 +1664,11 @@ static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
>  		    p_mpeg2_slice_params->forward_ref_index >= VIDEO_MAX_FRAME)
>  			return -EINVAL;
>  
> +		if (p_mpeg2_slice_params->pad ||
> +		    p_mpeg2_slice_params->picture.pad ||
> +		    p_mpeg2_slice_params->sequence.pad)
> +			return -EINVAL;
> +

Yuck.

>  		return 0;
>  
>  	case V4L2_CTRL_TYPE_MPEG2_QUANTIZATION:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 51b095898f4b..998983a6e6b7 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -50,6 +50,8 @@
>  #ifndef __LINUX_V4L2_CONTROLS_H
>  #define __LINUX_V4L2_CONTROLS_H
>  
> +#include <linux/types.h>
> +
>  /* Control classes */
>  #define V4L2_CTRL_CLASS_USER		0x00980000	/* Old-style 'user' controls */
>  #define V4L2_CTRL_CLASS_MPEG		0x00990000	/* MPEG-compression controls */
> @@ -1110,6 +1112,7 @@ struct v4l2_mpeg2_sequence {
>  	__u8	profile_and_level_indication;
>  	__u8	progressive_sequence;
>  	__u8	chroma_format;
> +	__u8	pad;

Rather than adding spurious 'pad' fields, can't we just change one of the u8 to u16?

Much cleaner that way.

Maxime, Paul, what do you think?

Regards,

	Hans

>  };
>  
>  struct v4l2_mpeg2_picture {
> @@ -1128,6 +1131,7 @@ struct v4l2_mpeg2_picture {
>  	__u8	alternate_scan;
>  	__u8	repeat_first_field;
>  	__u8	progressive_frame;
> +	__u8	pad;
>  };
>  
>  struct v4l2_ctrl_mpeg2_slice_params {
> @@ -1142,6 +1146,7 @@ struct v4l2_ctrl_mpeg2_slice_params {
>  
>  	__u8	backward_ref_index;
>  	__u8	forward_ref_index;
> +	__u8	pad;
>  };
>  
>  struct v4l2_ctrl_mpeg2_quantization {
> 

