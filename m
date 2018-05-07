Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeEGRog (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:44:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:19341 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeEGRod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:44:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,375,1520924400";
   d="scan'208";a="53156710"
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To: ast@fb.com, daniel@iogearbox.net, netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, magnus.karlsson@intel.com,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] xsk: fix 64-bit division
Date: Mon,  7 May 2018 19:43:50 +0200
Message-Id: <20180507174350.3534-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <e9890e95-16b4-4540-301b-43f17a824808@infradead.org>
References: <e9890e95-16b4-4540-301b-43f17a824808@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

i386 builds report:
  net/xdp/xdp_umem.o: In function `xdp_umem_reg':
  xdp_umem.c:(.text+0x47e): undefined reference to `__udivdi3'

This fix uses div_u64 instead of the GCC built-in.

Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 net/xdp/xdp_umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 881dfdefe235..2b47a1dd7c6c 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -209,7 +209,7 @@ int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if ((addr + size) < addr)
 		return -EINVAL;
 
-	nframes = size / frame_size;
+	nframes = (unsigned int)div_u64(size, frame_size);
 	if (nframes == 0 || nframes > UINT_MAX)
 		return -EINVAL;
 
-- 
2.14.1
