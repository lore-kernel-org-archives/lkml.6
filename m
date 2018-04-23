Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeDWG7w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:59:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751535AbeDWG7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:59:32 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 3/3] tools bpftool: Display license in prog show/list
Date: Mon, 23 Apr 2018 08:59:27 +0200
Message-Id: <20180423065927.23127-4-jolsa@kernel.org>
In-Reply-To: <20180423065927.23127-1-jolsa@kernel.org>
References: <20180423065927.23127-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display the license string in bpftool prog command, like:

  # bpftool prog list
  1: kprobe  name func_begin  tag 59bef35a42fda602 license GPL
          loaded_at Apr 22/15:46  uid 0
          xlated 272B  not jited  memlock 4096B  map_ids 1

  # bpftool prog show --json
  [{"id":1,"type":"kprobe","name":"fun ... ,"license":"GPL", ... ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/prog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 548adb9b7317..ea5ede899cf7 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -235,6 +235,8 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 		     info->tag[0], info->tag[1], info->tag[2], info->tag[3],
 		     info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
 
+	jsonw_string_field(json_wtr, "license", info->license);
+
 	print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
 
 	if (info->load_time) {
@@ -295,8 +297,10 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 	printf("tag ");
 	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
 	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
+	printf(" license %s", info->license);
 	printf("\n");
 
+
 	if (info->load_time) {
 		char buf[32];
 
-- 
2.13.6
