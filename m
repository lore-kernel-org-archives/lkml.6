Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593CBC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7A020846
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7A020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeIAP6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 11:58:17 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:48080 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727212AbeIAP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 11:58:17 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 63EFD634C7D;
        Sat,  1 Sep 2018 14:46:30 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1fw4MI-0001Dt-3o; Sat, 01 Sep 2018 14:46:30 +0300
Date:   Sat, 1 Sep 2018 14:46:29 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: ov2680: register the v4l2 subdev async at the end
 of probe
Message-ID: <20180901114629.rupnr7xaeyxjqfdk@valkosipuli.retiisi.org.uk>
References: <20180831151906.9315-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831151906.9315-1-javierm@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, Aug 31, 2018 at 05:19:06PM +0200, Javier Martinez Canillas wrote:
> The driver registers the subdev async in the middle of the probe function
> but this has to be done at the very end of the probe function to prevent
> registering a device whose probe function could fail (i.e: the clock and
> regulators enable can fail, the I2C transfers could return errors, etc).
> 
> It could also lead to a media device driver that is waiting to bound the
> v4l2 subdevice to incorrectly expose its media device to userspace, since
> the subdev is registered but later its media entity is cleaned up on error.
> 
> Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
> 
>  drivers/media/i2c/ov2680.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
> index f753a1c333ef..2ef920a17278 100644
> --- a/drivers/media/i2c/ov2680.c
> +++ b/drivers/media/i2c/ov2680.c
> @@ -983,10 +983,6 @@ static int ov2680_v4l2_init(struct ov2680_dev *sensor)
>  
>  	sensor->sd.ctrl_handler = hdl;
>  
> -	ret = v4l2_async_register_subdev(&sensor->sd);
> -	if (ret < 0)
> -		goto cleanup_entity;
> -
>  	return 0;
>  
>  cleanup_entity:
> @@ -1096,6 +1092,10 @@ static int ov2680_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		goto error_cleanup;

How about instead moving ov2680_check_id() call earlier in probe()? That
would seem to be a better fix: the driver should check the device is around
before registering anything.

>  
> +	ret = v4l2_async_register_subdev(&sensor->sd);
> +	if (ret < 0)
> +		goto error_cleanup;
> +
>  	dev_info(dev, "ov2680 init correctly\n");
>  
>  	return 0;
> @@ -1104,7 +1104,6 @@ static int ov2680_probe(struct i2c_client *client)
>  	dev_err(dev, "ov2680 init fail: %d\n", ret);
>  
>  	media_entity_cleanup(&sensor->sd.entity);
> -	v4l2_async_unregister_subdev(&sensor->sd);
>  	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
>  
>  lock_destroy:

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
