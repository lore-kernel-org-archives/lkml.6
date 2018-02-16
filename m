Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeBPUeF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:34:05 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:37473 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeBPUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:33:59 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="139025483"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 03/15] initramfs: store file name in name_buf
Date: Fri, 16 Feb 2018 20:33:39 +0000
Message-Id: <1518813234-5874-4-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already name_buf buffer pre-allocated for a file name. No need
to allocate vcollected for every file. More over a name can be already
stored in name_buf by read_info() function.

Add memcpy_optional() function to handle such case.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 49cd2681a26f..b6ee675e5cdb 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -210,7 +210,6 @@ static inline void __init eat(unsigned n)
 	byte_count -= n;
 }
 
-static __initdata char *vcollected;
 static __initdata char *collected;
 static long remains __initdata;
 static __initdata char *collect;
@@ -324,6 +323,13 @@ static void __init clean_path(char *path, umode_t fmode)
 	}
 }
 
+static void *memcpy_optional(void *dest, const void *src, size_t n)
+{
+	if (dest != src)
+		return memcpy(dest, src, n);
+	return dest;
+}
+
 static __initdata int wfd;
 
 static int __init do_name(void)
@@ -348,7 +354,8 @@ static int __init do_name(void)
 				sys_fchmod(wfd, mode);
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
-				vcollected = kstrdup(collected, GFP_KERNEL);
+				memcpy_optional(name_buf, collected,
+						N_ALIGN(name_len));
 				state = do_copy;
 			}
 		}
@@ -375,8 +382,7 @@ static int __init do_copy(void)
 		if (xwrite(wfd, victim, body_len) != body_len)
 			error("write error");
 		sys_close(wfd);
-		do_utime(vcollected, mtime);
-		kfree(vcollected);
+		do_utime(name_buf, mtime);
 		eat(body_len);
 		state = do_skip;
 		return 0;
-- 
2.10.3.dirty
