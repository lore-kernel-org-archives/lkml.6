Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1943AC71151
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C2820645
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C2820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeJGAzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeJGAzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87FC9859FF;
        Sat,  6 Oct 2018 17:50:53 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6B6718999;
        Sat,  6 Oct 2018 17:50:49 +0000 (UTC)
Date:   Sat, 6 Oct 2018 19:51:22 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w hint
Message-ID: <20181006175122.GA16521@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 06 Oct 2018 17:50:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit message in the original commit v4.13-rc1~212^2~51,
as well as userspace library[1] and man page update[2], R/W hint constants
are intended to have RWH_* prefix. However, RWF_WRITE_LIFE_NOT_SET retained
"RWF_*" prefix used in earlyy versions of the proposed patch set[3].
Rename it and provide the old name as a synonym for the new one
for backward compatibility.

[1] https://github.com/axboe/fio/commit/bd553af6c849
[2] https://github.com/mkerrisk/man-pages/commit/580082a186fd
[3] https://www.mail-archive.com/linux-block@vger.kernel.org/msg09638.html

Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 fs/fcntl.c                       | 2 +-
 include/uapi/linux/fcntl.h       | 9 ++++++++-
 tools/include/uapi/linux/fcntl.h | 9 ++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 4137d96..8f312fc 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -261,7 +261,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 static bool rw_hint_valid(enum rw_hint hint)
 {
 	switch (hint) {
-	case RWF_WRITE_LIFE_NOT_SET:
+	case RWH_WRITE_LIFE_NOT_SET:
 	case RWH_WRITE_LIFE_NONE:
 	case RWH_WRITE_LIFE_SHORT:
 	case RWH_WRITE_LIFE_MEDIUM:
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6448cdd..e8f878a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -57,7 +57,7 @@
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
  */
-#define RWF_WRITE_LIFE_NOT_SET	0
+#define RWH_WRITE_LIFE_NOT_SET	0
 #define RWH_WRITE_LIFE_NONE	1
 #define RWH_WRITE_LIFE_SHORT	2
 #define RWH_WRITE_LIFE_MEDIUM	3
@@ -65,6 +65,13 @@
 #define RWH_WRITE_LIFE_EXTREME	5
 
 /*
+ * The originally introduced spelling remained from the first
+ * versions of the patch set that introduced the feature,
+ * v4.13-rc1~212^2~51.
+ */
+#define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
+
+/*
  * Types of directory notifications that may be requested.
  */
 #define DN_ACCESS	0x00000001	/* File accessed */
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 6448cdd..e8f878a 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -57,7 +57,7 @@
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
  */
-#define RWF_WRITE_LIFE_NOT_SET	0
+#define RWH_WRITE_LIFE_NOT_SET	0
 #define RWH_WRITE_LIFE_NONE	1
 #define RWH_WRITE_LIFE_SHORT	2
 #define RWH_WRITE_LIFE_MEDIUM	3
@@ -65,6 +65,13 @@
 #define RWH_WRITE_LIFE_EXTREME	5
 
 /*
+ * The originally introduced spelling remained from the first
+ * versions of the patch set that introduced the feature,
+ * v4.13-rc1~212^2~51.
+ */
+#define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
+
+/*
  * Types of directory notifications that may be requested.
  */
 #define DN_ACCESS	0x00000001	/* File accessed */
-- 
2.1.4

