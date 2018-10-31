Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45251C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006DD20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006DD20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeJaNmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:42:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47506 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeJaNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:42:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHiNs-0002v1-9b; Tue, 30 Oct 2018 22:45:36 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHiNc-0008Jr-Ne; Tue, 30 Oct 2018 22:45:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <20181029221037.87724-1-dancol@google.com>
Date:   Tue, 30 Oct 2018 23:44:50 -0500
In-Reply-To: <20181029221037.87724-1-dancol@google.com> (Daniel Colascione's
        message of "Mon, 29 Oct 2018 22:10:37 +0000")
Message-ID: <87bm7a3et9.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gHiNc-0008Jr-Ne;;;mid=<87bm7a3et9.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+FneTdDlDEYXCq9FuigTPaN7Qn/NrBS9c=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Colascione <dancol@google.com> writes:

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

In general this looks good.

Unfortunately the permission checks are are subject to a serious
problem.  Even if I don't have permission to kill a process I quite
likely will be allowed to open the file.

Then I just need to find a setuid or setcap executable will write to
stdout or stderr a number.  Then I have killed something I should not
have the privileges to kill.

At a bare minimum you need to perform the permission check using the
credentials of the opener of the file.    Which means refactoring
kill_pid so that you can perform the permission check for killing the
application during open.  Given that process credentials can change
completely during exec you also need to rule out a change in process
credentials making it so that the original opener of the file would not
be able to kill the process as it is now.

But overall this looks quite reasaonble.

Eric

> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  fs/proc/base.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7e9f07bf260d..923d62b21e67 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -205,6 +205,44 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
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
> +	res = kstrtoint(strstrip(buffer), 10, &sig);
> +	if (res)
> +		goto out;
> +
> +	res = kill_pid(proc_pid(file_inode(file)), sig, 0);
> +	if (res)
> +		goto out;
> +	res = count;
> +out:
> +	return res;
> +
> +}
> +
> +static const struct file_operations proc_pid_kill_ops = {
> +	.write	= proc_pid_kill_write,
> +};
> +
>  static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  			      size_t count, loff_t *ppos)
>  {
> @@ -2935,6 +2973,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
>  	ONE("syscall",    S_IRUSR, proc_pid_syscall),
>  #endif
> +	REG("kill",       S_IRUGO | S_IWUGO, proc_pid_kill_ops),
>  	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
>  	ONE("stat",       S_IRUGO, proc_tgid_stat),
>  	ONE("statm",      S_IRUGO, proc_pid_statm),
