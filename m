Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753961AbeBUMDf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:03:35 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:34199 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751180AbeBUMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:03:32 -0500
Subject: Re: [PATCH v9 03/11] media: platform: Add Renesas CEU driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com,
        geert@glider.be, mchehab@kernel.org, festevam@gmail.com,
        sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com,
        pombredanne@nexb.com
Cc: linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1519059584-30844-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519059584-30844-4-git-send-email-jacopo+renesas@jmondi.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <024c232f-bd43-42a9-25e7-0fbe71edbcb0@xs4all.nl>
Date: Wed, 21 Feb 2018 13:03:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519059584-30844-4-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC3//5bGcprgwYjS3yJWpcn2SlUK3APAVGsHbEZgaspwkEG0TxTP0MPvdVG1kRoDHUOITr/u7Wu8IGCHuEfc4CgXZHyhJqtsTXxbw3q9bCK8Qx9pT6iB
 m7UZ+UyuBJ1+YfCcYWlswuVpOz2gI/3/bq3IEotWVKxLvqYdt6TyvWMf6Dxcpw7zygSZArBocxaliUUaJ9GEjN5QIoR5PMn/nCiuC4vkl0Iqk7Bif6DhOFhy
 9zieTN8DehihZ9eOUg+3jIoxQGwGp8PcxX/AGNWEkT1zbP3xCYavL2pcXjrj3VFKJXmWwNKG6xuRYG/TEwhAVACKkIOtaogVONxtAvXggcacjCNVQiqIf6E0
 8+hzPtTCaYw+gn0C8xMi1lXebsMEViXCqsyGUjNId6B9dMSwZAC1Fyv43647WyIlfeMl4lEu6NblBkPVzyeVnhgNhlqnfQ0u3GTyTLRFqJCbhDqSsBOPZkbH
 xMmLz/9s0Gy0ohMd+DksmHIkjVc0J8TIEDFbSJr9wQyh/HVZhexY4I2CFYBzbfXi22jg7hr3NRdYoTwJbqH3WquNp19kUZ9qdYZBIAPwKW2NEbr1AiYOytVv
 5kHE2ESMR2g5VzlwU/MTXjCvFlxGVtBb2heDqSAjKRpKPMdWqGkFX/IPImTyIpGfEMlSKoAkSdfCEcBjVDeaNM0zVj1kNJ+SxFmM2ZINK6ACsWt5/aAdo7Pi
 lnlSMDF8RsWDXmvAt1H5cqCYHG++MB07fvZxcTRsHXIevZU8CQqxDhznhCX3kPz2YWoIwOPI9F5j2TQhJVw0JU3OtWgrqkL0XGUFBfOsBWWP57kIyxZ+qg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/18 17:59, Jacopo Mondi wrote:
> Add driver for Renesas Capture Engine Unit (CEU).
> 
> The CEU interface supports capturing 'data' (YUV422) and 'images'
> (NV[12|21|16|61]).
> 
> This driver aims to replace the soc_camera-based sh_mobile_ceu one.
> 
> Tested with ov7670 camera sensor, providing YUYV_2X8 data on Renesas RZ
> platform GR-Peach.
> 
> Tested with ov7725 camera sensor on SH4 platform Migo-R.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/platform/Kconfig       |    9 +
>  drivers/media/platform/Makefile      |    1 +
>  drivers/media/platform/renesas-ceu.c | 1661 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1671 insertions(+)
>  create mode 100644 drivers/media/platform/renesas-ceu.c
> 

<snip>

> +static int ceu_s_input(struct file *file, void *priv, unsigned int i)
> +{
> +	struct ceu_device *ceudev = video_drvdata(file);
> +	struct ceu_subdev *ceu_sd_old;
> +	int ret;
> +
> +	if (i >= ceudev->num_sd)
> +		return -EINVAL;
> +
> +	if (vb2_is_streaming(&ceudev->vb2_vq))
> +		return -EBUSY;
> +
> +	if (i == ceudev->sd_index)
> +		return 0;
> +
> +	ceu_sd_old = ceudev->sd;
> +	ceudev->sd = &ceudev->subdevs[i];
> +
> +	/* Make sure we can generate output image formats. */
> +	ret = ceu_init_formats(ceudev);

Why is this done for every s_input? I would expect that this is done only once
for each subdev.

I also expect to see a ceu_set_default_fmt() call here. Or that the v4l2_pix is kept
in ceu_subdev (i.e. per subdev) instead of a single fmt in cuedev. I think I prefer
that over configuring a new default format every time you switch inputs.

This code will work for two subdevs with exactly the same formats/properties. But
switching between e.g. a sensor and a video receiver will leave things in an
inconsistent state as far as I can see.

E.g. if input 1 is the video receiver then switching to that input and running
'v4l2-ctl -V' will show the sensor format, not the video receiver format.

> +	if (ret) {
> +		ceudev->sd = ceu_sd_old;
> +		return -EINVAL;
> +	}
> +
> +	/* now that we're sure we can use the sensor, power off the old one. */
> +	v4l2_subdev_call(ceu_sd_old->v4l2_sd, core, s_power, 0);
> +	v4l2_subdev_call(ceudev->sd->v4l2_sd, core, s_power, 1);
> +
> +	ceudev->sd_index = i;
> +
> +	return 0;
> +}

The remainder of this driver looks good.

Regards,

	Hans
