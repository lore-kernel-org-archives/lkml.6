Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061BAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE02B20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeLAGIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:08:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37018 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLAGIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:08:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4EB3F20757; Fri, 30 Nov 2018 19:57:55 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1178A2037D;
        Fri, 30 Nov 2018 19:57:45 +0100 (CET)
Date:   Fri, 30 Nov 2018 19:57:44 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] drm/vc4: Add a debugfs entry to disable/enable the
 load tracker
Message-ID: <20181130195744.7502e9fe@bbrezillon>
In-Reply-To: <20181130161104.16352-1-paul.kocialkowski@bootlin.com>
References: <20181130161104.16352-1-paul.kocialkowski@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 17:11:04 +0100
Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:

> In order to test whether the load tracker is working as expected, we
> need the ability to compare the commit result with the underrun
> indication. With the load tracker always enabled, commits that are
> expected to trigger an underrun are always rejected, so userspace
> cannot get the actual underrun indication from the hardware.
> 
> Add a debugfs entry to disable/enable the load tracker, so that a DRM
> commit expected to trigger an underrun can go through with the load
> tracker disabled. The underrun indication is then available to
> userspace and can be checked against the commit result with the load
> tracker enabled.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
> 
> Changes since v1:
> * Moved all the debugfs-related functions and structure to vc4_debugfs.c.
> 
>  drivers/gpu/drm/vc4/vc4_debugfs.c | 58 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.c     |  2 ++
>  drivers/gpu/drm/vc4/vc4_drv.h     |  2 ++
>  drivers/gpu/drm/vc4/vc4_kms.c     |  6 +++-
>  4 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
> index 7a0003de71ab..8f4d7fadb226 100644
> --- a/drivers/gpu/drm/vc4/vc4_debugfs.c
> +++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
> @@ -32,9 +32,67 @@ static const struct drm_info_list vc4_debugfs_list[] = {
>  
>  #define VC4_DEBUGFS_ENTRIES ARRAY_SIZE(vc4_debugfs_list)
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
> +static const struct file_operations vc4_debugfs_load_tracker_fops = {
> +	.owner = THIS_MODULE,
> +	.open = vc4_debugfs_load_tracker_open,
> +	.read = seq_read,
> +	.write = vc4_debugfs_load_tracker_set,
> +};
> +
>  int
>  vc4_debugfs_init(struct drm_minor *minor)
>  {
> +	struct dentry *dentry;
> +
> +	dentry = debugfs_create_file("load_tracker", S_IRUGO | S_IWUSR,
> +				     minor->debugfs_root, minor->dev,
> +				     &vc4_debugfs_load_tracker_fops);
> +	if (!dentry)
> +		return -ENOMEM;

Hm, maybe you could use debugfs_create_bool() instead of
re-implementing it. The values won't be enabled/disabled though
(IIRC, it's Y or N).

> +
>  	return drm_debugfs_create_files(vc4_debugfs_list, VC4_DEBUGFS_ENTRIES,
>  					minor->debugfs_root, minor);
>  }
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 7195a0bcceb3..12ac971d24d6 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -290,6 +290,8 @@ static int vc4_drm_bind(struct device *dev)
>  
>  	drm_fbdev_generic_setup(drm, 32);
>  
> +	vc4->load_tracker_enabled = true;
> +
>  	return 0;
>  
>  unbind_all:
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 11369da944b6..8d0f2f16a9e8 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -188,6 +188,8 @@ struct vc4_dev {
>  
>  	int power_refcount;
>  
> +	bool load_tracker_enabled;
> +
>  	/* Mutex controlling the power refcount. */
>  	struct mutex power_lock;
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index b905a19c1470..4b2509b1b8ed 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -473,6 +473,7 @@ static const struct drm_private_state_funcs vc4_load_tracker_state_funcs = {
>  static int
>  vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>  {
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
>  	int ret;
>  
>  	ret = vc4_ctm_atomic_check(dev, state);
> @@ -483,7 +484,10 @@ vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>  	if (ret)
>  		return ret;
>  
> -	return vc4_load_tracker_atomic_check(state);
> +	if (vc4->load_tracker_enabled)
> +		return vc4_load_tracker_atomic_check(state);
> +
> +	return 0;
>  }
>  
>  static const struct drm_mode_config_funcs vc4_mode_funcs = {

