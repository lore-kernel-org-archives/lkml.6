Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70774ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAC42146E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpbO50yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAC42146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbeKIHnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbeKIHnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:50 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EC22146E;
        Thu,  8 Nov 2018 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714779;
        bh=AU15TOOf8iR08SCNCUmN70/yPyEgcn4qqpg3GJx9Vp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpbO50ybHo4Koq1PX9VQ6aX4Zioz68SRIoyvtm58e1fxFmf+wmRYIv5ZyJxHHD9vu
         rVSfCF9nj9vTqEpjznAy1nJMquG2s1IZWbBUds8tYh8rVAH20BhlsrjArmKVLR3z+q
         nno8KGMJL8XBmOxEWEd4gsqwFBibhUN5bTBJAcY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 103/171] Btrfs: incremental send, fix invalid memory access
Date:   Thu,  8 Nov 2018 13:51:13 -0800
Message-Id: <20181108215134.874496427@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 24e52b11e0ca788513b945a87b57cc0522a92933 ]

When doing an incremental send, while processing an extent that changed
between the parent and send snapshots and that extent was an inline extent
in the parent snapshot, it's possible to access a memory region beyond
the end of leaf if the inline extent is very small and it is the first
item in a leaf.

An example scenario is described below.

The send snapshot has the following leaf:

 leaf 33865728 items 33 free space 773 generation 46 owner 5
 fs uuid ab7090d8-dafd-4fb9-9246-723b6d2e2fb7
 chunk uuid 2d16478c-c704-4ab9-b574-68bff2281b1f
        (...)
        item 14 key (335 EXTENT_DATA 0) itemoff 3052 itemsize 53
                generation 36 type 1 (regular)
                extent data disk byte 12791808 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 15 key (335 EXTENT_DATA 8192) itemoff 2999 itemsize 53
                generation 36 type 1 (regular)
                extent data disk byte 138170368 nr 225280
                extent data offset 0 nr 225280 ram 225280
                extent compression 0 (none)
        (...)

And the parent snapshot has the following leaf:

 leaf 31272960 items 17 free space 17 generation 31 owner 5
 fs uuid ab7090d8-dafd-4fb9-9246-723b6d2e2fb7
 chunk uuid 2d16478c-c704-4ab9-b574-68bff2281b1f
        item 0 key (335 EXTENT_DATA 0) itemoff 3951 itemsize 44
                generation 31 type 0 (inline)
                inline extent data size 23 ram_bytes 613 compression 1 (zlib)
        (...)

When computing the send stream, it is detected that the extent of inode
335, at file offset 0, and at fs/btrfs/send.c:is_extent_unchanged() we
grab the leaf from the parent snapshot and access the inline extent item.
However, before jumping to the 'out' label, we access the 'offset' and
'disk_bytenr' fields of the extent item, which should not be done for
inline extents since the inlined data starts at the offset of the
'disk_bytenr' field and can be very small. For example accessing the
'offset' field of the file extent item results in the following trace:

[  599.705368] general protection fault: 0000 [#1] PREEMPT SMP
[  599.706296] Modules linked in: btrfs psmouse i2c_piix4 ppdev acpi_cpufreq serio_raw parport_pc i2c_core evdev tpm_tis tpm_tis_core sg pcspkr parport tpm button su$
[  599.709340] CPU: 7 PID: 5283 Comm: btrfs Not tainted 4.10.0-rc8-btrfs-next-46+ #1
[  599.709340] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
[  599.709340] task: ffff88023eedd040 task.stack: ffffc90006658000
[  599.709340] RIP: 0010:read_extent_buffer+0xdb/0xf4 [btrfs]
[  599.709340] RSP: 0018:ffffc9000665ba00 EFLAGS: 00010286
[  599.709340] RAX: db73880000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  599.709340] RDX: ffffc9000665ba60 RSI: db73880000000000 RDI: ffffc9000665ba5f
[  599.709340] RBP: ffffc9000665ba30 R08: 0000000000000001 R09: ffff88020dc5e098
[  599.709340] R10: 0000000000001000 R11: 0000160000000000 R12: 6db6db6db6db6db7
[  599.709340] R13: ffff880000000000 R14: 0000000000000000 R15: ffff88020dc5e088
[  599.709340] FS:  00007f519555a8c0(0000) GS:ffff88023f3c0000(0000) knlGS:0000000000000000
[  599.709340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  599.709340] CR2: 00007f1411afd000 CR3: 0000000235f8e000 CR4: 00000000000006e0
[  599.709340] Call Trace:
[  599.709340]  btrfs_get_token_64+0x93/0xce [btrfs]
[  599.709340]  ? printk+0x48/0x50
[  599.709340]  btrfs_get_64+0xb/0xd [btrfs]
[  599.709340]  process_extent+0x3a1/0x1106 [btrfs]
[  599.709340]  ? btree_read_extent_buffer_pages+0x5/0xef [btrfs]
[  599.709340]  changed_cb+0xb03/0xb3d [btrfs]
[  599.709340]  ? btrfs_get_token_32+0x7a/0xcc [btrfs]
[  599.709340]  btrfs_compare_trees+0x432/0x53d [btrfs]
[  599.709340]  ? process_extent+0x1106/0x1106 [btrfs]
[  599.709340]  btrfs_ioctl_send+0x960/0xe26 [btrfs]
[  599.709340]  btrfs_ioctl+0x181b/0x1fed [btrfs]
[  599.709340]  ? trace_hardirqs_on_caller+0x150/0x1ac
[  599.709340]  vfs_ioctl+0x21/0x38
[  599.709340]  ? vfs_ioctl+0x21/0x38
[  599.709340]  do_vfs_ioctl+0x611/0x645
[  599.709340]  ? rcu_read_unlock+0x5b/0x5d
[  599.709340]  ? __fget+0x6d/0x79
[  599.709340]  SyS_ioctl+0x57/0x7b
[  599.709340]  entry_SYSCALL_64_fastpath+0x18/0xad
[  599.709340] RIP: 0033:0x7f51945eec47
[  599.709340] RSP: 002b:00007ffc21c13e98 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  599.709340] RAX: ffffffffffffffda RBX: ffffffff81096459 RCX: 00007f51945eec47
[  599.709340] RDX: 00007ffc21c13f20 RSI: 0000000040489426 RDI: 0000000000000004
[  599.709340] RBP: ffffc9000665bf98 R08: 00007f519450d700 R09: 00007f519450d700
[  599.709340] R10: 00007f519450d9d0 R11: 0000000000000202 R12: 0000000000000046
[  599.709340] R13: ffffc9000665bf78 R14: 0000000000000000 R15: 00007f5195574040
[  599.709340]  ? trace_hardirqs_off_caller+0x43/0xb1
[  599.709340] Code: 29 f0 49 39 d8 4c 0f 47 c3 49 03 81 58 01 00 00 44 89 c1 4c 01 c2 4c 29 c3 48 c1 f8 03 49 0f af c4 48 c1 e0 0c 4c 01 e8 48 01 c6 <f3> a4 31 f6 4$
[  599.709340] RIP: read_extent_buffer+0xdb/0xf4 [btrfs] RSP: ffffc9000665ba00
[  599.762057] ---[ end trace fe00d7af61b9f49e ]---

This is because the 'offset' field starts at an offset of 37 bytes
(offsetof(struct btrfs_file_extent_item, offset)), has a length of 8
bytes and therefore attemping to read it causes a 1 byte access beyond
the end of the leaf, as the first item's content in a leaf is located
at the tail of the leaf, the item size is 44 bytes and the offset of
that field plus its length (37 + 8 = 45) goes beyond the item's size
by 1 byte.

So fix this by accessing the 'offset' and 'disk_bytenr' fields after
jumping to the 'out' label if we are processing an inline extent. We
move the reading operation of the 'disk_bytenr' field too because we
have the same problem as for the 'offset' field explained above when
the inline data is less then 8 bytes. The access to the 'generation'
field is also moved but just for the sake of grouping access to all
the fields.

Fixes: e1cbfd7bf6da ("Btrfs: send, fix file hole not being preserved due to inline extent")
Cc: <stable@vger.kernel.org>  # v4.12+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c8d2eec6596b..79dc3ee1de58 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5165,15 +5165,12 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 			goto out;
 		}
 
-		right_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
 		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
 			right_len = btrfs_file_extent_inline_len(eb, slot, ei);
 			right_len = PAGE_ALIGN(right_len);
 		} else {
 			right_len = btrfs_file_extent_num_bytes(eb, ei);
 		}
-		right_offset = btrfs_file_extent_offset(eb, ei);
-		right_gen = btrfs_file_extent_generation(eb, ei);
 
 		/*
 		 * Are we at extent 8? If yes, we know the extent is changed.
@@ -5198,6 +5195,10 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 			goto out;
 		}
 
+		right_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
+		right_offset = btrfs_file_extent_offset(eb, ei);
+		right_gen = btrfs_file_extent_generation(eb, ei);
+
 		left_offset_fixed = left_offset;
 		if (key.offset < ekey->offset) {
 			/* Fix the right offset for 2a and 7. */
-- 
2.17.1



