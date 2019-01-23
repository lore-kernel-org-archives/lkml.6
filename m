Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5587C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BA5217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548202307;
	bh=0Y9KGe755kcbeWU1ohKoelyd7yzRYbNn98WlFHP6dT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mLNTVLH/agztOfyUDwP7nIFWBJ93QJg5q9zD/oCiRvWh0K7Oy+5iL2QIVY33SDYYp
	 4btp7srrPOSIU7DWgnCw0xU7iI/B8Q9O9ambAc7+sRimjhiVCaS4gUT2H2ZUmD5QsB
	 VQAo0JAkGatMR/jhQ5mZWx10NRJKRlDz0lcR634k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAWALq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfAWALp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:11:45 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27D421726;
        Wed, 23 Jan 2019 00:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548202305;
        bh=0Y9KGe755kcbeWU1ohKoelyd7yzRYbNn98WlFHP6dT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qVw+uhZ5aR2I6T/EXmHMkygfXsNVsAsuDJCpXJx6XOBEHbxbxHUtkRISOJ2vd8zk7
         6vEcFuPSxpeOs+/h8T1yk3etsp3NDRm5TPp758RSPQXNl9Phr4P2Lg0MkoaRLuGLLy
         kik/FloL+yQa1c3N9cu7csINEmcejhqC6syD+lls=
Date:   Wed, 23 Jan 2019 09:11:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>, Josef Bacik <jbacik@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH] fail_function: no need to check return value of
 debugfs_create functions
Message-Id: <20190123091141.bfc311d389e48a23af79a8a9@kernel.org>
In-Reply-To: <20190122152151.16139-45-gregkh@linuxfoundation.org>
References: <20190122152151.16139-45-gregkh@linuxfoundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 16:21:44 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Ah, OK. It simplifies the code. But I have a question below,

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: zhong jiang <zhongjiang@huawei.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/fail_function.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 17f75b545f66..afc779be5ebb 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -152,20 +152,13 @@ static int fei_retval_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(fei_retval_ops, fei_retval_get, fei_retval_set,
>  			 "%llx\n");
>  
> -static int fei_debugfs_add_attr(struct fei_attr *attr)
> +static void fei_debugfs_add_attr(struct fei_attr *attr)
>  {
>  	struct dentry *dir;
>  
>  	dir = debugfs_create_dir(attr->kp.symbol_name, fei_debugfs_dir);
> -	if (!dir)
> -		return -ENOMEM;
> -
> -	if (!debugfs_create_file("retval", 0600, dir, attr, &fei_retval_ops)) {
> -		debugfs_remove_recursive(dir);
> -		return -ENOMEM;
> -	}
>  
> -	return 0;

Don't we need to check dir here? If above debugfs_create_dir() returns NULL,
it seems we will create "retval" under root directory of debugfs.

Thank you,

> +	debugfs_create_file("retval", 0600, dir, attr, &fei_retval_ops);
>  }
>  
>  static void fei_debugfs_remove_attr(struct fei_attr *attr)
> @@ -306,7 +299,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
>  
>  	ret = register_kprobe(&attr->kp);
>  	if (!ret)
> -		ret = fei_debugfs_add_attr(attr);
> +		fei_debugfs_add_attr(attr);
>  	if (ret < 0)
>  		fei_attr_remove(attr);
>  	else {
> @@ -337,19 +330,13 @@ static int __init fei_debugfs_init(void)
>  		return PTR_ERR(dir);
>  
>  	/* injectable attribute is just a symlink of error_inject/list */
> -	if (!debugfs_create_symlink("injectable", dir,
> -				    "../error_injection/list"))
> -		goto error;
> +	debugfs_create_symlink("injectable", dir, "../error_injection/list");
>  
> -	if (!debugfs_create_file("inject", 0600, dir, NULL, &fei_ops))
> -		goto error;
> +	debugfs_create_file("inject", 0600, dir, NULL, &fei_ops);
>  
>  	fei_debugfs_dir = dir;
>  
>  	return 0;
> -error:
> -	debugfs_remove_recursive(dir);
> -	return -ENOMEM;
>  }
>  
>  late_initcall(fei_debugfs_init);
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
