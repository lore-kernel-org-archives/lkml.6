Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEBOMf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:12:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52712 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeEBOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:12:21 -0400
X-Google-Smtp-Source: AB8JxZrVllP7nnVIpwdBPwXelj1mqFcLb+G5saCkgr+5VtrWI8Lhsx6cJjbIP6Dw+mZEEPOpK43LZaNuQEuMY5hmZQU=
MIME-Version: 1.0
In-Reply-To: <20180419024641.24213-1-marcos.souza.org@gmail.com>
References: <20180419024641.24213-1-marcos.souza.org@gmail.com>
From: Christian Brauner <christian.brauner@canonical.com>
Date: Wed, 2 May 2018 16:12:18 +0200
Message-ID: <CAPP7u0XztHVja18pJV+0cfRNr7cGmKq4i0nYKt03Sd6oyKUuVQ@mail.gmail.com>
Subject: Re: [PATCH -next] user_namespace: Replace gotos with return statements
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: linux-next@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 11:46:38PM -0300, Marcos Paulo de Souza wrote:
> Found while inspecting the code that handles the setgroups procfs file.

This is not really improving anything so I unfortunately don't really
see why we should take this.

Christian

>
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
> Tested locally setting up a new userns, and setting setgroups as deny and allow,
> worked as before.
>
>  kernel/user_namespace.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 246d4d4ce5c7..64a01254ac6b 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1142,22 +1142,18 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
>   struct user_namespace *ns = seq->private;
>   char kbuf[8], *pos;
>   bool setgroups_allowed;
> - ssize_t ret;
>
>   /* Only allow a very narrow range of strings to be written */
> - ret = -EINVAL;
>   if ((*ppos != 0) || (count >= sizeof(kbuf)))
> - goto out;
> + return -EINVAL;
>
>   /* What was written? */
> - ret = -EFAULT;
>   if (copy_from_user(kbuf, buf, count))
> - goto out;
> + return -EFAULT;
>   kbuf[count] = '\0';
>   pos = kbuf;
>
>   /* What is being requested? */
> - ret = -EINVAL;
>   if (strncmp(pos, "allow", 5) == 0) {
>   pos += 5;
>   setgroups_allowed = true;
> @@ -1167,14 +1163,13 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
>   setgroups_allowed = false;
>   }
>   else
> - goto out;
> + return -EINVAL;
>
>   /* Verify there is not trailing junk on the line */
>   pos = skip_spaces(pos);
>   if (*pos != '\0')
> - goto out;
> + return -EINVAL;
>
> - ret = -EPERM;
>   mutex_lock(&userns_state_mutex);
>   if (setgroups_allowed) {
>   /* Enabling setgroups after setgroups has been disabled
> @@ -1194,12 +1189,11 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
>
>   /* Report a successful write */
>   *ppos = count;
> - ret = count;
> -out:
> - return ret;
> + return count;
> +
>  out_unlock:
>   mutex_unlock(&userns_state_mutex);
> - goto out;
> + return -EPERM;
>  }
>
>  bool userns_may_setgroups(const struct user_namespace *ns)
> --
> 2.14.3
>
