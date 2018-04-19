Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDSAbQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:31:16 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42526 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDSAbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:31:14 -0400
X-Google-Smtp-Source: AB8JxZrXmZSASAex+BNYyAYcgoUkUKv2+241FGW9gE6hZo5NbwEktXBpsFh0Vh7bdYeBpJlRBOsUig==
From: Frank Mori Hess <fmh6jj@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5] dmaengine: pl330: flush before wait, and add dev burst support.
Date: Wed, 18 Apr 2018 20:31:06 -0400
Message-ID: <1643219.q45jaR7ETT@bear>
User-Agent: KMail/5.2.3 (Linux/4.9.0-6-amd64; KDE/5.28.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do DMAFLUSHP _before_ the first DMAWFP to ensure controller
and peripheral are in agreement about dma request state before first
transfer.  Add support for burst transfers to/from peripherals. In the new
scheme, the controller does as many burst transfers as it can then
transfers the remaining dregs with either single transfers for
peripherals, or with a reduced size burst for memory-to-memory transfers.

Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
Tested-by: Frank Mori Hess <fmh6jj@gmail.com>
---

I tested dma transfers to peripherals with v3 patch and designware serial 
port (drivers/tty/serial/8250/8250_dw.c) and a GPIB interface
(https://github.com/fmhess/fmh_gpib_core).  I tested memory-to-memory
transfers using the dmatest module.

v3 of this patch should be the same as v2 except with checkpatch.pl
warnings and errors cleaned up.

v4 addresses cosmetic complaints about v3, should be functionally unchanged.

v5 unchanged other than rebasing to HEAD on "next" branch of 
http://git.infradead.org/users/vkoul/slave-dma.git 
Retested with transfers to/from peripheral.

 drivers/dma/pl330.c | 209 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 159 insertions(+), 50 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index de1fd59fe136..6237069001c4 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -27,6 +27,7 @@
 #include <linux/of_dma.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/bug.h>
 
 #include "dmaengine.h"
 #define PL330_MAX_CHAN		8
@@ -1094,51 +1095,96 @@ static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
 	return off;
 }
 
-static inline int _ldst_devtomem(struct pl330_dmac *pl330, unsigned dry_run,
-				 u8 buf[], const struct _xfer_spec *pxs,
-				 int cyc)
+static u32 _emit_load(unsigned int dry_run, u8 buf[],
+	enum pl330_cond cond, enum dma_transfer_direction direction,
+	u8 peri)
 {
 	int off = 0;
-	enum pl330_cond cond;
 
-	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
-		cond = BURST;
-	else
-		cond = SINGLE;
+	switch (direction) {
+	case DMA_MEM_TO_MEM:
+		/* fall through */
+	case DMA_MEM_TO_DEV:
+		off += _emit_LD(dry_run, &buf[off], cond);
+		break;
 
-	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
-		off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
-		off += _emit_ST(dry_run, &buf[off], ALWAYS);
+	case DMA_DEV_TO_MEM:
+		if (cond == ALWAYS) {
+			off += _emit_LDP(dry_run, &buf[off], SINGLE,
+				peri);
+			off += _emit_LDP(dry_run, &buf[off], BURST,
+				peri);
+		} else {
+			off += _emit_LDP(dry_run, &buf[off], cond,
+				peri);
+		}
+		break;
 
-		if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
-			off += _emit_FLUSHP(dry_run, &buf[off],
-					    pxs->desc->peri);
+	default:
+		/* this code should be unreachable */
+		WARN_ON(1);
+		break;
 	}
 
 	return off;
 }
 
-static inline int _ldst_memtodev(struct pl330_dmac *pl330,
+static inline u32 _emit_store(unsigned int dry_run, u8 buf[],
+	enum pl330_cond cond, enum dma_transfer_direction direction,
+	u8 peri)
+{
+	int off = 0;
+
+	switch (direction) {
+	case DMA_MEM_TO_MEM:
+		/* fall through */
+	case DMA_DEV_TO_MEM:
+		off += _emit_ST(dry_run, &buf[off], cond);
+		break;
+
+	case DMA_MEM_TO_DEV:
+		if (cond == ALWAYS) {
+			off += _emit_STP(dry_run, &buf[off], SINGLE,
+				peri);
+			off += _emit_STP(dry_run, &buf[off], BURST,
+				peri);
+		} else {
+			off += _emit_STP(dry_run, &buf[off], cond,
+				peri);
+		}
+		break;
+
+	default:
+		/* this code should be unreachable */
+		WARN_ON(1);
+		break;
+	}
+
+	return off;
+}
+
+static inline int _ldst_peripheral(struct pl330_dmac *pl330,
 				 unsigned dry_run, u8 buf[],
-				 const struct _xfer_spec *pxs, int cyc)
+				 const struct _xfer_spec *pxs, int cyc,
+				 enum pl330_cond cond)
 {
 	int off = 0;
-	enum pl330_cond cond;
 
 	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
 		cond = BURST;
-	else
-		cond = SINGLE;
 
+	/*
+	 * do FLUSHP at beginning to clear any stale dma requests before the
+	 * first WFP.
+	 */
+	if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
+		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
 	while (cyc--) {
 		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
-		off += _emit_LD(dry_run, &buf[off], ALWAYS);
-		off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
-
-		if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
-			off += _emit_FLUSHP(dry_run, &buf[off],
-					    pxs->desc->peri);
+		off += _emit_load(dry_run, &buf[off], cond, pxs->desc->rqtype,
+			pxs->desc->peri);
+		off += _emit_store(dry_run, &buf[off], cond, pxs->desc->rqtype,
+			pxs->desc->peri);
 	}
 
 	return off;
@@ -1148,19 +1194,65 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond = BRST_LEN(pxs->ccr) > 1 ? BURST : SINGLE;
 
 	switch (pxs->desc->rqtype) {
 	case DMA_MEM_TO_DEV:
-		off += _ldst_memtodev(pl330, dry_run, &buf[off], pxs, cyc);
-		break;
+		/* fall through */
 	case DMA_DEV_TO_MEM:
-		off += _ldst_devtomem(pl330, dry_run, &buf[off], pxs, cyc);
+		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs, cyc,
+			cond);
 		break;
+
 	case DMA_MEM_TO_MEM:
 		off += _ldst_memtomem(dry_run, &buf[off], pxs, cyc);
 		break;
+
+	default:
+		/* this code should be unreachable */
+		WARN_ON(1);
+		break;
+	}
+
+	return off;
+}
+
+/*
+ * transfer dregs with single transfers to peripheral, or a reduced size burst
+ * for mem-to-mem.
+ */
+static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
+		const struct _xfer_spec *pxs, int transfer_length)
+{
+	int off = 0;
+	int dregs_ccr;
+
+	if (transfer_length == 0)
+		return off;
+
+	switch (pxs->desc->rqtype) {
+	case DMA_MEM_TO_DEV:
+		/* fall through */
+	case DMA_DEV_TO_MEM:
+		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs,
+			transfer_length, SINGLE);
+		break;
+
+	case DMA_MEM_TO_MEM:
+		dregs_ccr = pxs->ccr;
+		dregs_ccr &= ~((0xf << CC_SRCBRSTLEN_SHFT) |
+			(0xf << CC_DSTBRSTLEN_SHFT));
+		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
+			CC_SRCBRSTLEN_SHFT);
+		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
+			CC_DSTBRSTLEN_SHFT);
+		off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
+		off += _ldst_memtomem(dry_run, &buf[off], pxs, 1);
+		break;
+
 	default:
-		off += 0x40000000; /* Scare off the Client */
+		/* this code should be unreachable */
+		WARN_ON(1);
 		break;
 	}
 
@@ -1256,6 +1348,8 @@ static inline int _setup_loops(struct pl330_dmac *pl330,
 	struct pl330_xfer *x = &pxs->desc->px;
 	u32 ccr = pxs->ccr;
 	unsigned long c, bursts = BYTE_TO_BURST(x->bytes, ccr);
+	int num_dregs = (x->bytes - BURST_TO_BYTE(bursts, ccr)) /
+		BRST_SIZE(ccr);
 	int off = 0;
 
 	while (bursts) {
@@ -1263,6 +1357,7 @@ static inline int _setup_loops(struct pl330_dmac *pl330,
 		off += _loop(pl330, dry_run, &buf[off], &c, pxs);
 		bursts -= c;
 	}
+	off += _dregs(pl330, dry_run, &buf[off], pxs, num_dregs);
 
 	return off;
 }
@@ -1294,7 +1389,6 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
 		      struct _xfer_spec *pxs)
 {
 	struct _pl330_req *req = &thrd->req[index];
-	struct pl330_xfer *x;
 	u8 *buf = req->mc_cpu;
 	int off = 0;
 
@@ -1303,11 +1397,6 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
 	/* DMAMOV CCR, ccr */
 	off += _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
 
-	x = &pxs->desc->px;
-	/* Error if xfer length is not aligned at burst size */
-	if (x->bytes % (BRST_SIZE(pxs->ccr) * BRST_LEN(pxs->ccr)))
-		return -EINVAL;
-
 	off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
 
 	/* DMASEV peripheral/event */
@@ -1365,6 +1454,20 @@ static int pl330_submit_req(struct pl330_thread *thrd,
 	u32 ccr;
 	int ret = 0;
 
+	switch (desc->rqtype) {
+	case DMA_MEM_TO_DEV:
+		break;
+
+	case DMA_DEV_TO_MEM:
+		break;
+
+	case DMA_MEM_TO_MEM:
+		break;
+
+	default:
+		return -ENOTSUPP;
+	}
+
 	if (pl330->state == DYING
 		|| pl330->dmac_tbd.reset_chan & (1 << thrd->id)) {
 		dev_info(thrd->dmac->ddma.dev, "%s:%d\n",
@@ -2106,6 +2209,18 @@ static bool pl330_prep_slave_fifo(struct dma_pl330_chan *pch,
 	return true;
 }
 
+static int fixup_burst_len(int max_burst_len, int quirks)
+{
+	if (quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
+		return 1;
+	else if (max_burst_len > PL330_MAX_BURST)
+		return PL330_MAX_BURST;
+	else if (max_burst_len < 1)
+		return 1;
+	else
+		return max_burst_len;
+}
+
 static int pl330_config(struct dma_chan *chan,
 			struct dma_slave_config *slave_config)
 {
@@ -2117,15 +2232,15 @@ static int pl330_config(struct dma_chan *chan,
 			pch->fifo_addr = slave_config->dst_addr;
 		if (slave_config->dst_addr_width)
 			pch->burst_sz = __ffs(slave_config->dst_addr_width);
-		if (slave_config->dst_maxburst)
-			pch->burst_len = slave_config->dst_maxburst;
+		pch->burst_len = fixup_burst_len(slave_config->dst_maxburst,
+			pch->dmac->quirks);
 	} else if (slave_config->direction == DMA_DEV_TO_MEM) {
 		if (slave_config->src_addr)
 			pch->fifo_addr = slave_config->src_addr;
 		if (slave_config->src_addr_width)
 			pch->burst_sz = __ffs(slave_config->src_addr_width);
-		if (slave_config->src_maxburst)
-			pch->burst_len = slave_config->src_maxburst;
+		pch->burst_len = fixup_burst_len(slave_config->src_maxburst,
+			pch->dmac->quirks);
 	}
 
 	return 0;
@@ -2519,14 +2634,8 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
 	burst_len >>= desc->rqcfg.brst_size;
 
 	/* src/dst_burst_len can't be more than 16 */
-	if (burst_len > 16)
-		burst_len = 16;
-
-	while (burst_len > 1) {
-		if (!(len % (burst_len << desc->rqcfg.brst_size)))
-			break;
-		burst_len--;
-	}
+	if (burst_len > PL330_MAX_BURST)
+		burst_len = PL330_MAX_BURST;
 
 	return burst_len;
 }
@@ -2598,7 +2707,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 
 		desc->rqtype = direction;
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->bytes_requested = period_len;
 		fill_px(&desc->px, dst, src, period_len);
 
@@ -2743,7 +2852,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		}
 
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->rqtype = direction;
 		desc->bytes_requested = sg_dma_len(sg);
 	}
-- 
2.11.0
