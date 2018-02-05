Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeBERb3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:31:29 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33523 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeBERbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:31:19 -0500
X-Google-Smtp-Source: AH8x224TFJN/qUhugf09WaTp8olgB+aYUaOMB9PxmZTsfsLOZtjbJ66zy+kq42lzLerD237CUW7KBw==
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: George Spelvin <linux@sciencehorizons.net>,
        Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
Date: Mon,  5 Feb 2018 19:32:18 +0200
Message-Id: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment claims that this helper will try not to loose bits, but
for 64bit long it looses the high bits before hashing 64bit long into
32bit int. Use the helper hash_long() to do the right thing for 64bit
long. For 32bit long, there is no change.

All the callers of end_name_hash() either assign the result to
qstr->hash, which is u32 or return the result as an int value (e.g.
full_name_hash()). Change the helper return type to int to conform to
its users.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Linus,

This file doesn't have any explicit maintainer and it has your fingerprints
on it. Also, the alleged issue is there since git epoc, so.. please tell me,
am I interpreting "try to avoid losing bits" wrong?

For context, I have been working on a flavor full_name_long_hash() that
does not cut down the higher bits for 64bits long when I ran into this.

Assuming the fix is not moronic, I wouldn't even know where to begin testing
its affects, or how to prove if there really is a problem.
Any suggestions?

Thanks,
Amir.

 include/linux/stringhash.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stringhash.h b/include/linux/stringhash.h
index e8f0f852968f..c0c5c5b73dc0 100644
--- a/include/linux/stringhash.h
+++ b/include/linux/stringhash.h
@@ -50,9 +50,9 @@ partial_name_hash(unsigned long c, unsigned long prevhash)
  * losing bits).  This also has the property (wanted by the dcache)
  * that the msbits make a good hash table index.
  */
-static inline unsigned long end_name_hash(unsigned long hash)
+static inline unsigned int end_name_hash(unsigned long hash)
 {
-	return __hash_32((unsigned int)hash);
+	return hash_long(hash, 32);
 }
 
 /*
-- 
2.7.4
