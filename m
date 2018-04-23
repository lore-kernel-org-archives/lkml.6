Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeDWKVt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:21:49 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:34001 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeDWKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:21:44 -0400
X-Google-Smtp-Source: AB8JxZrK5mn6ud9F8j3kyvaB/qw4MwAX0ieo+t6lKEgQnYfJtmSIWMTBTdP29yLD4lJz4FeBp6xVbQ70JzQRcKDajk8=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <CAOQ4uxhzsV=9PaJF3uPpMMrkKAmysFuOqmPzjhRCzmWjNC8S+w@mail.gmail.com>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-17-mszeredi@redhat.com>
 <CAOQ4uxhw+B_BqMjojSSrvnCYOLgc7J1TR_eOvPkfo=Gb0vcW8Q@mail.gmail.com> <CAOQ4uxhzsV=9PaJF3uPpMMrkKAmysFuOqmPzjhRCzmWjNC8S+w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Apr 2018 12:21:43 +0200
Message-ID: <CAJfpegt_i78O_sswFucHf8ZhD8BPkLVXAWFdxE6YkvU6v=SyTw@mail.gmail.com>
Subject: Re: [RFC PATCH 16/35] ovl: readd lsattr/chattr support
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 10:35 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, Apr 17, 2018 at 10:51 PM, Amir Goldstein <amir73il@gmail.com> wrote:

[snip]

> Is there a reason why the real file can't get the real path?

It could, except for vma->vm_file.

Now, we could have a separate realfile for mmap (with overlay path)
and one for everything else (with real path).  Maybe that's the way to
go, to minimize the chance of trouble caused by this irregularity.

> For current kernels, can you say what else can go wrong when filesystems
> call mnt_want_write_file() on an overlay file on ioctl with filesystem
> inode and why I couldn't reproduce readonly/freeze bypass?

mnt_want_write_file() is overlayfs-aware in current kernels.

We could fix it to use file_inode()->i_sb instead of
f_path.dentry->d_sb after reverting the overlay specific hack, and
that would fix the freeze bypass bug and would be correct for all
filesystems.   But I wonder how many such issues we have where
discrepancy between f_path.dentry and file_inode() matters.

Thanks,
Miklos
