Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeBJBfT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:35:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40278 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJBfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:35:18 -0500
Date: Sat, 10 Feb 2018 01:35:16 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mconsole_proc(): don't mess with file->f_pos
Message-ID: <20180210013515.GM30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mconsole_proc(): don't mess with file->f_pos
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index c4d162a94be9..d5f9a2d1da1b 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -130,6 +130,7 @@ void mconsole_proc(struct mc_request *req)
 	struct file *file;
 	int first_chunk = 1;
 	char *ptr = req->request.data;
+	loff_t pos = 0;
 
 	ptr += strlen("proc");
 	ptr = skip_spaces(ptr);
@@ -148,7 +149,7 @@ void mconsole_proc(struct mc_request *req)
 	}
 
 	do {
-		len = kernel_read(file, buf, PAGE_SIZE - 1, &file->f_pos);
+		len = kernel_read(file, buf, PAGE_SIZE - 1, &pos);
 		if (len < 0) {
 			mconsole_reply(req, "Read of file failed", 1, 0);
 			goto out_free;
