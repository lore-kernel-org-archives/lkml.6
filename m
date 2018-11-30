Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F5C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F5C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeK3VNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:13:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48330 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeK3VNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:13:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 83C58207AB; Fri, 30 Nov 2018 11:04:51 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 49435206FF;
        Fri, 30 Nov 2018 11:04:41 +0100 (CET)
Date:   Fri, 30 Nov 2018 11:04:41 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/vc4: Add a debugfs entry to disable/enable the load
 tracker
Message-ID: <20181130110441.6d765c3e@bbrezillon>
In-Reply-To: <20181130095658.31062-1-paul.kocialkowski@bootlin.com>
References: <20181130095658.31062-1-paul.kocialkowski@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, 30 Nov 2018 10:56:58 +0100
Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:

> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 7195a0bcceb3..0ee75c71d8d8 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -46,6 +46,56 @@
>  #define DRIVER_MINOR 0
>  #define DRIVER_PATCHLEVEL 0
>  
> +static int vc4_debugfs_load_tracker_get(struct seq_file *m, void *data)
> +{
> +	struct drm_device *dev = m->private;
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +
> +	if (vc4->load_tracker_enabled)
> +		seq_printf(m, "enabled\n");
> +	else
> +		seq_printf(m, "disabled\n");
> +
> +	return 0;
> +}
> +
> +static ssize_t vc4_debugfs_load_tracker_set(struct file *file,
> +					    const char __user *ubuf,
> +					    size_t len, loff_t *offp)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct drm_device *dev = m->private;
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +	char buf[32] = {};
> +
> +	if (len >= sizeof(buf))
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf, ubuf, len))
> +		return -EFAULT;
> +
> +	if (!strncasecmp(buf, "enable", 6))
> +		vc4->load_tracker_enabled = true;
> +	else if (!strncasecmp(buf, "disable", 7))
> +		vc4->load_tracker_enabled = false;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
> +
> +static int vc4_debugfs_load_tracker_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, vc4_debugfs_load_tracker_get, inode->i_private);
> +}
> +
> +const struct file_operations vc4_debugfs_load_tracker_fops = {
> +	.owner = THIS_MODULE,
> +	.open = vc4_debugfs_load_tracker_open,
> +	.read = seq_read,
> +	.write = vc4_debugfs_load_tracker_set,
> +};
> +

I'd put this code directly in vc4_debugfs.c so you can make
vc4_debugfs_load_tracker_fops static and you don't need the extern ...
definition in vc4_drv.h. But maybe you have a good reason to do that.

Regards,

Boris
