Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80777C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CEB20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjpLEszX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CEB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbeKEVi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeKEVi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:38:28 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B08F20819;
        Mon,  5 Nov 2018 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541420339;
        bh=gwRHNGp1f3k6w8LXB20VUOr930FG6U9aiCvejZ7hycc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BjpLEszXDyEywe0kgR+eLnkrI5nNjvd/Fq5bTlm3HuH9HlIJdUY2fCQdPLxG15Qin
         JY/olXynROxIy7WjyLzDl6IbaofKjM4y3k2Goo3Ya24u3HZ3ysWt/pRK3hpJeYqPAS
         /vyCyhFVk4vXJxnv2yfxMjX7vKtbBEYAomEKZvg0=
Message-ID: <efbaeb736e4738bb7a0e2f8529bf1db8459bbe56.camel@kernel.org>
Subject: Re: [PATCH 04/12] gfs2: properly initial file_lock used for unlock.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 05 Nov 2018 07:18:56 -0500
In-Reply-To: <154138144777.31651.4516223215037533891.stgit@noble>
References: <154138128401.31651.1381177427603557514.stgit@noble>
         <154138144777.31651.4516223215037533891.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 12:30 +1100, NeilBrown wrote:
> Rather than assuming all-zeros is sufficient, use the available API to
> initialize the file_lock structure use for unlock.
> VFS-level changes will soon make it important that the
> list_heads in file_lock are always properly initialized.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/gfs2/file.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 45a17b770d97..271f847705e3 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1199,13 +1199,13 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
>  	mutex_lock(&fp->f_fl_mutex);
>  
>  	if (gfs2_holder_initialized(fl_gh)) {
> +		struct file_lock request;
>  		if (fl_gh->gh_state == state)
>  			goto out;
> -		locks_lock_file_wait(file,
> -				     &(struct file_lock) {
> -					     .fl_type = F_UNLCK,
> -					     .fl_flags = FL_FLOCK
> -				     });
> +		locks_init_lock(&request);
> +		request.fl_type = F_UNLOCK;

F_UNLCK ?

The ocfs2 patch has the same bug.

> +		request.fl_flags = FL_FLOCK;
> +		locks_lock_file_wait(file, &request);
>  		gfs2_glock_dq(fl_gh);
>  		gfs2_holder_reinit(state, flags, fl_gh);
>  	} else {
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

