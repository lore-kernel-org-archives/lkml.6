Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeCFQDf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:03:35 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34060 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCFQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:03:33 -0500
X-Google-Smtp-Source: AG47ELt4s48wquVF9aVRUAruCyJIT6L3zy2JC2apP8SG33Hmmsq4//EayR50noCMLpWyXN0pH49glQ==
From: Frank Mori Hess <fmh6jj@gmail.com>
To: dmaengine@vger.kernel.org
Reply-To: fmhess@users.sourceforge.net
Cc: Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dmaengine: pl330: flush before wait, and add dev burst support.
Date: Tue, 06 Mar 2018 11:03:22 -0500
Message-ID: <23394379.8nZhno5foU@bear>
User-Agent: KMail/5.2.3 (Linux/4.9.0-6-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20180306120259.GT15443@localhost>
References: <1957017.QzKNMJJqD6@bear> <20180306120259.GT15443@localhost>
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

I tested dma transfers to peripherals with designware serial port
(drivers/tty/serial/8250/8250_dw.c) and a GPIB interface
(https://github.com/fmhess/fmh_gpib_core).  I tested memory-to-memory
transfers using the dmatest module.

v3 of this patch should be the same as v2 except with checkpatch.pl
warnings and errors cleaned up.

---
 drivers/dma/pl330.c | 146 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 104 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index d7327fd5f445..cc2e4456bec1 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1094,26 +1094,33 @@ static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
 	return off;
 }
 
-static inline int _ldst_devtomem(struct pl330_dmac *pl330, unsigned dry_run,
-				 u8 buf[], const struct _xfer_spec *pxs,
-				 int cyc)
+static inline int _ldst_devtomem(struct pl330_dmac *pl330,
+				unsigned int dry_run, u8 buf[],
+				const struct _xfer_spec *pxs,
+				int cyc, enum pl330_cond cond)
 {
 	int off = 0;
-	enum pl330_cond cond;
 
 	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
 		cond = BURST;
-	else
-		cond = SINGLE;
 
+	/* do FLUSHP at beginning to clear any stale dma requests before the
+	 * first WFP.
+	 */
+	if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
+		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
 	while (cyc--) {
 		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
-		off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
+		if (cond == ALWAYS) {
+			off += _emit_LDP(dry_run, &buf[off], SINGLE,
+				pxs->desc->peri);
+			off += _emit_LDP(dry_run, &buf[off], BURST,
+				pxs->desc->peri);
+		} else {
+			off += _emit_LDP(dry_run, &buf[off], cond,
+				pxs->desc->peri);
+		}
 		off += _emit_ST(dry_run, &buf[off], ALWAYS);
-
-		if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
-			off += _emit_FLUSHP(dry_run, &buf[off],
-					    pxs->desc->peri);
 	}
 
 	return off;
@@ -1121,24 +1128,31 @@ static inline int _ldst_devtomem(struct pl330_dmac *pl330, unsigned dry_run,
 
 static inline int _ldst_memtodev(struct pl330_dmac *pl330,
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
 
+	/* do FLUSHP at beginning to clear any stale dma requests before the
+	 * first WFP.
+	 */
+	if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
+		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
 	while (cyc--) {
 		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_LD(dry_run, &buf[off], ALWAYS);
-		off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
-
-		if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
-			off += _emit_FLUSHP(dry_run, &buf[off],
-					    pxs->desc->peri);
+		if (cond == ALWAYS) {
+			off += _emit_STP(dry_run, &buf[off], SINGLE,
+				pxs->desc->peri);
+			off += _emit_STP(dry_run, &buf[off], BURST,
+				pxs->desc->peri);
+		} else {
+			off += _emit_STP(dry_run, &buf[off], cond,
+				pxs->desc->peri);
+		}
 	}
 
 	return off;
@@ -1148,13 +1162,16 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond = BRST_LEN(pxs->ccr) > 1 ? BURST : SINGLE;
 
 	switch (pxs->desc->rqtype) {
 	case DMA_MEM_TO_DEV:
-		off += _ldst_memtodev(pl330, dry_run, &buf[off], pxs, cyc);
+		off += _ldst_memtodev(pl330, dry_run, &buf[off], pxs, cyc,
+			cond);
 		break;
 	case DMA_DEV_TO_MEM:
-		off += _ldst_devtomem(pl330, dry_run, &buf[off], pxs, cyc);
+		off += _ldst_devtomem(pl330, dry_run, &buf[off], pxs, cyc,
+			cond);
 		break;
 	case DMA_MEM_TO_MEM:
 		off += _ldst_memtomem(dry_run, &buf[off], pxs, cyc);
@@ -1167,6 +1184,46 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 	return off;
 }
 
+/* transfer dregs with single transfers to peripheral, or a reduced size burst
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
+		off += _ldst_memtodev(pl330, dry_run, &buf[off], pxs,
+			transfer_length, SINGLE);
+		break;
+	case DMA_DEV_TO_MEM:
+		off += _ldst_devtomem(pl330, dry_run, &buf[off], pxs,
+			transfer_length, SINGLE);
+		break;
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
+	default:
+		off += 0x40000000; /* Scare off the Client */
+		break;
+	}
+
+	return off;
+}
+
 /* Returns bytes consumed and updates bursts */
 static inline int _loop(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 		unsigned long *bursts, const struct _xfer_spec *pxs)
@@ -1256,6 +1313,8 @@ static inline int _setup_loops(struct pl330_dmac *pl330,
 	struct pl330_xfer *x = &pxs->desc->px;
 	u32 ccr = pxs->ccr;
 	unsigned long c, bursts = BYTE_TO_BURST(x->bytes, ccr);
+	int num_dregs = (x->bytes - BURST_TO_BYTE(bursts, ccr)) /
+		BRST_SIZE(ccr);
 	int off = 0;
 
 	while (bursts) {
@@ -1263,6 +1322,7 @@ static inline int _setup_loops(struct pl330_dmac *pl330,
 		off += _loop(pl330, dry_run, &buf[off], &c, pxs);
 		bursts -= c;
 	}
+	off += _dregs(pl330, dry_run, &buf[off], pxs, num_dregs);
 
 	return off;
 }
@@ -1294,7 +1354,6 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
 		      struct _xfer_spec *pxs)
 {
 	struct _pl330_req *req = &thrd->req[index];
-	struct pl330_xfer *x;
 	u8 *buf = req->mc_cpu;
 	int off = 0;
 
@@ -1303,11 +1362,6 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
 	/* DMAMOV CCR, ccr */
 	off += _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
 
-	x = &pxs->desc->px;
-	/* Error if xfer length is not aligned at burst size */
-	if (x->bytes % (BRST_SIZE(pxs->ccr) * BRST_LEN(pxs->ccr)))
-		return -EINVAL;
-
 	off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
 
 	/* DMASEV peripheral/event */
@@ -2115,15 +2169,29 @@ static int pl330_config(struct dma_chan *chan,
 			pch->fifo_addr = slave_config->dst_addr;
 		if (slave_config->dst_addr_width)
 			pch->burst_sz = __ffs(slave_config->dst_addr_width);
-		if (slave_config->dst_maxburst)
-			pch->burst_len = slave_config->dst_maxburst;
+		if (pch->dmac->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
+			pch->burst_len = 1;
+		else if (slave_config->dst_maxburst) {
+			if (slave_config->dst_maxburst > PL330_MAX_BURST)
+				pch->burst_len = PL330_MAX_BURST;
+			else
+				pch->burst_len = slave_config->dst_maxburst;
+		} else
+			pch->burst_len = 1;
 	} else if (slave_config->direction == DMA_DEV_TO_MEM) {
 		if (slave_config->src_addr)
 			pch->fifo_addr = slave_config->src_addr;
 		if (slave_config->src_addr_width)
 			pch->burst_sz = __ffs(slave_config->src_addr_width);
-		if (slave_config->src_maxburst)
-			pch->burst_len = slave_config->src_maxburst;
+		if (pch->dmac->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
+			pch->burst_len = 1;
+		else if (slave_config->src_maxburst) {
+			if (slave_config->src_maxburst > PL330_MAX_BURST)
+				pch->burst_len = PL330_MAX_BURST;
+			else
+				pch->burst_len = slave_config->src_maxburst;
+		} else
+			pch->burst_len = 1;
 	}
 
 	return 0;
@@ -2517,14 +2585,8 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
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
@@ -2596,7 +2658,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 
 		desc->rqtype = direction;
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->bytes_requested = period_len;
 		fill_px(&desc->px, dst, src, period_len);
 
@@ -2741,7 +2803,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		}
 
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->rqtype = direction;
 		desc->bytes_requested = sg_dma_len(sg);
 	}
-- 
2.11.0
