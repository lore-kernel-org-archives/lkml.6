Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7726DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDAB20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfBTKA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:00:28 -0500
Received: from www62.your-server.de ([213.133.104.62]:36254 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:00:28 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwOft-00042g-Hb; Wed, 20 Feb 2019 11:00:21 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwOft-000NN8-8J; Wed, 20 Feb 2019 11:00:21 +0100
Subject: Re: BUG: assuming atomic context at kernel/seccomp.c:LINE
To:     syzbot <syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com>,
        ast@kernel.org, kafai@fb.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org, yhs@fb.com
References: <000000000000cedfe1058250076c@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <69ff36f9-8729-9b58-5595-1b35aa4a7825@iogearbox.net>
Date:   Wed, 20 Feb 2019 11:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000cedfe1058250076c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25365/Tue Feb 19 11:36:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2019 10:32 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    abf446c90405 Add linux-next specific files for 20190220
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f250d8c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=463cb576ac40e350
> dashboard link: https://syzkaller.appspot.com/bug?extid=8bf19ee2aa580de7a2a7
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com
> 
> BUG: assuming atomic context at kernel/seccomp.c:271
> in_atomic(): 0, irqs_disabled(): 0, pid: 12803, name: syz-executor.5
> no locks held by syz-executor.5/12803.
> CPU: 1 PID: 12803 Comm: syz-executor.5 Not tainted 5.0.0-rc7-next-20190220 #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  __cant_sleep kernel/sched/core.c:6218 [inline]
>  __cant_sleep.cold+0xa3/0xbb kernel/sched/core.c:6195
>  seccomp_run_filters kernel/seccomp.c:271 [inline]
>  __seccomp_filter+0x12b/0x12b0 kernel/seccomp.c:801
>  __secure_computing+0x101/0x360 kernel/seccomp.c:932
>  syscall_trace_enter+0x5bf/0xe10 arch/x86/entry/common.c:120
>  do_syscall_64+0x479/0x610 arch/x86/entry/common.c:280
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe

False positive; bpf-next only. Pushing this out in a bit:

From d56547070162a105ff666f3324e558fa6492aedd Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed, 20 Feb 2019 10:51:17 +0100
Subject: [PATCH bpf-next] bpf, seccomp: fix false positive preemption splat for
 cbpf->ebpf progs

In 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
a check was added for BPF_PROG_RUN() that for every invocation preemption is
disabled to not break eBPF assumptions (e.g. per-cpu map). Of course this does
not count for seccomp because only cBPF -> eBPF is loaded here and it does not
make use of any functionality that would require this assertion. Fix this false
positive by adding and using __BPF_PROG_RUN() variant that does not have the
cant_sleep(); check.

Fixes: 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
Reported-by: syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/filter.h | 9 ++++++++-
 kernel/seccomp.c       | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f32b3ec..2f3e29a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -533,7 +533,14 @@ struct sk_filter {
 	struct bpf_prog	*prog;
 };

-#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
+#define bpf_prog_run__non_preempt(prog, ctx)	\
+	({ cant_sleep(); __BPF_PROG_RUN(prog, ctx); })
+/* Native eBPF or cBPF -> eBPF transitions. Preemption must be disabled. */
+#define BPF_PROG_RUN(prog, ctx)			\
+	bpf_prog_run__non_preempt(prog, ctx)
+/* cBPF -> eBPF only, but not for native eBPF. */
+#define __BPF_PROG_RUN(prog, ctx)		\
+	(*(prog)->bpf_func)(ctx, (prog)->insnsi)

 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e815781..826d4e4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -268,7 +268,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	 * value always takes priority (ignoring the DATA).
 	 */
 	for (; f; f = f->prev) {
-		u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
+		u32 cur_ret = __BPF_PROG_RUN(f->prog, sd);

 		if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
 			ret = cur_ret;
-- 
2.9.5
