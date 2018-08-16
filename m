Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784D1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2764C20C0B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2764C20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403955AbeHPRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:50:44 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52233 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeHPRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:50:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqJck-000182-I2; Thu, 16 Aug 2018 08:51:42 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqJcj-0001dl-Nf; Thu, 16 Aug 2018 08:51:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180816092429.GV10406@uranus.lan>
Date:   Thu, 16 Aug 2018 09:51:36 -0500
In-Reply-To: <20180816092429.GV10406@uranus.lan> (Cyrill Gorcunov's message of
        "Thu, 16 Aug 2018 12:24:29 +0300")
Message-ID: <87va8acqkn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fqJcj-0001dl-Nf;;;mid=<87va8acqkn.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oH58xfFQbLWjwFg37LMlpLRoiOogw6SU=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [linux-next] Kernel panic while tetsing criu
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrill Gorcunov <gorcunov@gmail.com> writes:

> Hi Eric! We're regularly running criu on linux-next and today
> kernel get panicing.
> ---
> [  753.478579] BUG: unable to handle kernel NULL pointer dereference at 00000000000006a8
> [  753.479674] PGD 800000011215f067 P4D 800000011215f067 PUD 1134a8067 PMD 0
> [  753.480590] Oops: 0000 [#1] SMP PTI
> [  753.481054] CPU: 0 PID: 32493 Comm: file_fown Not tainted 4.18.0-next-20180815-00001-g1532db2f419f-dirty #2
> [  753.482329] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
> [  753.484096] RIP: 0010:send_sigio_to_task+0x81/0x2c0
> [  753.484792] Code: b9 02 00 00 00 31 f6 48 c7 c7 60 35 46 b2 e8 46 9c e3 ff e8 71 94 e5 ff 5a 85 c0 74 0d 80 3d 1e 26 2b 01 00 0f 84 cc 01 00 00 <4d> 8b b4 24 a8 06 00 00 e8 52 94 e5 ff 85 c0 74 0d 80 3d fe 25 2b
> [  753.487383] RSP: 0018:ffffbd8440f5bcc0 EFLAGS: 00010202
> [  753.488128] RAX: 0000000000000001 RBX: ffff99a75224f7c8 RCX: 00000000133c1702
> [  753.489166] RDX: ffffffffb12bd995 RSI: 00000000d1f2807e RDI: 0000000000000246
> [  753.490184] RBP: ffffbd8440f5bd78 R08: 0000000000000001 R09: 0000000000000000
> [  753.491204] R10: ffffffffb2463560 R11: 0000000000000000 R12: 0000000000000000
> [  753.492249] R13: 0000000000000002 R14: 0000000000000005 R15: 0000000000000001
> [  753.493273] FS:  00007f01488d04c0(0000) GS:ffff99a77ba00000(0000) knlGS:0000000000000000
> [  753.494423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  753.495244] CR2: 00000000000006a8 CR3: 00000001327b8004 CR4: 00000000003606f0
> [  753.496251] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  753.497269] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  753.498276] Call Trace:
> [  753.498653]  ? __lock_is_held+0x4f/0x90
> [  753.499198]  send_sigio+0x137/0x1c0
> [  753.499701]  kill_fasync+0xdd/0x210
> [  753.500208]  pipe_read+0x165/0x310
> [  753.500703]  __vfs_read+0x133/0x190
> [  753.501201]  vfs_read+0x9c/0x150
> [  753.501764]  ksys_read+0x52/0xc0
> [  753.502229]  do_syscall_64+0x60/0x210
> [  753.502756]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  753.503474] RIP: 0033:0x7f01483f5701
> [  753.504012] Code: fe ff ff 48 8d 3d af 8f 09 00 48 83 ec 08 e8 96 fe 01 00 66 0f 1f 44 00 00 8b 05 4a f1 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
> [  753.506667] RSP: 002b:00007ffdbb2d2878 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  753.507737] RAX: ffffffffffffffda RBX: 0000000000000025 RCX: 00007f01483f5701
> [  753.508733] RDX: 000000000000001c RSI: 00007ffdbb2d28a0 RDI: 0000000000000004
> [  753.509714] RBP: 00000000004043f0 R08: 0000000000000000 R09: 0000000000000000
> [  753.510696] R10: 000000000000038b R11: 0000000000000246 R12: 0000000000000000
> [  753.511677] R13: 00007ffdbb2d2a70 R14: 0000000000000000 R15: 0000000000000000
> [  753.512662] Modules linked in:
> [  753.513095] CR2: 00000000000006a8
> [  753.513579] ---[ end trace 2d68e222d9dac4c3 ]---
>
> we suspect it might be due to commit 9c2db007787ef1aac6728c5e03d37b0ae935d122
> because oneliner
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index a04accf6847f..20e4daf83aab 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -791,6 +791,8 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
>        if (type <= PIDTYPE_TGID) {
>                rcu_read_lock();
>                p = pid_task(pid, PIDTYPE_PID);
> +               if (!p)
> +                       goto out_unlock_fown;
>                send_sigio_to_task(p, fown, fd, band, type);
>                rcu_read_unlock();
>        } else {
>
> has helped.
>
> Could you please take a look once time permit?

That patch is incorrect as it misses the rcu_read_unlock.
>
> p.s. Andrew noticed the problem and asked me to notify,
> also he has been testing this oneliner patch. I'm out
> of sources at the moment but I think Andrew will help
> to test if needed.

I noticed a similar report from syzbot yesterday and I applied the patch
below.  Can you verify it fixes your issue?

Eric


From 84fe4cc09abc1a5ef3a282db3ed10f4d3f1e6a0b Mon Sep 17 00:00:00 2001
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 15 Aug 2018 21:20:46 -0500
Subject: [PATCH] signal: Don't send signals to tasks that don't exist

Recently syzbot reported crashes in send_sigio_to_task and
send_sigurg_to_task in linux-next.  Despite finding a reproducer
syzbot apparently did not bisected this or otherwise track down the
offending commit in linux-next.

I happened to see this report and examined the code because I had
recently changed these functions as part of making PIDTYPE_TGID a real
pid type so that fork would does not need to restart when receiving a
signal.  By examination I see that I spotted a bug in the code
that could explain the reported crashes.

When I took Oleg's suggestion and optimized send_sigurg and send_sigio
to only send to a single task when type is PIDTYPE_PID or PIDTYPE_TGID
I failed to handle pids that no longer point to tasks.  The macro
do_each_pid_task simply iterates for zero iterations.  With pid_task
an explicit NULL test is needed.

Update the code to include the missing NULL test.

Fixes: 019191342fec ("signal: Use PIDTYPE_TGID to clearly store where file signals will be sent")
Reported-by: syzkaller-bugs@googlegroups.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fcntl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index a04accf6847f..4137d96534a6 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -791,7 +791,8 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 	if (type <= PIDTYPE_TGID) {
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
-		send_sigio_to_task(p, fown, fd, band, type);
+		if (p)
+			send_sigio_to_task(p, fown, fd, band, type);
 		rcu_read_unlock();
 	} else {
 		read_lock(&tasklist_lock);
@@ -830,7 +831,8 @@ int send_sigurg(struct fown_struct *fown)
 	if (type <= PIDTYPE_TGID) {
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
-		send_sigurg_to_task(p, fown, type);
+		if (p)
+			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
 		read_lock(&tasklist_lock);
-- 
2.17.1


