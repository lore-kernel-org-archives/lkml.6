Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030499AbeEYVqc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:46:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030291AbeEYVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:46:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] procfs: use inline functions instead of macros for proc_create_single_data stub
Date: Fri, 25 May 2018 23:45:00 +0200
Message-Id: <20180525214548.2122779-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:pjWjjUxM59AzxV4VH5Q5xayjthbeTTq9P5SZXZNErwcBwbJ5cU7
 sY/8qrk4dIVJHCcQEeDJL6z2DnqfyPXBiGK8pJWeRZOH7h42O3xyuPDtFOzagmseFQHd1St
 0TO9aQOFdE4813KwQYXuEOSLoghFkTZg/aFb/qd1xPG+NDBRGCqBmxfQ7SN5iJPSNSrYDmA
 bN8TN/KfcY9hI8vcv6dgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fBKHoYUNifg=:GwXV8euQVo43dxGT2ra0ws
 LBxqUKQtIAgZ7kGYn/QMDzFmqSURKCWvmT/uL+/TAOkBgpXWPKg/MSj2ulcyoiSsccwazps9L
 1REPxXvASH/nQBSLfPliMxEjSx7MZhoh8DgO27qoK9ObqJeC8DUG6NDGSdo87GdrEOb6GX/pf
 B/zwRz/rpUy6y2GjRgRgZJUYeVxEt++ldekMMCkF0uJmXhgb/qsTe1pM3nmlvnA5IDcjqfMT4
 WDbpXYnnATLK5bXTa6l2tKcHiEPLi4zrxblCU0SmiwrJjGyFaF5+r1n4987mXCCT4u248tv+r
 7wiJ2UlWP7P8z6GQdC0yeB3lUpvbbyp0VSanQp2PrBo9m3cWF4d1CpemvTLk3qo3Y6JGfltWL
 XSnl9nimSxWtxH42K6cCxz2RFTYOC3Bi84ONVbUWLUEG50emx8CQSOvAXeCU1aKBsXT/hY+dd
 wxGT2560KfhRWZTjbO+A7D3/POxPjPywqKt2YxFHPS8HQhtwDRUS75Ac1cBhF3KdYHTNJjAVa
 MePSXaQZySBiuoGK/1OdZnaTwSxCHqKV+LmfsSwQTovL6bjEOCx9ixCzV5x+BoV5V5AEFE4xe
 tEBLcO4/RP4OTbN29KDGevBiuPXGOaY6O/YyT24H2X8xOAhJhp529qve5hPkFWxROti/y6m8N
 poyy8vukXoQsHO54PHRROSGI4MCBeeP36JN6fpJ/JTgC5p2ma53Wp++0bE9lBgQhCA3k=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The procfs interface changes caused one warning in afs for
a now unused function:

fs/afs/proc.c:818:12: error: 'afs_proc_stats_show' defined but not used [-Werror=unused-function]
 static int afs_proc_stats_show(struct seq_file *m, void *v)

This can be avoided by using an inline function instead of a macro
to reference it, so now the compiler can silently drop the function
after seeing that there is a reference but that it is never called.

Unfortunately, this change triggers another warning where a function
is hidden and now unexpectedly referenced:

drivers/mtd/mtdcore.c: In function 'init_mtd':
drivers/mtd/mtdcore.c:1878:48: error: 'mtd_proc_show' undeclared (first use in this function); did you mean 'mtd_name_show'?

It seems nicer to keep using the inline function and removing the #ifdef
here than to add an #ifdef around every single function we pass into
proc_create_single_data(), so I'm removing the #ifdef here.

After a few hundred randconfig builds, this was the only instance
I found that caused a problem.

Fixes: 353861cf0594 ("afs: simplify procfs code")
Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/mtdcore.c   |  3 ---
 include/linux/proc_fs.h | 10 ++++++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 42395df06be9..08d1e89faf9c 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1814,8 +1814,6 @@ void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size)
 }
 EXPORT_SYMBOL_GPL(mtd_kmalloc_up_to);
 
-#ifdef CONFIG_PROC_FS
-
 /*====================================================================*/
 /* Support for /proc/mtd */
 
@@ -1833,7 +1831,6 @@ static int mtd_proc_show(struct seq_file *m, void *v)
 	mutex_unlock(&mtd_table_mutex);
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
 
 /*====================================================================*/
 /* Init code */
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index e518352137e7..3b44c357a6e7 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -84,8 +84,14 @@ static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
 #define proc_create_seq_private(name, mode, parent, ops, size, data) ({NULL;})
 #define proc_create_seq_data(name, mode, parent, ops, data) ({NULL;})
 #define proc_create_seq(name, mode, parent, ops) ({NULL;})
-#define proc_create_single(name, mode, parent, show) ({NULL;})
-#define proc_create_single_data(name, mode, parent, show, data) ({NULL;})
+static inline struct proc_dir_entry *proc_create_single_data(const char *name,
+		umode_t mode, struct proc_dir_entry *parent,
+		int (*show)(struct seq_file *, void *), void *data)
+{
+	return NULL;
+}
+#define proc_create_single(name, mode, parent, show) \
+	proc_create_single_data(name, mode, parent, show, NULL)
 #define proc_create(name, mode, parent, proc_fops) ({NULL;})
 #define proc_create_data(name, mode, parent, proc_fops, data) ({NULL;})
 
-- 
2.9.0
