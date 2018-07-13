Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95AAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE92920857
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE92920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbeGMOl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:41:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:41:26 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MIezY-1fbnAJ0zs0-002EOF; Fri, 13 Jul 2018 16:26:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2, RESEND] afs: avoid deprecated get_seconds()
Date:   Fri, 13 Jul 2018 16:25:58 +0200
Message-Id: <20180713142605.3138377-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180713142605.3138377-1-arnd@arndb.de>
References: <20180713142605.3138377-1-arnd@arndb.de>
X-Provags-ID: V03:K1:c+8yXU4aax3dQJwq0+8TczUK4O6i69muQ71Ts1UCt7KlJl8Jnh8
 7W653lb6bux48ik3sNqQePYsjwi4UUDdHHBpFVGFLy9ObA4Wkkx0kG88Wxz8S51b4+0YZ6T
 1fn/YGNnANLqzKvps84cyo8sGTkJhcy76PVENgd8wjUMrOKO6Vv13GFLKbjPBBTHi+3nph0
 8/VIyTxRt8cRB8YzF4LVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GThKXj7mY8g=:X4inrw+7S4hW9fzpDHI9+z
 5Czb3i4fWq0AzdeEFob1lBnGbiguO/8NcGsHa1HJ2A6gcRAhNpM5R2MdKfFviaHyVd9K4fyNh
 n9De/XM27H+2adKSDnWTFfpzz3rwaPrH1zihpTVjvpte/YKJdUJ9Sh6OisFE8Hko5v+LyDs+g
 5qFR7oG3OwfQoh9e9aWbuPMxqjuzr25AVJvwK70ez2skJTLVAFJbH8EvSvc1IeTPdesBBzMii
 A9JNVhZcZflG8fkBzCuGoKjWNHk9PHfBqZu8rxUagNoQxvmTF/k+YGD/WlbVRqQuGkJ7BeAC0
 P8JBeQWJcbgfBt/bu/IhWdCyDQrpDqTvStoECv1509R3Dg/FzW6jvpSZmwXjMUryB4ro0TAGO
 0LgTxvXmNf0Bu8Yk6w50m6VZc3kdsB7pkt8PAeoQJh3g/8VGNJdfVHmxr9wB6s3HHzT+yl/Al
 Av3GS44YJTP0fdKvDoGbGQ6T6f+JGkSMhRbbUtrq6VxdONvYhMy7djXQszC9wMlz5hjBMK1BV
 N3pNIGaneAXcSfwo8o/TQt9LDy+5rLBnEJY3D82wEzrA0iINHS4ZTR36RAb73dQdNnVcizGhz
 kf1rW1FXIqLN1yD/+a1A2PsXcuHsOW9XcJa82/IDCtLLuU1VWRMh/esX66hm7ghWmi9q05oIz
 fyzkeUMyXb/GQAa443S1h8/iGUEwSsDFcFfeNXG2afICYwh85tfJoF9Jrcy7wXKoVNdU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() has a limited range on 32-bit architectures and is
deprecated because of that. While AFS uses the same limits for
its inode timestamps on the wire protocol, let's just use the
simpler current_time() as we do for other file systems.

This will still zero out the 'tv_nsec' field of the timestamps
internally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally submitted this on June 20, but got no reply.
Resending this in case it got lost somewhere on the way.
David, can you pick up both patches?
---
 fs/afs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 479b7fdda124..0507e52e3330 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -213,9 +213,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	set_nlink(inode, 2);
 	inode->i_uid		= GLOBAL_ROOT_UID;
 	inode->i_gid		= GLOBAL_ROOT_GID;
-	inode->i_ctime.tv_sec	= get_seconds();
-	inode->i_ctime.tv_nsec	= 0;
-	inode->i_atime		= inode->i_mtime = inode->i_ctime;
+	inode->i_ctime = inode->i_atime = inode->i_mtime = current_time(inode);
 	inode->i_blocks		= 0;
 	inode_set_iversion_raw(inode, 0);
 	inode->i_generation	= 0;
-- 
2.9.0

