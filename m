Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeCTKcS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:32:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:10210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeCTKcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:32:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="209755613"
Date: Tue, 20 Mar 2018 18:31:25 +0800
From: kbuild test robot <lkp@intel.com>
To: thor.thayer@linux.intel.com
Cc: kbuild-all@01.org, cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thor.thayer@linux.intel.com
Subject: Re: [PATCH] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
Message-ID: <201803201812.TdB2doqa%fengguang.wu@intel.com>
References: <1521485124-24882-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521485124-24882-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thor,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180319]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/thor-thayer-linux-intel-com/mtd-spi-nor-Fix-Cadence-QSPI-page-fault-kernel-panic/20180320-133857
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/mtd/spi-nor/cadence-quadspi.c:651:25: sparse: incompatible types in comparison expression (different type sizes)
   In file included from include/linux/clk.h:16:0,
                    from drivers/mtd/spi-nor/cadence-quadspi.c:18:
   drivers/mtd/spi-nor/cadence-quadspi.c: In function 'cqspi_indirect_write_execute':
   include/linux/kernel.h:793:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   7-                ^
   include/linux/kernel.h:802:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   10-  ^~~~~
   drivers/mtd/spi-nor/cadence-quadspi.c:651:25: note: in expansion of macro 'min'
       memcpy(&temp, txbuf, min(sizeof(temp), mod_bytes));
                            ^~~

vim +651 drivers/mtd/spi-nor/cadence-quadspi.c

   606	
   607	static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
   608						const u8 *txbuf, const size_t n_tx)
   609	{
   610		const unsigned int page_size = nor->page_size;
   611		struct cqspi_flash_pdata *f_pdata = nor->priv;
   612		struct cqspi_st *cqspi = f_pdata->cqspi;
   613		void __iomem *reg_base = cqspi->iobase;
   614		unsigned int remaining = n_tx;
   615		unsigned int mod_bytes, write_bytes, write_words;
   616		int ret;
   617	
   618		writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
   619		writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
   620	
   621		/* Clear all interrupts. */
   622		writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
   623	
   624		writel(CQSPI_IRQ_MASK_WR, reg_base + CQSPI_REG_IRQMASK);
   625	
   626		reinit_completion(&cqspi->transfer_complete);
   627		writel(CQSPI_REG_INDIRECTWR_START_MASK,
   628		       reg_base + CQSPI_REG_INDIRECTWR);
   629		/*
   630		 * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
   631		 * Controller programming sequence, couple of cycles of
   632		 * QSPI_REF_CLK delay is required for the above bit to
   633		 * be internally synchronized by the QSPI module. Provide 5
   634		 * cycles of delay.
   635		 */
   636		if (cqspi->wr_delay)
   637			ndelay(cqspi->wr_delay);
   638	
   639		while (remaining > 0) {
   640			write_bytes = remaining > page_size ? page_size : remaining;
   641			write_words = write_bytes / 4;
   642			mod_bytes = write_bytes % 4;
   643			/* Write 4 bytes at a time then single bytes. */
   644			if (write_words) {
   645				iowrite32_rep(cqspi->ahb_base, txbuf, write_words);
   646				txbuf += (write_words * 4);
   647			}
   648			if (mod_bytes) {
   649				unsigned int temp = 0xFFFFFFFF;
   650	
 > 651				memcpy(&temp, txbuf, min(sizeof(temp), mod_bytes));
   652				iowrite32(temp, cqspi->ahb_base);
   653				txbuf += mod_bytes;
   654			}
   655			ret = wait_for_completion_timeout(&cqspi->transfer_complete,
   656							  msecs_to_jiffies
   657							  (CQSPI_TIMEOUT_MS));
   658			if (!ret) {
   659				dev_err(nor->dev, "Indirect write timeout\n");
   660				ret = -ETIMEDOUT;
   661				goto failwr;
   662			}
   663	
   664			remaining -= write_bytes;
   665	
   666			if (remaining > 0)
   667				reinit_completion(&cqspi->transfer_complete);
   668		}
   669	
   670		/* Check indirect done status */
   671		ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTWR,
   672					 CQSPI_REG_INDIRECTWR_DONE_MASK, 0);
   673		if (ret) {
   674			dev_err(nor->dev,
   675				"Indirect write completion error (%i)\n", ret);
   676			goto failwr;
   677		}
   678	
   679		/* Disable interrupt. */
   680		writel(0, reg_base + CQSPI_REG_IRQMASK);
   681	
   682		/* Clear indirect completion status */
   683		writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
   684	
   685		cqspi_wait_idle(cqspi);
   686	
   687		return 0;
   688	
   689	failwr:
   690		/* Disable interrupt. */
   691		writel(0, reg_base + CQSPI_REG_IRQMASK);
   692	
   693		/* Cancel the indirect write */
   694		writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
   695		       reg_base + CQSPI_REG_INDIRECTWR);
   696		return ret;
   697	}
   698	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
