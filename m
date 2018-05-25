Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936336AbeEYPQW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:16:22 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936219AbeEYPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:16:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xfs, proc: hide unused xfs procfs helpers
Date: Fri, 25 May 2018 17:16:04 +0200
Message-Id: <20180525151612.2408651-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:KtKvff3PowapyjyoDc7YePxu+538PDk/vmtiZvTlzkZ9jp3jNqQ
 gFIIPiaP5OVaSnYTjVpL6Afp0UZgJh8hy3I4ITJbMJ58R8PGU/pL/THI63R1am6/WFPG/Ma
 e5QT8bmPMPBa7Upqg+o+9+2GefQCQO7AYaAnYdnuZFZJLmz3rV4/1rduXO7Tpg9tcPL93cD
 TIevAQjTXU50apx9tAu8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KYjekaY/82g=:aC0OrA92Kqr3ibM1KDrG0a
 obzMphQ4lU6V6m1+Dc7dguLWIBZOk6+gMsHzxBryJR685rnXlFkEhHsoAffQbUdKm+Tt0TnKB
 FEISNvp1EM5/VFcn0hw5zO4OvERXZNt6S7TbMPYrU5eraL4bcdmd/Vg4bzuut5Z9Y9ZxVOXz6
 gdeVmHZ0tOJfHP93//T64RKrArdB5fFjPqHD7/9dQmiMEwXWCMOiWTJqOvV2szG3vcWOZHp8I
 5+a0QcM5jZ3ODqKqkDnzyI8RhMlkS/19bthrm3mIZ08hcgU6HXNy68jeJGuByy7WCdOAi4VUg
 1xbjdDM7WPgWOFnPS4eYb+ocZhCJRye2zgfViJ8YyYIq6WxnVCoQPq3zHmIYhINc7vbcRWZRA
 2SzfN5btq9m4S4+TgjubgAHbsEpbl1JQUealdkABRY//kRICBPzo6dJnBsAEIlU8cwf2IuyJJ
 4r6RUKW9Rll9LdbTyHaiVq6kp763pbe5Wx949PLyHJhLEztrgiAsSpbN2WDWfnYGv2TboqYcH
 xX8VfuSFk+5E7AzR2hVkKSVi0TRMK7WjaHwJWIOOTEzUq194E3wyvC8/27Xq/vJDrKkYtknAa
 zheEPAuEDFVmUtr6+vz2NsSMIvVgV400exqA5Jygwezq4YmUvhovAJM3UWCSbzF9sY0vcaFXp
 Khpxyyw//zOBWebEj5zjKz0eTbN2gkiKm6sc+VC/A3TFVOqS5BoafrC/ECDiEn1KDASQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions now trigger a warning when CONFIG_PROC_FS is disabled:

fs/xfs/xfs_stats.c:128:12: error: 'xqmstat_proc_show' defined but not used [-Werror=unused-function]
 static int xqmstat_proc_show(struct seq_file *m, void *v)
            ^~~~~~~~~~~~~~~~~
fs/xfs/xfs_stats.c:118:12: error: 'xqm_proc_show' defined but not used [-Werror=unused-function]
 static int xqm_proc_show(struct seq_file *m, void *v)
            ^~~~~~~~~~~~~

Previously, they were referenced from an unused 'static const' structure,
which is silently dropped by gcc.

We can address the warning by adding the same #ifdef around them that
hides the reference.

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The warning was caused by a patch in Al's VFS tree, so the fix
needs to go through the same one.
---
 fs/xfs/xfs_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
index 04762a72e344..1cc79907b377 100644
--- a/fs/xfs/xfs_stats.c
+++ b/fs/xfs/xfs_stats.c
@@ -113,6 +113,7 @@ void xfs_stats_clearall(struct xfsstats __percpu *stats)
 	}
 }
 
+#ifdef CONFIG_PROC_FS
 /* legacy quota interfaces */
 #ifdef CONFIG_XFS_QUOTA
 static int xqm_proc_show(struct seq_file *m, void *v)
@@ -137,7 +138,6 @@ static int xqmstat_proc_show(struct seq_file *m, void *v)
 }
 #endif /* CONFIG_XFS_QUOTA */
 
-#ifdef CONFIG_PROC_FS
 int
 xfs_init_procfs(void)
 {
-- 
2.9.0
