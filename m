Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCKO54 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 10:57:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:30407 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932144AbeCKO5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 10:57:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,455,1515484800";
   d="scan'208";a="41016630"
Date: Sun, 11 Mar 2018 20:31:51 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: fmhess@users.sourceforge.net
Cc: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: pl330: flush before wait, and add dev
 burst support.
Message-ID: <20180311150151.GB15443@localhost>
References: <1957017.QzKNMJJqD6@bear>
 <20180306120259.GT15443@localhost>
 <23394379.8nZhno5foU@bear>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23394379.8nZhno5foU@bear>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 11:03:22AM -0500, Frank Mori Hess wrote:
> Do DMAFLUSHP _before_ the first DMAWFP to ensure controller
> and peripheral are in agreement about dma request state before first
> transfer.  Add support for burst transfers to/from peripherals. In the new
> scheme, the controller does as many burst transfers as it can then
> transfers the remaining dregs with either single transfers for
> peripherals, or with a reduced size burst for memory-to-memory transfers.
> 
> Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
> Tested-by: Frank Mori Hess <fmh6jj@gmail.com>

sorry if it wasnt clear earlier, the lines below should come after the ---
line. git-am skips that part while applying..

> 
> I tested dma transfers to peripherals with designware serial port
> (drivers/tty/serial/8250/8250_dw.c) and a GPIB interface
> (https://github.com/fmhess/fmh_gpib_core).  I tested memory-to-memory
> transfers using the dmatest module.
> 
> v3 of this patch should be the same as v2 except with checkpatch.pl
> warnings and errors cleaned up.
> 
> ---
>  drivers/dma/pl330.c | 146 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 104 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index d7327fd5f445..cc2e4456bec1 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1094,26 +1094,33 @@ static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
>  	return off;
>  }
>  
> -static inline int _ldst_devtomem(struct pl330_dmac *pl330, unsigned dry_run,
> -				 u8 buf[], const struct _xfer_spec *pxs,
> -				 int cyc)
> +static inline int _ldst_devtomem(struct pl330_dmac *pl330,
> +				unsigned int dry_run, u8 buf[],
> +				const struct _xfer_spec *pxs,
> +				int cyc, enum pl330_cond cond)
>  {
>  	int off = 0;
> -	enum pl330_cond cond;
>  
>  	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
>  		cond = BURST;
> -	else
> -		cond = SINGLE;
>  
> +	/* do FLUSHP at beginning to clear any stale dma requests before the
> +	 * first WFP.
> +	 */

multiline comments should be:

/*
 * this is an example of multi-line
 * comment
 */

Pls fix at this and other places...

>  static inline int _ldst_memtodev(struct pl330_dmac *pl330,
>  				 unsigned dry_run, u8 buf[],
> -				 const struct _xfer_spec *pxs, int cyc)
> +				 const struct _xfer_spec *pxs, int cyc,
> +				 enum pl330_cond cond)
>  {
>  	int off = 0;
> -	enum pl330_cond cond;
>  
>  	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
>  		cond = BURST;
> -	else
> -		cond = SINGLE;
>  
> +	/* do FLUSHP at beginning to clear any stale dma requests before the
> +	 * first WFP.
> +	 */
> +	if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
> +		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>  	while (cyc--) {
>  		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
>  		off += _emit_LD(dry_run, &buf[off], ALWAYS);
> -		off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
> -
> -		if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
> -			off += _emit_FLUSHP(dry_run, &buf[off],
> -					    pxs->desc->peri);
> +		if (cond == ALWAYS) {
> +			off += _emit_STP(dry_run, &buf[off], SINGLE,
> +				pxs->desc->peri);
> +			off += _emit_STP(dry_run, &buf[off], BURST,
> +				pxs->desc->peri);
> +		} else {
> +			off += _emit_STP(dry_run, &buf[off], cond,
> +				pxs->desc->peri);
> +		}

this looks quite similar to previous routine above, if so can we please make
it common function and invoke from both of these...

> +static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
> +		const struct _xfer_spec *pxs, int transfer_length)
> +{
> +	int off = 0;
> +	int dregs_ccr;
> +
> +	if (transfer_length == 0)
> +		return off;
> +
> +	switch (pxs->desc->rqtype) {
> +	case DMA_MEM_TO_DEV:
> +		off += _ldst_memtodev(pl330, dry_run, &buf[off], pxs,
> +			transfer_length, SINGLE);
> +		break;

empty line after each case pls

> +	case DMA_DEV_TO_MEM:
> +		off += _ldst_devtomem(pl330, dry_run, &buf[off], pxs,
> +			transfer_length, SINGLE);
> +		break;
> +	case DMA_MEM_TO_MEM:
> +		dregs_ccr = pxs->ccr;
> +		dregs_ccr &= ~((0xf << CC_SRCBRSTLEN_SHFT) |
> +			(0xf << CC_DSTBRSTLEN_SHFT));
> +		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
> +			CC_SRCBRSTLEN_SHFT);
> +		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
> +			CC_DSTBRSTLEN_SHFT);
> +		off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
> +		off += _ldst_memtomem(dry_run, &buf[off], pxs, 1);
> +		break;
> +	default:
> +		off += 0x40000000; /* Scare off the Client */

Can you explain this bit, shouldnt this be err?

> @@ -1303,11 +1362,6 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
>  	/* DMAMOV CCR, ccr */
>  	off += _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
>  
> -	x = &pxs->desc->px;
> -	/* Error if xfer length is not aligned at burst size */
> -	if (x->bytes % (BRST_SIZE(pxs->ccr) * BRST_LEN(pxs->ccr)))
> -		return -EINVAL;
> -
>  	off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
>  
>  	/* DMASEV peripheral/event */
> @@ -2115,15 +2169,29 @@ static int pl330_config(struct dma_chan *chan,
>  			pch->fifo_addr = slave_config->dst_addr;
>  		if (slave_config->dst_addr_width)
>  			pch->burst_sz = __ffs(slave_config->dst_addr_width);
> -		if (slave_config->dst_maxburst)
> -			pch->burst_len = slave_config->dst_maxburst;
> +		if (pch->dmac->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
> +			pch->burst_len = 1;

so in this case we don't honour the requested burst length?

> +		else if (slave_config->dst_maxburst) {
> +			if (slave_config->dst_maxburst > PL330_MAX_BURST)
> +				pch->burst_len = PL330_MAX_BURST;
> +			else
> +				pch->burst_len = slave_config->dst_maxburst;
> +		} else
> +			pch->burst_len = 1;
>  	} else if (slave_config->direction == DMA_DEV_TO_MEM) {
>  		if (slave_config->src_addr)
>  			pch->fifo_addr = slave_config->src_addr;
>  		if (slave_config->src_addr_width)
>  			pch->burst_sz = __ffs(slave_config->src_addr_width);
> -		if (slave_config->src_maxburst)
> -			pch->burst_len = slave_config->src_maxburst;
> +		if (pch->dmac->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
> +			pch->burst_len = 1;
> +		else if (slave_config->src_maxburst) {
> +			if (slave_config->src_maxburst > PL330_MAX_BURST)
> +				pch->burst_len = PL330_MAX_BURST;
> +			else
> +				pch->burst_len = slave_config->src_maxburst;
> +		} else
> +			pch->burst_len = 1;

again this looks duplicate..
-- 
~Vinod
