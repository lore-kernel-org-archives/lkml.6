Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A09EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB399218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c33cxKe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbeLUBTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:19:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41307 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbeLUBS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:18:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so1690656pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x/vXYZ31g3ABH1UZtxHJHemkMZpDKLKHrwM3x9jGNlQ=;
        b=c33cxKe4uBU7BEYsZx6lgv0tAAjdPgS/8Mw/LHftDlJ9kqBpzJqly+FnBNsKUB/+3o
         W1wTIM46JEduAp9Z3DmXwaYgyUI4NqadIzlQznCsiNPRzZhLelWTvbHGWCRElukXrn+H
         RIwqU9q3XJHK5gfeMwll0Q4GNMIvvLeFeX5No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/vXYZ31g3ABH1UZtxHJHemkMZpDKLKHrwM3x9jGNlQ=;
        b=qnSD/Af/r/AzlgpB1u8hLIr+R1g4IzdYKusYOjI17cr0ldfPTcWuJfwt8V+ojo1203
         7WLCRCUmVzJ/ts8KZHgJ09JLYn08gjUn5crltLmf4LpVNHFsJP8RdvkcNyRifI2wpaJa
         YlnAEzGwj3YG9OYvDqdSvO4w9SS4dVtEm+k+PXzk/GAKQVV+gVrqSU3o2Yk2v74CW28J
         gMrZHIb0yMSwZS0G/Uy+TqGg7maKUVUUYs/M5umx3EktdF/jx+K/oButUehoksIrRsi9
         a806c4hWKecV54tJIQN3PgB+reNJsO/+8B36o4AP3RIU1AzhJzOsKCoMRJ706iGKtWy/
         YSSg==
X-Gm-Message-State: AA+aEWasahM4kk2xpXwFyybHzCE89XQWAsj1f2F5d8Isg9LMXYQx8qh3
        qh7Uu0ftlwgu7a3HUTOTenFuOg==
X-Google-Smtp-Source: AFSGD/UrZ1/uKlhKhbW5A3qs6S9RVEF1S/udQL+Ymeqb+AfxtrmPT0sNNOcLJq3dBC1mPDMFJtXuHg==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr463884pfc.113.1545355138374;
        Thu, 20 Dec 2018 17:18:58 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id u69sm45723955pfj.116.2018.12.20.17.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 17:18:57 -0800 (PST)
Date:   Thu, 20 Dec 2018 17:18:54 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ben Chan <benchan@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
Message-ID: <20181221011853.GA189656@google.com>
References: <20181218000834.201748-1-evgreen@chromium.org>
 <20181218000834.201748-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218000834.201748-2-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On Mon, Dec 17, 2018 at 04:08:33PM -0800, Evan Green wrote:
> Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
> Add a class to the rmtfs device so that uevents fire when the device is added.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
>  drivers/soc/qcom/rmtfs_mem.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index 97bb5989aa211..0bf800ee2a978 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -132,6 +132,11 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static struct class rmtfs_class = {
> +	.owner          = THIS_MODULE,
> +	.name           = "rmtfs",
> +};
> +
>  static const struct file_operations qcom_rmtfs_mem_fops = {
>  	.owner = THIS_MODULE,
>  	.open = qcom_rmtfs_mem_open,
> @@ -173,9 +178,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  
>  	}
>  
> +	ret  = class_register(&rmtfs_class);
> +	if (ret)
> +		return ret;

Hmm, is this how classes are supposed to work? Usually, you have the
possibility of more than 1 device per class, and therefore you don't
register the class in the driver probe -- you register it in the init()
routine, or something similar. As it is, I expect this will break if
there were ever a second rmtfs device.

Brian

> +
>  	rmtfs_mem = kzalloc(sizeof(*rmtfs_mem), GFP_KERNEL);
> -	if (!rmtfs_mem)
> -		return -ENOMEM;
> +	if (!rmtfs_mem) {
> +		ret = -ENOMEM;
> +		goto unregister_class;
> +	}
>  
>  	rmtfs_mem->addr = rmem->base;
>  	rmtfs_mem->client_id = client_id;
> @@ -199,8 +210,8 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  
>  	dev_set_name(&rmtfs_mem->dev, "qcom_rmtfs_mem%d", client_id);
>  	rmtfs_mem->dev.id = client_id;
> +	rmtfs_mem->dev.class = &rmtfs_class;
>  	rmtfs_mem->dev.devt = MKDEV(MAJOR(qcom_rmtfs_mem_major), client_id);
> -
>  	ret = cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add cdev: %d\n", ret);
> @@ -235,11 +246,13 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +
>  remove_cdev:
>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  put_device:
>  	put_device(&rmtfs_mem->dev);
> -
> +unregister_class:
> +	class_unregister(&rmtfs_class);
>  	return ret;
>  }
>  
> @@ -258,7 +271,7 @@ static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
>  
>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  	put_device(&rmtfs_mem->dev);
> -
> +	class_unregister(&rmtfs_class);
>  	return 0;
>  }
>  
> -- 
> 2.18.1
> 
