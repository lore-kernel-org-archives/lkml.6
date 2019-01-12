Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF59C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8715420835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfALP3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:29:24 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34295 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbfALP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:29:09 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0CFSn53026596;
        Sat, 12 Jan 2019 16:28:49 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Silvio Cesare <silvio.cesare@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: [PATCH 1/8] lkdtm: change snprintf to scnprintf for possible overflow
Date:   Sat, 12 Jan 2019 16:28:37 +0100
Message-Id: <20190112152844.26550-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Silvio Cesare <silvio.cesare@gmail.com>

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>

---
 drivers/misc/lkdtm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..610aa3bfe630 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -347,9 +347,9 @@ static ssize_t lkdtm_debugfs_read(struct file *f, char __user *user_buf,
 	if (buf == NULL)
 		return -ENOMEM;
 
-	n = snprintf(buf, PAGE_SIZE, "Available crash types:\n");
+	n = scnprintf(buf, PAGE_SIZE, "Available crash types:\n");
 	for (i = 0; i < ARRAY_SIZE(crashtypes); i++) {
-		n += snprintf(buf + n, PAGE_SIZE - n, "%s\n",
+		n += scnprintf(buf + n, PAGE_SIZE - n, "%s\n",
 			      crashtypes[i].name);
 	}
 	buf[n] = '\0';
-- 
2.19.2

