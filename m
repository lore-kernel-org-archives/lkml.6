Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B433ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD1D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD1D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbeGRM2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:28:23 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40520 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeGRM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:28:22 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lpijq-1gHrgd01yA-00fQYG; Wed, 18 Jul 2018 13:50:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     akpm@linux-foundation.org, Anton Altaparmakov <anton@tuxera.com>
Cc:     viro@zeniv.linux.org.uk, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] [RESEND] ntfs: use timespec64 directly for timestamp conversion
Date:   Wed, 18 Jul 2018 13:49:25 +0200
Message-Id: <20180718115017.742609-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180718115017.742609-1-arnd@arndb.de>
References: <20180718115017.742609-1-arnd@arndb.de>
X-Provags-ID: V03:K1:48HS6bUrv82M+wTECIkvvM0e/wX0MoM1hFhZUZC8jtt8TrMTJbl
 dMink4CvqSzJoNiGejrjXT8dKfW58V8yv3Ddmb3AM6sDs/JTSgY6AnMLnXfDh6s53znUy9b
 OjhCItBi4pEtbKDvtXSAkucVGUBRc3nAHNKnepC1ucnwWLS63+rVNmtxFXIEpm0rvKNNG4D
 Y6l62X8H/vIaSs8nQMExw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LzqsGoFDgLk=:p4bHRCyay8txTcpFNq33No
 zNJZSjywMEerCiTwNopQPrVbgzA/zdkxjS/P8jJ4bUfhCICcHXLW2bZg7UOLlbWMpKljKj53c
 3exTiSQZWwSeu/kmMiCVIHzKbk58kkNhHcNObHppykiIRWcg4cmd3Ta3Wf5/SRzl/wy/MRDoE
 saW8FYeLylp08yMY71CqIPjOAzGr9rMfT4z0EV2Ex8BjfPFa4Ibcxit2dIepNDqJ8Yd9B0YJ+
 x1xm6wSdmxlAUWvJkG6dmutHVVbN8Vb4SXQcYH69wHfc+ZSYTrZJ+e3UXG6ChZQk4KCMEJBG3
 qEppI7mhV2yfe9ejFMGUgGlhKwp2zFfVR6ihGgysrPdK7exzgoq0NFhqdI8RS/2I80653HfH1
 McG7ht8dN/V8TDXvasQU9xikYW5sv72ejwfSKdtYyf5EY/DfzSKKVP+C6hKRbVtWLybMNDIST
 A1ozY38lcbnTR1RB5PvCo9ElThuwAvNfDpnvncoRehebn7/lldSVn5p3HiE+VqtpKQMtYZJam
 XkN2s90sACKa4dRqpeiGvB10lVVsInFfCMr5HXy6O5X7P0pRXKuv5wTQvmlRdM0yaNLC5SwF+
 AqpOl69oDjfeCmYY2fXdBZNjfy8byYN0zxL9fNVQQm2Jd6Zz8IofQsC9Fsv27om4SZBkYweMj
 UOBF7hY5RmOxqM5RyyF04pbxWo24LAZ00u5yuBTCx6Xn8ZjO72CMLGY4lGnWkBU9Aw0I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the VFS has been converted from timespec to timespec64
timestamps, only the conversion to/from ntfs timestamps uses 32-bit
seconds.

This changes that last missing piece to get the ntfs implementation
y2038 safe on 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent on June 19, but got no reply
---
 fs/ntfs/inode.c | 12 ++++++------
 fs/ntfs/time.h  | 27 +++++++++++++++------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index decaf75d1cd5..bd3221cbdd95 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -667,18 +667,18 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * mtime is the last change of the data within the file. Not changed
 	 * when only metadata is changed, e.g. a rename doesn't affect mtime.
 	 */
-	vi->i_mtime = timespec_to_timespec64(ntfs2utc(si->last_data_change_time));
+	vi->i_mtime = ntfs2utc(si->last_data_change_time);
 	/*
 	 * ctime is the last change of the metadata of the file. This obviously
 	 * always changes, when mtime is changed. ctime can be changed on its
 	 * own, mtime is then not changed, e.g. when a file is renamed.
 	 */
-	vi->i_ctime = timespec_to_timespec64(ntfs2utc(si->last_mft_change_time));
+	vi->i_ctime = ntfs2utc(si->last_mft_change_time);
 	/*
 	 * Last access to the data within the file. Not changed during a rename
 	 * for example but changed whenever the file is written to.
 	 */
-	vi->i_atime = timespec_to_timespec64(ntfs2utc(si->last_access_time));
+	vi->i_atime = ntfs2utc(si->last_access_time);
 
 	/* Find the attribute list attribute if present. */
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -2997,7 +2997,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	si = (STANDARD_INFORMATION*)((u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
 	/* Update the access times if they have changed. */
-	nt = utc2ntfs(timespec64_to_timespec(vi->i_mtime));
+	nt = utc2ntfs(vi->i_mtime);
 	if (si->last_data_change_time != nt) {
 		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
@@ -3006,7 +3006,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_data_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(timespec64_to_timespec(vi->i_ctime));
+	nt = utc2ntfs(vi->i_ctime);
 	if (si->last_mft_change_time != nt) {
 		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
@@ -3015,7 +3015,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_mft_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(timespec64_to_timespec(vi->i_atime));
+	nt = utc2ntfs(vi->i_atime);
 	if (si->last_access_time != nt) {
 		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino,
diff --git a/fs/ntfs/time.h b/fs/ntfs/time.h
index 01233989d5d1..24cd719f1fd2 100644
--- a/fs/ntfs/time.h
+++ b/fs/ntfs/time.h
@@ -36,16 +36,16 @@
  * Convert the Linux UTC time @ts to its corresponding NTFS time and return
  * that in little endian format.
  *
- * Linux stores time in a struct timespec consisting of a time_t (long at
- * present) tv_sec and a long tv_nsec where tv_sec is the number of 1-second
- * intervals since 1st January 1970, 00:00:00 UTC and tv_nsec is the number of
- * 1-nano-second intervals since the value of tv_sec.
+ * Linux stores time in a struct timespec64 consisting of a time64_t tv_sec
+ * and a long tv_nsec where tv_sec is the number of 1-second intervals since
+ * 1st January 1970, 00:00:00 UTC and tv_nsec is the number of 1-nano-second
+ * intervals since the value of tv_sec.
  *
  * NTFS uses Microsoft's standard time format which is stored in a s64 and is
  * measured as the number of 100-nano-second intervals since 1st January 1601,
  * 00:00:00 UTC.
  */
-static inline sle64 utc2ntfs(const struct timespec ts)
+static inline sle64 utc2ntfs(const struct timespec64 ts)
 {
 	/*
 	 * Convert the seconds to 100ns intervals, add the nano-seconds
@@ -63,7 +63,10 @@ static inline sle64 utc2ntfs(const struct timespec ts)
  */
 static inline sle64 get_current_ntfs_time(void)
 {
-	return utc2ntfs(current_kernel_time());
+	struct timespec64 ts;
+
+	ktime_get_coarse_real_ts64(&ts);
+	return utc2ntfs(ts);
 }
 
 /**
@@ -73,18 +76,18 @@ static inline sle64 get_current_ntfs_time(void)
  * Convert the little endian NTFS time @time to its corresponding Linux UTC
  * time and return that in cpu format.
  *
- * Linux stores time in a struct timespec consisting of a time_t (long at
- * present) tv_sec and a long tv_nsec where tv_sec is the number of 1-second
- * intervals since 1st January 1970, 00:00:00 UTC and tv_nsec is the number of
- * 1-nano-second intervals since the value of tv_sec.
+ * Linux stores time in a struct timespec64 consisting of a time64_t tv_sec
+ * and a long tv_nsec where tv_sec is the number of 1-second intervals since
+ * 1st January 1970, 00:00:00 UTC and tv_nsec is the number of 1-nano-second
+ * intervals since the value of tv_sec.
  *
  * NTFS uses Microsoft's standard time format which is stored in a s64 and is
  * measured as the number of 100 nano-second intervals since 1st January 1601,
  * 00:00:00 UTC.
  */
-static inline struct timespec ntfs2utc(const sle64 time)
+static inline struct timespec64 ntfs2utc(const sle64 time)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 
 	/* Subtract the NTFS time offset. */
 	u64 t = (u64)(sle64_to_cpu(time) - NTFS_TIME_OFFSET);
-- 
2.9.0

