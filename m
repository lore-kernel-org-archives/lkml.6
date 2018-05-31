Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeEaLXY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:23:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754822AbeEaLWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:49 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        <linux-bcache@vger.kernel.org>
Subject: [PATCH v2 19/21] bcache: use match_string() helper
Date: Thu, 31 May 2018 19:11:24 +0800
Message-ID: <1527765086-19873-20-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-bcache@vger.kernel.org 
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/md/bcache/util.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 74febd5..cd1f4fd 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -136,22 +136,17 @@ ssize_t bch_snprint_string_list(char *buf, size_t size, const char * const list[
 
 ssize_t bch_read_string_list(const char *buf, const char * const list[])
 {
-	size_t i;
+	ssize_t i;
 	char *s, *d = kstrndup(buf, PAGE_SIZE - 1, GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
 	s = strim(d);
 
-	for (i = 0; list[i]; i++)
-		if (!strcmp(list[i], s))
-			break;
+	i = match_string(list, -1, s);
 
 	kfree(d);
 
-	if (!list[i])
-		return -EINVAL;
-
 	return i;
 }
 
-- 
1.7.12.4
