Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeEHBoU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:44:20 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45938 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeEHBoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:44:19 -0400
X-Google-Smtp-Source: AB8JxZreYjnd+36ZxkC0wpLbxac02tOaochYlNbXwgl25EDBdQmudyUC1ef3Yx8cmDYeN6DifpkQK80onGcsbfLQSzY=
MIME-Version: 1.0
In-Reply-To: <1525740850-23737-1-git-send-email-wang6495@umn.edu>
References: <1525740850-23737-1-git-send-email-wang6495@umn.edu>
From: adam radford <aradford@gmail.com>
Date: Mon, 7 May 2018 18:44:18 -0700
Message-ID: <CAHtARFFVXV0UQt0xyL4PwkOL_9ng_DsVdvRu1YhRJqXifvKU8g@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: 3w-xxxx: fix a missing-check bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 5:54 PM, Wenwen Wang <wang6495@umn.edu> wrote:
> In tw_chrdev_ioctl(), the length of the data buffer is firstly copied from
> the userspace pointer 'argp' and saved to the kernel object
> 'data_buffer_length'. Then a security check is performed on it to make sure
> that the length is not more than 'TW_MAX_IOCTL_SECTORS * 512'. Otherwise,
> an error code -EINVAL is returned. If the security check is passed, the
> entire ioctl command is copied again from the 'argp' pointer and saved to
> the kernel object 'tw_ioctl'. Then, various operations are performed on
> 'tw_ioctl' according to the 'cmd'. Given that the 'argp' pointer resides in
> userspace, a malicious userspace process can race to change the buffer
> length between the two copies. This way, the user can bypass the security
> check and inject invalid data buffer length. This can cause potential
> security issues in the following execution.
>
> This patch checks for capable(CAP_SYS_ADMIN) in tw_chrdev_open() to avoid
> the above issues.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/scsi/3w-xxxx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
> index 33261b6..f6179e3 100644
> --- a/drivers/scsi/3w-xxxx.c
> +++ b/drivers/scsi/3w-xxxx.c
> @@ -1033,6 +1033,9 @@ static int tw_chrdev_open(struct inode *inode, struct file *file)
>
>         dprintk(KERN_WARNING "3w-xxxx: tw_ioctl_open()\n");
>
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EACCES;
> +
>         minor_number = iminor(inode);
>         if (minor_number >= tw_device_extension_count)
>                 return -ENODEV;
> --
> 2.7.4
>

Acked-by: Adam Radford <aradford@gmail.com>
