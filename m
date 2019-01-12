Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4BE20835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfALP3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:29:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34305 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfALP3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:29:30 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0CFSo0s026598;
        Sat, 12 Jan 2019 16:28:50 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Silvio Cesare <silvio.cesare@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: [PATCH 3/8] ocfs2: change snprintf to scnprintf for possible overflow
Date:   Sat, 12 Jan 2019 16:28:39 +0100
Message-Id: <20190112152844.26550-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20190112152844.26550-1-w@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
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
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>

---
 fs/ocfs2/cluster/heartbeat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 9b2ed62dd638..2a0af0887ba0 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1324,7 +1324,7 @@ static int o2hb_debug_open(struct inode *inode, struct file *file)
 
 	case O2HB_DB_TYPE_REGION_NUMBER:
 		reg = (struct o2hb_region *)db->db_data;
-		out += snprintf(buf + out, PAGE_SIZE - out, "%d\n",
+		out += scnprintf(buf + out, PAGE_SIZE - out, "%d\n",
 				reg->hr_region_num);
 		goto done;
 
@@ -1334,12 +1334,12 @@ static int o2hb_debug_open(struct inode *inode, struct file *file)
 		/* If 0, it has never been set before */
 		if (lts)
 			lts = jiffies_to_msecs(jiffies - lts);
-		out += snprintf(buf + out, PAGE_SIZE - out, "%lu\n", lts);
+		out += scnprintf(buf + out, PAGE_SIZE - out, "%lu\n", lts);
 		goto done;
 
 	case O2HB_DB_TYPE_REGION_PINNED:
 		reg = (struct o2hb_region *)db->db_data;
-		out += snprintf(buf + out, PAGE_SIZE - out, "%u\n",
+		out += scnprintf(buf + out, PAGE_SIZE - out, "%u\n",
 				!!reg->hr_item_pinned);
 		goto done;
 
@@ -1348,8 +1348,8 @@ static int o2hb_debug_open(struct inode *inode, struct file *file)
 	}
 
 	while ((i = find_next_bit(map, db->db_len, i + 1)) < db->db_len)
-		out += snprintf(buf + out, PAGE_SIZE - out, "%d ", i);
-	out += snprintf(buf + out, PAGE_SIZE - out, "\n");
+		out += scnprintf(buf + out, PAGE_SIZE - out, "%d ", i);
+	out += scnprintf(buf + out, PAGE_SIZE - out, "\n");
 
 done:
 	i_size_write(inode, out);
-- 
2.19.2

