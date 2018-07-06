Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066E6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE41240A7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE41240A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934776AbeGFFxI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:53:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933845AbeGFFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:53:05 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A72086A;
        Fri,  6 Jul 2018 05:53:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 47/61] netfilter: ebtables: handle string from userspace with care
Date:   Fri,  6 Jul 2018 07:47:11 +0200
Message-Id: <20180706054714.144635681@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 94c752f99954797da583a84c4907ff19e92550a4 ]

strlcpy() can't be safely used on a user-space provided string,
as it can try to read beyond the buffer's end, if the latter is
not NULL terminated.

Leveraging the above, syzbot has been able to trigger the following
splat:

BUG: KASAN: stack-out-of-bounds in strlcpy include/linux/string.h:300
[inline]
BUG: KASAN: stack-out-of-bounds in compat_mtw_from_user
net/bridge/netfilter/ebtables.c:1957 [inline]
BUG: KASAN: stack-out-of-bounds in ebt_size_mwt
net/bridge/netfilter/ebtables.c:2059 [inline]
BUG: KASAN: stack-out-of-bounds in size_entry_mwt
net/bridge/netfilter/ebtables.c:2155 [inline]
BUG: KASAN: stack-out-of-bounds in compat_copy_entries+0x96c/0x14a0
net/bridge/netfilter/ebtables.c:2194
Write of size 33 at addr ffff8801b0abf888 by task syz-executor0/4504

CPU: 0 PID: 4504 Comm: syz-executor0 Not tainted 4.17.0-rc2+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memcpy+0x37/0x50 mm/kasan/kasan.c:303
  strlcpy include/linux/string.h:300 [inline]
  compat_mtw_from_user net/bridge/netfilter/ebtables.c:1957 [inline]
  ebt_size_mwt net/bridge/netfilter/ebtables.c:2059 [inline]
  size_entry_mwt net/bridge/netfilter/ebtables.c:2155 [inline]
  compat_copy_entries+0x96c/0x14a0 net/bridge/netfilter/ebtables.c:2194
  compat_do_replace+0x483/0x900 net/bridge/netfilter/ebtables.c:2285
  compat_do_ebt_set_ctl+0x2ac/0x324 net/bridge/netfilter/ebtables.c:2367
  compat_nf_sockopt net/netfilter/nf_sockopt.c:144 [inline]
  compat_nf_setsockopt+0x9b/0x140 net/netfilter/nf_sockopt.c:156
  compat_ip_setsockopt+0xff/0x140 net/ipv4/ip_sockglue.c:1279
  inet_csk_compat_setsockopt+0x97/0x120 net/ipv4/inet_connection_sock.c:1041
  compat_tcp_setsockopt+0x49/0x80 net/ipv4/tcp.c:2901
  compat_sock_common_setsockopt+0xb4/0x150 net/core/sock.c:3050
  __compat_sys_setsockopt+0x1ab/0x7c0 net/compat.c:403
  __do_compat_sys_setsockopt net/compat.c:416 [inline]
  __se_compat_sys_setsockopt net/compat.c:413 [inline]
  __ia32_compat_sys_setsockopt+0xbd/0x150 net/compat.c:413
  do_syscall_32_irqs_on arch/x86/entry/common.c:323 [inline]
  do_fast_syscall_32+0x345/0xf9b arch/x86/entry/common.c:394
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fb3cb9
RSP: 002b:00000000fff0c26c EFLAGS: 00000282 ORIG_RAX: 000000000000016e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000080 RSI: 0000000020000300 RDI: 00000000000005f4
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea0006c2afc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 ffffea0006c20101 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Fix the issue replacing the unsafe function with strscpy() and
taking care of possible errors.

Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
Reported-and-tested-by: syzbot+4e42a04e0bc33cb6c087@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/netfilter/ebtables.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1950,7 +1950,8 @@ static int compat_mtw_from_user(struct c
 	int off, pad = 0;
 	unsigned int size_kern, match_size = mwt->match_size;
 
-	strlcpy(name, mwt->u.name, sizeof(name));
+	if (strscpy(name, mwt->u.name, sizeof(name)) < 0)
+		return -EINVAL;
 
 	if (state->buf_kern_start)
 		dst = state->buf_kern_start + state->buf_kern_offset;


