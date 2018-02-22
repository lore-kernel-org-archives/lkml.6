Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeBVK0Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:26:25 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32844 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753417AbeBVK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:26:23 -0500
X-Google-Smtp-Source: AG47ELtuTtCkzc9JlO7YaJOcTU+CWnzc73eyTy/ha/HTOJr0cf/Q+/plYhPnCL6OQJFFSdS5kIUm4trUxHBiFy4+Jec=
MIME-Version: 1.0
In-Reply-To: <20180221202908.17258-2-ebiederm@xmission.com>
References: <878tbmf5vl.fsf@xmission.com> <20180221202908.17258-2-ebiederm@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 22 Feb 2018 11:26:22 +0100
Message-ID: <CAOssrKeYuVj6ZWUrXp7R_d+wdoArnJ=mhRp22qE9JBW3x-7tfw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] fuse: Fail all requests with invalid uids or gids
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
> Upon a cursory examinination the uid and gid of a fuse request are
> necessary for correct operation.  Failing a fuse request where those
> values are not reliable seems a straight forward and reliable means of
> ensuring that fuse requests with bad data are not sent or processed.
>
> In most cases the vfs will avoid actions it suspects will cause
> an inode write back of an inode with an invalid uid or gid.  But that does
> not map precisely to what fuse is doing, so test for this and solve
> this at the fuse level as well.
>
> Performing this work in fuse_req_init_context is cheap as the code is
> already performing the translation here and only needs to check the
> result of the translation to see if things are not representable in
> a form the fuse server can handle.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  fs/fuse/dev.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0fb58f364fa6..216db3f51a31 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -112,11 +112,13 @@ static void __fuse_put_request(struct fuse_req *req)
>         refcount_dec(&req->count);
>  }
>
> -static void fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
> +static bool fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
>  {
> -       req->in.h.uid = from_kuid_munged(&init_user_ns, current_fsuid());
> -       req->in.h.gid = from_kgid_munged(&init_user_ns, current_fsgid());
> +       req->in.h.uid = from_kuid(&init_user_ns, current_fsuid());
> +       req->in.h.gid = from_kgid(&init_user_ns, current_fsgid());
>         req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
> +
> +       return (req->in.h.uid != ((uid_t)-1)) && (req->in.h.gid != ((gid_t)-1));
>  }
>
>  void fuse_set_initialized(struct fuse_conn *fc)
> @@ -162,12 +164,13 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
>                         wake_up(&fc->blocked_waitq);
>                 goto out;
>         }
> -
> -       fuse_req_init_context(fc, req);
>         __set_bit(FR_WAITING, &req->flags);
>         if (for_background)
>                 __set_bit(FR_BACKGROUND, &req->flags);
> -
> +       if (unlikely(!fuse_req_init_context(fc, req))) {
> +               fuse_put_request(fc, req);
> +               return ERR_PTR(-EOVERFLOW);
> +       }
>         return req;
>
>   out:
> @@ -256,9 +259,12 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
>         if (!req)
>                 req = get_reserved_req(fc, file);
>
> -       fuse_req_init_context(fc, req);
>         __set_bit(FR_WAITING, &req->flags);
>         __clear_bit(FR_BACKGROUND, &req->flags);
> +       if (unlikely(!fuse_req_init_context(fc, req))) {
> +               fuse_put_request(fc, req);
> +               return ERR_PTR(-EOVERFLOW);
> +       }

I think failing the "_nofail" variant is the wrong thing to do.  This
is called to allocate a FLUSH request on close() and in readdirplus to
allocate a FORGET request.  Failing the latter results in refcount
leak in userspace.   Failing the former results in missing unlock on
close() of posix locks.

Thanks,
Miklos
