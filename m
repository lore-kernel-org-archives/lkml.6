Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF0C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4919E205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4919E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeJNXhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:37:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36044 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727650AbeJNXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:55 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004cp-TT; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000iH-41; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Paolo Abeni" <pabeni@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.801704341@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 329/366] netfilter: ebtables: handle string from
 userspace with care
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 94c752f99954797da583a84c4907ff19e92550a4 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bridge/netfilter/ebtables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1897,7 +1897,8 @@ static int compat_mtw_from_user(struct c
 	int off, pad = 0;
 	unsigned int size_kern, match_size = mwt->match_size;
 
-	strlcpy(name, mwt->u.name, sizeof(name));
+	if (strscpy(name, mwt->u.name, sizeof(name)) < 0)
+		return -EINVAL;
 
 	if (state->buf_kern_start)
 		dst = state->buf_kern_start + state->buf_kern_offset;

