Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeBGE5n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:57:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37648 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeBGE5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:57:42 -0500
X-Google-Smtp-Source: AH8x225odj+xU3gx9/y46KUy88qr+wQKSvPo4U6P8wandyXNDkzjtYLjhdV3Lx4cZ/8b/QzCtgNZssObY214BassQyA=
MIME-Version: 1.0
In-Reply-To: <20180206152148.bfe7464fe12452d60ec91209@linux-foundation.org>
References: <001a113ecb5e596b8e0564931c04@google.com> <20180206152148.bfe7464fe12452d60ec91209@linux-foundation.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 Feb 2018 05:57:20 +0100
Message-ID: <CACT4Y+YNgy8gjqfWn83OXf3kYy5f92n+wQ3rzGhxSDWUn4vR0w@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in relay_open_buf
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+7525b19f9531f76b8b1e@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 12:21 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 06 Feb 2018 14:58:02 -0800 syzbot <syzbot+7525b19f9531f76b8b1e@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> e237f98a9c134c3d600353f21e07db915516875b (Mon Feb 5 21:35:56 2018 +0000)
>> Merge tag 'xfs-4.16-merge-5' of
>> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>>
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+7525b19f9531f76b8b1e@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> audit: type=1400 audit(1517939984.452:7): avc:  denied  { map } for
>> pid=4159 comm="syzkaller032522" path="/root/syzkaller032522586" dev="sda1"
>> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
>> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
>> WARNING: CPU: 0 PID: 4159 at mm/slab_common.c:1012 kmalloc_slab+0x5d/0x70
>> mm/slab_common.c:1012
>> Kernel panic - not syncing: panic_on_warn set ...
>
>
> David sent a fix today which I believe will address this.

Thanks
Let's tell syzbot about the fix:
#syz fix: kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE

> From: David Rientjes <rientjes@google.com>
> Subject: kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE
>
> chan->n_subbufs is set by the user and relay_create_buf() does a kmalloc()
> of chan->n_subbufs * sizeof(size_t *).
>
> kmalloc_slab() will generate a warning when this fails if
> chan->subbufs * sizeof(size_t *) > KMALLOC_MAX_SIZE.
>
> Limit chan->n_subbufs to the maximum allowed kmalloc() size.
>
> Link: http://lkml.kernel.org/r/alpine.DEB.2.10.1802061216100.122576@chino.kir.corp.google.com
> Fixes: f6302f1bcd75 ("relay: prevent integer overflow in relay_open()")
> Signed-off-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  kernel/relay.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN kernel/relay.c~kernel-relay-limit-kmalloc-size-to-kmalloc_max_size kernel/relay.c
> --- a/kernel/relay.c~kernel-relay-limit-kmalloc-size-to-kmalloc_max_size
> +++ a/kernel/relay.c
> @@ -163,7 +163,7 @@ static struct rchan_buf *relay_create_bu
>  {
>         struct rchan_buf *buf;
>
> -       if (chan->n_subbufs > UINT_MAX / sizeof(size_t *))
> +       if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t *))
>                 return NULL;
>
>         buf = kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
