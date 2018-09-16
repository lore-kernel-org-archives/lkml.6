Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573FEECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3B2083A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B3B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeIPWW6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 18:22:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48165 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeIPWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 18:22:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1aOL-0000Tn-14; Sun, 16 Sep 2018 10:59:25 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1aOJ-0006XU-Sh; Sun, 16 Sep 2018 10:59:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, berrange@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180914105310.6454-1-jlayton@kernel.org>
        <20180914105310.6454-4-jlayton@kernel.org>
Date:   Sun, 16 Sep 2018 18:59:14 +0200
In-Reply-To: <20180914105310.6454-4-jlayton@kernel.org> (Jeff Layton's message
        of "Fri, 14 Sep 2018 06:53:10 -0400")
Message-ID: <87tvmps7j1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1g1aOJ-0006XU-Sh;;;mid=<87tvmps7j1.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18dVpWqaiD3mw6+suQ7uEYXwKgKjq4geKo=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 3/3] exec: do unshare_files after de_thread
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

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

Actually because unshare_files happens after de_thread (the point of no
return) we don't need to do anything with displaced files.  A failing
exec will clear brpm->mm, and search_binary_handler will convert any
error into force_sigsegv.

> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/exec.c               | 11 ++++++-----
>  include/linux/binfmts.h |  1 +
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index c8a68481d7eb..b4a7e659d908 100644
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

We can place this just above do_close_on_exec.  And simply modify
unshare_files to instead of returning displaced simply put it.

We gain nothing be returning displaced_files as we are already past
the point of no return, and userspace will get an unblockable SIGSEGV
and exit.

>  	/*
>  	 * Must be called _before_ exec_mmap() as bprm->mm is
>  	 * not visibile until then. This also enables the update
> @@ -1713,7 +1717,7 @@ static int __do_execve_file(int fd, struct filename *filename,
>  {
>  	char *pathbuf = NULL;
>  	struct linux_binprm *bprm;
> -	struct files_struct *displaced;
> +	struct files_struct *displaced = NULL;
>  	int retval;
>  
>  	if (IS_ERR(filename))
> @@ -1735,10 +1739,6 @@ static int __do_execve_file(int fd, struct filename *filename,
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
> @@ -1817,6 +1817,7 @@ static int __do_execve_file(int fd, struct filename *filename,
>  	would_dump(bprm, bprm->file);
>  
>  	retval = exec_binprm(bprm);
> +	displaced = bprm->displaced_files;
>  	if (retval < 0)
>  		goto out;
>  
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
