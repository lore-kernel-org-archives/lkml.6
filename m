Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCLPp0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:45:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35000 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeCLPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:45:24 -0400
X-Google-Smtp-Source: AG47ELsL+Mu4r0ofp2kU+x/Fvd2b1YMzGh/EiNNmXygogE4dYm+K0e/ZVoSlP6FCFazkuuOhfoBi29T8KvgALuR2G2M=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <b8673a31534c6122545a09abcb6db405e0d0ec50.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com> <b8673a31534c6122545a09abcb6db405e0d0ec50.1520835596.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 11:45:22 -0400
Message-ID: <CAHC9VhTumvARQP6k=iKA5Vv_w4Qm8b2SyP_gzXcDc_X2wcBbEQ@mail.gmail.com>
Subject: Re: [PATCH ghak21 V2 4/4] audit: add parent of refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 2:31 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events for symlinks were missing the parent PATH
> record.  Add it.  Since the full pathname may not be available,
> reconstruct it from the path in the nameidata supplied.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c            |  2 +-
>  include/linux/audit.h |  3 +++
>  kernel/audit.c        | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)

See my comment in patch 3/4; it should really be folded into this
patch.  Additional comment inline below ...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index e54deaf..4acf374 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -73,6 +73,7 @@
>  #include <linux/freezer.h>
>  #include <linux/pid_namespace.h>
>  #include <net/netns/generic.h>
> +#include <linux/namei.h> /* for LOOKUP_PARENT */
>
>  #include "audit.h"
>
> @@ -2320,6 +2321,36 @@ void audit_log_link_denied(const char *operation)
>         audit_log_end(ab);
>  }
>
> +/*
> + * audit_log_symlink_denied - report a symlink restriction denial
> + * @link: the path that triggered the restriction
> + */
> +void audit_log_symlink_denied(const struct path *link)
> +{
> +       char *pathname;
> +       struct filename *filename;
> +
> +       if (audit_dummy_context())
> +               return;
> +
> +       pathname = kmalloc(PATH_MAX + 1, GFP_KERNEL);
> +       if (!pathname) {
> +               audit_panic("memory allocation error while reporting symlink denied");
> +               return;
> +       }
> +       filename = getname_kernel(d_absolute_path(link, pathname, PATH_MAX + 1));
> +       if (IS_ERR(filename)) {
> +               audit_panic("error getting pathname while reporting symlink denied");
> +               goto out;
> +       }
> +       audit_inode(filename, link->dentry->d_parent, LOOKUP_PARENT);

Since we are already checking audit_dummy_context() above we don't
need to check it again in audit_inode(), you should just call
__audit_inode() directly.  As a reminder, make sure you convert
LOOKUP_PARENT to AUDIT_INODE_PARENT.

> +       audit_log_link_denied("follow_link");
> +       putname(filename);
> +out:
> +       kfree(pathname);
> +       return;
> +}

-- 
paul moore
www.paul-moore.com
