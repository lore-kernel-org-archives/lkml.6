Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734A1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A2D20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A2D20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbeG1AsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:48:18 -0400
Received: from h2.hallyn.com ([78.46.35.8]:34870 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388563AbeG1AsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:48:18 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 11409120CB6; Fri, 27 Jul 2018 18:24:09 -0500 (CDT)
Date:   Fri, 27 Jul 2018 18:24:09 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Eddie.Horng" <eddie.horng@mediatek.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eddie Horng <eddiehorng.tw@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cap_inode_getsecurity: use d_find_any_alias() instead
 of d_find_alias()
Message-ID: <20180727232408.GA9800@mail.hallyn.com>
References: <1532071800.19245.5.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532071800.19245.5.camel@mtkswgap22>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie.Horng (eddie.horng@mediatek.com):
> 
> The code in cap_inode_getsecurity(), introduced by commit 8db6c34f1dbc
> ("Introduce v3 namespaced file capabilities"), should use
> d_find_any_alias() instead of d_find_alias() do handle unhashed dentry
> correctly. This is needed, for example, if execveat() is called with an
> open but unlinked overlayfs file, because overlayfs unhashes dentry on
> unlink.
> This is a regression of real life application, first reported at
> https://www.spinics.net/lists/linux-unionfs/msg05363.html
> 
> Below reproducer and setup can reproduce the case.
>   const char* exec="echo";
>   const char *newargv[] = { "echo", "hello", NULL};
>   const char *newenviron[] = { NULL };
>   int fd, err;
> 
>   fd = open(exec, O_PATH);
>   unlink(exec);
>   err = syscall(322/*SYS_execveat*/, fd, "", newargv, newenviron,
> AT_EMPTY_PATH);
>   if(err<0)
>     fprintf(stderr, "execveat: %s\n", strerror(errno));
> 
> gcc compile into ~/test/a.out
> mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w
> none /mnt/m
> cd /mnt/m
> cp /bin/echo .
> ~/test/a.out
> 
> Expected result:
> hello
> Actually result:
> execveat: Invalid argument
> dmesg:
> Invalid argument reading file caps for /dev/fd/3
> 
> The 2nd reproducer and setup emulates similar case but for
> regular filesystem:
>   const char* exec="echo";
>   int fd, err;
>   char buf[256];
> 
>   fd = open(exec, O_RDONLY);
>   unlink(exec);
>   err = fgetxattr(fd, "security.capability", buf, 256);
>   if(err<0)
>     fprintf(stderr, "fgetxattr: %s\n", strerror(errno));
> 
> gcc compile into ~/test_fgetxattr
> 
> cd /tmp
> cp /bin/echo .
> ~/test_fgetxattr
> 
> Result:
> fgetxattr: Invalid argument
> 
> On regular filesystem, for example, ext4 read xattr from
> disk and return to execveat(), will not trigger this issue, however,
> the overlay attr handler pass real dentry to vfs_getxattr() will.
> This reproducer calls fgetxattr() with an unlinked fd, involkes
> vfs_getxattr() then reproduced the case that d_find_alias() in
> cap_inode_getsecurity() can't find the unlinked dentry.
> 
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Serge E. Hallyn <serge@hallyn.com>
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Cc: <stable@vger.kernel.org> # v4.14
> Signed-off-by: Eddie Horng <eddie.horng@mediatek.com>

Hey Eric,

if the patch looks ok to you, do you mind pulling it in through your tree?

thanks,
-serge

> ---
> Changes in v2:
>  - fix commit message wrapped at 74 chars
>  - added previous acked-by
> 
> ---
> Changes in v3:
>  - added original case report link
>  - added 2nd reproducer for regular filesystems
>  - added acked-by Serge E. Hallyn
>  - add Cc
> 
> ---
>  security/commoncap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 1ce701fcb3f3..147f6131842a 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -388,7 +388,7 @@ int cap_inode_getsecurity(struct inode *inode, const
> char *name, void **buffer,
>  	if (strcmp(name, "capability") != 0)
>  		return -EOPNOTSUPP;
>  
> -	dentry = d_find_alias(inode);
> +	dentry = d_find_any_alias(inode);
>  	if (!dentry)
>  		return -EINVAL;
>  
> -- 
> 2.12.5
> 
