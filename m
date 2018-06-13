Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 04A2DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ACA208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ACA208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964814AbeFMPpk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:45:40 -0400
Received: from h2.hallyn.com ([78.46.35.8]:51796 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935833AbeFMPpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:45:39 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9F173120218; Wed, 13 Jun 2018 10:45:37 -0500 (CDT)
Date:   Wed, 13 Jun 2018 10:45:37 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cjwatson@ubuntu.com, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk, serge@hallyn.com
Subject: Re: [PATCH 1/1] getxattr: use correct xattr length
Message-ID: <20180613154537.GA29950@mail.hallyn.com>
References: <20180607114348.23667-1-christian@brauner.io>
 <20180607114348.23667-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607114348.23667-2-christian@brauner.io>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 01:43:48PM +0200, Christian Brauner wrote:
> When running in a container with a user namespace, if you call getxattr
> with name = "system.posix_acl_access" and size % 8 != 4, then getxattr
> silently skips the user namespace fixup that it normally does resulting in
> un-fixed-up data being returned.
> This is caused by posix_acl_fix_xattr_to_user() being passed the total
> buffer size and not the actual size of the xattr as returned by
> vfs_getxattr().
> This commit passes the actual length of the xattr as returned by
> vfs_getxattr() down.
> 
> A reproducer for the issue is:
> 
>   touch acl_posix
> 
>   setfacl -m user:0:rwx acl_posix
> 
> and the compile:
> 
>   #define _GNU_SOURCE
>   #include <errno.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <sys/types.h>
>   #include <unistd.h>
>   #include <attr/xattr.h>
> 
>   /* Run in user namespace with nsuid 0 mapped to uid != 0 on the host. */
>   int main(int argc, void **argv)
>   {
>           ssize_t ret1, ret2;
>           char buf1[128], buf2[132];
>           int fret = EXIT_SUCCESS;
>           char *file;
> 
>           if (argc < 2) {
>                   fprintf(stderr,
>                           "Please specify a file with "
>                           "\"system.posix_acl_access\" permissions set\n");
>                   _exit(EXIT_FAILURE);
>           }
>           file = argv[1];
> 
>           ret1 = getxattr(file, "system.posix_acl_access",
>                           buf1, sizeof(buf1));
>           if (ret1 < 0) {
>                   fprintf(stderr, "%s - Failed to retrieve "
>                                   "\"system.posix_acl_access\" "
>                                   "from \"%s\"\n", strerror(errno), file);
>                   _exit(EXIT_FAILURE);
>           }
> 
>           ret2 = getxattr(file, "system.posix_acl_access",
>                           buf2, sizeof(buf2));
>           if (ret2 < 0) {
>                   fprintf(stderr, "%s - Failed to retrieve "
>                                   "\"system.posix_acl_access\" "
>                                   "from \"%s\"\n", strerror(errno), file);
>                   _exit(EXIT_FAILURE);
>           }
> 
>           if (ret1 != ret2) {
>                   fprintf(stderr, "The value of \"system.posix_acl_"
>                                   "access\" for file \"%s\" changed "
>                                   "between two successive calls\n", file);
>                   _exit(EXIT_FAILURE);
>           }
> 
>           for (ssize_t i = 0; i < ret2; i++) {
>                   if (buf1[i] == buf2[i])
>                           continue;
> 
>                   fprintf(stderr,
>                           "Unexpected different in byte %zd: "
>                           "%02x != %02x\n", i, buf1[i], buf2[i]);
>                   fret = EXIT_FAILURE;
>           }
> 
>           if (fret == EXIT_SUCCESS)
>                   fprintf(stderr, "Test passed\n");
>           else
>                   fprintf(stderr, "Test failed\n");
> 
>           _exit(fret);
>   }
> and run:
> 
>   ./tester acl_posix
> 
> On a non-fixed up kernel this should return something like:
> 
>   root@c1:/# ./t
>   Unexpected different in byte 16: ffffffa0 != 00
>   Unexpected different in byte 17: ffffff86 != 00
>   Unexpected different in byte 18: 01 != 00
> 
> and on a fixed kernel:
> 
>   root@c1:~# ./t
>   Test passed
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199945
> Reported-by: Colin Watson <cjwatson@ubuntu.com>
> Signed-off-by: Christian Brauner <christian@brauner.io>

D'oh, sorry, I thought I had replied to this!

Acked-by: Serge Hallyn <serge@hallyn.com>

thanks,
Serge

> ---
>  fs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index f9cb1db187b7..1bee74682513 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -539,7 +539,7 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
>  	if (error > 0) {
>  		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
>  		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
> -			posix_acl_fix_xattr_to_user(kvalue, size);
> +			posix_acl_fix_xattr_to_user(kvalue, error);
>  		if (size && copy_to_user(value, kvalue, error))
>  			error = -EFAULT;
>  	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
> -- 
> 2.17.0
