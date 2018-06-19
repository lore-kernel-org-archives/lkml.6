Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E713920661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E713920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966864AbeFSQCf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:02:35 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48737 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:02:33 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MUjoe-1fhSBy3r36-00Y8zn; Tue, 19 Jun 2018 18:02:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hfs: stop using timespec based interfaces
Date:   Tue, 19 Jun 2018 18:02:07 +0200
Message-Id: <20180619160223.4108556-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:L9t0W1DT5ojYT4b0E/bYnB21OmagDxPdAxoHiNzQAQe6rlRn8lD
 lOzuko0IJ1RLmW4p5Zs3X1JZzPcvsvIK/DGmQLKT19Y0ag4Lc9IZBbvnnvrPxzi/xVUE7gT
 9y5z3svGqto0Yj2KA529DaWyAWiEeB6eEUpahFJwIiLsYXgKBkNa3Zf+d9w0LZyBTaYONeq
 ejUpD0cOd8z2pu9hbYTMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GboANqIifc0=:mfS9Z9MRa2lqf4ywrfyYIh
 OftX/kdNYHAoDduyF8+CH9gIyb5cb+uvY7C0B43czLf4KPpg5EymBPMgIndIZMFzB2XlySTHr
 6MzX1kRZt8xX9VkMaCqhjrpxDfh4mK05w52YDErui7eV4MJXADMe2kLSOUDqxqN2o9Rbjd5lO
 a2yt2T6D862sxi2Pdpc0EyBv9od4Me7psRGeivTONffhMvsPR+Gm28h7+1wEF2mQHMqPgFmTb
 S3K3YhJeoGYzSISs6YTAL+SIPFpBZba1kxrX/WDyeBP2nmaC99PHkQguJUSPUzBr8KBYvBiMw
 eSfHn7gYB/Gi9OWlzxmbPx09PzFL0v3RPxMUg8JcZ/koz8loa/QWCP3lbNTOdwR9qauwW5a6E
 yy43NwhBxu7u84yyFeVlhgOO3zz35c7X4MrXd8LLt6FcSe8KxwXwQ/wCAcBOaO1KDQG9DR5AQ
 FBX3OlfS/s/s/lr2ZbUs8wcewBv0FwcKarB5d9g7ObnDjZKE+NrsvAVgjNzGxlxkYaC6SKFc2
 ZRdmDGorBJPbymqPrKamNVLfTGGswt36LsOYMcMR+KGx73Y6zQIwDcS2X5pSqNESbXXKaQDe9
 Lq3pkbHzHy2Hej/UEVtyT8VmFhUg9OyKiUGKRtJiSZRUalx6JB0D/wZHxyMKQ+r7zonScOceY
 HcUdQIN6GXRdFL1d2v8dSNTWFIQnqCuTvr5aPzNzREvMTp/Q/OXHwOelN0Hvq3uOnyyI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The native HFS timestamps overflow in year 2040, two years after the Unix
y2038 overflow. However, the way that the conversion between on-disk
timestamps and in-kernel timestamps was implemented, 64-bit machines
actually ended up converting negative UTC timestamps (1902 through 1969)
into times between 2038 and 2106.

Rather than making all machines faithfully represent timestamps in the
ancient past but break after 2040, this changes the file system to
always use the unsigned UTC interpretation, reading back times between
1970 and 2106.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hfs/hfs_fs.h | 6 ++++--
 fs/hfs/inode.c  | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 6d0783e2e276..ff432931a5b1 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -245,6 +245,8 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
  *	Unix:	unsigned lil-endian since 00:00 GMT, Jan. 1, 1970
  *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
  *
+ * We treat all timestamps before 1970 as times after 2038, so this
+ * actually works until year 2106
  */
 #define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
 #define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
@@ -252,9 +254,9 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
 
-#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
+#define hfs_m_to_utime(time)	(struct timespec64){ .tv_sec = __hfs_m_to_utime(time) }
 #define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
-#define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
+#define hfs_mtime()		__hfs_u_to_mtime(ktime_get_real_seconds())
 
 static inline const char *hfs_mdb_name(struct super_block *sb)
 {
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2a16111d312f..b3309b83371a 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -351,7 +351,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				timespec_to_timespec64(hfs_m_to_utime(rec->file.MdDat));
+				hfs_m_to_utime(rec->file.MdDat);
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -362,7 +362,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
-				timespec_to_timespec64(hfs_m_to_utime(rec->dir.MdDat));
+				hfs_m_to_utime(rec->dir.MdDat);
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
-- 
2.9.0

