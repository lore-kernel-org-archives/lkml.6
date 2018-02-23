Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBWG64 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:58:56 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44210 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeBWG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:58:54 -0500
X-Google-Smtp-Source: AH8x225LP+CgYcJsu5YaN2CNW9LG+z/MzfMjvkXmb07g77pJ/yxRBYtaF6yqins9VcGfKShzMO45GQ==
From: Yafang Shao <laoar.shao@gmail.com>
To: dsa@cumulusnetworks.com, ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next] bpf: NULL pointer check is not needed in BPF_CGROUP_RUN_PROG_INET_SOCK
Date: Fri, 23 Feb 2018 14:58:41 +0800
Message-Id: <1519369121-22269-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sk is already allocated in inet_create/inet6_create, hence when
BPF_CGROUP_RUN_PROG_INET_SOCK is executed sk will never be NULL.

The logic is as bellow,
	sk = sk_alloc();
	if (!sk)
		goto out;
	BPF_CGROUP_RUN_PROG_INET_SOCK(sk);

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a7f16e0..8a45666 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -96,7 +96,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk)				       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled && sk) {					       \
+	if (cgroup_bpf_enabled) {					       \
 		__ret = __cgroup_bpf_run_filter_sk(sk,			       \
 						 BPF_CGROUP_INET_SOCK_CREATE); \
 	}								       \
--
1.8.3.1
