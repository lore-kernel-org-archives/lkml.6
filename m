Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755843AbeDXO2a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:28:30 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:41832 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeDXO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:28:23 -0400
X-Google-Smtp-Source: AB8JxZrUr7dOLETgcuO57xMqJ6BF792It7atcgOptnwcFKKegw8bLz83SoxWgARqxjVDSGHad+md55368CdJjiSwb84=
MIME-Version: 1.0
In-Reply-To: <000000000000ae37a6056a9273f6@google.com>
References: <20180424062000.GA57884@jaegeuk-macbookpro.roam.corp.google.com> <000000000000ae37a6056a9273f6@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 24 Apr 2018 16:28:02 +0200
Message-ID: <CACT4Y+b2UgpGHDdfPgu3vp1MR8feL16C=HXsQwx7TC2-3U=0Sg@mail.gmail.com>
Subject: Re: kernel BUG at fs/f2fs/node.c:LINE!
To: syzbot <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 8:42 AM, syzbot
<syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot tried to test the proposed patch but build/boot failed:
>
> failed to create VM pool: failed to create GCE image: failed to get create
> image operation operation-1524552040215-56a926ecc71d9-3edfeb8b-8abca81c:
> googleapi: Error 403: Rate Limit Exceeded, rateLimitExceeded
>
>
> Tested on git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev
> commit
> b549e322861b99f1862fb5f08dfb5e5753a38635 (Sat Apr 21 06:44:59 2018 +0000)
> f2fs: check cap_resource only for data blocks
>
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> Patch: https://syzkaller.appspot.com/x/patch.diff?id=5565179303559168
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=1808800213120130118

Hi Jaegeuk,

Re the last failure (rate limiting), now should be fixed with:
https://github.com/google/syzkaller/commit/e2f4bf8f3818d49baf0f3789add75d5fd506ad8d
which adds some backoff-and-retry logic.

Re the first one, do I understand it correctly that dev-test already
contains the fix that you want to test?
We did not foresee such case initially, but you are not the first one
to try this. I've added support for testing without a patch now:
https://github.com/google/syzkaller/commit/9366d03f001170479319878905031f63d4377c46
and updated the docs:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

So now this should work:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
dev-test
