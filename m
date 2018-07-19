Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9872D20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9872D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeGSKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:11:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeGSKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:11:51 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 99475BD1;
        Thu, 19 Jul 2018 09:29:33 +0000 (UTC)
Date:   Thu, 19 Jul 2018 11:29:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 16/32] staging: gasket: always allow root open for write
Message-ID: <20180719092930.GB14301@kroah.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
 <20180717205712.29495-17-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717205712.29495-17-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:56:56PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Always allow root to open device for writing.
> 
> Drop special-casing of ioctl permissions for root vs. owner.
> 
> Reported-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/apex_driver.c  |  9 +--------
>  drivers/staging/gasket/gasket_core.c  |  8 +++++---
>  drivers/staging/gasket/gasket_ioctl.c | 19 ++++++++-----------
>  3 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index 3a83c3d4d5561..612b3ab803196 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -629,14 +629,7 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
>   */
>  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
>  {
> -	struct gasket_dev *gasket_dev = filp->private_data;
> -	int root = capable(CAP_SYS_ADMIN);
> -	int is_owner = gasket_dev->dev_info.ownership.is_owned &&
> -		       current->tgid == gasket_dev->dev_info.ownership.owner;
> -
> -	if (root || is_owner)
> -		return 1;
> -	return 0;
> +	return !!(filp->f_mode & FMODE_WRITE);

Shouldn't this return a boolean instead of uint?

>  }
>  
>  /*
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 0d5ba7359af73..947b4fcc76970 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -1085,6 +1085,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
>  	char task_name[TASK_COMM_LEN];
>  	struct gasket_cdev_info *dev_info =
>  	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
> +	int is_root = capable(CAP_SYS_ADMIN);
>  
>  	gasket_dev = dev_info->gasket_dev_ptr;
>  	driver_desc = gasket_dev->internal_desc->driver_desc;
> @@ -1098,7 +1099,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
>  		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
>  		"fmode_write: %d is_root: %u)",
>  		current->tgid, task_name, filp->f_mode,
> -		(filp->f_mode & FMODE_WRITE), capable(CAP_SYS_ADMIN));
> +		(filp->f_mode & FMODE_WRITE), is_root);
>  
>  	/* Always allow non-writing accesses. */
>  	if (!(filp->f_mode & FMODE_WRITE)) {
> @@ -1112,8 +1113,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
>  		gasket_dev, "Current owner open count (owning tgid %u): %d.",
>  		ownership->owner, ownership->write_open_count);
>  
> -	/* Opening a node owned by another TGID is an error (even root.) */
> -	if (ownership->is_owned && ownership->owner != current->tgid) {
> +	/* Opening a node owned by another TGID is an error (unless root) */
> +	if (ownership->is_owned && ownership->owner != current->tgid &&
> +	    !is_root) {
>  		gasket_log_error(
>  			gasket_dev,
>  			"Process %u is opening a node held by %u.",
> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
> index 0c2f85cf54480..d0fa05b8bf1d3 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -171,7 +171,7 @@ long gasket_is_supported_ioctl(uint cmd)
>   */
>  static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
>  {

Also return bool?

> -	uint alive, root, device_owner;
> +	uint alive;
>  	fmode_t read, write;
>  	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
>  
> @@ -183,33 +183,30 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
>  			alive, gasket_dev->status);
>  	}
>  
> -	root = capable(CAP_SYS_ADMIN);
> -	read = filp->f_mode & FMODE_READ;
> -	write = filp->f_mode & FMODE_WRITE;
> -	device_owner = (gasket_dev->dev_info.ownership.is_owned &&
> -			current->tgid == gasket_dev->dev_info.ownership.owner);
> +	read = !!(filp->f_mode & FMODE_READ);
> +	write = !!(filp->f_mode & FMODE_WRITE);

These should be bool as well, right?

I'll drop this patch, thanks.

greg k-h
