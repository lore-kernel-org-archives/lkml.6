Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeCJAM2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:12:28 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40351 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCJAM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:12:26 -0500
X-Google-Smtp-Source: AG47ELvPhJhfMqJwOy2w9pBt9ApEAeix6fCso5xsFRC7nuYZpiqsBYzdWMNb2C5kOfCD2Oed60nlaA==
Date: Sat, 10 Mar 2018 03:12:23 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, eric.dumazet@gmail.com,
        xiyou.wangcong@gmail.com, fw@strlen.de
Subject: [PATCH] proc: reject "." and ".." as filenames
Message-ID: <20180310001223.GB12443@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various subsystems can create files and directories in /proc
with names directly controlled by userspace.

Which means "/", "." and ".." are no-no.

"/" split is already taken care of, do the other 2 prohibited names.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -366,6 +366,14 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 		WARN(1, "name len %u\n", qstr.len);
 		return NULL;
 	}
+	if (qstr.len == 1 && fn[0] == '.') {
+		WARN(1, "name '.'\n");
+		return NULL;
+	}
+	if (qstr.len == 2 && fn[0] == '.' && fn[1] == '.') {
+		WARN(1, "name '..'\n");
+		return NULL;
+	}
 	if (*parent == &proc_root && name_to_int(&qstr) != ~0U) {
 		WARN(1, "create '/proc/%s' by hand\n", qstr.name);
 		return NULL;
