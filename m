Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeBVKNi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:13:38 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35109 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeBVKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:13:37 -0500
X-Google-Smtp-Source: AH8x224dXTMtWEI6kSbzKz3ImvETWQq96lUt3KqAE/5xOibS457uAOGjixaG2U4LGJt/ujH8nrnyyzyRCQwc8KIMVOk=
MIME-Version: 1.0
In-Reply-To: <20180221202908.17258-1-ebiederm@xmission.com>
References: <878tbmf5vl.fsf@xmission.com> <20180221202908.17258-1-ebiederm@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 22 Feb 2018 11:13:36 +0100
Message-ID: <CAOssrKch20vj8phkjfjMe=07-8uQiuXfOuCTDjrMzPbkg6DoxA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:29 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> At the point of fuse_dev_do_read the user space process that initiated the
> action on the fuse filesystem may no longer exist.  The process have been
> killed or may have fired an asynchronous request and exited.
>
> If the initial process has exited the code "pid_vnr(find_pid_ns(in->h.pid,
> fc->pid_ns)" will either return a pid of 0, or in the unlikely event that
> the pid has been reallocated it can return practically any pid.  Any pid is
> possible as the pid allocator allocates pid numbers in different pid
> namespaces independently.
>
> The only way to make translation in fuse_dev_do_read reliable is to call
> get_pid in fuse_req_init_context, and pid_vnr followed by put_pid in
> fuse_dev_do_read.  That reference counting in other contexts has been shown
> to bounce cache lines between processors and in general be slow.  So that is
> not desirable.
>
> The only known user of running the fuse server in a different pid namespace
> from the filesystem does not care what the pids are in the fuse messages
> so removing this code should not matter.

Shouldn't we at least zero out the pid in that case?

Thanks,
Miklos


>
> Getting the translation to a server running outside of the pid namespace
> of a container can still be achieved by playing setns games at mount time.
> It is also possible to add an option to pass a pid namespace into the fuse
> filesystem at mount time.
>
> Fixes: 5d6d3a301c4e ("fuse: allow server to run in different pid_ns")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/fuse/dev.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5d06384c2cae..0fb58f364fa6 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1260,12 +1260,6 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>         in = &req->in;
>         reqsize = in->h.len;
>
> -       if (task_active_pid_ns(current) != fc->pid_ns) {
> -               rcu_read_lock();
> -               in->h.pid = pid_vnr(find_pid_ns(in->h.pid, fc->pid_ns));
> -               rcu_read_unlock();
> -       }
> -
>         /* If request is too large, reply with an error and restart the read */
>         if (nbytes < reqsize) {
>                 req->out.h.error = -EIO;
> --
> 2.14.1
>
