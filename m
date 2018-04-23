Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbeDWNjs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:39:48 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45844 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755176AbeDWNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:39:46 -0400
X-Google-Smtp-Source: AIpwx48Y+bCcu63yzh3++e+OuU9Q0FC/YA2g4kg4EYzSw0ySqAleI5hggNfPjEKU05tuSfYQagJDwhUJuadg+bId3rc=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180423133617.GB2794@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-14-mszeredi@redhat.com>
 <20180423133617.GB2794@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Apr 2018 15:39:45 +0200
Message-ID: <CAJfpegsmxOtn9yjy4fvsYOt7cL49mzOM00bh8+CgxJcT3meLBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/35] ovl: readd fsync
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 3:36 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Thu, Apr 12, 2018 at 05:08:04PM +0200, Miklos Szeredi wrote:
>> Implement stacked fsync().
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> ---
>>  fs/overlayfs/file.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index b98204c1c19c..4417527667ff 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -222,10 +222,30 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>>       return ret;
>>  }
>>
>> +static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>> +{
>> +     struct fd real;
>> +     const struct cred *old_cred;
>> +     int ret;
>> +
>> +     ret = ovl_real_file(file, &real);
>> +     if (ret)
>> +             return ret;
>> +
>> +     old_cred = ovl_override_creds(file_inode(file)->i_sb);
>> +     ret = vfs_fsync_range(real.file, start, end, datasync);
>> +     revert_creds(old_cred);
>
> Can we avoid calling fsync() on real file if it is not upper. Is it worth
> optimizing.

Not sure it's worth bothering with.   If caller of fsync(2) didn't
worry about cost, then why should we?

Thanks,
Miklos
