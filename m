Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3969208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3969208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFTOf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:35:59 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57985 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeFTOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:35:58 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MgI6w-1fs8dU01YM-00Ng8S; Wed, 20 Jun 2018 16:35:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Omar Sandoval <osandov@fb.com>, Liu Bo <bo.li.liu@oracle.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use timespec64 for i_otime
Date:   Wed, 20 Jun 2018 16:34:34 +0200
Message-Id: <20180620143448.44388-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620143448.44388-1-arnd@arndb.de>
References: <20180620143448.44388-1-arnd@arndb.de>
X-Provags-ID: V03:K1:64ae6ej6GWDaggWWkac+lHArkwY6qkKHJYloNUh0uQoskF5Sy9d
 PZtYjHqS5RdsWDG1vADqfPLQi0dbEYcH2Z0/FeKvLx0ubpjSE3LVBungbhI1INYBaTlAHRA
 aW4gU8WEKHEdUcp8isDxNTCOQ1O+V+3BBJNE0N58wv8rG9HTQNKQpuirUMdbOW+RaHVgaKa
 7PPL2VD7C125eoKtNhkOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MH9aXRGwem0=:Gpxc20+tA3ANirFW1kpcLT
 racVDbqcZfdsq6Fo9GRqH1X4466q9qJRnyQHDKc+DAQpoGgpEdiaEeWM7ZXlB9i3SieXAvMAU
 cQiuQofIXJhN1faaANTEkt57OlFv1hQWxWtiW80QmWFY4MpkynG3QkuHXFxlvKcHX/zOj1eaB
 JOvSZFDv04Pi52D34HI4uafWK1bIQbcX9litevOJlTFr/5FtxNb0lxAWp7fQiEa3UexTdxOf/
 QxUqK0u1aRFak7nixQ8PZ53Xhhx/DherDjZqgfNFS5VPZr3o/GSejhfj+YIooTVpHrZkrnxgW
 mASiAsmv502XfzSGMR+kHp3olZwRmgB2VzQoNgI0XvCh5qOmN01Ljwn9jTQv+srAb/WeKGp4J
 iF7tjsdpPvphZuv6TOAC3CjaCQSdr2oLkqpyDP+dHXcRrYAwH0uan0+bK0eWX1c9NvVTOpTgd
 Xm/2x9vVCwOQSV7HFwc0gjSs6bqYBHaEgitMsrZq8yuA5xyjuLC7BeU99utZ09bLnKmWtaI4h
 6jVdDl4QihWJHZw9Fe/aeGgkwoBlzSuJ3QigvXTWFbY5KXPSwa6LpF0rhDU06Emw7ZhxCPN2g
 kkl2zwKT8AALNwBoqZGpuCxROcv3YXB/Z3ibErqNxjzAQyoBLNGTXSGq2apJroQjBjKEkhfD9
 cULHRfzcJ7xqrm7sJywvS3a/7UT0wJWWgXyPbx+R0AqbLHUfH6CqbRY8cWLm1yxygavs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the regular inode timestamps all use timespec64 now, the
i_otime field is btrfs specific and still needs to be converted
to correctly represent times beyond 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/btrfs_inode.h | 2 +-
 fs/btrfs/inode.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 7e075343daa5..1343ac57b438 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -178,7 +178,7 @@ struct btrfs_inode {
 	struct btrfs_delayed_node *delayed_node;
 
 	/* File creation time. */
-	struct timespec i_otime;
+	struct timespec64 i_otime;
 
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e9482f0db9d0..22dcc8afd38f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5745,7 +5745,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
-	BTRFS_I(inode)->i_otime = timespec64_to_timespec(inode->i_mtime);
+	BTRFS_I(inode)->i_otime = inode->i_mtime;
 
 	return inode;
 }
@@ -6349,7 +6349,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
-	BTRFS_I(inode)->i_otime = timespec64_to_timespec(inode->i_mtime);
+	BTRFS_I(inode)->i_otime = inode->i_mtime;
 
 	inode_item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				  struct btrfs_inode_item);
-- 
2.9.0

