Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756080AbeDYRlV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:41:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756042AbeDYRlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:41:14 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 3/3] tools bpftool: Display license GPL compatible in prog show/list
Date: Wed, 25 Apr 2018 19:41:08 +0200
Message-Id: <20180425174108.6586-4-jolsa@kernel.org>
In-Reply-To: <20180425174108.6586-1-jolsa@kernel.org>
References: <20180425174108.6586-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display the license GPL NON/compatible string in bpftool
prog command, like:

  # bpftool prog list
  3: kprobe  name func_begin  tag 57cd311f2e27366b license GPL NON compatible
          loaded_at Apr 25/11:20  uid 0
          xlated 16B  not jited  memlock 4096B

  # bpftool prog list
  4: kprobe  name func_begin  tag 57cd311f2e27366b license GPL compatible
          loaded_at Apr 25/11:20  uid 0
          xlated 16B  not jited  memlock 4096B

  # bpftool prog show --json
  [{"id":3,"type":"kprobe","name":"func ... ,"gpl_compatible":false,"loade...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/prog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 548adb9b7317..b8b4341a1342 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -235,6 +235,8 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 		     info->tag[0], info->tag[1], info->tag[2], info->tag[3],
 		     info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
 
+	jsonw_bool_field(json_wtr, "gpl_compatible", info->gpl_compatible);
+
 	print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
 
 	if (info->load_time) {
@@ -295,6 +297,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 	printf("tag ");
 	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
 	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
+	printf(" license GPL %scompatible", info->gpl_compatible ? "" : "NON ");
 	printf("\n");
 
 	if (info->load_time) {
-- 
2.13.6
