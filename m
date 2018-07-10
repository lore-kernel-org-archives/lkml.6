Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0986208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eAeASWqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0986208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbeGJTo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:44:57 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35781 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:44:57 -0400
Received: by mail-it0-f66.google.com with SMTP id l16-v6so350987ita.0;
        Tue, 10 Jul 2018 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPioTA7NSLb8JOZqcXPi8HBGs8dC4Uc5cuXwz5hqMb4=;
        b=eAeASWqCXVdBHLFq0FVfQyHRtCq1ZQGpvyNFvuZiJaXl67xjnIxRm4HIGYvFLs0Y3n
         oKjXJDiacC5ad6W/pCQ6FEIg25D6T09s8ycVvVCwkgrmz2QPoKY3SInK+0TTNK6P+1yB
         V24AiflqF/V7yMKOLDmLTNZ61vQ4N5Q9Kro0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPioTA7NSLb8JOZqcXPi8HBGs8dC4Uc5cuXwz5hqMb4=;
        b=eTBuoFep3x6UudFslO56U/L4VJUVC0sReCjZNzvnvwnquTYbkXGmKbiC0Y9ddnS6nJ
         ml+J+Ia8ufnwFFxGA3XsPo1BSdbLgzbOQF9B5YARYMBiiRaoqSJ82rdrwn8M5WcS18EI
         LYpztfGG2lond9jDtelpZoONpeVHroGbmToUzqCsTlA6cPdj8SiJa3fKSoeZYC+TxUcF
         9n2Je4SHerzBO9v5mqqPQe6hvDMAGfq9aH/PJLFgLoBIKQJyX0QrbJl8Z1OJ41GQh9gF
         FdN8mDegMxycku/roVfwEHuxHx0CdcUxiESUeRSUbWlzIciO27z1eJK5aVUo94rLIg6e
         E7Hw==
X-Gm-Message-State: APt69E1kLH9xqwdkfuF8PqN53OBh0vYPqIz07M4w3rTRKcSG9imzym4I
        dPt8d2pf/dCUKyJcJ1k9eJqrViH9Y1pO5Pa65LM=
X-Google-Smtp-Source: AAOMgpdOlXKp/OefmeoxT4pNqDwHlJTPJei9GgU/lHe9FVH2nq0n9TwKMFvcOYnD2AlnkDF2WrQA0B1ZXPyz4yxK3DA=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr20063287itm.113.1531251865802;
 Tue, 10 Jul 2018 12:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c242e90570aa0062@google.com>
In-Reply-To: <000000000000c242e90570aa0062@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 12:44:14 -0700
Message-ID: <CA+55aFyEZR=v2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw@mail.gmail.com>
Subject: Re: general protection fault in in_aton
To:     syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:19 PM syzbot
<syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com> wrote:
> RIP: 0010:in_aton+0x3e/0x180 net/core/utils.c:63

That's

                if (*str != '\0') {

in in_aton().

The code disassembles to

        movzbl (%rax,%r15,1),%eax

which is a bit odd, because

> RAX: 0000000000000000

Ok, NULL pointer, looks sane, but:

> R15: dffffc0000000000

Yeah, that's unusual. But I'm guessing it's some KASAN artifact. One
of the big problemns with KASAN is that it makes the generated code
completely illegible because 90% of the code is just KASAN overhead.

> Call Trace:
>   rdma_create_trans+0xdbe/0x1ed0 net/9p/trans_rdma.c:678

Well, rdma_create_trans() certainly doesn't verify 'addr' before using it.

>   p9_client_create+0x915/0x16c9 net/9p/client.c:1062

p9_client_create() just blindly passes on "dev_name"

>   v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
>   v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135

.. as does v9fs_session_init() and v9fs_mount()

>   mount_fs+0xae/0x328 fs/super.c:1277
>   vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>   vfs_kern_mount fs/namespace.c:1027 [inline]
>   do_new_mount fs/namespace.c:2518 [inline]
>   do_mount+0x581/0x30e0 fs/namespace.c:2848

This is "name" in mount_fs(), vfs_kern_mount(), do_new_mount() and
do_mount(), also just passed through.

>   __do_compat_sys_mount fs/compat.c:125 [inline]
>   __se_compat_sys_mount fs/compat.c:92 [inline]
>   __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92

And here we have the source:

        kernel_dev = copy_mount_string(dev_name);

Note that copy_mount_string() just passes a NULL user space pointer
through as a NULL kernel pointer (otherwise it does a
"strndup_user()".

And no, this is not a compat issue. The native mount does the same thing.

So yes. The device name can trivially be NULL, and either rdma or the
p9 code should check for NULL.

Adding in the 9p people, because I think it's for them. Note the
syzbot info below.

               Linus

--

syzbot found the following crash on:

HEAD commit:    092150a25cb7 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1687b168400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=2a831e062bb4aebd8755
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=158cc2c2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e7ef48400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com
