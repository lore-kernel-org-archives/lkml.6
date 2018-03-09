Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeCIW1P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:27:15 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35928 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbeCIW1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:27:13 -0500
X-Google-Smtp-Source: AG47ELvsCHU8o4HQWhAQ2YbaZnMR08go8tmFfJTyWxpma0crq+k44qPOPHKs9hLnUonG+tbkxLJqyQ==
Date: Sat, 10 Mar 2018 01:27:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: register filesystem last
Message-ID: <20180309222709.GA3843@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As soon as register_filesystem() exits, filesystem can be mounted.
It is better to present fully operational /proc.

Of course it doesn't matter because /proc is not modular
but do it anyway.

Drop error check, it should be handled by panicking.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/root.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -123,14 +123,8 @@ static struct file_system_type proc_fs_type = {
 
 void __init proc_root_init(void)
 {
-	int err;
-
 	proc_init_kmemcache();
 	set_proc_pid_nlink();
-	err = register_filesystem(&proc_fs_type);
-	if (err)
-		return;
-
 	proc_self_init();
 	proc_thread_self_init();
 	proc_symlink("mounts", NULL, "self/mounts");
@@ -146,6 +140,8 @@ void __init proc_root_init(void)
 	proc_tty_init();
 	proc_mkdir("bus", NULL);
 	proc_sys_init();
+
+	register_filesystem(&proc_fs_type);
 }
 
 static int proc_root_getattr(const struct path *path, struct kstat *stat,
