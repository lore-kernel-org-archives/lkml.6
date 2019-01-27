Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F702C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12A52184B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfA0IoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:44:13 -0500
Received: from mfb01-md.ns.itscom.net ([175.177.155.109]:37902 "EHLO
        mfb01-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfA0IoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 03:44:11 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jan 2019 03:44:10 EST
Received: from mail02-md.ns.itscom.net (mail02-md.ns.itscom.net [175.177.155.112])
        by mfb01-md.ns.itscom.net (Postfix) with ESMTP id 1F8C5238127
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 17:38:15 +0900 (JST)
Received: from scan11-mds.s.noc.itscom.net (scan11-md.ns.itscom.net [175.177.155.5])
        by mail02-md-outgoing.ns.itscom.net (Postfix) with ESMTP id 89A88B00622;
        Sun, 27 Jan 2019 17:38:13 +0900 (JST)
Received: from unknown (HELO mail04-md-outgoing.ns.itscom.net) ([175.177.155.114])
  by scan11-mds.s.noc.itscom.net with ESMTP; 27 Jan 2019 17:38:13 +0900
Received: from jromail.nowhere (h219-110-108-112.catv02.itscom.jp [219.110.108.112])
        by mail04-md-outgoing.ns.itscom.net (Postfix) with ESMTP;
        Sun, 27 Jan 2019 17:38:13 +0900 (JST)
Received: from jro by jrobl id 1gnfxF-0000Xs-4R ; Sun, 27 Jan 2019 17:38:13 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc:     linux-kernel@vger.kernel.org
Subject: fix v5.0-rc1, SUNRPC: init machine_cred.magic under CONFIG_DEBUG_CREDENTIALS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2098.1548578293.1@jrobl>
Date:   Sun, 27 Jan 2019 17:38:13 +0900
Message-ID: <2099.1548578293@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the commit,
a52458b48af1 2018-12-19 NFS/NFSD/SUNRPC: replace generic creds with 'struct cred'.

struct rpc_cred machine_cred was converted to struct cred, but
machine_cred.magic is still uninitialized.  Without initializing it, I
got 'Invalid credentials' error.  It is necessary when
CONFIG_DEBUG_CREDENTIALS is enabled.

CRED: Invalid credentials
CRED: At /proj/aufs/aufs4-linux.git/include/linux/cred.h:253
CRED: Specified credentials: 000000006ca067d8 
CRED: ->magic=0, put_addr=          (null)
CRED: ->usage=1, subscr=0
CRED: ->*uid = { 0,0,0,0 }
CRED: ->*gid = { 0,0,0,0 }
CRED: ->security is           (null)
------------[ cut here ]------------
kernel BUG at /proj/aufs/aufs4-linux.git/kernel/cred.c:825!
invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 24923 Comm: mount.nfs4 Tainted: G        W         5.0.0-rc1aufsD+ #906
Hardware name: Pegatron Pegatron/IPM41, BIOS 0001 02/05/2009
RIP: 0010:__invalid_creds+0x4d/0x60
Code: 44 89 ea 4c 89 e6 48 c7 c7 cf 92 49 82 e8 5e 21 05 00 48 c7 c6 e1 92 49 82 48 89 df 65 48 8b 14 25 80 4e 01 00 e8 23 fe ff ff <0f> 0b 48 c7 c7 00 ac 68 82 e8 25 6a 53 00 0f 1f 44 00 00 66 66 66
RSP: 0018:ffff88810bedf918 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff829016c0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8294c428
RBP: ffff88810bedf930 R08: 0000000000000001 R09: 0000000000000000
R10: ffff88810bedf930 R11: 0000000000000000 R12: ffffffff824964d0
R13: 00000000000000fd R14: ffffffff829016c0 R15: 0000000000000001
FS:  00007f8616b55480(0000) GS:ffff88811ba00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fda79fe7170 CR3: 00000000aca90000 CR4: 00000000000406f0
Call Trace:
 nfs4_discover_server_trunking+0x2cb/0x330
 nfs4_init_client+0x16e/0x210
 ? lockdep_init_map+0x57/0x1d0
 ? rpc_wake_up_task_on_wq_queue_action_locked+0x60/0x60
 ? nfs_get_client+0x500/0x680
 nfs_get_client+0x51d/0x680
 nfs4_set_client+0xb9/0x130
 nfs4_create_server+0x10d/0x290
 nfs4_remote_mount+0x30/0x90
 mount_fs+0x51/0x220
 ? __init_waitqueue_head+0x3b/0x50
 vfs_kern_mount+0x6b/0x190
 ? nfs_do_root_mount+0x3c/0xc0
 nfs_do_root_mount+0x84/0xc0
 nfs4_try_mount+0x37/0x50
 nfs_fs_mount+0x2a1/0xa40
 ? nfs_clone_super+0x80/0x80
 ? nfs_free_parsed_mount_data+0x60/0x60
 mount_fs+0x51/0x220
 ? nfs_alloc_parsed_mount_data+0xd0/0xd0
 ? mount_fs+0x51/0x220
 ? __init_waitqueue_head+0x3b/0x50
 vfs_kern_mount+0x6b/0x190
 ? ns_capable_common+0xc3/0x110
 do_mount+0x220/0xf90
 ksys_mount+0xea/0x170
 __x64_sys_mount+0x25/0x30
 do_syscall_64+0x79/0x360
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Here is a patch.

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 1ff9768f5456..0e5236a3b5e0 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -41,6 +41,9 @@ static unsigned long number_cred_unused;
 
 static struct cred machine_cred = {
 	.usage = ATOMIC_INIT(1),
+#ifdef CONFIG_DEBUG_CREDENTIALS
+	.magic = CRED_MAGIC
+#endif
 };
 
 /*
