Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FD5ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8255221473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UORlHapa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8255221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJRIww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:52:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43164 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:52:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id d8-v6so2119527pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OfuNNSz4yqUHuHArNJc01cR9p3XMcty2kblhbmkcp9o=;
        b=UORlHapaFqlIXiDKUkACLuAajuSpBSgPFCKkPQrY2mSWKW7J20TDu+CF1h2vQJdbmP
         FBd1s77GYYWfZ8qgcpeo3Of2a7+CQLFHKIbjoczdi/FarAr+p4g6CG3A1wpi83JDeUOP
         Q24nszBl8MmtilXNTPbEqF1AOtP7mLVsxBsQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OfuNNSz4yqUHuHArNJc01cR9p3XMcty2kblhbmkcp9o=;
        b=qiPkcgXybwhlw5u/MRdN7tA6NCMGFyy8puwk6WaIcXmp2VbCqd42s0Y+VRnSxKMwUj
         tVCJvzbAIk+xNq1YoZJ5NLawb0Az/xev8VVA1JSG7Ap/j3WYa5H970uM0a4NIg8PHtb/
         MbXoCiP9/52dTxursi+hO918unzzpa8XHfbsm61O2omqkuGEfg6uiBs3jyxK410PenLN
         f2A8ANmXNL8bLe1hY68/PtT3hDDrNsCbuLZZvjrQEvboXfLsr0kFtNJ74VWD8E1s0Mam
         uQGWR/PWOJqu1BKJw9YBuKQH4ZDPw2dY9/P7OL9HLwhwvO5kReovP6CL9KbLdXr0Y64S
         DBqw==
X-Gm-Message-State: ABuFfoiEro/saJxSX7J3BnQkRWAVILwpGkEryXZo26oSIxYSRXG0qOua
        Vd34xr/gTHfnUZkzs5Og4q23Qw==
X-Google-Smtp-Source: ACcGV61zRTKXcvs302P6bqL1QuMxY3QIK7m7UMTikfr3hRbLTGsvih3Idu+xC7/gG7V7Kd/S3NIShg==
X-Received: by 2002:a63:ac02:: with SMTP id v2-v6mr26507535pge.414.1539824071462;
        Wed, 17 Oct 2018 17:54:31 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 67-v6sm20630853pfw.60.2018.10.17.17.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 17:54:30 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:54:27 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC PATCH v2] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
Message-ID: <20181018005426.GC179852@rodete-desktop-imager.corp.google.com>
References: <20180930155646.20590-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930155646.20590-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Sun, Sep 30, 2018 at 09:26:46PM +0530, Sibi Sankar wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> rmtfs_mem provides access to physical storage and is crucial for the
> operation of the Qualcomm modem subsystem.
> 
> The rmtfs_mem implementation must be available before the modem
> subsystem is booted and a solution where the modem remoteproc will
> verify that the rmtfs_mem is available has been discussed in the past.
> But this would not handle the case where the rmtfs_mem provider is
> restarted, which would cause fatal loss of access to the storage device
> for the modem.
> 
> The suggestion is therefore to link the rmtfs_mem to its associated
> remote processor instance and control it based on the availability of
> the rmtfs_mem implementation.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> [sibis: Added qmi lookup for Remote file system service]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> The currently implemented workaround in the Linaro QCOMLT releases is to
> blacklist the qcom_q6v5_pil kernel module and load this explicitly after rmtfs
> has been started.
> 
> With this patch the modem module can be loaded automatically by the
> platform_bus and will only be booted as the rmtfs becomes available. Performing
> actions such as upgrading (and restarting) the rmtfs service will cause the
> modem to automatically restart and hence continue to function after the
> upgrade.
> 
> v2:
>   Remove rproc_boot/shutdown from rmtfs_mem open/release and add
>   qmi lookup for Remote file system service to address Brian's
>   race concerns.
> 
>  .../reserved-memory/qcom,rmtfs-mem.txt        |  7 ++
>  drivers/remoteproc/qcom_q6v5_pil.c            |  1 +
>  drivers/soc/qcom/Kconfig                      |  2 +
>  drivers/soc/qcom/rmtfs_mem.c                  | 65 ++++++++++++++++++-
>  4 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
> index 8562ba1dce69..95b209e7f5d1 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
> @@ -32,6 +32,13 @@ access block device data using the Remote Filesystem protocol.
>  	Value type: <u32>
>  	Definition: vmid of the remote processor, to set up memory protection.
>  
> +- rproc:
> +	Usage: optional
> +	Value type: <phandle>
> +	Definition: reference to a remoteproc node, that should be powered up
> +		    while the remote file system memory instance is ready to
> +		    handle requests from the remote subsystem.
> +

I'll repeat my comment here: this is straying far into the territory of
putting software configuration in the device tree. Per your own
comments, the modem firmware can be configured to run with or without a
remote FS, and now you're assuming that the device tree will include
this property or not, based on how you configured said firmware. That's
not how device tree is supposed to work.

>  = EXAMPLE
>  The following example shows the remote filesystem memory setup for APQ8016,
>  with the rmtfs region for the Hexagon DSP (id #1) located at 0x86700000.
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index d7a4b9eca5d2..1445a38e8b34 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -1142,6 +1142,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	qproc = (struct q6v5 *)rproc->priv;
>  	qproc->dev = &pdev->dev;
>  	qproc->rproc = rproc;
> +	rproc->auto_boot = false;

So how is it supposed to work when you have an internal filesystem for
the modem? User space just knows about this, and manually starts the
remoteproc?

>  	platform_set_drvdata(pdev, qproc);
>  
>  	ret = q6v5_init_mem(qproc, pdev);
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 8a7b8dea6990..4e3345944325 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -86,7 +86,9 @@ config QCOM_QMI_HELPERS
>  config QCOM_RMTFS_MEM
>  	tristate "Qualcomm Remote Filesystem memory driver"
>  	depends on ARCH_QCOM
> +	depends on REMOTEPROC
>  	select QCOM_SCM
> +	select QCOM_QMI_HELPERS
>  	help
>  	  The Qualcomm remote filesystem memory driver is used for allocating
>  	  and exposing regions of shared memory with remote processors for the
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index 97bb5989aa21..757e30083f67 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -18,11 +18,13 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_reserved_mem.h>
> +#include <linux/remoteproc.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
>  #include <linux/qcom_scm.h>
> +#include <linux/soc/qcom/qmi.h>
>  
>  #define QCOM_RMTFS_MEM_DEV_MAX	(MINORMASK + 1)
>  
> @@ -31,6 +33,7 @@ static dev_t qcom_rmtfs_mem_major;
>  struct qcom_rmtfs_mem {
>  	struct device dev;
>  	struct cdev cdev;
> +	struct qmi_handle rmtfs_hdl;
>  
>  	void *base;
>  	phys_addr_t addr;
> @@ -39,6 +42,8 @@ struct qcom_rmtfs_mem {
>  	unsigned int client_id;
>  
>  	unsigned int perms;
> +
> +	struct rproc *rproc;
>  };
>  
>  static ssize_t qcom_rmtfs_mem_show(struct device *dev,
> @@ -141,6 +146,36 @@ static const struct file_operations qcom_rmtfs_mem_fops = {
>  	.llseek = default_llseek,
>  };
>  
> +static int rmtfs_new_server(struct qmi_handle *qmi,
> +				 struct qmi_service *service)
> +{
> +	int ret = 0;
> +	struct qcom_rmtfs_mem *rmtfs_mem = container_of(qmi,
> +							struct qcom_rmtfs_mem,
> +							rmtfs_hdl);
> +
> +	if (rmtfs_mem->rproc)

Couldn't you avoid registering these callbacks entirely, if there's no
rproc device/phandle?

> +		ret = rproc_boot(rmtfs_mem->rproc);
> +
> +	return ret;
> +};
> +
> +static void rmtfs_del_server(struct qmi_handle *qmi,
> +				  struct qmi_service *service)
> +{
> +	struct qcom_rmtfs_mem *rmtfs_mem = container_of(qmi,
> +							struct qcom_rmtfs_mem,
> +							rmtfs_hdl);
> +
> +	if (rmtfs_mem->rproc)
> +		rproc_shutdown(rmtfs_mem->rproc);
> +};
> +
> +static struct qmi_ops rmtfs_lookup_ops = {
> +	.new_server = rmtfs_new_server,
> +	.del_server = rmtfs_del_server,
> +};
> +
>  static void qcom_rmtfs_mem_release_device(struct device *dev)
>  {
>  	struct qcom_rmtfs_mem *rmtfs_mem = container_of(dev,
> @@ -156,6 +191,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	struct qcom_scm_vmperm perms[2];
>  	struct reserved_mem *rmem;
>  	struct qcom_rmtfs_mem *rmtfs_mem;
> +	phandle rproc_phandle;
>  	u32 client_id;
>  	u32 vmid;
>  	int ret;
> @@ -181,6 +217,22 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	rmtfs_mem->client_id = client_id;
>  	rmtfs_mem->size = rmem->size;
>  
> +	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
> +	if (!ret) {
> +		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);
> +		if (!rmtfs_mem->rproc)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ret = qmi_handle_init(&rmtfs_mem->rmtfs_hdl, 0,
> +			      &rmtfs_lookup_ops, NULL);

Similar to the above comment: this should just be under the "if rproc"
condition -- also because in remove(), you only unregister these
callbacks if you have an rproc device.

> +	if (ret < 0)
> +		goto put_rproc;

You've got the error handling wrong here. You're doing the
rmtfs_mem->dev cleanup under the 'put_rproc' label, but you haven't even
started to initialize that device by now.

> +
> +	ret = qmi_add_lookup(&rmtfs_mem->rmtfs_hdl, 14, 0, 0);

I can see there are some bad examples out there already to cheat off
of...but please don't just use magic nubmers like '14' here. There
should be a defined constant for this.

And while we're at it: why isn't there a common header for QMI service
IDs? Would be nice to list all the IDs that the kernel might be using,
in one place.

> +	if (ret < 0)
> +		goto err_release_qmi_handle;
> +
>  	device_initialize(&rmtfs_mem->dev);
>  	rmtfs_mem->dev.parent = &pdev->dev;
>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
> @@ -191,7 +243,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	if (IS_ERR(rmtfs_mem->base)) {
>  		dev_err(&pdev->dev, "failed to remap rmtfs_mem region\n");
>  		ret = PTR_ERR(rmtfs_mem->base);
> -		goto put_device;
> +		goto err_release_qmi_handle;
>  	}
>  
>  	cdev_init(&rmtfs_mem->cdev, &qcom_rmtfs_mem_fops);
> @@ -204,7 +256,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	ret = cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add cdev: %d\n", ret);
> -		goto put_device;
> +		goto err_release_qmi_handle;
>  	}
>  
>  	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
> @@ -237,7 +289,10 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  
>  remove_cdev:
>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
> -put_device:
> +err_release_qmi_handle:
> +	qmi_handle_release(&rmtfs_mem->rmtfs_hdl);
> +put_rproc:
> +	rproc_put(rmtfs_mem->rproc);
>  	put_device(&rmtfs_mem->dev);

As mentioned above, this is in the wrong order. You probably will need
an additional exit label too.

>  
>  	return ret;
> @@ -257,6 +312,10 @@ static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
>  	}
>  
>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
> +	if (rmtfs_mem->rproc) {
> +		qmi_handle_release(&rmtfs_mem->rmtfs_hdl);

As noted above, this doesn't match with probe().

Brian

> +		rproc_put(rmtfs_mem->rproc);
> +	}
>  	put_device(&rmtfs_mem->dev);
>  
>  	return 0;
