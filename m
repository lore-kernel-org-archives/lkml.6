Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53473C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FF420896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXYyk9x3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FF420896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756861AbeFPHLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 03:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754015AbeFPHLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 03:11:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D902720896;
        Sat, 16 Jun 2018 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529133091;
        bh=qKcbbHNGs48M46Nr7op7MZ57jID9CQXoxJF+2ujhERs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXYyk9x3Ox6WeAFszciwEZaR+w+A/Iwa+T4q0y6YBhYREBTvdJBNORGBsIpLWTTsA
         n8k0xX/sBW1WwB2nfXBvephoZ1IZ/781oN97AKiK12qgpAybfL4xGInsFfN4J7CyON
         GBflab5YW43dA0WMW/srzUMvCv5+rOItACAr+9jc=
Date:   Sat, 16 Jun 2018 09:11:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     linux-kernel@vger.kernel.org, rajatxjain@gmail.com
Subject: Re: [PATCH] sysfs: Fix internal_create_group() for named group
 updates
Message-ID: <20180616071108.GB30558@kroah.com>
References: <20180616012910.152694-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616012910.152694-1-rajatja@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 06:29:10PM -0700, Rajat Jain wrote:
> There are a couple of problems with named group updates in the code
> today:
> 
> * sysfs_update_group() will always fail for a named group, because
>   internal_create_group() will try to create a new sysfs directory
>   unconditionally, which will ofcourse fail with -EEXIST.
> 
> * We can leak the kernfs_node for grp->name if some one tries to:
>   - rename a group (change grp->name), or
>   - update a named group, to an unnamed group
> 
> It appears that the whole purpose of sysfs_update_group() was to
> allow changing the permissions or visibility of attributes and not
> the names. So make it clear in the comments, and allow it to update
> an existing named group.

Who uses sysfs_update_group() today that has these problems?  Or do you
want to use it in new code?  How can it be broken today so badly that it
does not work?

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  fs/sysfs/group.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 4802ec0e1e3a..8bd10dc730ae 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -119,12 +119,23 @@ static int internal_create_group(struct kobject *kobj, int update,
>  		return -EINVAL;
>  	}
>  	if (grp->name) {
> -		kn = kernfs_create_dir(kobj->sd, grp->name,
> -				       S_IRWXU | S_IRUGO | S_IXUGO, kobj);
> -		if (IS_ERR(kn)) {
> -			if (PTR_ERR(kn) == -EEXIST)
> -				sysfs_warn_dup(kobj->sd, grp->name);
> -			return PTR_ERR(kn);
> +		if (update) {
> +			kn = kernfs_find_and_get(kobj->sd, grp->name);
> +			if (!kn) {
> +				WARN(1,
> +				     "Can't update unknown attr grp name: %s/%s\n",
> +				     kobj->name, grp->name);
> +				return -EINVAL;

This is going to cause the syzbot to bug the heck out of us, as people
do run with panic-on-warning.  Just make this a "normal" error message
and dump the stack if you want that.

But maybe we should just get rid of this function entirely, it feels
very ackward and I can't remember why we added it...

thanks,

greg k-h
