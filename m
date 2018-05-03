Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeECQFI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:05:08 -0400
Received: from foss.arm.com ([217.140.101.70]:43958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeECQFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:05:06 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org
Subject: [PATCH] bpf: fix possible spectre-v1 in find_and_alloc_map()
Date: Thu,  3 May 2018 17:04:59 +0100
Message-Id: <20180503160459.4111-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for userspace to control attr->map_type. Sanitize it when
using it as an array index to prevent an out-of-bounds value being used
under speculation.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
---
 kernel/bpf/syscall.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

I found this when running smatch over a v4.17-rc2 arm64 allyesconfig kernel.

IIUC this may allow for a speculative branch to an arbitrary gadget when we
subsequently call ops->map_alloc_check(attr).

Mark.

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4ca46df19c9a..8a7acd0dbeb6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -26,6 +26,7 @@
 #include <linux/cred.h>
 #include <linux/timekeeping.h>
 #include <linux/ctype.h>
+#include <linux/nospec.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PROG_ARRAY || \
 			   (map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
@@ -102,12 +103,14 @@ const struct bpf_map_ops bpf_map_offload_ops = {
 static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
+	u32 type = attr->map_type;
 	struct bpf_map *map;
 	int err;
 
-	if (attr->map_type >= ARRAY_SIZE(bpf_map_types))
+	if (type >= ARRAY_SIZE(bpf_map_types))
 		return ERR_PTR(-EINVAL);
-	ops = bpf_map_types[attr->map_type];
+	type = array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
+	ops = bpf_map_types[type];
 	if (!ops)
 		return ERR_PTR(-EINVAL);
 
@@ -122,7 +125,7 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 	if (IS_ERR(map))
 		return map;
 	map->ops = ops;
-	map->map_type = attr->map_type;
+	map->map_type = type;
 	return map;
 }
 
-- 
2.11.0
