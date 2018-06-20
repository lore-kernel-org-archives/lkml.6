Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140E620836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140E620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeFTOD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:03:29 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbeFTOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:03:26 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MQLgi-1fdIAD33Ma-00Tjr3; Wed, 20 Jun 2018 16:03:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] afs: avoid deprecated get_seconds()
Date:   Wed, 20 Jun 2018 16:02:48 +0200
Message-Id: <20180620140256.19648-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620140256.19648-1-arnd@arndb.de>
References: <20180620140256.19648-1-arnd@arndb.de>
X-Provags-ID: V03:K1:D2IUtNlU4CrLGfQ9M6toTnPD6ki57NCPHLPpcZw06Xzz/SUB0U9
 mO8PzXDtHfd7+nfk/Q1tg2ZpSPBS6IurcWyZvcOBXzwanjORYaVRt7FvExtgrCgV5XBqg+N
 ftburCk2W4UxYFWCzG1M6zlMRM1rKj45PtKrbYJZWnd8loeCh9Ek+EH0FS90GwdAadHFcQ6
 qzhMkXj02VS0ec3rMql5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JX+grlsGGQ8=:UJtIxv8EIx48z7Ab3mGSSm
 w+ls76aguLcDQxbVsDtK6ARTbr7AcgiT48URn2w/sqH+iqCDQJyfttTuHIU6PZKFck0qaCOK7
 v/QklA/Pl7cOo6ZimXsNW11ishgoEJcP99I0c+3eUyQBhXIr+3MjjRp9xZNaIeoRtNOAvlDJZ
 uuYJYCnKhvzKAeiKLOQaN9n2aY6UUxuwxQSAUbQnTlin65HOczk7Wng/bNIfFHZWw1weUXW+U
 viFquiO73zKWN2fBb1szkMdzB4LAdMdOOf9lYt++mOOrAJqBxqzijmdrYaE8HoF4s8SWwKE0+
 QtpBIDwmat8E+EdCR3XGUp0icVDd0177sC5HAUjUBuYX7v0ZIibCCzReB2LTtS0+F8Jl6/dH/
 RidTk0kRxkMgaUL3fUvcFYDL06RCDTUdcuT0dVHE1+IXLqSwJU/iG2D+k+Of9vIVxBhXfYeZI
 QHpruAZ6t4U49Kae5tpAhp5q158HF6gDNgxBoNediS4P6GZDuh1hBFzTAA+I5pFGKc/r9BYVa
 VIoCpThFJvT9twhfEZG6R+5xRK/ITrZvZuBoMlvg5dVWE/ey6UVVPVkqMV4zMOSsZgDrSw6n4
 G0CTt4mJvF53uNJNMc8pcNEFOVcvyw3rwRV5HCvmGihzq80KNFDPwykolVAzru+0n6uBW7ywB
 ciiWzq7G3PF75J1mQUJGObbSrFRb1sa4p3FSo3clmrp0XwLKcT9lb3au8/d9MkWWbp+Y=
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

