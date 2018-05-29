Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935485AbeE2ClN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:41:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751341AbeE2ClL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:41:11 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <ast@kernel.org>, <daniel@iogearbox.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] bpf: hide the unused 'off' variable
Date: Tue, 29 May 2018 10:40:18 +0800
Message-ID: <20180529024018.12740-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable is only used while CONFIG_IPV6 enabled

net/core/filter.c: In function ‘sk_msg_convert_ctx_access’:
net/core/filter.c:6489:6: warning: unused variable ‘off’ [-Wunused-variable]
  int off;
      ^
This puts it into #ifdef.

Fixes: 303def35f64e ("bpf: allow sk_msg programs to read sock fields")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 24e6ce8..0ce93ed 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6486,7 +6486,9 @@ static u32 sk_msg_convert_ctx_access(enum bpf_access_type type,
 				     struct bpf_prog *prog, u32 *target_size)
 {
 	struct bpf_insn *insn = insn_buf;
+#if IS_ENABLED(CONFIG_IPV6)
 	int off;
+#endif
 
 	switch (si->off) {
 	case offsetof(struct sk_msg_md, data):
-- 
2.7.0
