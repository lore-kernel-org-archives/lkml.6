Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910A9208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910A9208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935403AbeFRKFp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:05:45 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934927AbeFRKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:05:42 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MKxUa-1fUr2X3oDg-0007HR; Mon, 18 Jun 2018 12:05:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: hypfs: use ktime_get_seconds() instead of get_seconds()
Date:   Mon, 18 Jun 2018 12:05:00 +0200
Message-Id: <20180618100534.1857997-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:KGgJLfdQ/HqP0GR5FYdAvj8PBrlFjxGx/cKaP/jfBz5gcsyed1F
 aBdrUxBAihrcQrL/XXeO/ubrBycB91ETX1oF5UYpXajvwZTClHWShal8QvdDhumvnQ1spvy
 1kjYufZ26n4x79up1YpZQX55q0tNgLuMMnrk/vgpvSkNCIz5krsYKFew2d3F+uFxzjqp4n5
 dF3xf3QcD+57vLIjy3WKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o6vKrHjPPUA=:ZqPtTzNRlRqPFrQLa2vxMA
 0GsJy9YVse4mLA0RA0Y814wUbd7RuszeTioMFWdmGU/PygdpaNqEvRv8fwY0SRexI5B92XOc4
 T+BhwQpt8i4EC5C1f57R9oeFPLvHUTnMOzqjrtH8aG1SW8iOnW6fvNRMy2UYlyN0ZBsUhU6BD
 8TVzJxuhXPMq6oh0wyQM3CZ7dvEUdUL9MkyxJSlhw7SYQ6gGiWgxa5kXZrNhRHxR6ZIT/PSp6
 w2MT2Ty7rAtvJSGF+kH876ykEv+G5Ts+vkMeX/D6tJvFHt6i0K6vJhVUIKe/82LmMOZ+DTBzi
 L9nENxNGkPd5MueVKmDELrr6ALcN2VoKg6LeQDgXhQ1UjaAjkqSI93kCLAFXsFO1QbiYILxHX
 e0UVFb1UigQi44HDIJdpE7pDTZYJs51uDBIuUws4jIIg18gELi27DJgtqCaY53VG5V5jgSQAA
 jNnLyj73lZ7p3dqe4POC0J1Z01FabltV1ruOoD7YPLxqYE3NTL1pWRaN0RfyaUEvsBiUfnlRl
 0aBZDeftoYHMlxfeS4lEbQqsHwFv+k54zcGnazxUBri5PN7O484ztmebVF6qjuRn0y8tfgmn4
 utlJ0nnomX/vYQ657TwWqFGbqI29iMnMj3QJ1+lHGNKEoO88F0DwfnjSiTeifiH9PgmExxU9Z
 y10yOo2JbNBNoHvasJXZe/hM9t5yErOrv2wWQDX4kmA3FQSt2buJrIwPoMTuWdrZNJxE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

time_t and get_seconds() are deprecated because they will overflow on
32-bit architectures in the future. This is not a problem on 64-bit s390,
but we should use proper interfaces anyway.

Besides moving to the time64_t based interface, the CLOCK_MONOTONIC
based ktime_get_seconds() is preferred for kernel internal timekeeping
because it does not behave in unexpected ways during leap second changes
or settimeofday() calls.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/hypfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 06b513d192b9..c681329fdeec 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -36,7 +36,7 @@ struct hypfs_sb_info {
 	kuid_t uid;			/* uid used for files and dirs */
 	kgid_t gid;			/* gid used for files and dirs */
 	struct dentry *update_file;	/* file to trigger update */
-	time_t last_update;		/* last update time in secs since 1970 */
+	time64_t last_update;		/* last update, CLOCK_MONOTONIC time */
 	struct mutex lock;		/* lock to protect update process */
 };
 
@@ -52,7 +52,7 @@ static void hypfs_update_update(struct super_block *sb)
 	struct hypfs_sb_info *sb_info = sb->s_fs_info;
 	struct inode *inode = d_inode(sb_info->update_file);
 
-	sb_info->last_update = get_seconds();
+	sb_info->last_update = ktime_get_seconds();
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 }
 
@@ -179,7 +179,7 @@ static ssize_t hypfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	 *    to restart data collection in this case.
 	 */
 	mutex_lock(&fs_info->lock);
-	if (fs_info->last_update == get_seconds()) {
+	if (fs_info->last_update == ktime_get_seconds()) {
 		rc = -EBUSY;
 		goto out;
 	}
-- 
2.9.0

