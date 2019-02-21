Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6A220838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760040;
	bh=4gJu8RxaHo25ZCYNBoQNWPuuFFrKXeZglDXNDXkqtTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FuRonH66TwzXcExWO4JeFWD7PIewPpul4Iwp9xnYtgxKkqfShRCZ+XuDFqblerxEl
	 UrayQ6i6ywWKQZzSu+MRUkdo39m81YHwyHnt07eMu0egjYDKtKdEMDIzvNVZ6pgR+W
	 GlMMurdaIH7y2RMNqpDXz1FDSbUiPz0rHwMYWLyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfBUOki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbfBUOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF0232084D;
        Thu, 21 Feb 2019 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760035;
        bh=4gJu8RxaHo25ZCYNBoQNWPuuFFrKXeZglDXNDXkqtTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGVFetgdo+3P9E1GpEmuYn7t/P0MONI+EA79nJYelO/j7/R3xLYObcue2eKA7mcSB
         XcMQcT7J+KLhpiysJi6ShbKGGd0oGow14qt8Bx6UMnWPJglH6Bl0viHAZuIY1pzRQu
         y/L/FW54+3Gvxhh24064UaCh3BGIsnK2zrKCS794=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/23] net: crypto set sk to NULL when af_alg_release.
Date:   Thu, 21 Feb 2019 15:35:50 +0100
Message-Id: <20190221125246.909126725@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 9060cb719e61b685ec0102574e10337fa5f445ea ]

KASAN has found use-after-free in sockfs_setattr.
The existed commit 6d8c50dcb029 ("socket: close race condition between sock_close()
and sockfs_setattr()") is to fix this simillar issue, but it seems to ignore
that crypto module forgets to set the sk to NULL after af_alg_release.

KASAN report details as below:
BUG: KASAN: use-after-free in sockfs_setattr+0x120/0x150
Write of size 4 at addr ffff88837b956128 by task syz-executor0/4186

CPU: 2 PID: 4186 Comm: syz-executor0 Not tainted xxx + #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0xca/0x13e
 print_address_description+0x79/0x330
 ? vprintk_func+0x5e/0xf0
 kasan_report+0x18a/0x2e0
 ? sockfs_setattr+0x120/0x150
 sockfs_setattr+0x120/0x150
 ? sock_register+0x2d0/0x2d0
 notify_change+0x90c/0xd40
 ? chown_common+0x2ef/0x510
 chown_common+0x2ef/0x510
 ? chmod_common+0x3b0/0x3b0
 ? __lock_is_held+0xbc/0x160
 ? __sb_start_write+0x13d/0x2b0
 ? __mnt_want_write+0x19a/0x250
 do_fchownat+0x15c/0x190
 ? __ia32_sys_chmod+0x80/0x80
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 __x64_sys_fchownat+0xbf/0x160
 ? lockdep_hardirqs_on+0x39a/0x5e0
 do_syscall_64+0xc8/0x580
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462589
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
f7 48 89 d6 48 89
ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3
48 c7 c1 bc ff ff
ff f7 d8 64 89 01 48
RSP: 002b:00007fb4b2c83c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 000000000072bfa0 RCX: 0000000000462589
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000007
RBP: 0000000000000005 R08: 0000000000001000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb4b2c846bc
R13: 00000000004bc733 R14: 00000000006f5138 R15: 00000000ffffffff

Allocated by task 4185:
 kasan_kmalloc+0xa0/0xd0
 __kmalloc+0x14a/0x350
 sk_prot_alloc+0xf6/0x290
 sk_alloc+0x3d/0xc00
 af_alg_accept+0x9e/0x670
 hash_accept+0x4a3/0x650
 __sys_accept4+0x306/0x5c0
 __x64_sys_accept4+0x98/0x100
 do_syscall_64+0xc8/0x580
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4184:
 __kasan_slab_free+0x12e/0x180
 kfree+0xeb/0x2f0
 __sk_destruct+0x4e6/0x6a0
 sk_destruct+0x48/0x70
 __sk_free+0xa9/0x270
 sk_free+0x2a/0x30
 af_alg_release+0x5c/0x70
 __sock_release+0xd3/0x280
 sock_close+0x1a/0x20
 __fput+0x27f/0x7f0
 task_work_run+0x136/0x1b0
 exit_to_usermode_loop+0x1a7/0x1d0
 do_syscall_64+0x461/0x580
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Syzkaller reproducer:
r0 = perf_event_open(&(0x7f0000000000)={0x0, 0x70, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext}, 0x0, 0x0,
0xffffffffffffffff, 0x0)
r1 = socket$alg(0x26, 0x5, 0x0)
getrusage(0x0, 0x0)
bind(r1, &(0x7f00000001c0)=@alg={0x26, 'hash\x00', 0x0, 0x0,
'sha256-ssse3\x00'}, 0x80)
r2 = accept(r1, 0x0, 0x0)
r3 = accept4$unix(r2, 0x0, 0x0, 0x0)
r4 = dup3(r3, r0, 0x0)
fchownat(r4, &(0x7f00000000c0)='\x00', 0x0, 0x0, 0x1000)

Fixes: 6d8c50dcb029 ("socket: close race condition between sock_close() and sockfs_setattr()")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/af_alg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -122,8 +122,10 @@ static void alg_do_release(const struct
 
 int af_alg_release(struct socket *sock)
 {
-	if (sock->sk)
+	if (sock->sk) {
 		sock_put(sock->sk);
+		sock->sk = NULL;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(af_alg_release);


