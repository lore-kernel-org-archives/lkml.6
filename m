Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15896C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB58925C27
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB58925C27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030444AbeGBLov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:44:51 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:33869 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965717AbeGBLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:44:45 -0400
Received: from [IPv6:2001:983:e9a7:1:64b7:68bc:9d17:fa06] ([IPv6:2001:983:e9a7:1:64b7:68bc:9d17:fa06])
        by smtp-cloud8.xs4all.net with ESMTPA
        id ZxG6frQufoj71ZxG7fDAV2; Mon, 02 Jul 2018 13:44:44 +0200
Subject: Re: [PATCH] venus: venc: add support for ext controls
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org
References: <1530530783-9480-1-git-send-email-vgarodia@codeaurora.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b8cb593a-7102-7cf4-6101-bbf3ea83d9ee@xs4all.nl>
Date:   Mon, 2 Jul 2018 13:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530530783-9480-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO6vX9tKlctuCMP7juKX6sRv4cqaAy51IhO1ORJ0YVwGjdMkeOTbQrIiy21T+lwdq2Ed4vFON7inDxY9pSheXM63NyjLJ/NZkscY3LgLKnfhQ2NOfIyK
 ndQlrLiXsFfOIBnYCcUpnGIK0q1jycHtO/XFWHPGeUsiQfdMb0m3+waxedql/Ob/sY3gbgupWRhM9R/dhsn7Qa4BDqZfVslCk5ykSex6Mkt/vQzpD5rDrPR/
 T8PdE/eYkLHOtZkXkhrlwuCZJkK7nsTwKd9pvTnY1gtu//yZlUZ+KfB7XgsGJFYd6g9jBOXw6WzrM5YQ1nJw3gfWVlZC0Co+86ytuM4ln++7XnrsQPRpvzFb
 NGybQedpsx133iabBMP0+dHly5JpmAm6poYMdwXthPCDA6I3kHKslPv/whXki/+uW9CuNV+5mH3IkxrZsj923k4fzFxZPl6sBm1Af2ddo7IHsbOcza8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/18 13:26, Vikash Garodia wrote:
> There is a requirement to add frame level rate control.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index a2c6a4b..eaf2fa8 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -546,6 +546,33 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>  	return 0;
>  }
>  
> +static int venc_s_ext_ctrls(struct file *file, void *fh,
> +				struct v4l2_ext_controls *ctrl)
> +{
> +	struct venus_inst *inst = to_inst(file);
> +	struct v4l2_ext_control *control;
> +	u32 ptype, i, ret;
> +	struct hfi_enable en = { .enable = 1 };
> +	void *pdata = NULL;
> +
> +	control = ctrl->controls;
> +	for (i = 0; i < ctrl->count; i++) {
> +		switch (control[i].id) {
> +		case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
> +			ptype = HFI_PROPERTY_PARAM_VENC_DISABLE_RC_TIMESTAMP;
> +			en.enable = control[i].value;
> +			pdata = &en;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	ret = hfi_session_set_property(inst, ptype, pdata);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
>  static int venc_enum_framesizes(struct file *file, void *fh,
>  				struct v4l2_frmsizeenum *fsize)
>  {
> @@ -638,6 +665,7 @@ static int venc_enum_frameintervals(struct file *file, void *fh,
>  	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
>  	.vidioc_s_parm = venc_s_parm,
>  	.vidioc_g_parm = venc_g_parm,
> +	.vidioc_s_ext_ctrl = venc_s_ext_ctrls,

No, that's not how you do this. See venc_ctrls.c on how to handle controls.

Nacked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

>  	.vidioc_enum_framesizes = venc_enum_framesizes,
>  	.vidioc_enum_frameintervals = venc_enum_frameintervals,
>  	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> 

