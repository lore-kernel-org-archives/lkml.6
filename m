Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeDSBQQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:16:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40338 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752738AbeDSBQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:16:15 -0400
From: Li Bin <huawei.libin@huawei.com>
To: Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <huawei.libin@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH v2] prctl: fix compat handling for prctl
Date: Thu, 19 Apr 2018 09:06:06 +0800
Message-ID: <1524099966-43544-1-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member auxv in prctl_mm_map structure which be shared with
userspace is pointer type, but the kernel supporting COMPAT didn't
handle it. This patch fix the compat handling for prctl syscall.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 kernel/sys.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index ad69218..d4259938 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1969,6 +1969,26 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
+
+#ifdef CONFIG_COMPAT
+struct compat_prctl_mm_map {
+	__u64   start_code;     /* code section bounds */
+	__u64   end_code;
+	__u64   start_data;     /* data section bounds */
+	__u64   end_data;
+	__u64   start_brk;      /* heap for brk() syscall */
+	__u64   brk;
+	__u64   start_stack;        /* stack starts at */
+	__u64   arg_start;      /* command line arguments bounds */
+	__u64   arg_end;
+	__u64   env_start;      /* environment variables bounds */
+	__u64   env_end;
+	compat_uptr_t   auxv;   /* auxiliary vector */
+	__u32   auxv_size;      /* vector size */
+	__u32   exe_fd;         /* /proc/$pid/exe link file */
+};
+#endif
+
 static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data_size)
 {
 	struct prctl_mm_map prctl_map = { .exe_fd = (u32)-1, };
@@ -1986,6 +2006,28 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	if (data_size != sizeof(prctl_map))
 		return -EINVAL;
 
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_prctl_mm_map prctl_map32;
+		if (copy_from_user(&prctl_map32, addr, sizeof(prctl_map32)))
+			return -EFAULT;
+
+		prctl_map.start_code = prctl_map32.start_code;
+		prctl_map.end_code = prctl_map32.end_code;
+		prctl_map.start_data = prctl_map32.start_data;
+		prctl_map.end_data = prctl_map32.end_data;
+		prctl_map.start_brk = prctl_map32.start_brk;
+		prctl_map.brk = prctl_map32.brk;
+		prctl_map.start_stack = prctl_map32.start_stack;
+		prctl_map.arg_start = prctl_map32.arg_start;
+		prctl_map.arg_end = prctl_map32.arg_end;
+		prctl_map.env_start = prctl_map32.env_start;
+		prctl_map.env_end = prctl_map32.env_end;
+		prctl_map.auxv = compat_ptr(prctl_map32.auxv);
+		prctl_map.auxv_size = prctl_map32.auxv_size;
+		prctl_map.exe_fd = prctl_map32.exe_fd;
+	} else
+#endif
 	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
 		return -EFAULT;
 
-- 
1.7.12.4
