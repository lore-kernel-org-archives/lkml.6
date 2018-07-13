Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C901ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156C820878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156C820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeGMOuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:50:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeGMOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:50:52 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LlJ1m-1gEhYn1QoA-00b2Gh; Fri, 13 Jul 2018 16:35:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] fuse: convert last timespec use to timespec64
Date:   Fri, 13 Jul 2018 16:35:10 +0200
Message-Id: <20180713143525.3144656-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:DtEqYo1dxnIUnZudwm3AASOcqYHAkIb1TcSiQINfz6k6Fkkrb2l
 KoWinwheLBaqlKGr+2nn4SOeBXV6S7KEcbC6JJMGne3GHpBFrsV459EC2CBGIbw1jyy4YVJ
 eNLz7p2FSKTkrQpnEgrwz12UMbJCvUkJ53OU6OpaTd9l8X4wswHda7fSl9klWIGPIN9imhw
 EqZG+TUf0ZFWYJL2G96tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J77Jj9/zJME=:wlDR2P2mdnG1ve45aNOGjd
 FenpoM4kc40iQB1qp0+1PrxWVmP4zoW6lfhzoSG8czHXdk5d5lgvU80xa1L+zIjWkwKG6agOs
 3BKux27SGNHLd8cnehZsQgr3EIyyuIQFKVirXDyxctnDyau5xAoEPHxK9/fQ7QOP/SSUx8nbr
 EVBcBNRwhv0jV3pDSnl9D5VVpdqkbqbDjkbb/Nftm4Yy6SpkmW5ZruqIcQXny94QGQdSu6RYs
 0mErfW5jeNOuRNuebehzOSU8uLzc3V6gtJI8y6Oeq6k+wP7htbwfKBwBTa4GMLrBy5+6g1dC/
 JHUJtl/ZEoqLnLfTHEiyOYxNn18AnyUYDjEC6fZKRhhKzI2EBPGCCIgnGuElcS394Wqh7NcZ7
 hfKdYXf94MX5BXMWlj+pJz/FJhph1GndQkAG6dBrXP5E+ALAtekDkMFu09/h/0sNcTVX/Bi9M
 jtz0oiMYJ74L6slbrAUxlYlOG856QeMFxAroru3A1d4Q43kaxZSAfy6/hzA3HlTAoAj1keR7G
 9WS6u3WzcI8/3Pi7h9ZBXIlbKsUwVpjFBeBNzqIkUUAFEh5w6aHjFIQwPGYFYMLhIzKeBZPM3
 cGgkItZen8hkEU46eJnBoRRZNEBuVUfSjgg8nnPZn0XcBRzi6IX5RS9nzkuh8N1OQOGcQy1lK
 TkMEf6/mwaTJHHcb8y47OtJ0IyaQPro1+QyLmfZNYlAMM51HJCsURCFF/SYUzExDXQKM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of fuse uses 64-bit timestamps with the exception of the
fuse_change_attributes(), so let's convert this one as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I submitted this on June 20 but got no reply. Miklos, could
you pick this up for 4.19?
---
 fs/fuse/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 85b3954945af..f6f46bb5ef4b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -209,7 +209,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	bool is_wb = fc->writeback_cache;
 	loff_t oldsize;
-	struct timespec old_mtime;
+	struct timespec64 old_mtime;
 
 	spin_lock(&fc->lock);
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
@@ -218,7 +218,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		return;
 	}
 
-	old_mtime = timespec64_to_timespec(inode->i_mtime);
+	old_mtime = inode->i_mtime;
 	fuse_change_attributes_common(inode, attr, attr_valid);
 
 	oldsize = inode->i_size;
@@ -238,7 +238,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			truncate_pagecache(inode, attr->size);
 			inval = true;
 		} else if (fc->auto_inval_data) {
-			struct timespec new_mtime = {
+			struct timespec64 new_mtime = {
 				.tv_sec = attr->mtime,
 				.tv_nsec = attr->mtimensec,
 			};
@@ -247,7 +247,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			 * Auto inval mode also checks and invalidates if mtime
 			 * has changed.
 			 */
-			if (!timespec_equal(&old_mtime, &new_mtime))
+			if (!timespec64_equal(&old_mtime, &new_mtime))
 				inval = true;
 		}
 
-- 
2.9.0

