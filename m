Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967076AbeBOIqz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:46:55 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42070 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966555AbeBOIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:46:52 -0500
X-Google-Smtp-Source: AH8x227bzBqmoa75gJHOHtcf6xasiXCGWVSjoncyuZFfLqyGcLtPIp9xIXq6lVoxBCmLU3TWnY5wAOxNDYULy7aFrnM=
MIME-Version: 1.0
In-Reply-To: <CAOssrKcHOp9OaCWRALsxe5MTk+tv7Gi5rPsHz2VLguzK-P+LMw@mail.gmail.com>
References: <cover.1512741134.git.dongsu@kinvolk.io> <a26103156b3f6ba73b1e46c6f577f1bee74872d9.1512041070.git.dongsu@kinvolk.io>
 <CAOssrKcHOp9OaCWRALsxe5MTk+tv7Gi5rPsHz2VLguzK-P+LMw@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 15 Feb 2018 09:46:51 +0100
Message-ID: <CAOssrKf+d3PcHxT-GTfpESONywk9kFanmnzrX4EN=1XUpizFsg@mail.gmail.com>
Subject: Re: [PATCH 10/11] fuse: Allow user namespace mounts
To: Dongsu Park <dongsu@kinvolk.io>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 2:44 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
>> From: Seth Forshee <seth.forshee@canonical.com>
>>
>> To be able to mount fuse from non-init user namespaces, it's necessary
>> to set FS_USERNS_MOUNT flag to fs_flags.
>>
>> Patch v4 is available: https://patchwork.kernel.org/patch/8944681/
>>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>> [dongsu: add a simple commit messasge]
>> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
>> ---
>>  fs/fuse/inode.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 7f6b2e55..8c98edee 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1212,7 +1212,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
>>  static struct file_system_type fuse_fs_type = {
>>         .owner          = THIS_MODULE,
>>         .name           = "fuse",
>> -       .fs_flags       = FS_HAS_SUBTYPE,
>> +       .fs_flags       = FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
>>         .mount          = fuse_mount,
>>         .kill_sb        = fuse_kill_sb_anon,
>>  };
>
> I think enabling FS_USERNS_MOUNT should be pretty safe.
>
> I was thinking opting out should be as simple as "chmod o-rw
> /dev/fuse".  But that breaks libfuse, even though fusermount opens
> /dev/fuse in privileged mode, so it shouldn't.

I'm talking rubbish, /dev/fuse is opened without privs in fusermount as well.

So there's not way to differentiate user_ns unpriv mounts from suid
fusermount unpriv mounts.

Maybe that's just as well...

Thanks,
Miklos
