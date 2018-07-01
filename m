Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4819C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B754258C8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="BDziEhy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B754258C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeGAU5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 16:57:18 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:47267 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbeGAU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 16:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UNP98H78uow7lYkbBgYVbeQI1pW63cuOCMYOohSWxq8=; b=BDziEhy3y1+h+8GcvISAM+CSVI
        KpR9q9bjuglo0ojGMo6nDMJrtKlHnAeYwUyfgUAfd/TwDKiqp5P0KFtB4AhwLo6ezCKvuMPYQ1cU+
        BBe5QpGet1kzaup+puOo2NSDiFBW/ENRF2ToElMEn+IXl40Ohu1aHG3hd0hE7tsN+jrMMxbtNxgxA
        gUEwLw+oaHSCEHpOQQqPN0QyrhX1coV3/MN+lmWBwG+vKvoVlod9W5xCicooisdu4n1nTU7Mq2n6y
        7JNLDQZZQSPG0KzTjZgWx9ut1uxiLzcHde/8315/+oLmcylFihTP6iPHWLZFNQBhOf6TdqVO/IDdH
        /GLZrYWA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48682 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fZjPF-007e9g-3n; Sun, 01 Jul 2018 20:57:13 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] f2fs: Replace strncpy with memcpy
Date:   Sun,  1 Jul 2018 13:57:06 -0700
Message-Id: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 8.1.0 complains:

fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
fs/f2fs/namei.c:257:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length
fs/f2fs/namei.c:249:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/f2fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 231b7f3ea7d3..e75607544f7c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 		return -EINVAL;
 
 	if (hot) {
-		strncpy(extlist[count], name, strlen(name));
+		memcpy(extlist[count], name, strlen(name));
 		sbi->raw_super->hot_ext_count = hot_count + 1;
 	} else {
 		char buf[F2FS_MAX_EXTENSION][F2FS_EXTENSION_LEN];
@@ -254,7 +254,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 		memcpy(buf, &extlist[cold_count],
 				F2FS_EXTENSION_LEN * hot_count);
 		memset(extlist[cold_count], 0, F2FS_EXTENSION_LEN);
-		strncpy(extlist[cold_count], name, strlen(name));
+		memcpy(extlist[cold_count], name, strlen(name));
 		memcpy(&extlist[cold_count + 1], buf,
 				F2FS_EXTENSION_LEN * hot_count);
 		sbi->raw_super->extension_count = cpu_to_le32(cold_count + 1);
-- 
2.7.4

