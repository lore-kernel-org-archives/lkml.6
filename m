Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbeEMFHA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 01:07:00 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41217 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMFG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 01:06:59 -0400
X-Google-Smtp-Source: AB8JxZqhiWY9hY5uaX87nhS1J0rKfDn69Frwv7Wwiue7D5fS3Du4vS2FGdeH+1hZfEgzPDUAvrOlBtwq9QZpuTFaN4c=
MIME-Version: 1.0
In-Reply-To: <CABeXuvpdH190cc5vhiqUkjK6B3UD9Bjy_TVPD=C-kBbHTUZmug@mail.gmail.com>
References: <20180512065724.GA19716@beast> <CABeXuvpdH190cc5vhiqUkjK6B3UD9Bjy_TVPD=C-kBbHTUZmug@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 12 May 2018 22:06:57 -0700
X-Google-Sender-Auth: QJiXWoVahBcowe9t6IwMOQwyXkI
Message-ID: <CAGXu5jJGnPUdvuB099WbbWTFNAkKy6eyvW_95v_D2EJYh2R3fg@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert internal records to timespec64
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 10:45 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>  Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>

Thanks for checking this over!

> I will rebase the vfs series on top of this.
> I'm a little worried about merge strategy.
> Whoever is taking that series should pull in this patch as well?
> I could include it as one of the patches in the series if you prefer.

I'll send a v2, I found some problems in my testing. I'll see if Linus
will take it for v4.17, so it'll be out of your way for v4.18.

-Kees

>
> -Deepa
>
> On Fri, May 11, 2018 at 11:57 PM, Kees Cook <keescook@chromium.org> wrote:
>> This prepares pstore for converting the VFS layer to timespec64.
>>
>> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  fs/pstore/inode.c      | 3 ++-
>>  fs/pstore/platform.c   | 2 +-
>>  include/linux/pstore.h | 2 +-
>>  3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
>> index 5fcb845b9fec..75afe5eb0574 100644
>> --- a/fs/pstore/inode.c
>> +++ b/fs/pstore/inode.c
>> @@ -392,7 +392,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>>         inode->i_private = private;
>>
>>         if (record->time.tv_sec)
>> -               inode->i_mtime = inode->i_ctime = record->time;
>> +               inode->i_mtime = inode->i_ctime =
>> +                       timespec64_to_timespec(record->time);
>>
>>         d_add(dentry, inode);
>>
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index dc720573fd53..c238ab8ba31d 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -328,7 +328,7 @@ void pstore_record_init(struct pstore_record *record,
>>         record->psi = psinfo;
>>
>>         /* Report zeroed timestamp if called before timekeeping has resumed. */
>> -       record->time = ns_to_timespec(ktime_get_real_fast_ns());
>> +       record->time = ns_to_timespec64(ktime_get_real_fast_ns());
>>  }
>>
>>  /*
>> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
>> index 61f806a7fe29..a15bc4d48752 100644
>> --- a/include/linux/pstore.h
>> +++ b/include/linux/pstore.h
>> @@ -71,7 +71,7 @@ struct pstore_record {
>>         struct pstore_info      *psi;
>>         enum pstore_type_id     type;
>>         u64                     id;
>> -       struct timespec         time;
>> +       struct timespec64       time;
>>         char                    *buf;
>>         ssize_t                 size;
>>         ssize_t                 ecc_notice_size;
>> --
>> 2.17.0
>>
>>
>> --
>> Kees Cook
>> Pixel Security



-- 
Kees Cook
Pixel Security
