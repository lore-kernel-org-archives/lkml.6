Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530DFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0436F20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0436F20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbeGJVmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:42:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbeGJVmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:42:44 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MAvMi-1fkftr2dAi-009x7s; Tue, 10 Jul 2018 23:41:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v2] hfs/hfsplus: follow MacOS time behavior
Date:   Tue, 10 Jul 2018 23:40:50 +0200
Message-Id: <20180710214131.4106527-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:SzAiAz7VKkdG5l4G8DunjBBtV6IPD16r/H6OaKUE3Sq/ZaLJxHW
 rSWJR+5XW/jvQFx1T121v/654dJSlQLpUoqcs41V+Amp9pal8T01j9rT8wEJ0U/rE02J1x2
 UL/zKzL886wM8diP/iTLQwsCjNsdU1UNfE4cCsDe4QiGQDapncQugArprmaUl3Gzye5PHDa
 JUHAJq2JEXT1nCt2pRfcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qZyPirPEt0E=:bISQE6y6rWL09VHHVzF4xA
 TB9sTqDbr42PdQHIylDg4f3njdjOjHyJkJC6GaA7HSx5QW0Aiu67/7bKCi8KoyDXwN3DDlDxD
 Yh1xiGNhZbiA3TPGZRpmTIAzrSdXJ8o+4mktgUB4x/Km3ilO+bwaLyEzlgy4/VTQcJ0ZWL2Vu
 UK+Lfj7S818nzgEglTUxKMCkww8bQmZ4y/jYfGei6JJdBvFYO0xKRQXJyY5AhZGvwk5aHLedI
 mbBgfy6GIXVKEyVw7ktKCmh3U7V0ijEtqaMZyaDEylpEBMDHOefZOxtED6qVS1nH2txtZ3vaM
 2i9WS9xZ1fteOdnBtGcHPZ+8QveF0XKuDtxdoyvU+2XhT/BlCl+zZ8SiAtd9D83lakQQhsKz3
 lOZFAh2IaOZaPGQQiyC6S9aEaR9ewI7AWeIkvk4qkpGxt1bP+ItYdTLPA6NDzWd61E7/UQBke
 1SbYFYhSNXIhB3p0lpkEsyL79WmnVZ0GHJvDv0DGkY9EtHWNDXE52oLib2nhEb7trl3FjZZ7p
 c9FRz5rIr+kFYCixYTOEYGSDojOpfC0qwhdKGdwHOdwHvJdNZUoDotTitbUU9CcOgLs6q7W8m
 XoxzxiTgKb5hBDcmCjdcjXSFTS21cJr2hbmQPDwVWgusJZeauVThMaqWtkZvQJ501ZiLk8zbQ
 3YsZYjJ9MR8g/roB3k8GElO0jgh5aHrHlUbBQfWwRwGEHl96jvxFi+PQIDFUoSvP8jWw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the official documentation for HFS+ [1], inode timestamps
are supposed to cover the time range from 1904 to 2040 as originally
used in classic MacOS.

The traditional Linux usage is to convert the timestamps into an unsigned
32-bit number based on the Unix epoch and from there to a time_t. On
32-bit systems, that wraps the time from 2038 to 1902, so the last
two years of the valid time range become garbled. On 64-bit systems,
all times before 1970 get turned into timestamps between 2038 and 2106,
which is more convenient but also different from the documented behavior.

Looking at the Darwin sources [2], it seems that MacOS is inconsistent in
yet another way: all timestamps are wrapped around to a 32-bit unsigned
number when written to the disk, but when read back, all numeric values
lower than 2082844800U are assumed to be invalid, so we cannot represent
the times before 1970 or the times after 2040.

While all implementations seem to agree on the interpretation of values
between 1970 and 2038, they often differ on the exact range they support
when reading back values outside of the common range:

MacOS (traditional):		1904-2040
Apple Documentation:		1904-2040
MacOS X source comments:	1970-2040
MacOS X source code:		1970-2038
32-bit Linux:			1902-2038
64-bit Linux:			1970-2106
hfsfuse:			1970-2040
hfsutils (32 bit, old libc)	1902-2038
hfsutils (32 bit, new libc)	1970-2106
hfsutils (64 bit)		1904-2040
hfsplus-utils			1904-2040
hfsexplorer			1904-2040
7-zip				1904-2040

This changes Linux over to mostly the same behavior as described in the
code comment in MacOS X, disallowing all times before 1970 and after
2040, while still allowing times between 2038 and 2040 like most other
implementations do. Most importantly, it means we can have the same
behavior on 32-bit and 64-bit.

Cc: stable@vger.kernel.org
Link: [1] https://developer.apple.com/library/archive/technotes/tn/tn1150.html
Link: [2] https://opensource.apple.com/source/hfs/hfs-407.30.1/core/MacOSStubs.c.auto.html
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: treat pre-1970 dates as invalid following MacOS X behavior,
    reword and expand changelog text
---
 fs/hfs/hfs_fs.h         | 29 +++++++++++++++++++++++++----
 fs/hfsplus/hfsplus_fs.h | 26 +++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 6d0783e2e276..1af998fb522e 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -246,14 +246,35 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
  *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
  *
  */
-#define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
-#define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
+static inline time64_t __hfs_m_to_utime(__be32 mt)
+{
+	time64_t ut = (u32)(be32_to_cpu(mt) - 2082844800U);
+
+	/*
+	 * Times past 2040-02-06 06:28 are assumed to be invalid,
+	 * matching the MacOS behavior.
+	 */
+	if (ut > 2082844800U + UINT_MAX)
+		ut = 0;
+
+	return ut + sys_tz.tz_minuteswest * 60;
+}
 
+static inline __be32 __hfs_u_to_mtime(time64_t ut)
+{
+	ut -= - sys_tz.tz_minuteswest * 60;
+
+	/*
+	 * MacOS wraps "invalid" times after 2040 when writing back, so
+	 * let's do the same here.
+	 */
+	return cpu_to_be32(lower_32_bits(ut + 2082844800U));
+}
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
 
-#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
-#define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
+#define hfs_m_to_utime(time)   (struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
+#define hfs_u_to_mtime(time)   __hfs_u_to_mtime((time).tv_sec)
 #define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
 
 static inline const char *hfs_mdb_name(struct super_block *sb)
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index d9255abafb81..7f0943e540a0 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -530,9 +530,29 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, int op, int op_flags);
 int hfsplus_read_wrapper(struct super_block *sb);
 
-/* time macros */
-#define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
-#define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
+/* time helpers */
+static inline time64_t __hfsp_mt2ut(__be32 mt)
+{
+	time64_t ut = (u32)(be32_to_cpu(mt) - 2082844800U);
+
+	/*
+	 * Times past 2040-02-06 06:28 are assumed to be invalid,
+	 * matching the MacOS behavior.
+	 */
+	if (ut > 2082844800U + UINT_MAX)
+		ut = 0;
+
+	return ut;
+}
+
+static inline __be32 __hfsp_ut2mt(time64_t ut)
+{
+	/*
+	 * MacOS wraps "invalid" times after 2040 when writing back, so
+	 * let's do the same here.
+	 */
+	return cpu_to_be32(lower_32_bits(ut + 2082844800U));
+}
 
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
-- 
2.9.0

