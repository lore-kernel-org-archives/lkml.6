Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E20C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3304220676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NNg30QSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3304220676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIYXi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:38:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeIYXiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:38:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id q19-v6so11191013pgn.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qRpFU03cygqLIF0fNm4mTLpJbpBZjWH/cQhabsNceos=;
        b=NNg30QSOth9p+MgyY59APIVfAUcWQMSxnyw9/clgFFDdH6VClnxNduv4O2pQe3mdCC
         qXdeeDXTmnFByCBJOLzQSlGComC6EIdYEQkYbeE6erOpK6XYs9pNdLJWQZ+dQZ9rvPxc
         Y9FBl9kqgw3A0A+eT6DxtsLwxXezblmKDUtIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qRpFU03cygqLIF0fNm4mTLpJbpBZjWH/cQhabsNceos=;
        b=qA+iRyYrRhntDjSkCNNrEtgYzRbhQVNsqYGIK7foGaod1tK0+TaUOhPQgMd8Ep8xvU
         p7P50FkJSkxtNVWXc7h0ZRX0U5/PE2VqvdUHRCbOdWa55asJbSbv3OugUG8pDuqqdhZk
         lwwUvbqidxhg4+ATH11o4pKuY10bKMBfOj2W+QElO69mhk6/LugsruQZO6I2ygTCJJu4
         ILoUEvCwqleWiyi/jRB8MoJPg3Mu2TxE0Zv4CSRQJkDiJOqpo0br5jR73Zl2ynRhrcdM
         owytQZ66Od+F/ZpgflzsDUNC74sPTBVqMnvkMMNy9yqqgswMKPdlpZXEw9XcgH2NB3ul
         notg==
X-Gm-Message-State: ABuFfohkadh96ZQ826/0Q7K7dZQVSTS1eoexNKBJ1m9DiSrWsqyTHpMS
        DPJnQRCdBDefsN8ksxxBOl0XSg==
X-Google-Smtp-Source: ACcGV62HJAv7MxVI8E7Q9y3PDTyIO/6pHPVU3G18fVmJzDL6RhJ05TEsbe3oPwAcYzMzErRSAdxZ6w==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12-v6mr2147396plr.163.1537896594056;
        Tue, 25 Sep 2018 10:29:54 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id b14-v6sm4949452pfc.178.2018.09.25.10.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 10:29:52 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:29:50 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [RFC PATCH] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
Message-ID: <20180925172943.GA118699@ban.mtv.corp.google.com>
References: <20180925080607.30565-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925080607.30565-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Tue, Sep 25, 2018 at 01:06:07AM -0700, Bjorn Andersson wrote:
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
> The suggestion is therefor to link the rmtfs_mem to its associated
> remote processor instance and control it based on the availability of
> the rmtfs_mem implementation.

But what does "availability" mean? If I'm reading your rmtfs daemon
properly, "availability" should mean that the daemon is up and has
registered a RMTFS_QMI_SERVICE. But in this patch, you're keying off of
the open() call, which sounds like you're introducing a race condition
-- we might have open()ed the RMTFS memory but we're not actually
completely ready to service requests.

So rather than looking for open(), I think somebody needs to be looking
for the appearance and disappearance of the RMTFS_QMI_SERVICE. (Looking
for disappearance would resolve the daemon restart issue, no?) That
"somebody" could be the remoteproc driver I suppose (qmi_add_lookup()?),
or...couldn't it just be the modem itself? Do you actually need to
restart the entire modem when the RMTFS service goes away, or do you
just need to pause storage activity?

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
>  .../reserved-memory/qcom,rmtfs-mem.txt        |  7 ++++++
>  drivers/remoteproc/qcom_q6v5_pil.c            |  1 +
>  drivers/soc/qcom/Kconfig                      |  1 +
>  drivers/soc/qcom/rmtfs_mem.c                  | 23 ++++++++++++++++++-
>  4 files changed, 31 insertions(+), 1 deletion(-)
> 
...
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index 8a3678c2e83c..8b08be310397 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_reserved_mem.h>
> +#include <linux/remoteproc.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -39,6 +40,8 @@ struct qcom_rmtfs_mem {
>  	unsigned int client_id;
>  
>  	unsigned int perms;
> +
> +	struct rproc *rproc;
>  };
>  
>  static ssize_t qcom_rmtfs_mem_show(struct device *dev,
> @@ -80,11 +83,18 @@ static int qcom_rmtfs_mem_open(struct inode *inode, struct file *filp)
>  	struct qcom_rmtfs_mem *rmtfs_mem = container_of(inode->i_cdev,
>  							struct qcom_rmtfs_mem,
>  							cdev);
> +	int ret = 0;
>  
>  	get_device(&rmtfs_mem->dev);
>  	filp->private_data = rmtfs_mem;
>  
> -	return 0;
> +	if (rmtfs_mem->rproc) {
> +		ret = rproc_boot(rmtfs_mem->rproc);
> +		if (ret)
> +			put_device(&rmtfs_mem->dev);
> +	}
> +
> +	return ret;
>  }
>  static ssize_t qcom_rmtfs_mem_read(struct file *filp,
>  			      char __user *buf, size_t count, loff_t *f_pos)
> @@ -127,6 +137,9 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
>  {
>  	struct qcom_rmtfs_mem *rmtfs_mem = filp->private_data;
>  
> +	if (rmtfs_mem->rproc)
> +		rproc_shutdown(rmtfs_mem->rproc);
> +
>  	put_device(&rmtfs_mem->dev);
>  
>  	return 0;
> @@ -156,6 +169,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	struct qcom_scm_vmperm perms[2];
>  	struct reserved_mem *rmem;
>  	struct qcom_rmtfs_mem *rmtfs_mem;
> +	phandle rproc_phandle;
>  	u32 client_id;
>  	u32 vmid;
>  	int ret;
> @@ -181,6 +195,13 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	rmtfs_mem->client_id = client_id;
>  	rmtfs_mem->size = rmem->size;
>  
> +	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
> +	if (!ret) {
> +		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);

You're doing an rproc_get(), so you need to do a rproc_put() in
remove().

Brian

> +		if (!rmtfs_mem->rproc)
> +			return -EPROBE_DEFER;
> +	}
> +
>  	device_initialize(&rmtfs_mem->dev);
>  	rmtfs_mem->dev.parent = &pdev->dev;
>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
