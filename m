Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C04C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9E72437F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9E72437F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeFVOSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:18:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeFVOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:18:13 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MGzR4-1fSZWt32Pq-00Dr03; Fri, 22 Jun 2018 16:18:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vyacheslav Dubeyko <slava@dubeyko.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        stable@vger.kernel.org,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hfs/hfsplus: use documented official timestamp range
Date:   Fri, 22 Jun 2018 16:17:32 +0200
Message-Id: <20180622141758.229589-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:m71kq+EW7DCpNDD22ji8Kqt9orK+JiyKhpCE+8SPMyFxJCwNhtO
 XGlDAxZ2g9m5wMBAHo7yxLLoqNRdtzNfP87y6PqbMfT2CTNFAZUwGwvDK5CzRSgp/0zmjVD
 Xk9i8aCJVh7o0SlPwcTBrbpaDW9q9Kb7j24wITXhjnDVmRZeLjTkyDi7TAKmkRU842S+Q/8
 mVnZSGTnW3wE5fUqHcwgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7YFBCuhiy4Q=:BpLikdIRBd+BwrIczIWg6x
 7ABwItAuIJytvfIH6Y4RS7cxCOjwHkIqdoDCR5GyRczdtMbpzNePVGnN9pubSpom8JsEH44Up
 mGOpG2wWvD9FQsmJNIw1h85W9Ho6OcCjgzuFGYHNJxYAHAQUBHcK1T+BgEcHQWnr+7wDuCXVh
 eNwt/tg/42Z7HurL2ZnEqq058P2GFG4xOvV1HTKFxQh8HD2C4m/2DrQABlczoz73pg5p9aKBg
 KVRLNzwkzrYNMpxgDTe3h+RSLxDHuZTeInstc26zXDwyW40mzrthK3zwkuLhNv/SLujFrDbVM
 M8fscONocTqOT2EvePmIAsImbnutNzyGQ4qtt3YFfXP4AG0Qd/WVtkYIRwvEZo6SUdV/mnFYq
 61SeFIQiz/ulZKxnt8sqzTVArv2vXE94HGnjC6T06SgRorsockfff5LnmYotULMi0G08aCaIo
 EYo1+kdX6mqGP5W1OGCGEoJmu6tUsJsjv/B6GPbrZvkze2HqF/vBrLceztpfb+SIr41SisfIz
 kc1ub3euYNr5RuC+W4M4VTTQkx0sOjyLObE3ZrLso8Yj9BfjPAho0FlkZsAbf3s0Sm29Q+VOz
 ryYev+DRsn43j0oqMZwmaEAt1VEBLhqAo9EXc4mLsaeJ85+ioUY/azC+8eEFhdMWmsQxTHSWR
 JMz4wTqlZpw0MgaJBxUshn7o3VpENC0Nviu/6HmjU+aaiMgm3Uy7FBqmUgomBD5BOAy8=
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

The same behavior is used in Darwin and presumaby all versions of MacOS X,
as seen in the to_hfs_time() function in [2]. It is unclear whether this
is a bug in the file system code, or intentional but undocumented behavior.

This changes Linux over to the traditional MacOS (pre MacOS X)
behavior. This means all files that are created on MacOS X or Linux
with future timestamps between 2040 and 2106 will now show up as past
dates. Timestamps between 2038 and 2040 will still be represented
incorrectly on 32-bit architectures as times between 1902 and 1904,
but that will be fixed once we have user space with 64-bit time_t.

Cc: stable@vger.kernel.org
Link: [1] https://developer.apple.com/library/archive/technotes/tn/tn1150.html
Link: [2] https://opensource.apple.com/source/xnu/xnu-344/bsd/hfs/MacOSStubs.c
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Note: This is the patch that Viacheslav asked for, but given how
MacOS X behaves, I'm increasingly thinking this is a bad idea.
---
 fs/hfs/hfs_fs.h         | 2 +-
 fs/hfsplus/hfsplus_fs.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 6d0783e2e276..39c1f3a43ed8 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -247,7 +247,7 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
  *
  */
 #define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
-#define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
+#define __hfs_m_to_utime(sec)	((time64_t)be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
 
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index d9255abafb81..57838ef4dcdc 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -530,8 +530,9 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, int op, int op_flags);
 int hfsplus_read_wrapper(struct super_block *sb);
 
-/* time macros */
-#define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
+/* time macros: convert between 1904-2040 and 1970-2106 range,
+ * pre-1970 timestamps are interpreted as post-2038 times after wrap-around */
+#define __hfsp_mt2ut(t)		((time64_t)be32_to_cpu(t) - 2082844800U)
 #define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
 
 /* compatibility */
-- 
2.9.0

