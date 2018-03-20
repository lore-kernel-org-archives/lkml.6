Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeCTUMF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:12:05 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41188 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeCTUMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:12:01 -0400
X-Google-Smtp-Source: AG47ELs3p9kr0MtbqfQIweyBQU65YRuCheBw+zmET4D3fJ+6KuqOJat44lKbUbGYKz3D9V1j+sVAY5YejJFUkRqchxg=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <b55492688f43df914037c48314db483a3c6ad05b.1521005283.git.rgb@redhat.com>
References: <cover.1521005283.git.rgb@redhat.com> <b55492688f43df914037c48314db483a3c6ad05b.1521005283.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Mar 2018 16:11:59 -0400
Message-ID: <CAHC9VhQSjhjEkdrXhFVgMmnhAeR3EB_LB8nc2QtXuySqrUSmLQ@mail.gmail.com>
Subject: Re: [PATCH ghak21 V3 2/2] audit: add refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 1:43 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events for symlinks had duplicate PATH records rather
> than just updating the existing PATH record.  Update the symlink's PATH
> record with the current dentry and inode information.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 50d2533..00f5041 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -945,6 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
>         if (nd->flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> +       audit_inode(nd->name, nd->stack[0].link.dentry, 0);
>         audit_log_link_denied("follow_link", &nd->stack[0].link);

That's the one, right above this comment ...

Be honest, this never compiled did it?

My confidence for these patches is really low right now, which is not
good for something asking to go in at this stage in the -rcX
development cycle.  There have been some delays due to review, so I'm
willing to be a little flexible on timelines and accept stuff this
week, but for the v4 patchset please provide before and after audit
logs for both hard and soft links both where CWD is the same as the
parent as well as different (eight logs total if I did the math
right).  You can include them in the 0/2 patch as it's probably a bit
much for the individual patches.

>         return -EACCES;
>  }
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
