Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0822DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD065214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD065214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933546AbeFUQFb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:05:31 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:05:30 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LisgQ-1g3Qoi3fvq-00dHDB; Thu, 21 Jun 2018 18:04:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Omar Sandoval <osandov@fb.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Liu Bo <bo.li.liu@oracle.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] btrfs: use timespec64 for i_otime
Date:   Thu, 21 Jun 2018 18:04:06 +0200
Message-Id: <20180621160420.139575-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180621160420.139575-1-arnd@arndb.de>
References: <20180621160420.139575-1-arnd@arndb.de>
X-Provags-ID: V03:K1:RPgmPI+oan5jG1gT9SLeDop9/LIgYHtQ9KYDsB1h1xaXWr8yp+c
 UaRWIZaiAUYks/IzZQ2BElAmtovyESS51Ui70vyZCk2MC90+TyieZm0kumPseEBiTeedEnq
 wknVgZsp2V5jeKukODUKXU2SVLiikKPrzO2sbeLyrrM1PU7CgR2RWvoqLXGNsaxQYSzaepE
 x+KjxBB10jNtnjVctOeHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HvGdXofP5Ik=:qas8yQWowTx6fRhINj6fcy
 1wY9ruIx828wnFAslGJDAv3EwKQe896Xee1ekIr5dGISdxVQQ02ztrV1f/Xdq2JWyfNjRI41K
 3qVaIPwd9dMgA0XEPTNtKC7xGwoc/Jfkq4xjAZDEsxDVvVYhzZcnBcdXhaQC9R9ZA0N0Elh0Q
 reTl7f/BbQ+HCcApZQ4pwIwrAM4HWEXtjSuiFHIuLetR+KOcHgSoQ4AyosrRqBFqWQLJafIbt
 Gps7utt86fuUqkaT1ki4NUqKv9yCNwLCgExyJ7MApczXxhvxzEVnmbpNvB/ck7rWo3xFAwRhK
 N8AAUWdAnLiOb0XuVsnp/uNTpMJp8GcezbeGHLLkHPiD2WWcSG6iFzXSQ1fAUArjkdpjWVUDG
 pqwFIDDtLhuLSCifANN7WC3cRLQSQbCScNK00FqnVy7bdGeEEIifISMh7DxNJwilf0UgvbBJc
 3tWDDd+94RjXJQh68W4EXp7CYE4djY4N8pnd4qhqAlM2ago/R4b8LcISuj5ibuW3ksIYo8oY1
 9C9mb/rbBYUmByi/fglY3vnXLIA8+AgRjVG8i5ZQiA58nJzyuVHj9ms9XfmxHFmYavyBt9IDN
 OG12DLifaYNmZdCKcQtkA+faWOhKiU3/yP99bRQufTAK7WSIUhq5MiJxY3P3piVTrgpJB22mr
 CtSI+j3Jv7zRM9FR1akCV3CsUoD4NsIPWodVWMsrC8NvReoICkXhZcJptP16M/4mMC2k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the regular inode timestamps all use timespec64 now, the
i_otime field is btrfs specific and still needs to be converted
to correctly represent times beyond 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: no changes
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

