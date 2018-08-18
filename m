Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4355C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5881E208EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5881E208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeHRDjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:39:47 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:60790 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeHRDjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:39:47 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 96DBB15AF4C;
        Sat, 18 Aug 2018 09:34:10 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w7I0Y9Ys017949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Aug 2018 09:34:10 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w7I0Y9Bu004260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Aug 2018 09:34:09 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w7I0Y89t004259;
        Sat, 18 Aug 2018 09:34:08 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Cleanup "fat: propagate 64-bit inode timestamps" patch
Date:   Sat, 18 Aug 2018 09:34:07 +0900
Message-ID: <87zhxkjyww.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like I missed the email to read for a patch
(mmots/broken-out/fat-propagate-64-bit-inode-timestamps.patch).  Well,
so FWIW,

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

And additionally cleanup patch here (this would be better to be folded
into his patch).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

[PATCH] Cleanup "fat: propagate 64-bit inode timestamps" patch

- Remove useless temporary variable
- Remove needless long long

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |   10 +++-------
 fs/fat/misc.c  |    7 +++----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff -puN fs/fat/inode.c~fat-propagate-64-bit-inode-timestamps-cleanup fs/fat/inode.c
--- linux/fs/fat/inode.c~fat-propagate-64-bit-inode-timestamps-cleanup	2018-08-18 09:23:27.990137305 +0900
+++ linux-hirofumi/fs/fat/inode.c	2018-08-18 09:32:52.629008507 +0900
@@ -509,7 +509,6 @@ static int fat_validate_dir(struct inode
 int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
-	struct timespec64 ts;
 	int error;
 
 	MSDOS_I(inode)->i_pos = 0;
@@ -559,14 +558,11 @@ int fat_fill_inode(struct inode *inode,
 	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
-	fat_time_fat2unix(sbi, &ts, de->time, de->date, 0);
-	inode->i_mtime = ts;
+	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
 	if (sbi->options.isvfat) {
-		fat_time_fat2unix(sbi, &ts, de->ctime,
+		fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
 				  de->cdate, de->ctime_cs);
-		inode->i_ctime = ts;
-		fat_time_fat2unix(sbi, &ts, 0, de->adate, 0);
-		inode->i_atime = ts;
+		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
 	} else
 		inode->i_ctime = inode->i_atime = inode->i_mtime;
 
diff -puN fs/fat/misc.c~fat-propagate-64-bit-inode-timestamps-cleanup fs/fat/misc.c
--- linux/fs/fat/misc.c~fat-propagate-64-bit-inode-timestamps-cleanup	2018-08-18 09:23:27.992137301 +0900
+++ linux-hirofumi/fs/fat/misc.c	2018-08-18 09:32:52.596008572 +0900
@@ -180,7 +180,7 @@ int fat_chain_add(struct inode *inode, i
 #define IS_LEAP_YEAR(y)	(!((y) & 3) && (y) != YEAR_2100)
 
 /* Linear day numbers of the respective 1sts in non-leap years. */
-static time64_t days_in_year[] = {
+static long days_in_year[] = {
 	/* Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec */
 	0,   0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0,
 };
@@ -191,8 +191,7 @@ void fat_time_fat2unix(struct msdos_sb_i
 {
 	u16 time = le16_to_cpu(__time), date = le16_to_cpu(__date);
 	time64_t second;
-	long day, leap_day, month;
-	long long year;
+	long day, leap_day, month, year;
 
 	year  = date >> 9;
 	month = max(1, (date >> 5) & 0xf);
@@ -207,7 +206,7 @@ void fat_time_fat2unix(struct msdos_sb_i
 	second =  (time & 0x1f) << 1;
 	second += ((time >> 5) & 0x3f) * SECS_PER_MIN;
 	second += (time >> 11) * SECS_PER_HOUR;
-	second += (year * 365 + leap_day
+	second += (time64_t)(year * 365 + leap_day
 		   + days_in_year[month] + day
 		   + DAYS_DELTA) * SECS_PER_DAY;
 
_
