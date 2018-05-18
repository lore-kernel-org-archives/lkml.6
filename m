Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeERW2O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:28:14 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40355 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeERW2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:28:10 -0400
X-Google-Smtp-Source: AB8JxZr5RgZ/vTuWGIAvgm0sCFt6BYLobA8D+gYQ9nBJc6+p4V7pEpCXu0vPdFmUGOH4nWFpUlA0bA==
From: Anders Roxell <anders.roxell@linaro.org>
To: davem@davemloft.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: net: reuseport_bpf_numa: don't fail if no numa support
Date: Sat, 19 May 2018 00:27:37 +0200
Message-Id: <20180518222737.16006-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180306151004.31336-1-anders.roxell@linaro.org>
References: <20180306151004.31336-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reuseport_bpf_numa test case fails there's no numa support.  The
test shouldn't fail if there's no support it should be skipped.

Fixes: 3c2c3c16aaf6 ("reuseport, bpf: add test case for bpf_get_numa_node_id")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/reuseport_bpf_numa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index 365c32e84189..c9f478b40996 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -23,6 +23,8 @@
 #include <unistd.h>
 #include <numa.h>
 
+#include "../kselftest.h"
+
 static const int PORT = 8888;
 
 static void build_rcv_group(int *rcv_fd, size_t len, int family, int proto)
@@ -229,7 +231,7 @@ int main(void)
 	int *rcv_fd, nodes;
 
 	if (numa_available() < 0)
-		error(1, errno, "no numa api support");
+		ksft_exit_skip("no numa api support\n");
 
 	nodes = numa_max_node() + 1;
 
-- 
2.17.0
