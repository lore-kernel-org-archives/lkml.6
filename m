Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbeDCMKz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:10:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34870 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:10:53 -0400
X-Google-Smtp-Source: AIpwx4+sbqEopHm/d6IHwHdSGdIkzCLqdsiJDVaRjmwkz3wlnec55TOQYkWWPQmJaWSoQeCYJI1Szw==
From: Anders Roxell <anders.roxell@linaro.org>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] kernel/bpf/syscall: fix warning defined but not used
Date: Tue,  3 Apr 2018 14:09:47 +0200
Message-Id: <20180403120947.9321-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will be a build warning -Wunused-function if CONFIG_CGROUP_BPF
isn't defined, since the only user is inside #ifdef CONFIG_CGROUP_BPF:
kernel/bpf/syscall.c:1229:12: warning: ‘bpf_prog_attach_check_attach_type’
    defined but not used [-Wunused-function]
 static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Current code moves function bpf_prog_attach_check_attach_type inside
ifdef CONFIG_CGROUP_BPF.

Fixes: 5e43f899b03a ("bpf: Check attach type at prog load time")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/bpf/syscall.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7457f2676c6d..56f49557adda 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1226,18 +1226,6 @@ bpf_prog_load_check_attach_type(enum bpf_prog_type prog_type,
 	}
 }
 
-static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
-					     enum bpf_attach_type attach_type)
-{
-	switch (prog->type) {
-	case BPF_PROG_TYPE_CGROUP_SOCK:
-	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
-	default:
-		return 0;
-	}
-}
-
 /* last field in 'union bpf_attr' used by this command */
 #define	BPF_PROG_LOAD_LAST_FIELD expected_attach_type
 
@@ -1465,6 +1453,18 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 
 #ifdef CONFIG_CGROUP_BPF
 
+static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
+					     enum bpf_attach_type attach_type)
+{
+	switch (prog->type) {
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
+	default:
+		return 0;
+	}
+}
+
 #define BPF_PROG_ATTACH_LAST_FIELD attach_flags
 
 static int sockmap_get_from_fd(const union bpf_attr *attr,
-- 
2.16.2
