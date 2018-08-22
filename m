Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E003C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6F82151D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6F82151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeHVJxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:53:48 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:43379 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbeHVJxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:53:48 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id sMekfFJqqoj71sMeofXZ41; Wed, 22 Aug 2018 08:30:19 +0200
Subject: Re: [PATCH] media: vimc: implement basic v4l2-ctrls
To:     Guilherme Gallo <gagallo7@gmail.com>,
        lkcamp@lists.libreplanetbr.org, helen.koike@collabora.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180822012219.22946-1-gagallo7@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0c204c5f-2bd1-2ca7-c055-b0ff6d93189a@xs4all.nl>
Date:   Wed, 22 Aug 2018 08:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180822012219.22946-1-gagallo7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMQ+5/wplLy0u8aTV2AZJOWwRxVyEVzY7tJWaHpWjX/OWCOeYh6zvgpYcMKce0VqtJvT1/aHFubTDPaTSovj8Ur1IczZMq6Dysbk08x/XjV88MMSqEjK
 UU1g+kYaZhggg/sBitmS6tTMOprKgnnhmLVcRViRb0zZ9aGDgN35NHfGgn+imj3Ewj3k5dfXGad+aF/3bYrwxv+iaUryQs18qbvJZcZhybHsaWDQeSlw9Not
 02+8VFPgiH0VxYHOt4LnTV5rW1EcW7QVruYc51K9bwbSnkoL/n249+eroVajOvUI5wLxqKlAxnfRUZfSyVFeZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme,

Thank you for your patch. It looks good, but can you add support for V4L2_CID_SATURATION
as well? The TPG supports that as well, so there is no reason to leave that out.

Thank you!

	Hans

On 08/22/2018 03:22 AM, Guilherme Gallo wrote:
> Implement brightness, contrast and hue controls in vimc-sensor
> 
> Signed-off-by: Guilherme Alcarde Gallo <gagallo7@gmail.com>
> ---
>  drivers/media/platform/vimc/vimc-sensor.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
> index 605e2a2d5dd5..ecc82cd60900 100644
> --- a/drivers/media/platform/vimc/vimc-sensor.c
> +++ b/drivers/media/platform/vimc/vimc-sensor.c
> @@ -316,6 +316,15 @@ static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_VFLIP:
>  		tpg_s_vflip(&vsen->tpg, ctrl->val);
>  		break;
> +	case V4L2_CID_BRIGHTNESS:
> +		tpg_s_brightness(&vsen->tpg, ctrl->val);
> +		break;
> +	case V4L2_CID_CONTRAST:
> +		tpg_s_contrast(&vsen->tpg, ctrl->val);
> +		break;
> +	case V4L2_CID_HUE:
> +		tpg_s_hue(&vsen->tpg, ctrl->val);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -377,6 +386,12 @@ static int vimc_sen_comp_bind(struct device *comp, struct device *master,
>  			  V4L2_CID_VFLIP, 0, 1, 1, 0);
>  	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
>  			  V4L2_CID_HFLIP, 0, 1, 1, 0);
> +	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> +			  V4L2_CID_BRIGHTNESS, 0, 255, 1, 128);
> +	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> +			  V4L2_CID_CONTRAST, 0, 255, 1, 128);
> +	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> +			  V4L2_CID_HUE, 0, 255, 1, 128);
>  	vsen->sd.ctrl_handler = &vsen->hdl;
>  	if (vsen->hdl.error) {
>  		ret = vsen->hdl.error;
> 

