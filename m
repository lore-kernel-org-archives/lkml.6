Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C03CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D6020693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D6020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeFSEEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:04:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:36973 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeFSEEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:04:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 21:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,241,1526367600"; 
   d="scan'208";a="48777636"
Received: from aosowska-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.34.137])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2018 21:04:33 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id A964B21E18; Tue, 19 Jun 2018 07:04:32 +0300 (EEST)
Date:   Tue, 19 Jun 2018 07:04:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: ov5645: Report number of skip frames
Message-ID: <20180619040432.xbcrkgof6rycg3db@kekkonen.localdomain>
References: <1529309219-27404-1-git-send-email-todor.tomov@linaro.org>
 <1529309219-27404-2-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529309219-27404-2-git-send-email-todor.tomov@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todor,

On Mon, Jun 18, 2018 at 11:06:59AM +0300, Todor Tomov wrote:
> The OV5645 supports automatic exposure (AE) and automatic white
> balance (AWB). When streaming is started it takes up to 5 frames
> until the AE and AWB converge and output a frame with good quality.

The frames aren't bad as such; it's just that the AE hasn't converged yet.
I presume the number of the frames needed depends on the lighting
conditions.

The g_skip_frames is intended to tell the frames really are bad, i.e.
distorted or broken somehow.

I wouldn't discard them on the grounds of unconverged exposure. If we did,
then on which other grounds should the frames be discarded as well? Does
the white balance and focus need to be converged as well before considering
the frames good, for instance?

If you need this, I'd use a control instead to tell AE has converged.

I wonder what others think.

> 
> Implement g_skip_frames to report number of frames to be skipped
> when streaming is started.
> 
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  drivers/media/i2c/ov5645.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index 1722cda..00bc3c0 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -70,6 +70,9 @@
>  #define OV5645_SDE_SAT_U		0x5583
>  #define OV5645_SDE_SAT_V		0x5584
>  
> +/* Number of frames needed for AE and AWB to converge */
> +#define OV5645_NUM_OF_SKIP_FRAMES 5
> +
>  struct reg_value {
>  	u16 reg;
>  	u8 val;
> @@ -1071,6 +1074,13 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
>  	return 0;
>  }
>  
> +static int ov5645_get_skip_frames(struct v4l2_subdev *sd, u32 *frames)
> +{
> +	*frames = OV5645_NUM_OF_SKIP_FRAMES;
> +
> +	return 0;
> +}
> +
>  static const struct v4l2_subdev_core_ops ov5645_core_ops = {
>  	.s_power = ov5645_s_power,
>  };
> @@ -1088,10 +1098,15 @@ static const struct v4l2_subdev_pad_ops ov5645_subdev_pad_ops = {
>  	.get_selection = ov5645_get_selection,
>  };
>  
> +static const struct v4l2_subdev_sensor_ops ov5645_sensor_ops = {
> +	.g_skip_frames = ov5645_get_skip_frames,
> +};
> +
>  static const struct v4l2_subdev_ops ov5645_subdev_ops = {
>  	.core = &ov5645_core_ops,
>  	.video = &ov5645_video_ops,
>  	.pad = &ov5645_subdev_pad_ops,
> +	.sensor = &ov5645_sensor_ops,
>  };
>  
>  static int ov5645_probe(struct i2c_client *client,
> -- 
> 2.7.4
> 

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
