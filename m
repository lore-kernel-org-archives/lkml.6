Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbeCFN63 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:58:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:6180 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753768AbeCFN62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:58:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="23354834"
Date: Tue, 6 Mar 2018 15:58:25 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Todor Tomov <todor.tomov@linaro.org>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: ov5645: Improve mode finding function
Message-ID: <20180306135825.6ctnlra3rbz3hub7@paasikivi.fi.intel.com>
References: <1518082920-11309-1-git-send-email-todor.tomov@linaro.org>
 <1518082920-11309-2-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518082920-11309-2-git-send-email-todor.tomov@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todor,

On Thu, Feb 08, 2018 at 11:42:00AM +0200, Todor Tomov wrote:
> Find the sensor mode by comparing the size of the requested image size
> and the sensor mode's image size. The distance between image sizes is the
> size in pixels of the non-overlapping regions between the requested size
> and the frame-specified size. This logic is borrowed from et8ek8 sensor
> driver.
> 
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  drivers/media/i2c/ov5645.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index 9755562..6d06c50 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -964,18 +964,24 @@ __ov5645_get_pad_crop(struct ov5645 *ov5645, struct v4l2_subdev_pad_config *cfg,
>  static const struct ov5645_mode_info *
>  ov5645_find_nearest_mode(unsigned int width, unsigned int height)
>  {
> -	int i;
> +	unsigned int max_dist_match = (unsigned int) -1;
> +	int i, n = 0;
>  
> -	for (i = ARRAY_SIZE(ov5645_mode_info_data) - 1; i >= 0; i--) {
> -		if (ov5645_mode_info_data[i].width <= width &&
> -		    ov5645_mode_info_data[i].height <= height)
> -			break;
> +	for (i = 0; i < ARRAY_SIZE(ov5645_mode_info_data); i++) {
> +		unsigned int dist = min(width, ov5645_mode_info_data[i].width)
> +				* min(height, ov5645_mode_info_data[i].height);
> +
> +		dist = ov5645_mode_info_data[i].width *
> +				ov5645_mode_info_data[i].height
> +		     + width * height - 2 * dist;

Could you use v4l2_find_nearest_size()?

The patch is here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?h=v4l2-common-size&id=83fdb8a0ab43fc86c329f63f1052e6113871a965>

The pull request has been sent on it.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
