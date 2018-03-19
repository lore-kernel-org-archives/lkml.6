Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeCSOWW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:22:22 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:26549 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755588AbeCSOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:22:17 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        davem@davemloft.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC PATCH 3/3] cxgb4: read on-chip memory 256-bits at a time
Date: Mon, 19 Mar 2018 19:50:36 +0530
Message-Id: <b95c4daeaf169ef0b3b689214c7c4ab37d946949.1521469118.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use readqq() to read on-chip memory 256-bits at a time.

Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c | 16 ++++++++--------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h     |  6 ++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
index 9da6f57901a9..3a319b16c8a3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -885,7 +885,7 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 	struct adapter *adap = pdbg_init->adap;
 	u32 pos, offset, resid;
 	u32 *res_buf;
-	u64 *buf;
+	u256 *buf;
 	int ret;
 
 	/* Argument sanity checks ...
@@ -893,10 +893,10 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 	if (addr & 0x3 || (uintptr_t)hbuf & 0x3)
 		return -EINVAL;
 
-	buf = (u64 *)hbuf;
+	buf = (u256 *)hbuf;
 
-	/* Try to do 64-bit reads.  Residual will be handled later. */
-	resid = len & 0x7;
+	/* Try to do 256-bit reads.  Residual will be handled later. */
+	resid = len & 0x1f;
 	len -= resid;
 
 	ret = t4_memory_rw_init(adap, win, mtype, &memoffset, &mem_base,
@@ -917,10 +917,10 @@ static int cudbg_memory_read(struct cudbg_init *pdbg_init, int win,
 
 	/* Transfer data from the adapter */
 	while (len > 0) {
-		*buf++ = le64_to_cpu((__force __le64)
-				     t4_read_reg64(adap, mem_base + offset));
-		offset += sizeof(u64);
-		len -= sizeof(u64);
+		*buf++ = le256_to_cpu((__force __le256)
+				      t4_read_reg256(adap, mem_base + offset));
+		offset += sizeof(u256);
+		len -= sizeof(u256);
 
 		/* If we've reached the end of our current window aperture,
 		 * move the PCI-E Memory Window on to the next.
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index a5c0a649f3c7..0035ed0a2ec9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -51,6 +51,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/ptp_classify.h>
 #include <asm/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include "t4_chip_type.h"
 #include "cxgb4_uld.h"
 
@@ -1234,6 +1235,11 @@ static inline u64 t4_read_reg64(struct adapter *adap, u32 reg_addr)
 	return readq(adap->regs + reg_addr);
 }
 
+static inline u256 t4_read_reg256(struct adapter *adap, u32 reg_addr)
+{
+	return readqq(adap->regs + reg_addr);
+}
+
 static inline void t4_write_reg64(struct adapter *adap, u32 reg_addr, u64 val)
 {
 	writeq(val, adap->regs + reg_addr);
-- 
2.14.1
