Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE46FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D95D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D95D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeGSUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:40:14 -0400
Received: from www.osadl.org ([62.245.132.105]:53769 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbeGSUkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:40:13 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6JJsNAG005161;
        Thu, 19 Jul 2018 21:54:23 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] fs: drop duplicated bit in bitmask
Date:   Thu, 19 Jul 2018 21:53:31 +0200
Message-Id: <1532030011-736-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of VALID_OPEN_FLAGS contains O_NDELAY two times which
is unnecessary. The duplication has no actual effect so this is just
a minor code cleanup and fixes a coccinelle warning.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem found by coccicheck: doublebitand.cocci
message: ./include/linux/fcntl.h:10:13-21: duplicated argument to & or |

Patch was compile tested with: x86_64_defconfig (built fs/open.c and
fs/fcntl.c)
with some sparse warnings in both cases - not related to the proposed
change though

Patch is against 4.18-rc5 (localversion-next is next-20180719)

 include/linux/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 27dc7a6..72df1b8 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -7,7 +7,7 @@
 /* list of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
-	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
+	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
-- 
2.1.4

