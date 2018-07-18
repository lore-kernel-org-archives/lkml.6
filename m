Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C88ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E829F206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E829F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeGRM23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:28:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeGRM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:28:29 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M9cAV-1fkOUL3v5j-00CwU9; Wed, 18 Jul 2018 13:50:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     akpm@linux-foundation.org,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     viro@zeniv.linux.org.uk, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [RESEND] hpfs: extend gmt_to_local() conversion to 64-bit times
Date:   Wed, 18 Jul 2018 13:49:26 +0200
Message-Id: <20180718115017.742609-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180718115017.742609-1-arnd@arndb.de>
References: <20180718115017.742609-1-arnd@arndb.de>
X-Provags-ID: V03:K1:JZwT7DxOgtYM8bHfurcaegwXpIyKn68Ug9IAHnmJ4BSmgkmal/F
 mjWKl5Y5dBhD5ltFygPAulTIvmGspZgN8443IC/OyB2xTVe5ITmT6o8ALcZV6oMqQmENqFd
 QX5dYD1vNDLAFOVAxoMhHDF4KOk/h78UiM+DxFMgOiZW4+lMfM16jothYS2IyeQKeD1MZ6/
 CZlYd44C8GXz5AE96lDug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TRSt9876ecw=:dKKG8faYZqu5oiH4a6JMgJ
 jVdw6VlvEHWwkOr0yIAP/MGiErMnT8564ldRFhkjy43fn449ez9yEZmXrbp7kzPSyCp9u8to6
 TvWiMPz6uH6MtaPBpp2h9ZxA0cxvR+FMKoEu0UsrKlTzzn/hiZmhZkpfohxqikqj49VbOQ1yY
 pCWtSjf1RPX8zVjj69IjM24UOnGbMzqD7Tmp1sD1n+iUF1LcS/k+7c4okN3eqvoyo23LMM7ix
 7Y2Pk3vc7OgTPSIb1ezAzCTqEhq6qrKuqCCQJos2cKwT9zWa/Xar/0p/iwlC7CSTBLVPjc2u0
 ZiOe+W415/WG1OhoHyLzRjF1YEgIrfUuSkBn7a9RU2IsF2vPEFmvY3a44TEHpLPNIHfkTJzRG
 TJ+aBAf7GEELMCXa+cssiT45KIQ85utDg4LdUDAK964nh/6N1xHTH+OLkAm1tQ13wXqX7tznq
 7eZS+T7f3ruM/7ZROVt6YVOcwX8ZQKNM4JfvrL1flYHyJ0dORdCAGa74kSEi23rOSxEThDjgR
 B1u0BMRIoHlmmCvlNRe/69+ufWNJ919vfDPSrVrqlykC73gr1Ps5XG6x+smOSKF/Cy0IqzpAY
 pyY+IliUwv6gdHaV8yuOZExXeFcVToFKxY9UB83ROY4/Kr6M0JjILR9jTR6OSexjRI6hsjmvx
 qyGD1koV/IDRNRK7oHHhZ/yowawndQSG/a2K6zKTWZbF6M9ErZTT3+vXAGYjYcpRI1x4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFS timestamps are all 64-bit now, the only missing piece for
hpfs is the internal conversion function. One interesting bit about
hpfs is that it can already deal with moving the 136 year window of
its timestamps to support a much wider range than other file systems
with 32-bit timestamps. It also treats the timestamps as 'unsigned'
on 64-bit architectures (but signed on 32-bit, because time_t always
around to negative numbers in 2038).

Changing the conversion to use time64_t makes 32-bit architectures
behave the same way as 64-bit. For completeness, this also adds
a clamp_t call for each conversion, so we don't wrap the timestamps
but instead stay within the [0..U32_MAX] range of the on-disk
timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent on June 19, but got no reply
---
 fs/hpfs/hpfs_fn.h | 13 ++++++++++---
 fs/hpfs/namei.c   | 12 ++++++------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index 2a153aed4c19..ab2e7cc2ff33 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -334,16 +334,23 @@ long hpfs_ioctl(struct file *file, unsigned cmd, unsigned long arg);
  * local time (HPFS) to GMT (Unix)
  */
 
-static inline time_t local_to_gmt(struct super_block *s, time32_t t)
+static inline time64_t local_to_gmt(struct super_block *s, time32_t t)
 {
 	extern struct timezone sys_tz;
 	return t + sys_tz.tz_minuteswest * 60 + hpfs_sb(s)->sb_timeshift;
 }
 
-static inline time32_t gmt_to_local(struct super_block *s, time_t t)
+static inline time32_t gmt_to_local(struct super_block *s, time64_t t)
 {
 	extern struct timezone sys_tz;
-	return t - sys_tz.tz_minuteswest * 60 - hpfs_sb(s)->sb_timeshift;
+	t = t - sys_tz.tz_minuteswest * 60 - hpfs_sb(s)->sb_timeshift;
+
+	return clamp_t(time64_t, t, 0, U32_MAX);
+}
+
+static inline time32_t local_get_seconds(struct super_block *s)
+{
+	return gmt_to_local(s, ktime_get_real_seconds());
 }
 
 /*
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index a3615e4c730d..082b7c76dd0c 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -11,7 +11,7 @@
 
 static void hpfs_update_directory_times(struct inode *dir)
 {
-	time_t t = get_seconds();
+	time64_t t = local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
 	if (t == dir->i_mtime.tv_sec &&
 	    t == dir->i_ctime.tv_sec)
 		return;
@@ -50,7 +50,7 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	/*dee.archive = 0;*/
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 	result = new_inode(dir->i_sb);
 	if (!result)
 		goto bail2;
@@ -91,7 +91,7 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	dnode->root_dnode = 1;
 	dnode->up = cpu_to_le32(fno);
 	de = hpfs_add_de(dir->i_sb, dnode, "\001\001", 2, 0);
-	de->creation_date = de->write_date = de->read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	de->creation_date = de->write_date = de->read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 	if (!(mode & 0222)) de->read_only = 1;
 	de->first = de->directory = 1;
 	/*de->hidden = de->system = 0;*/
@@ -151,7 +151,7 @@ static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 
 	result = new_inode(dir->i_sb);
 	if (!result)
@@ -238,7 +238,7 @@ static int hpfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, de
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 
 	result = new_inode(dir->i_sb);
 	if (!result)
@@ -314,7 +314,7 @@ static int hpfs_symlink(struct inode *dir, struct dentry *dentry, const char *sy
 	dee.archive = 1;
 	dee.hidden = name[0] == '.';
 	dee.fnode = cpu_to_le32(fno);
-	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(gmt_to_local(dir->i_sb, get_seconds()));
+	dee.creation_date = dee.write_date = dee.read_date = cpu_to_le32(local_get_seconds(dir->i_sb));
 
 	result = new_inode(dir->i_sb);
 	if (!result)
-- 
2.9.0

