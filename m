Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934317AbeE2N13 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:27:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46673 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934178AbeE2N10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:27:26 -0400
X-Google-Smtp-Source: ADUXVKL+YbGCs7uR4kQqnw36YhBL4A0SpJGE3G+Am+GCmmwWBqm0qk9ljuq0X5aSmvk1KIa/vB7SGQ==
Date: Tue, 29 May 2018 14:27:22 +0100
From: Andy Whitcroft <robobotbotbot@gmail.com>
To: Brian Belleville <bbellevi@uci.edu>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] floppy: Do not copy a kernel pointer to user memory in
 FDGETPRM ioctl
Message-ID: <20180529132722.GH7445@brain>
References: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 04:02:45PM -0800, Brian Belleville wrote:
> The final field of a floppy_struct is the field "name", which is a
> pointer to a string in kernel memory. The kernel pointer should not be
> copied to user memory. The FDGETPRM ioctl copies a floppy_struct to
> user memory, including the "name" field. This pointer cannot be used
> by the user, and it will leak a kernel address to user-space, which
> will reveal the location of kernel code and data and undermine KASLR
> protection. Instead, copy the floppy_struct except for the "name"
> field.
> 
> Signed-off-by: Brian Belleville <bbellevi@uci.edu>
> ---
>  drivers/block/floppy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index eae484a..4d4a422 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3470,6 +3470,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
>  					  (struct floppy_struct **)&outparam);
>  		if (ret)
>  			return ret;
> +		size = offsetof(struct floppy_struct, name);
>  		break;
>  	case FDMSGON:
>  		UDP->flags |= FTD_MSG;

I am not sure it is reasonable to simply set size here to the length of the
valid data.  Though in the real world everyonne should be using the defines
and those should include the full length, the code itself does not require
this, it only prevents overly long reads.  So I think it is possible to do
this read with a shorter userspace buffer; with this change we would
then write beyond the end of the buffer.

This also seems to introduce a slight behavioural difference between the
primary and compat calls.  The compat call already elides the name but it
also is copying into a new structure for return and this is pre-cleared,
so the name will always be null for the compat case and undefined for
the primary ioctl.

Perhaps the below patch would be more appropriate.

-apw

>From ddb8c77229a9507fa5575c910d2847e123a9c94c Mon Sep 17 00:00:00 2001
From: Andy Whitcroft <apw@canonical.com>
Date: Tue, 29 May 2018 13:04:15 +0100
Subject: [PATCH 1/1] floppy: Do not copy a kernel pointer to user memory in
 FDGETPRM ioctl

The final field of a floppy_struct is the field "name", which is a pointer
to a string in kernel memory.  The kernel pointer should not be copied to
user memory.  The FDGETPRM ioctl copies a floppy_struct to user memory,
including this "name" field.  This pointer cannot be used by the user
and it will leak a kernel address to user-space, which will reveal the
location of kernel code and data and undermine KASLR protection.

Model this code after the compat ioctl which copies the returned data
to a previously cleared temporary structure on the stack (excluding the
name pointer) and copy out to userspace from there.  As we already have
an inparam union with an appropriate member and that memory is already
cleared even for read only calls make use of that as a temporary store.

Based on an initial patch by Brian Belleville.

CVE-2018-7755
Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 drivers/block/floppy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8ec7235fc93b..7512f6ff7c43 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3470,6 +3470,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 					  (struct floppy_struct **)&outparam);
 		if (ret)
 			return ret;
+		memcpy(&inparam.g, outparam, offsetof(struct floppy_struct, name));
+		outparam = &inparam.g;
 		break;
 	case FDMSGON:
 		UDP->flags |= FTD_MSG;
-- 
2.17.0
