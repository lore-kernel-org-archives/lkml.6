Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380AECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D052B208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D052B208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeGOJ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:28:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeGOJ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:28:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B70DDA95;
        Sun, 15 Jul 2018 09:05:46 +0000 (UTC)
Date:   Sun, 15 Jul 2018 11:05:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
Message-ID: <20180715090544.GC23333@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-12-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714055816.223754-12-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:58:09PM -0700, Todd Poynor wrote:
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
>  drivers/staging/gasket/apex_driver.c  |  9 +++------
>  drivers/staging/gasket/gasket_core.c  |  8 +++++---
>  drivers/staging/gasket/gasket_ioctl.c | 15 ++++++---------
>  3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index b1318482ba65..ffe11d8168ea 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -644,13 +644,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
>  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
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

Ok, this is insane.  You don't change, or check, the permissions on a
file handle while it is already open, as you only check the permissions
on OPEN, not on WRITE.  See the recent rant from Linus on the linux-api
list for yet-another-long-threaad in which he explains this.

So this whole ioctl can just be removed, it is totally crazy and wrong
and should just be removed.

Want me to go remove it right now?

thanks,

greg k-h
