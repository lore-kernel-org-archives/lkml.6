Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC681C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0532208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0532208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeFTPee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:34:34 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbeFTPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:34:31 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MOXED-1fbQHW3kUn-005r4c; Wed, 20 Jun 2018 17:34:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>
Cc:     y2038@lists.linaro.org, linux-ext4@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ext4: use timespec64 for all inode times
Date:   Wed, 20 Jun 2018 17:33:01 +0200
Message-Id: <20180620153322.54221-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180620153322.54221-1-arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
X-Provags-ID: V03:K1:OxfsEwd2qoEFU1YiFJomABpL6ZKFyn6XFKTmU1bZQlLXyf/3lVk
 UpGhjkg6CSa/q1vxQR9zq8/6TVZVcJPeTTRh0L0E7bLnnqCPsTaxisnSTQK+L82IrxQzMOi
 88/wwsC3qYe18JC2JehKlWxWmUkcIn9hPqCBJxB9gKHnzb3KUS/fKhga5Hrnf6yWCo7UcNm
 2gfiYGILzG7umwVw+ihPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h6bulAq365Q=:eBQxlXffo/nv9AGeA2/Jn7
 ul4792VEyBkvEfoY4ZWdDCg7tJsZZ8CMRvq1B0kdpBzmFlnUu8oUft/qbvJ0pJRon4EJGtE3r
 mpzWI6+GsBHqtlNBUlHXJs1BfqPsvP5uSMYTw0x031qu83ERWexKa9iEioolcGYFodYg2ZCbI
 EbvANqpxx389zlNTLBuuxcsjADmKTrwob+OxVH8S5pqcPvu94Zw2rtP9e6AV/fcxl7Q1FQArq
 3QgWdJQeqnrAQsGShOvmA/mKrSir1UaDIEhG5fhd5O64CY+oGRI9FijN9mfUF9b7kYMwPVKc7
 Yco8cDJY2lnPkIFzj6O9H4pshNywRxywdcJfM8eC4OYxhUlECjzDhYiMgZhXTq1cSSZSsmV92
 INOoiYI1VbYKkPrtG46J8Fh0cnTIRPM0MCEsZMTJXfBMqleH80MTbHJJjxsmwxHX8LRBovym2
 q3f0fJBX8UbQHnI2IZ8nGegd/ufJGecWZlEnLcgU4KhWCY/IPBwSkGrMZOjGJdVxn7Fhnly2Q
 EJiC2CzhfegvHu2Iolgu59EmorIaoCcpngJ9GPIfc3bHbZFOynYfRIQK9kbhaVJUKSJBTJrxv
 VVhlEpwfPECwdQbqS1MX4uUfXhrm22ifAPYCbOAhuU8ExsYmUZ1U4He+TYA0NmcEC8t1Ci/KE
 NL0gWlOk4I2WWqBq7qxbGR1cnHKU6wLSt5h2bx73l0Im2A0YLkltDSPR1WRHidDwpPNk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last missing piece for the inode times on 32-bit systems:
now that VFS interfaces use timespec64, we just need to stop truncating
the tv_sec values for y2038 compatibililty.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/ext4.h   | 18 +++++++-----------
 fs/ext4/ialloc.c |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0b127853c584..6b4f4369a08c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -789,17 +789,16 @@ struct move_extent {
  * affected filesystem before 2242.
  */
 
-static inline __le32 ext4_encode_extra_time(struct timespec *time)
+static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
 {
 	u32 extra = sizeof(time->tv_sec) > 4 ?
 		((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK : 0;
 	return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
 }
 
-static inline void ext4_decode_extra_time(struct timespec *time, __le32 extra)
+static inline void ext4_decode_extra_time(struct timespec64 *time, __le32 extra)
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
index f525f909b559..8c00c871f5dc 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1073,7 +1073,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-	ei->i_crtime = timespec64_to_timespec(inode->i_mtime);
+	ei->i_crtime = inode->i_mtime;
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
 	ei->i_dir_start_lookup = 0;
-- 
2.9.0

