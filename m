Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75CF2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548250993;
	bh=jqK/YN93TXmfORHoqG1DAfI93GeUNyfuuEKjVqyOqso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tSm8WK23KRiRYfZfuI8WzM8iNGPVr3oYdu7w6wgfmJWN1NtyJb2UcR7w13BtMVW3Y
	 2VtoLAqec/aOyQMPLT7caZLm9vs/MUp4EhsKNgYxBSfZKDCbtIpJ2zXZw5DNzIfUuG
	 Y+7D2TqmmBbbklD7BLjpX3SVnKKjrBNNel6tBXvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfAWNnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfAWNnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:43:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6BEA2184B;
        Wed, 23 Jan 2019 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548250990;
        bh=jqK/YN93TXmfORHoqG1DAfI93GeUNyfuuEKjVqyOqso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euMglUlOgjNgJKI3h+MNeK4EpWvvoooOfgfsZ28vwTVC978yS74/mmSYk0LQGcSS9
         r+V/a92Y8KxDiBsPzjH+BWdV+xned9x3c/qrzKFZ5RUclAKWSsLJptUEctGiQv2EZb
         CqpAWv9HtENMhsM7Z73GzA4sA5h6kgZA3/IMpuy4=
Date:   Wed, 23 Jan 2019 14:43:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcov: no need to check return value of debugfs_create
 functions
Message-ID: <20190123134307.GD24700@kroah.com>
References: <20190122152151.16139-49-gregkh@linuxfoundation.org>
 <b277b33b-bcc0-c1c5-52d6-9e1580531df3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b277b33b-bcc0-c1c5-52d6-9e1580531df3@linux.ibm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:22:33PM +0100, Peter Oberparleiter wrote:
> On 22.01.2019 16:21, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Also delete the dentry variable as it is never needed.
> > 
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/gcov/fs.c | 22 ++--------------------
> >  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> 
> Compile test was successful, but the patch introduces a compile warning.
> Could you merge the attached patch?
> 
> 8<===
> From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> Subject: [PATCH] gcov: Fix compiler warning
> 
> Fix compiler warning when compiling with CONFIG_GCOV_KERNEL=y:
> 
>   CC      kernel/gcov/fs.o
> kernel/gcov/fs.c: In function ‘gcov_fs_init’:
> kernel/gcov/fs.c:756:6: warning: unused variable ‘rc’ [-Wunused-variable]
>   int rc = -EIO;
>       ^~
> 
> Signed-off-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> ---
>  kernel/gcov/fs.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
> index aa9a49f72024..e5eb5ea7ea59 100644
> --- a/kernel/gcov/fs.c
> +++ b/kernel/gcov/fs.c
> @@ -753,8 +753,6 @@ void gcov_event(enum gcov_action action, struct gcov_info *info)
>  /* Create debugfs entries. */
>  static __init int gcov_fs_init(void)
>  {
> -	int rc = -EIO;
> -
>  	init_node(&root_node, NULL, NULL, NULL);
>  	/*
>  	 * /sys/kernel/debug/gcov will be parent for the reset control file
> -- 

Ah, good catch, will do that, thanks.

greg k-h
