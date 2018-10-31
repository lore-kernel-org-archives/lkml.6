Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDB1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB0C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DKBCs6rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB0C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeKAAEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:04:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeKAAEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:04:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id k1-v6so6096131pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j3c11nxoD/TAnBnTTa0O8G4EJ3FYk6elSZWYqMnVshI=;
        b=DKBCs6rzXGAQzayzLHAcOmDMZb/7rIkVqKEmmIf0m3q2wqY42xnOjMxl59r+Zh0LEl
         rSzel+SUrzUVGzMLIUCLEn4qWRyVRIxFBVjgxtKdtr0LyKPbh8O7AiVNAEy1NpZK7B9S
         EIjbtQP2Pms5Q8lOKzAJ65PpLP5HCzIGdErSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j3c11nxoD/TAnBnTTa0O8G4EJ3FYk6elSZWYqMnVshI=;
        b=gncj5XPA15lLa+igwE5rrbjjUcU4lnLOqlY03+PpLMkDaIO5SNpKaRFaxCZNyKt2rm
         dljZI+mYNuYkWJKdbz6LPCQ0bzsZH685/J6xeAJjIpQwPGFldx0no6wHVGjETDfEqf/y
         hdQTErG0k8j6D1BoOX2TeLnqaRH7iE7H4rTC8HZyzGg7YmDKuKthR08IYFndLCw+NVsF
         UlK2wPgRmrJ25PXEehNMb+GcYqislmTRHUpNXP5wcIktSQQ3PsstKJlS9znBOLZwVJC0
         rM9UkDmHsTe9YippHgDuospe0vOf3ZkKpZwN5iRLlSorIaVPdbUdbrheGnV5eKKaOO4i
         YE2Q==
X-Gm-Message-State: AGRZ1gJ7m3/i7ZqQ+s8HUKx7+EbMYMLPyXVkQzMUpLFE0lNcOmetEnXY
        MKzZ9fMWgRmbQ7y9e1i2/UoNsQ==
X-Google-Smtp-Source: AJdET5fMLfYg6GqUrigVClTBrurikChaAcQ2P8ghh27QQzPvzZbiSFU8WQ6wY9JOxYzI3mHtVQtNWw==
X-Received: by 2002:a62:2683:: with SMTP id m125-v6mr3784207pfm.74.1540998350952;
        Wed, 31 Oct 2018 08:05:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 11-v6sm26720182pfr.55.2018.10.31.08.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:05:49 -0700 (PDT)
Date:   Wed, 31 Oct 2018 08:05:48 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com, cyphar@cyphar.com,
        christian.brauner@canonical.com, ebiederm@xmission.com,
        keescook@chromium.org, oleg@redhat.com
Subject: Re: [PATCH v2] Implement /proc/pid/kill
Message-ID: <20181031150548.GA103404@joelaf.mtv.corp.google.com>
References: <20181029221037.87724-1-dancol@google.com>
 <20181031143744.77677-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031143744.77677-1-dancol@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:37:44PM +0000, Daniel Colascione wrote:
> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> write the signal number in base-10 ASCII to the kill file of the
> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
> 
> Semantically, /proc/pid/kill works like kill(2), except that the
> process ID comes from the proc filesystem context instead of from an
> explicit system call parameter. This way, it's possible to avoid races
> between inspecting some aspect of a process and that process's PID
> being reused for some other process.
> 
> Note that only the real user ID that opened a /proc/pid/kill file can
> write to it; other users get EPERM.  This check prevents confused
> deputy attacks via, e.g., standard output of setuid programs.
> 
> With /proc/pid/kill, it's possible to write a proper race-free and
> safe pkill(1). An approximation follows. A real program might use
> openat(2), having opened a process's /proc/pid directory explicitly,
> with the directory file descriptor serving as a sort of "process
> handle".
> 
>     #!/bin/bash
>     set -euo pipefail
>     pat=$1
>     for proc_status in /proc/*/status; do (
>         cd $(dirname $proc_status)
>         readarray proc_argv -d'' < cmdline
>         if ((${#proc_argv[@]} > 0)) &&
>                [[ ${proc_argv[0]} = *$pat* ]];
>         then
>             echo 15 > kill
>         fi
>     ) || true; done
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
> 
> Added a real-user-ID check to prevent confused deputy attacks.
> 
>  fs/proc/base.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7e9f07bf260d..74e494f24b28 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -205,6 +205,56 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
>  	return result;
>  }
>  
> +static ssize_t proc_pid_kill_write(struct file *file,
> +				   const char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	ssize_t res;
> +	int sig;
> +	char buffer[4];
> +
> +	/* This check prevents a confused deputy attack in which an
> +	 * unprivileged process opens /proc/victim/kill and convinces
> +	 * a privileged process to write to that kill FD, effectively
> +	 * performing a kill with the privileges of the unwitting
> +	 * privileged process.  Here, we just fail the kill operation
> +	 * if someone calls write(2) with a real user ID that differs
> +	 * from the one used to open the kill FD.
> +	 */
> +	res = -EPERM;
> +	if (file->f_cred->user != current_user())
> +		goto out;

nit: You could get rid of the out label and just do direct returns. Will save
a few lines and is more readable.

> +
> +	res = -EINVAL;
> +	if (*ppos != 0)
> +		goto out;
> +
> +	res = -EINVAL;
> +	if (count > sizeof(buffer) - 1)
> +		goto out;
> +
> +	res = -EFAULT;
> +	if (copy_from_user(buffer, buf, count))
> +		goto out;
> +
> +	buffer[count] = '\0';

I think you can just zero-initialize buffer with "= {};" and get rid of this line.

> +	res = kstrtoint(strstrip(buffer), 10, &sig);
> +	if (res)
> +		goto out;


> +
> +	res = kill_pid(proc_pid(file_inode(file)), sig, 0);
> +	if (res)
> +		goto out;

if (res)
	return res;

Other than the security issues which I still think you're discussing, since
we need this, I suggest to maintainers we take this in as an intermediate
solution since we don't have anything close to it and this is a real issue,
and the fix proposed is simple.  So FWIW feel free to add my reviewed-by
(with the above nits and security issues taken care off) on any future
respins:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel

