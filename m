Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414809-2-11790779188509070541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414809; b=Ou+eadQdJ3KuxX8l/k0NLDXBkssGCJNDQQuZDX4zL2IvHZy
    JTye00Rn3JRwNOpfyC/aItLkcOSuML8NsOTPdGj/tesPU7dpE4J9lai1s9+a9HxF
    /+gdkqY2zx6WjMFYKEy4Dpqm1FUKpaY/0wSUMt9hW2mnOo9N5UKbaYq2WBOlb+Ul
    tyxipdHsBE2KGM3XTnBooOsO7H/XpJjSSFq/+tFIcQwLn0I4ViKRX70i8QpDgyhd
    A+koW+J7k+2zYtv9ltz5PyJzBTdrkixxevSzT7cqZgiCTfYaXFyilEcnX1YRHpNs
    Ow+8ptBYLeVKBGOd1JqlPtNoTZEdoM2iE1Sd8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414809; bh=SmUtSAK2axQZN/UTHVX4V2Oa2g
    CR0rqcMXvaum4K+fI=; b=tkCOC7vDVbENGA3YnuQczkV3K3tEcRwsXbYT3q8gzC
    LpHk5dVJb/l0HLfBugzbfZz3d5ws7LyQY1wBhMPeEOqw38jVg6gCtyTacVRIVCso
    Jcl6G5zHOghhxRk7Qp855x3LuDi1NmIf7ab8wqttHcpYbPIqAMRTRYL9u2LP2Dxd
    aMRoLyRrHsNRQOgm7znZIsUDl38ib8hWHmSADg6KVc+dGzeYdGcfPOFg9i7+vtxJ
    d4Bg0fZDGtU4O9LjZ6BRa/37y2UW4+XIV8jpodCmqKDCphk4TnzXEK8JBJlA43vq
    8kSxlfFxSxBj2bcCYwfVbUTf18nZWDSxABG8lfnp3aAA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeBWSth (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbeBWStf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 014/159] RDMA/netlink: Fix general protection fault
Date: Fri, 23 Feb 2018 19:25:22 +0100
Message-Id: <20180223170744.963001285@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit d0e312fe3d34c1bc014a7f8ec6540d05e8077483 upstream.

The RDMA netlink core code checks validity of messages by ensuring
that type and operand are in range. It works well for almost all
clients except NLDEV, which has cb_table less than number of operands.

Request to access such operand will trigger the following kernel panic.

This patch updates all places where cb_table is declared for the
consistency, but only NLDEV is actually need it.

general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
Modules linked in:
CPU: 0 PID: 522 Comm: syz-executor6 Not tainted 4.13.0+ #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
task: ffff8800657799c0 task.stack: ffff8800695d000
RIP: 0010:rdma_nl_rcv_msg+0x13a/0x4c0
RSP: 0018:ffff8800695d7838 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 1ffff1000d2baf0b RCX: 00000000704ff4d7
RDX: 0000000000000000 RSI: ffffffff81ddb03c RDI: 00000003827fa6bc
RBP: ffff8800695d7900 R08: ffffffff82ec0578 R09: 0000000000000000
R10: ffff8800695d7900 R11: 0000000000000001 R12: 000000000000001c
R13: ffff880069d31e00 R14: 00000000ffffffff R15: ffff880069d357c0
FS:  00007fee6acb8700(0000) GS:ffff88006ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000201a9000 CR3: 0000000059766000 CR4: 00000000000006b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ? rdma_nl_multicast+0x80/0x80
 rdma_nl_rcv+0x36b/0x4d0
 ? ibnl_put_attr+0xc0/0xc0
 netlink_unicast+0x4bd/0x6d0
 ? netlink_sendskb+0x50/0x50
 ? drop_futex_key_refs.isra.4+0x68/0xb0
 netlink_sendmsg+0x9ab/0xbd0
 ? nlmsg_notify+0x140/0x140
 ? wake_up_q+0xa1/0xf0
 ? drop_futex_key_refs.isra.4+0x68/0xb0
 sock_sendmsg+0x88/0xd0
 sock_write_iter+0x228/0x3c0
 ? sock_sendmsg+0xd0/0xd0
 ? do_futex+0x3e5/0xb20
 ? iov_iter_init+0xaf/0x1d0
 __vfs_write+0x46e/0x640
 ? sched_clock_cpu+0x1b/0x190
 ? __vfs_read+0x620/0x620
 ? __fget+0x23a/0x390
 ? rw_verify_area+0xca/0x290
 vfs_write+0x192/0x490
 SyS_write+0xde/0x1c0
 ? SyS_read+0x1c0/0x1c0
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 entry_SYSCALL_64_fastpath+0x18/0xad
RIP: 0033:0x7fee6a74a219
RSP: 002b:00007fee6acb7d58 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000638000 RCX: 00007fee6a74a219
RDX: 0000000000000078 RSI: 0000000020141000 RDI: 0000000000000006
RBP: 0000000000000046 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: ffff8800695d7f98
R13: 0000000020141000 R14: 0000000000000006 R15: 00000000ffffffff
Code: d6 48 b8 00 00 00 00 00 fc ff df 66 41 81 e4 ff 03 44 8d 72 ff 4a 8d 3c b5 c0 a6 7f 82 44 89 b5 4c ff ff ff 48 89 f9 48 c1 e9 03 <0f> b6 0c 01 48 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85
RIP: rdma_nl_rcv_msg+0x13a/0x4c0 RSP: ffff8800695d7838
---[ end trace ba085d123959c8ec ]---
Kernel panic - not syncing: Fatal exception

Cc: syzkaller <syzkaller@googlegroups.com>
Fixes: b4c598a67ea1 ("RDMA/netlink: Implement nldev device dumpit calback")
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Doug Ledford <dledford@redhat.com>

---
 drivers/infiniband/core/cma.c    |    2 +-
 drivers/infiniband/core/device.c |    2 +-
 drivers/infiniband/core/iwcm.c   |    2 +-
 drivers/infiniband/core/nldev.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4461,7 +4461,7 @@ out:
 	return skb->len;
 }
 
-static const struct rdma_nl_cbs cma_cb_table[] = {
+static const struct rdma_nl_cbs cma_cb_table[RDMA_NL_RDMA_CM_NUM_OPS] = {
 	[RDMA_NL_RDMA_CM_ID_STATS] = { .dump = cma_get_id_stats},
 };
 
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1154,7 +1154,7 @@ struct net_device *ib_get_net_dev_by_par
 }
 EXPORT_SYMBOL(ib_get_net_dev_by_params);
 
-static const struct rdma_nl_cbs ibnl_ls_cb_table[] = {
+static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 	[RDMA_NL_LS_OP_RESOLVE] = {
 		.doit = ib_nl_handle_resolve_resp,
 		.flags = RDMA_NL_ADMIN_PERM,
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -80,7 +80,7 @@ const char *__attribute_const__ iwcm_rej
 }
 EXPORT_SYMBOL(iwcm_reject_msg);
 
-static struct rdma_nl_cbs iwcm_nl_cb_table[] = {
+static struct rdma_nl_cbs iwcm_nl_cb_table[RDMA_NL_IWPM_NUM_OPS] = {
 	[RDMA_NL_IWPM_REG_PID] = {.dump = iwpm_register_pid_cb},
 	[RDMA_NL_IWPM_ADD_MAPPING] = {.dump = iwpm_add_mapping_cb},
 	[RDMA_NL_IWPM_QUERY_MAPPING] = {.dump = iwpm_add_and_query_mapping_cb},
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -303,7 +303,7 @@ out:	cb->args[0] = idx;
 	return skb->len;
 }
 
-static const struct rdma_nl_cbs nldev_cb_table[] = {
+static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
 		.dump = nldev_get_dumpit,
