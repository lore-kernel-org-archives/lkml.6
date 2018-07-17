Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7BEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A31120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AeZsVzIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A31120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeGQKyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:54:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52634 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbeGQKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:54:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HAJD0F094478;
        Tue, 17 Jul 2018 10:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9W5RBjpTstN9Y+YKpXo+N/dGQKhvbQA66MOkcktD4ig=;
 b=AeZsVzIyLSwWq5gTXfEVjzsGq3I2DqL6cnHOOq43QaqWfvjtHrDab5G/822mp9RE8aUk
 JU1LqBo9w5qHK4lN3m7rQ2TElRuMecmiJ0YvNkE35+tRnL5pzJNXdG1c94bDuWm+Ka+g
 49cYYSlsWFrpPmUchmFBqLn5P1eCLIByw9Y8PCLAAwPLCs/j5fVtQjAIJcsnIuCdTgyb
 RPWt6xXvNoUAe/HJLELZWryWF5DCS0uAGLzwuDwJ89twGnFLOub5MJlKw5/tuxEY4lbG
 htf72+K/P7Dl4bdmRlkzW7JkfYWC//QRJkATVLDlcfi+swSJwWQ4SrrguGfr11zNLVjz WA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k7a3401kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:22:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6HAMhu6003469
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:22:43 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6HAMhQZ017836;
        Tue, 17 Jul 2018 10:22:43 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 03:22:42 -0700
Date:   Tue, 17 Jul 2018 13:22:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 16/32] staging: gasket: always allow root open for write
Message-ID: <20180717102234.3spplwaf5n5wmpcl@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717020926.176408-17-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717020926.176408-17-toddpoynor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:09:10PM -0700, Todd Poynor wrote:
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -630,13 +630,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
>  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)

This function name is a bit of out of date.

>  {
>  	struct gasket_dev *gasket_dev = filp->private_data;
> -	int root = capable(CAP_SYS_ADMIN);
> -	int is_owner = gasket_dev->dev_info.ownership.is_owned &&
> -		       current->tgid == gasket_dev->dev_info.ownership.owner;
> +	fmode_t write;
>  
> -	if (root || is_owner)
> -		return 1;
> -	return 0;
> +	write = filp->f_mode & FMODE_WRITE;
> +	return write;

This doesn't match the comment because it returns 0x2 or zero.

	return !!(filp->f_mode & FMODE_WRITE);

>  }
>  
>  /*
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index ae20b7ff9569b..9d1bb3caf6de2 100644
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
> index 0c2f85cf54480..17431d14e6ef1 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -171,7 +171,7 @@ long gasket_is_supported_ioctl(uint cmd)
>   */
>  static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
>  {
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
>  	read = filp->f_mode & FMODE_READ;
>  	write = filp->f_mode & FMODE_WRITE;

write = !!(filp->f_mode & FMODE_WRITE);

> -	device_owner = (gasket_dev->dev_info.ownership.is_owned &&
> -			current->tgid == gasket_dev->dev_info.ownership.owner);
>  
>  	switch (cmd) {
>  	case GASKET_IOCTL_RESET:
>  	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
> -		return root || (write && device_owner);
> +		return write;

regards,
dan carpenter

