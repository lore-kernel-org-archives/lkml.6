Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D760C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0850A213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0850A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJDJtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:49:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52400 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727209AbeJDJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:49:07 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w942uhDS020677
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 19:57:59 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mw6bprnch-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 19:57:59 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.18) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 19:57:57 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 36C54760B5F; Wed,  3 Oct 2018 19:57:51 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     "David S . Miller" <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <luto@amacapital.net>,
        <viro@zeniv.linux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 6/6] selftests/bpf: add a test for BPF_CGROUP_FILE_OPEN
Date:   Wed, 3 Oct 2018 19:57:50 -0700
Message-ID: <20181004025750.498303-7-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004025750.498303-1-ast@kernel.org>
References: <20181004025750.498303-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add bpf test for BPF_CGROUP_FILE_OPEN which attaches to a temporary cgroup and
- disallows further access to cgroup v2 file system for processes within this cgroup
- figures out mount_id of /etc, disallows access to this mnt_id,
  checks that /etc/hosts and /etc/hostname are no longer readable,
  re-allows access to /etc.
  Note that /etc is likely mounted as part of /, so the test disallows access to / mount
- figures out dev/inode of /etc/hosts file and disallows access to this file

cgroup local storage is used to pass information between user space control program
and bpf program attached to BPF_CGROUP_FILE_OPEN hook

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/test_file_open.c  | 154 ++++++++++++++++++
 .../selftests/bpf/test_file_open_common.h     |  13 ++
 .../selftests/bpf/test_file_open_kern.c       |  48 ++++++
 5 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_file_open.c
 create mode 100644 tools/testing/selftests/bpf/test_file_open_common.h
 create mode 100644 tools/testing/selftests/bpf/test_file_open_kern.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 8a60c9b9892d..a332b39bed68 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -25,3 +25,4 @@ test_cgroup_storage
 test_select_reuseport
 test_flow_dissector
 flow_dissector_load
+test_file_open
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1381ab81099c..89a0fd955c8e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -24,7 +24,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
 	test_socket_cookie test_cgroup_storage test_select_reuseport test_section_names \
-	test_netcnt
+	test_netcnt test_file_open
 
 TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test_obj_id.o \
 	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_prog.o     \
@@ -36,7 +36,8 @@ TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test
 	test_get_stack_rawtp.o test_sockmap_kern.o test_sockhash_kern.o \
 	test_lwt_seg6local.o sendmsg4_prog.o sendmsg6_prog.o test_lirc_mode2_kern.o \
 	get_cgroup_id_kern.o socket_cookie_prog.o test_select_reuseport_kern.o \
-	test_skb_cgroup_id_kern.o bpf_flow.o netcnt_prog.o test_sk_lookup_kern.o
+	test_skb_cgroup_id_kern.o bpf_flow.o netcnt_prog.o test_sk_lookup_kern.o \
+	test_file_open_kern.o
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
@@ -74,6 +75,7 @@ $(OUTPUT)/test_progs: trace_helpers.c
 $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 $(OUTPUT)/test_netcnt: cgroup_helpers.c
+$(OUTPUT)/test_file_open: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/tools/testing/selftests/bpf/test_file_open.c b/tools/testing/selftests/bpf/test_file_open.c
new file mode 100644
index 000000000000..33716adafecf
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_file_open.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Facebook */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <assert.h>
+#include <sys/time.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <linux/kdev_t.h>
+
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "cgroup_helpers.h"
+#include "bpf_rlimit.h"
+#include "test_file_open_common.h"
+
+#define CGROUP_PROG "./test_file_open_kern.o"
+
+#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
+
+int main(int argc, char **argv)
+{
+	struct bpf_cgroup_storage_key key;
+	struct file_handle fhp[1] = {};
+	struct test_file_open_config cfg = {};
+	struct bpf_object *obj;
+	int error = EXIT_FAILURE;
+	int prog_fd, cgroup_fd;
+	struct bpf_map *map;
+	__u32 prog_cnt;
+	struct stat st;
+	int map_fd;
+
+	if (bpf_prog_load(CGROUP_PROG, BPF_PROG_TYPE_FILE_FILTER,
+			  &obj, &prog_fd)) {
+		printf("Failed to load FILE_FILTER program\n");
+		goto out;
+	}
+
+	map = bpf_object__find_map_by_name(obj, "local_storage");
+	if (!map) {
+		printf("Failed to find cgroup local storage map");
+		goto err;
+	}
+	map_fd = bpf_map__fd(map);
+
+	if (setup_cgroup_environment()) {
+		printf("Failed to load FILE_FILTER program\n");
+		goto err;
+	}
+
+	/* Create a cgroup, get fd, and join it */
+	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
+	if (!cgroup_fd) {
+		printf("Failed to create test cgroup\n");
+		goto err;
+	}
+
+	if (join_cgroup(TEST_CGROUP)) {
+		printf("Failed to join cgroup\n");
+		goto err;
+	}
+
+	/* few sanity checks before bpf prog is attached */
+	assert(system("cat /mnt/cgroup-test-work-dir" TEST_CGROUP "cgroup.procs >& /dev/null") == 0);
+	assert(system("cat /etc/hosts >& /dev/null") == 0);
+
+	/* Attach bpf program */
+	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_FILE_OPEN, 0)) {
+		perror("Failed to attach CGROUP_FILE_OPEN program");
+		goto err;
+	}
+
+	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
+		printf("Failed to get key in cgroup storage\n");
+		goto err;
+	}
+
+	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_FILE_OPEN, 0, NULL, NULL,
+			   &prog_cnt)) {
+		perror("Failed to query attached programs");
+		goto err;
+	}
+	assert(prog_cnt == 1);
+
+	/* check that this process cannot make any further changes to cgroup */
+	assert(system("cat /mnt/cgroup-test-work-dir" TEST_CGROUP "cgroup.procs >& /dev/null") != 0);
+
+	/* figure out the mnt_id of /etc */
+	if (name_to_handle_at(-1, "/etc", fhp, &cfg.mnt_id, 0) != -1 ||
+	    errno != EOVERFLOW) {
+		perror("name_to_handle_at failed");
+		goto err;
+	}
+
+	/* let bpf prog know /etc's mnt_id via cgroup local storage */
+	if (bpf_map_update_elem(map_fd, &key, &cfg, 0)) {
+		printf("Failed to update cgroup local storage\n");
+		goto err;
+	}
+
+	/* check that this process cannot read /etc any more */
+	assert(system("cat /etc/hosts >& /dev/null") != 0);
+	assert(system("cat /etc/hostname >& /dev/null") != 0);
+
+	/* set mnt_id back to zero */
+	cfg.mnt_id = 0;
+	if (bpf_map_update_elem(map_fd, &key, &cfg, 0)) {
+		printf("Failed to update cgroup local storage\n");
+		goto err;
+	}
+	/* access to /etc should work again */
+	assert(system("cat /etc/hosts >& /dev/null") == 0);
+
+	/* figure out inode of /etc/hosts */
+	if (stat("/etc/hosts", &st)) {
+		perror("stat failed");
+		goto err;
+	}
+	cfg.inode = st.st_ino;
+	cfg.dev_major = MAJOR(st.st_dev);
+	cfg.dev_minor = MINOR(st.st_dev);
+	if (bpf_map_update_elem(map_fd, &key, &cfg, 0)) {
+		printf("Failed to update cgroup local storage\n");
+		goto err;
+	}
+	/* check that this process cannot read /etc/hosts any more */
+	assert(system("cat /etc/hosts >& /dev/null") != 0);
+	/* but /etc/hostname is still ok */
+	assert(system("cat /etc/hostname >& /dev/null") == 0);
+
+	/*
+	 * detach from cgroup. Otherwise our own bpf prog will prevent us
+	 * from cleaning up the cgroup environment
+	 */
+	if (bpf_prog_detach(cgroup_fd, BPF_CGROUP_FILE_OPEN)) {
+		perror("Failed to detach");
+		goto err;
+	}
+
+	error = 0;
+	printf("test_file_open:PASS\n");
+
+err:
+	cleanup_cgroup_environment();
+
+out:
+	return error;
+}
diff --git a/tools/testing/selftests/bpf/test_file_open_common.h b/tools/testing/selftests/bpf/test_file_open_common.h
new file mode 100644
index 000000000000..d07b1f0ba28b
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_file_open_common.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Facebook */
+#ifndef __TEST_FILE_OPEN_COMMON_H
+#define __TEST_FILE_OPEN_COMMON_H
+
+struct test_file_open_config {
+	int mnt_id;
+	int dev_major;
+	int dev_minor;
+	int inode;
+};
+
+#endif
diff --git a/tools/testing/selftests/bpf/test_file_open_kern.c b/tools/testing/selftests/bpf/test_file_open_kern.c
new file mode 100644
index 000000000000..ea4b7a576b38
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_file_open_kern.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Facebook */
+#include <linux/bpf.h>
+#include <linux/magic.h>
+#include "bpf_helpers.h"
+#include "test_file_open_common.h"
+
+struct bpf_map_def SEC("maps") local_storage = {
+	.type = BPF_MAP_TYPE_CGROUP_STORAGE,
+	.key_size = sizeof(struct bpf_cgroup_storage_key),
+	.value_size = sizeof(struct test_file_open_config),
+};
+
+SEC("cgroup/file_open")
+int bpf_file_filter(struct bpf_file_info *f)
+{
+	char fmt1[] = "magic 0x%x mnt %d inode %ld\n";
+	char fmt2[] = "dev 0x%x link %d file %s\n";
+	char fmt3[] = "mode %o flags %o /etc mnt_id %d\n";
+	char path[400];
+	struct test_file_open_config *cfg;
+
+	cfg = bpf_get_local_storage(&local_storage, 0);
+
+	/* debugging prints */
+	bpf_get_file_path(f, path, sizeof(path));
+	bpf_trace_printk(fmt1, sizeof(fmt1), f->fs_magic, f->mnt_id, f->inode);
+	bpf_trace_printk(fmt2, sizeof(fmt2), (f->dev_major << 8) | f->dev_minor,
+			 f->nlink, path);
+	bpf_trace_printk(fmt3, sizeof(fmt3), f->mode, f->flags, cfg->mnt_id);
+
+	/* disallow access to cgroupv2 */
+	if (f->fs_magic == CGROUP2_SUPER_MAGIC)
+		return 0;
+
+	/* disallow access to given mount */
+	if (f->mnt_id == cfg->mnt_id)
+		return 0;
+
+	/* disallow access to a given file */
+	if (f->dev_major == cfg->dev_major &&
+	    f->dev_minor == cfg->dev_minor &&
+	    f->inode == cfg->inode)
+		return 0;
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.17.1

