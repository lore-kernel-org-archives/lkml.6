Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBE62081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBE62081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeKHDgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:36:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbeKHDgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:36:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECBF0307EA8F;
        Wed,  7 Nov 2018 18:05:15 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5B6C2654F;
        Wed,  7 Nov 2018 18:05:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3D2632239AE; Wed,  7 Nov 2018 13:05:15 -0500 (EST)
Date:   Wed, 7 Nov 2018 13:05:15 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utimensat: AT_EMPTY_PATH support
Message-ID: <20181107180515.GA28296@redhat.com>
References: <20181107091552.17100-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107091552.17100-1-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 07 Nov 2018 18:05:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 10:15:52AM +0100, Miklos Szeredi wrote:
> This makes it possible to use utimensat on an O_PATH file (including
> symlinks).
> 
> It supersedes the nonstandard utimensat(fd, NULL, ...) form.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks for fixing this Miklos. It seems to work for me for following
use case I have where I want to change time on symlink opened with O_PATH.

symfd = open("foo-symlink.txt", O_PATH | O_NOFOLLOW);
utimensat(fd, "", NULL, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);

Thanks
Vivek

> ---
>  fs/utimes.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/utimes.c b/fs/utimes.c
> index bdcf2daf39c1..f9c7ebad19d7 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -97,13 +97,13 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
>  		goto out;
>  	}
>  
> -	if (flags & ~AT_SYMLINK_NOFOLLOW)
> +	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
>  		goto out;
>  
>  	if (filename == NULL && dfd != AT_FDCWD) {
>  		struct fd f;
>  
> -		if (flags & AT_SYMLINK_NOFOLLOW)
> +		if (flags)
>  			goto out;
>  
>  		f = fdget(dfd);
> @@ -119,6 +119,8 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
>  
>  		if (!(flags & AT_SYMLINK_NOFOLLOW))
>  			lookup_flags |= LOOKUP_FOLLOW;
> +		if (flags & AT_EMPTY_PATH)
> +			lookup_flags |= LOOKUP_EMPTY;
>  retry:
>  		error = user_path_at(dfd, filename, lookup_flags, &path);
>  		if (error)
> -- 
> 2.14.3
> 
