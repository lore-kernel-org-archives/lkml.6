Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FA5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC54120897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xmZLecHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC54120897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeH1RJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1RJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:09:01 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BF72087E;
        Tue, 28 Aug 2018 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535462242;
        bh=2n0W9ET2asUJQtCQvaoGa6/3aczvL/3hkdvGzZMLCUE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xmZLecHAQrclj+wX+O4YDa7bX9PtS4l+vBhB0S1qogSmQnmITytHuWWeFmbQbBnA2
         S6Fu7ia8XVUZamQahtpKjXLUr5eB5HSOlbxbyuPJ32oVLnNH7x5kiyuP01ZZ3YtueA
         A7m2aXI1ZDIMWPKs0HvrhmJy9L7dw7Q+Y75foi5w=
Message-ID: <59178dc982fa22a1d6d965f5221327d19815b953.camel@kernel.org>
Subject: Re: [RFC PATCH 3/3] exec: do unshare_files after de_thread
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Aug 2018 09:17:19 -0400
In-Reply-To: <20180827174722.3723-4-jlayton@kernel.org>
References: <20180827174722.3723-1-jlayton@kernel.org>
         <20180827174722.3723-4-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 13:47 -0400, Jeff Layton wrote:
> POSIX mandates that open fds and their associated file locks should be
> preserved across an execve. This works, unless the process is
> multithreaded at the time that execve is called.
> 
> In that case, we'll end up unsharing the files_struct but the locks will
> still have their fl_owner set to the address of the old one. Eventually,
> when the other threads die and the last reference to the old
> files_struct is put, any POSIX locks get torn down since it looks like
> a close occurred on them.
> 
> The result is that all of your open files will be intact with none of
> the locks you held before execve. The simple answer to this is "use OFD
> locks", but this is a nasty surprise and it violates the spec.
> 
> Fix this by doing unshare_files later during exec, after we've already
> killed off the other threads in the process. This helps ensure that we
> only unshare the files_struct during exec when it is truly shared with
> other processes.
> 
> Note that because the unshare_files call is now done just after
> de_thread, we need a mechanism to pass the displaced files_struct back
> up to __do_execve_file. This is done via a new displaced_files field
> inside the linux_binprm.
> 
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/exec.c               | 19 +++++++++----------
>  include/linux/binfmts.h |  1 +
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index ca25f805ebad..a45b0cae5817 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1262,6 +1262,10 @@ int flush_old_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> +	retval = unshare_files(&bprm->displaced_files);
> +	if (retval)
> +		goto out;
> +
>  	/*
>  	 * Must be called _before_ exec_mmap() as bprm->mm is
>  	 * not visibile until then. This also enables the update
> @@ -1712,8 +1716,7 @@ static int __do_execve_file(int fd, struct filename *filename,
>  			    int flags, struct file *file)
>  {
>  	char *pathbuf = NULL;
> -	struct linux_binprm *bprm;
> -	struct files_struct *displaced;
> +	struct linux_binprm *bprm = NULL;
>  	int retval;
>  
>  	if (IS_ERR(filename))
> @@ -1735,10 +1738,6 @@ static int __do_execve_file(int fd, struct filename *filename,
>  	 * further execve() calls fail. */
>  	current->flags &= ~PF_NPROC_EXCEEDED;
>  
> -	retval = unshare_files(&displaced);
> -	if (retval)
> -		goto out_ret;
> -
>  	retval = -ENOMEM;
>  	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
>  	if (!bprm)
> @@ -1831,8 +1830,8 @@ static int __do_execve_file(int fd, struct filename *filename,
>  	kfree(pathbuf);
>  	if (filename)
>  		putname(filename);
> -	if (displaced) {
> -		put_files_struct(displaced);
> +	if (bprm->displaced_files) {
> +		put_files_struct(bprm->displaced_files);

Note that this is broken (bprm is freed above this point). It's simple
enough to fix, but I'll hold off on resending until I hear some feedback
on the general approach.

>  	} else {
>  		spin_lock(&current->files->file_lock);
>  		current->files->in_exec = false;
> @@ -1855,8 +1854,8 @@ static int __do_execve_file(int fd, struct filename *filename,
>  	kfree(pathbuf);
>  
>  out_files:
> -	if (displaced) {
> -		reset_files_struct(displaced);
> +	if (bprm && bprm->displaced_files) {
> +		reset_files_struct(bprm->displaced_files);
>  	} else {
>  		spin_lock(&current->files->file_lock);
>  		current->files->in_exec = false;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index c05f24fac4f6..d7ec384bb1b0 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -49,6 +49,7 @@ struct linux_binprm {
>  	unsigned int taso:1;
>  #endif
>  	unsigned int recursion_depth; /* only for search_binary_handler() */
> +	struct files_struct * displaced_files;
>  	struct file * file;
>  	struct cred *cred;	/* new credentials */
>  	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */

-- 
Jeff Layton <jlayton@kernel.org>

