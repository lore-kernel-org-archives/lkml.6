Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeCPXVw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 19:21:52 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36454 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeCPXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 19:21:51 -0400
X-Google-Smtp-Source: AG47ELtqT6vXCjURcHxb1nkpCaJDgGmJxM1XolEXWWNrjWrBj4eJqYOPv5bn3jVhHnN0bJvaNPuNng==
Date: Sat, 17 Mar 2018 02:21:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] proc: fixup test for read
Message-ID: <20180316232147.GA20146@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/kmsg can and will block if read under root.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/read.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -54,7 +54,8 @@ static void f_reg(DIR *d, const char *filename)
 	int fd;
 	ssize_t rv;
 
-	fd = openat(dirfd(d), filename, O_RDONLY);
+	/* read from /proc/kmsg can block */
+	fd = openat(dirfd(d), filename, O_RDONLY|O_NONBLOCK);
 	if (fd == -1)
 		return;
 	rv = read(fd, buf, sizeof(buf));
