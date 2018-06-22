Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD6DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E3F242C5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E3F242C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeFVNdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:33:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeFVNdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:33:39 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LvBGU-1gEf2I19W6-010KtA; Fri, 22 Jun 2018 15:33:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jan Kara <jack@suse.cz>, Jeff Mahoney <jeffm@suse.com>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] reiserfs: change j_timestamp type to time64_t
Date:   Fri, 22 Jun 2018 15:32:58 +0200
Message-Id: <20180622133315.221210-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:ZIohq4OfRwTj8RksFWJsgr0fkXc6EAwpyjrEy9nhctZCVB2zq2y
 0NlaK/O0DCE5T8K52Je+T3RuSHoyeh1t9qhajPJhzpP6rNTn7IUE943gVncT7tMfCuSDZhM
 WGrmzrLotNo8BF6tBKCKh88L9v03xeh6lOLZz+ZPEjW9+WkM41FFmZ9n+Bq3jxvCRZdBGsD
 zJLLAyNEJHn7Y2Fp/v7cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vzaDHnzi2L4=:t+iZsVVDMX78uXk6uTXZK3
 Q2l+iyd2f5Y9DGAa+CZbZxU2ndBNzDsrJxkcbHAZpN87iRq3e3sjsoaQnA0llpRudXHvYFp1I
 HuDTWd+iVZj5XLOd83rUKidr9aZDfsDHZvDaIeI2utuhZz7JSw68phrzFmyOEc1cNN9ihiQER
 SDwAMb/kSBvQiDK96soUWAa3YK7xsC+234jcMFHpCOCzljFaZcVcIry3Nng+adlAGx9FTwSRG
 oaOjMV4CTUj+vyp5O3xFrT/W39mHWzcOk+0xjux7cINHmk43u2FuWSg891WAW7iwI/Z1K4OQz
 dtUG4c5h4XO/UYT9OlsJZ4UbUynssCSIzHx+zIIqzKNKxpCMY08A7DQ6qaeSLwJLwyyL3/6ib
 P4lP7I6N9LoWY/DjrxAaZjqEjFfhyF5pqdKp7V55lY/4fkL14rWIdTylefsJOk0TOGfqPlyy1
 FbByyFhsdRklszSu3glDL4o8Sd/dEP2UpajCkS9tR3NzkcmnXlxjsFT1ByhkuHB/MepyHjs1U
 7SFuMyiDnSP1c22c063qXj57IrROpUFBrSDaMqCm9bCb6HQJqk/5xsyTl8ozgpZSc/o2Vu97A
 qbwL6GPvkf23uQN2JJez4gobbQH+3FGwDQYu3+am9oEZjbIELOtfKAEg1RYRFGVQOZtpkJFc+
 WYaw9IKhqJITIaWVnHLEufJwdTt/QDp5aI+hNW4r0VmVHJn4giqWzR5vjLnXLNbByjpY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the deprecated time_t type but is write-only, and could be
removed, but as Jeff explains, having a timestamp can be usefule for
post-mortem analysis in crash dumps.

In order to remove one of the last instances of time_t, this changes
the type to time64_t, same as j_trans_start_time.

Cc: Jan Kara <jack@suse.cz>
Cc: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This could replace "reiserfs: remove unused j_timestamp" if we decide
that we want to keep that variable.

Posting this patch as an alternative now, while waiting for Jeff to
reply on how important this really is.
---
 fs/reiserfs/reiserfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 621b9a07080a..e5ca9ed79e54 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -271,7 +271,7 @@ struct reiserfs_journal_list {
 
 	struct mutex j_commit_mutex;
 	unsigned int j_trans_id;
-	time_t j_timestamp;
+	time64_t j_timestamp; /* write-only but useful for crash dump analysis */
 	struct reiserfs_list_bitmap *j_list_bitmap;
 	struct buffer_head *j_commit_bh;	/* commit buffer head */
 	struct reiserfs_journal_cnode *j_realblock;
-- 
2.9.0

