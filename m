Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F802081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F802081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeKCHy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:54:56 -0400
Received: from nautica.notk.org ([91.121.71.147]:37640 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbeKCHy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:54:56 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 149A2C009; Fri,  2 Nov 2018 23:45:53 +0100 (CET)
Date:   Fri, 2 Nov 2018 23:45:38 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: INFO: task hung in grab_super
Message-ID: <20181102224538.GB9565@nautica>
References: <0000000000002f5541057143a85e@google.com>
 <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
 <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
 <CACT4Y+bM1tfisT+7=ZChHRZKZkddbWp0kNi5q46EqOYBSptXtg@mail.gmail.com>
 <0adc592b-d4a3-f6da-3c5c-22490f641eb9@i-love.sakura.ne.jp>
 <CACT4Y+YqDFNrdtk+aet9UVBxyvxs+O85YLnMYL3FvoPckBx-Mg@mail.gmail.com>
 <fe20c22a-028b-b2a3-7714-c90b7fe51cbf@i-love.sakura.ne.jp>
 <CACT4Y+YShmryp_RJErUrjP=9GJ3YcRPLXyQP8XKoA9AW114Ygg@mail.gmail.com>
 <727110bb-0154-e5df-4b2f-e965e3b98c62@i-love.sakura.ne.jp>
 <CACT4Y+Z-jwUJsfisdevXZdReWYgNnLELhgDtkVH53GC_mZqEPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z-jwUJsfisdevXZdReWYgNnLELhgDtkVH53GC_mZqEPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Fri, Nov 02, 2018:
> >> I guess that's the problem, right? SIGKILL-ed task must not ignore
> >> SIGKILL and hang in infinite loop. This would explain a bunch of hangs
> >> in 9p.
> >
> > Did you check /proc/18253/task/*/stack after manually sending SIGKILL?
> 
> Yes:
> 
> root@syzkaller:~# ps afxu | grep syz
> root     18253  0.0  0.0      0     0 ttyS0    Zl   10:16   0:00  \_
> [syz-executor] <defunct>
> root@syzkaller:~# cat /proc/18253/task/*/stack
> [<0>] p9_client_rpc+0x3a2/0x1400
> [<0>] p9_client_flush+0x134/0x2a0
> [<0>] p9_client_rpc+0x122c/0x1400
> [<0>] p9_client_create+0xc56/0x16af
> [<0>] v9fs_session_init+0x21a/0x1a80
> [<0>] v9fs_mount+0x7c/0x900
> [<0>] mount_fs+0xae/0x328
> [<0>] vfs_kern_mount.part.34+0xdc/0x4e0
> [<0>] do_mount+0x581/0x30e0
> [<0>] ksys_mount+0x12d/0x140
> [<0>] __x64_sys_mount+0xbe/0x150
> [<0>] do_syscall_64+0x1b9/0x820
> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [<0>] 0xffffffffffffffff

Yes that's a known problem with the current code, since everything must
be cleaned up on the spot, the first kill sends a flush and waits again
for the flush reply to come; the second kill is completly ignored.

With the refcounting work we've done that went in this merge window
we're halfways there - memory can now have a lifetime independant of the
current request and won't be freed when the process exits p9_client_rpc,
so we can send the flush and return immediately; then have the rest of
the cleanup happen asynchronously when the flush reply comes or the
client is torn down, whichever happens first.

I've got this planned for 4.21 if I can find the time to do it early in
this cycle and I get it to work on first try, 4.22 if I run into
complications to make sure it's well tested in -next first.
My freetime is pretty limited this year so unless you want to help it'll
get done when it's ready :)

-- 
Dominique
