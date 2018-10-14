Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A33C7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463FD20989
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463FD20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJNXLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35645 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbeJNXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cD-Ci; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000M0-T7; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paolo Abeni" <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.589574152@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 157/366] team: avoid adding twice the same option to
 the event list
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

commit 4fb0534fb7bbc2346ba7d3a072b538007f4135a5 upstream.

When parsing the options provided by the user space,
team_nl_cmd_options_set() insert them in a temporary list to send
multiple events with a single message.
While each option's attribute is correctly validated, the code does
not check for duplicate entries before inserting into the event
list.

Exploiting the above, the syzbot was able to trigger the following
splat:

kernel BUG at lib/list_debug.c:31!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4466 Comm: syzkaller556835 Not tainted 4.16.0+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:__list_add_valid+0xaa/0xb0 lib/list_debug.c:29
RSP: 0018:ffff8801b04bf248 EFLAGS: 00010286
RAX: 0000000000000058 RBX: ffff8801c8fc7a90 RCX: 0000000000000000
RDX: 0000000000000058 RSI: ffffffff815fbf41 RDI: ffffed0036097e3f
RBP: ffff8801b04bf260 R08: ffff8801b0b2a700 R09: ffffed003b604f90
R10: ffffed003b604f90 R11: ffff8801db027c87 R12: ffff8801c8fc7a90
R13: ffff8801c8fc7a90 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000b98880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043fc30 CR3: 00000001afe8e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add include/linux/list.h:79 [inline]
  team_nl_cmd_options_set+0x9ff/0x12b0 drivers/net/team/team.c:2571
  genl_family_rcv_msg+0x889/0x1120 net/netlink/genetlink.c:599
  genl_rcv_msg+0xc6/0x170 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x58b/0x740 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x9f0/0xfa0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
  __sys_sendmsg+0x115/0x270 net/socket.c:2155
  SYSC_sendmsg net/socket.c:2164 [inline]
  SyS_sendmsg+0x29/0x30 net/socket.c:2162
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4458b9
RSP: 002b:00007ffd1d4a7278 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00000000004458b9
RDX: 0000000000000010 RSI: 0000000020000d00 RDI: 0000000000000004
RBP: 00000000004a74ed R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffd1d4a7348
R13: 0000000000402a60 R14: 0000000000000000 R15: 0000000000000000
Code: 75 e8 eb a9 48 89 f7 48 89 75 e8 e8 d1 85 7b fe 48 8b 75 e8 eb bb 48
89 f2 48 89 d9 4c 89 e6 48 c7 c7 a0 84 d8 87 e8 ea 67 28 fe <0f> 0b 0f 1f
40 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41
RIP: __list_add_valid+0xaa/0xb0 lib/list_debug.c:29 RSP: ffff8801b04bf248

This changeset addresses the avoiding list_add() if the current
option is already present in the event list.

Reported-and-tested-by: syzbot+4d4af685432dc0e56c91@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 2fcdb2c9e659 ("team: allow to send multiple set events in one message")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/team/team.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -253,6 +253,17 @@ static void __team_option_inst_mark_remo
 	}
 }
 
+static bool __team_option_inst_tmp_find(const struct list_head *opts,
+					const struct team_option_inst *needle)
+{
+	struct team_option_inst *opt_inst;
+
+	list_for_each_entry(opt_inst, opts, tmp_list)
+		if (opt_inst == needle)
+			return true;
+	return false;
+}
+
 static int __team_options_register(struct team *team,
 				   const struct team_option *option,
 				   size_t option_count)
@@ -2520,6 +2531,14 @@ static int team_nl_cmd_options_set(struc
 			if (err)
 				goto team_put;
 			opt_inst->changed = true;
+
+			/* dumb/evil user-space can send us duplicate opt,
+			 * keep only the last one
+			 */
+			if (__team_option_inst_tmp_find(&opt_inst_list,
+							opt_inst))
+				continue;
+
 			list_add(&opt_inst->tmp_list, &opt_inst_list);
 		}
 		if (!opt_found) {

