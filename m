Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DC0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CF12086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dKEgim7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CF12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeKGFoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:44:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45074 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeKGFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:44:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so5861036pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 12:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xay21Culhf9gw/VcFbDi2scwuLDFA32F3Y+oMl5aZ4M=;
        b=dKEgim7c8gKqxD0iST+daiFK7DRerOoPm6scfY3rqG1S37LAWiFjXK145kEBpEw4+3
         nf2bc4hadF+F2SKTa4zyrYx6vTLrgLNlUR3ymi3McfiC1GtjIl52GzYJwzLwTwTP1Wed
         TMdPmyNlxuRrcBySRnlPS/M/U9CJGSZ5xxlXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xay21Culhf9gw/VcFbDi2scwuLDFA32F3Y+oMl5aZ4M=;
        b=JyHvA8pjYkApasSceIQxlBF4TchBweEV73xyhi7Cu+v56u4Q2L9YjqIDSnMzGK3HOW
         OllswFbXIFF9Rv9nJ2g4EvI41D+jM7U7XrvR/ezxEbdaJd8CVmbS2U+qdmuXlnwcF9p3
         TU3YtggEt/ccT3UYrPmTIZC4NFvbiNZeNCJSWIjudyKwTvQ/yRFOhN1wSFVP7OKYAqet
         ad/nYFK5V2HvHZv/t7JFKoAF7sfx9qKprVyL4VoUxEUk+hivIwTKNhsXuAqsuhU+hL/z
         I7CyYn12g1embvzp2v3TA3j+nwzYAJ9ySFSl+/AoGewrvdgvlbXwPsnr16q0qV6kDf1o
         GNsQ==
X-Gm-Message-State: AGRZ1gL08x4nA3OLBHVKrF/fDWKH5T/ufsuOPSYAODhKWx04GKm56oqM
        n5rpX3Qhd1wqBawciku86Nqfrw==
X-Google-Smtp-Source: AJdET5c7je2v3ICZntwbAGM9cQ8KmGGwcxi46S9jJfEsEZY0rdbC/m48wNEV3l3HgXUYRlyGQMEEzw==
X-Received: by 2002:a63:8549:: with SMTP id u70mr25012757pgd.401.1541535477288;
        Tue, 06 Nov 2018 12:17:57 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z63-v6sm54099913pfz.31.2018.11.06.12.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 12:17:56 -0800 (PST)
Date:   Tue, 6 Nov 2018 12:17:55 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jerry Lin <wahahab11@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, ghartman@google.com,
        astrachan@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
Message-ID: <20181106201755.GA204219@google.com>
References: <20181106052116.GA25953@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106052116.GA25953@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 01:21:16PM +0800, Jerry Lin wrote:
> Add a attribute called permissions under vsoc device node for examining
> current granted permissions in vsoc_device.
> 
> This file will display permissions in following format:
>   begin_offset  end_offset  owner_offset  owned_value
>             %x          %x            %x           %x
> 
> Signed-off-by: Jerry Lin <wahahab11@gmail.com>

Please always post patches to the list with reviewers on CC. Also CC the
following addresses in addition:
astrachan@google.com
ghartman@google.com (infact you deleted a TODO he added so)

And just one more minor nit below, otherwise LGTM.

thanks,

- Joel

> ---
>  drivers/staging/android/vsoc.c | 49 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
> index 22571ab..481554a 100644
> --- a/drivers/staging/android/vsoc.c
> +++ b/drivers/staging/android/vsoc.c
> @@ -128,9 +128,10 @@ struct vsoc_device {
>  
>  static struct vsoc_device vsoc_dev;
>  
> -/*
> - * TODO(ghartman): Add a /sys filesystem entry that summarizes the permissions.
> - */
> +static ssize_t permissions_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf);
> +static DEVICE_ATTR_RO(permissions);
>  
>  struct fd_scoped_permission_node {
>  	struct fd_scoped_permission permission;
> @@ -718,6 +719,38 @@ static ssize_t vsoc_write(struct file *filp, const char __user *buffer,
>  	return len;
>  }
>  
> +static ssize_t permissions_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buffer)
> +{
> +	struct fd_scoped_permission_node *node;
> +	char *row;
> +	int ret;
> +	ssize_t written = 0;
> +
> +	row = kzalloc(sizeof(char) * 128, GFP_KERNEL);
> +	if (!row)
> +		return 0;
> +	mutex_lock(&vsoc_dev.mtx);
> +	list_for_each_entry(node, &vsoc_dev.permissions, list) {
> +		ret = snprintf(row, 128, "%x\t%x\t%x\t%x\n",
> +			       node->permission.begin_offset,
> +			       node->permission.end_offset,
> +			       node->permission.owner_offset,
> +			       node->permission.owned_value);
> +		if (ret < 0)
> +			goto done;
> +		row[ret] = '\0';

Do you really need null termination after snprintf?

> +		memcpy(buffer + written, row, ret);
> +		written += ret;
> +	}
> +
> +done:
> +	mutex_unlock(&vsoc_dev.mtx);
> +	kfree(row);
> +	return written;
> +}
> +
>  static irqreturn_t vsoc_interrupt(int irq, void *region_data_v)
>  {
>  	struct vsoc_region_data *region_data =
> @@ -942,6 +975,15 @@ static int vsoc_probe_device(struct pci_dev *pdev,
>  		}
>  		vsoc_dev.regions_data[i].device_created = true;
>  	}
> +	/*
> +	 * Create permission attribute on device node.
> +	 */
> +	result = device_create_file(&pdev->dev, &dev_attr_permissions);
> +	if (result) {
> +		dev_err(&vsoc_dev.dev->dev, "device_create_file failed\n");
> +		vsoc_remove_device(pdev);
> +		return -EFAULT;
> +	}
>  	return 0;
>  }
>  
> @@ -967,6 +1009,7 @@ static void vsoc_remove_device(struct pci_dev *pdev)
>  	if (!pdev || !vsoc_dev.dev)
>  		return;
>  	dev_info(&pdev->dev, "remove_device\n");
> +	device_remove_file(&pdev->dev, &dev_attr_permissions);
>  	if (vsoc_dev.regions_data) {
>  		for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
>  			if (vsoc_dev.regions_data[i].device_created) {
> -- 
> 2.7.4
> 
