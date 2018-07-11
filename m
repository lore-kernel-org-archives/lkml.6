Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CBC20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CBC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeGKJSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:18:17 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeGKJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:18:15 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M8iRY-1fn6qE0aZY-00C9q6; Wed, 11 Jul 2018 11:14:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     adilger.kernel@dilger.ca
Cc:     arnd@arndb.de, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com, tytso@mit.edu,
        y2038@lists.linaro.org
Subject: [PATCH v2 4/6] ext4: use timespec64 for all inode times
Date:   Wed, 11 Jul 2018 11:14:12 +0200
Message-Id: <20180711091414.1494843-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711091414.1494843-1-arnd@arndb.de>
References: <20180711091414.1494843-1-arnd@arndb.de>
X-Provags-ID: V03:K1:btygqJY5XDy41W3h5gSj0JmWcqxhEd25Q38kiD0YBSTilUYitYq
 /EnuPJjMSqpEx98oUYKuOzgt2pvmFCDHM6wVD0XyV7bjaAlP4vGVqMwqwfrMp9gTkHDxzGN
 0COqNN+PY3FTCbmlpDvCwWdvlusZ2Fxrj5vlvGPb0TkFdkJhQqVzOKhFdoeUdzvxnCwcuLv
 HjYPGXFwWPJ14psvLL7zQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+nsWJ4ZGs08=:GzMwSZOYFjGKKTG3q/atyy
 e5I0mCzh/UYJua4yYZRIoMiPZFSDJlyOCMn+vfkW1UTqVkG7tye+XazCE+Y1dDzqC/CqHAYoD
 ebbYYmCSSqts+1Scyndu57IFKk5cF9GjBS7yiTtK7yWzE3dYjBevZ8yTfNXdhhrIqTTatDqxg
 YXI2oDAXFyNcWmpz8KMYHJ4KA4fBrCC//AS+EKGcRK4rU5AaAzdGipwh6EuovXU7onh02Bmhc
 JulK7zvFXRhtO9CK52vDKLOiqBq3dY/BbvZojIy7/kJADevFNJkIBlMFktEdjSzB/WQMOT94p
 PUi9jI7Pa5Q2JiN4+kydnCOa1yJM1aQn3fQJmWmbuxLXmIAUL0hhCPf2e3cuyaE3Yk/26NpZb
 XXoqmuVCvs+wPzWCrzUuZrZQhasRYvZ/OLd1xV24YQZdeW+2kQYN8FBvfjxq3f6eqBRfti9ZO
 bzmK1dwUKNKPl6hCh2Ps8BbcFI4WGmzQ7SpS1ctyJ89lv+pNCaUpw2XdpG6/GRZGqPasE05GD
 KwnBrsmXPGuIC4QmhCdsJdA35Tbc1Dz1P8IljqVwvoemOOcCA0p28Mi3ffBadADDGbSDy0V3L
 uU5Of2UuIlSEQ6R9EZ5iMqVLuG6Y0ETlZBeiXWXHTCCYlCmplNJ2FLemRt12C7k4K597jIDTB
 93UebVOvzlNwxRmdVXkArkbxJTxFa3rWrKpO84OR0Qe9akoHs7A613wgc++8RqGOf99M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last missing piece for the inode times on 32-bit systems:
now that VFS interfaces use timespec64, we just need to stop truncating
the tv_sec values for y2038 compatibililty.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/ext4.h   | 22 +++++++++-------------
 fs/ext4/ialloc.c |  2 +-
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d79d1a54a27e..f71ccafe8f9f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -789,17 +789,16 @@ struct move_extent {
  * affected filesystem before 2242.
  */
 
-static inline __le32 ext4_encode_extra_time(struct timespec *time)
+static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
 {
-	u32 extra = sizeof(time->tv_sec) > 4 ?
-		((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK : 0;
+	u32 extra =((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK;
 	return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
 }
 
-static inline void ext4_decode_extra_time(struct timespec *time, __le32 extra)
+static inline void ext4_decode_extra_time(struct timespec64 *time,
+					  __le32 extra)
 {
-	if (unlikely(sizeof(time->tv_sec) > 4 &&
-			(extra & cpu_to_le32(EXT4_EPOCH_MASK)))) {
+	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK))) {
 
 #if 1
 		/* Handle legacy encoding of pre-1970 dates with epoch
@@ -821,9 +820,8 @@ static inline void ext4_decode_extra_time(struct timespec *time, __le32 extra)
 do {										\
 	(raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);		\
 	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     {\
-		struct timespec ts = timespec64_to_timespec((inode)->xtime);	\
 		(raw_inode)->xtime ## _extra =					\
-				ext4_encode_extra_time(&ts);			\
+				ext4_encode_extra_time(&(inode)->xtime);	\
 		}								\
 } while (0)
 
@@ -840,10 +838,8 @@ do {									       \
 do {										\
 	(inode)->xtime.tv_sec = (signed)le32_to_cpu((raw_inode)->xtime);	\
 	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra)) {	\
-		struct timespec ts = timespec64_to_timespec((inode)->xtime);	\
-		ext4_decode_extra_time(&ts,					\
+		ext4_decode_extra_time(&(inode)->xtime,				\
 				       raw_inode->xtime ## _extra);		\
-		(inode)->xtime = timespec_to_timespec64(ts);			\
 		}								\
 	else									\
 		(inode)->xtime.tv_nsec = 0;					\
@@ -993,9 +989,9 @@ struct ext4_inode_info {
 
 	/*
 	 * File creation time. Its function is same as that of
-	 * struct timespec i_{a,c,m}time in the generic inode.
+	 * struct timespec64 i_{a,c,m}time in the generic inode.
 	 */
-	struct timespec i_crtime;
+	struct timespec64 i_crtime;
 
 	/* mballoc */
 	struct list_head i_prealloc_list;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index fb83750c1a14..18c37c43751c 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1083,7 +1083,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-	ei->i_crtime = timespec64_to_timespec(inode->i_mtime);
+	ei->i_crtime = inode->i_mtime;
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_dir_start_lookup = 0;
-- 
2.9.0

