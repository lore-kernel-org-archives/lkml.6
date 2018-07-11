Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C30C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8E720878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8E720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeGKJSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:18:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbeGKJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:18:14 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MeBaA-1fRZZv2gqk-00PvCC; Wed, 11 Jul 2018 11:14:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     adilger.kernel@dilger.ca
Cc:     arnd@arndb.de, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com, tytso@mit.edu,
        y2038@lists.linaro.org
Subject: [PATCH v2 3/6] ext4: use ktime_get_real_seconds for i_dtime
Date:   Wed, 11 Jul 2018 11:14:11 +0200
Message-Id: <20180711091414.1494843-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711091414.1494843-1-arnd@arndb.de>
References: <20180711091414.1494843-1-arnd@arndb.de>
X-Provags-ID: V03:K1:aLZZDLe4yh9mM/SxxZyq83TZgByo8/3I999hKbspb10a+AXFU3A
 vKFh9z44EXJwcmC7zLSDiyqiBL67c9CZ7SqDIAG5nbOwcjS0fqtEFsdJmn5ck5ssz40FPEd
 EmZv4J4TZ4LiTuW9RudvUaclouFuj5C7q4HjqodyZt5+JFDbkJV7Yp0I/HpOgOROrSx2zP7
 9HgMNbB9sIF5HfrjX0VXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLJ0P+786jA=:Nz5demrXIadNQ/i7ERRua8
 KKWf+iPFJHwtQH5E4HrAJ078q2cfj4rtDTk2TJGTr3raClkDqz5YVs+3zMhKWsAR2Mixql3Os
 8rvY6RX9yV8vrrUqKnYBNZkDrt34L7UAMPotPdAyv49ky9zn9PbdGIGIF6KuAxIEeO50PeHlX
 8yGyi0sn3OhRxoUzHJWCkIQlaNCBbLnDlmSCGUrOCYqz6L6TESyHBX9K/fUDtGm7gTKNteh8y
 F4jRiwv6jzH0/nameYSOEk6RXo2L42DQosx5SHPVestayI1Jq9LFr/0zi7L6by4UyziAKxNMy
 T7mPCMBhTvEZdTbwvJ5uor7SRs4G+nIprLSDwhWKzNnwhsxUQFQEqAORCRET06QhmhEYiZkri
 CeVeN4YMkccPQEkY4WvOfFpdv1C6y2DQ7fPBgE6tvouQHWlzyIDD5gd+RehB9NQ2ArDLggnfF
 8pHgvhnhwydjzpw0toB6F1ACpya8femVj6gMeqxIYD4+QdxBzeYHuYJqRU1UPpau3mMvF0gMA
 hUsNcz7hLmGmrGMuiCtMF6Hem4FLPSstfGMKC0N9fHf11Ug2Adg0g4sozSWvTG+UZhspUCuml
 MdkkAj7FyL6S0PgKh93/FwKd11BSNFteTX4Z2NdBgszcWu9p7CEa1KemNp5HxgtciG9j4JuPv
 xW8LfLvOu2xYSF8q3G6/2OoBmUVCBx4qjoCy1RbmFB/s27jZOSLmKZilfkNInY/C4lDY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only care about the low 32-bit for i_dtime as explained in commit
b5f515735bea ("ext4: avoid Y2038 overflow in recently_deleted()"), so
the use of get_seconds() is correct here, but that function is getting
removed in the process of the y2038 fixes, so let's use the modern
ktime_get_real_seconds() here.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 74982a9566a9..3b54227cf2b1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -317,7 +317,7 @@ void ext4_evict_inode(struct inode *inode)
 	 * (Well, we could do this if we need to, but heck - it works)
 	 */
 	ext4_orphan_del(handle, inode);
-	EXT4_I(inode)->i_dtime	= get_seconds();
+	EXT4_I(inode)->i_dtime	= (__u32)ktime_get_real_seconds();
 
 	/*
 	 * One subtle ordering requirement: if anything has gone wrong
-- 
2.9.0

