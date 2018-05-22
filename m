Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeEVTsr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:48:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:61780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeEVTsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:48:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="43377975"
Date: Wed, 23 May 2018 03:48:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: kbuild-all@01.org, Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [v4 06/11] drivers/peci: Add a PECI adapter driver for Aspeed
 AST24xx/AST25xx
Message-ID: <201805230234.nRBsOd6G%fengguang.wu@intel.com>
References: <20180521195856.27938-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521195856.27938-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jae,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc6 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/dt-bindings-Add-a-document-of-PECI-subsystem/20180522-204411
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/peci/peci-aspeed.c:146:42: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned int [unsigned] val @@    got d int [unsigned] val @@
   drivers/peci/peci-aspeed.c:146:42:    expected unsigned int [unsigned] val
   drivers/peci/peci-aspeed.c:146:42:    got restricted __le32

vim +146 drivers/peci/peci-aspeed.c

   116	
   117	static int aspeed_peci_xfer_native(struct aspeed_peci *priv,
   118					   struct peci_xfer_msg *msg)
   119	{
   120		long err, timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
   121		u32 peci_head, peci_state, rx_data, cmd_sts;
   122		unsigned long flags;
   123		int i, rc;
   124		uint reg;
   125	
   126		/* Check command sts and bus idle state */
   127		rc = regmap_read_poll_timeout(priv->regmap, ASPEED_PECI_CMD, cmd_sts,
   128			!(cmd_sts & (PECI_CMD_STS_MASK | PECI_CMD_PIN_MON)),
   129			PECI_IDLE_CHECK_INTERVAL_USEC, PECI_IDLE_CHECK_TIMEOUT_USEC);
   130		if (rc)
   131			return rc; /* -ETIMEDOUT */
   132	
   133		spin_lock_irqsave(&priv->lock, flags);
   134		reinit_completion(&priv->xfer_complete);
   135	
   136		peci_head = FIELD_PREP(PECI_TAGET_ADDR_MASK, msg->addr) |
   137			    FIELD_PREP(PECI_WRITE_LEN_MASK, msg->tx_len) |
   138			    FIELD_PREP(PECI_READ_LEN_MASK, msg->rx_len);
   139	
   140		regmap_write(priv->regmap, ASPEED_PECI_CMD_CTRL, peci_head);
   141	
   142		for (i = 0; i < msg->tx_len; i += 4) {
   143			reg = i < 16 ? ASPEED_PECI_W_DATA0 + i % 16 :
   144				       ASPEED_PECI_W_DATA4 + i % 16;
   145			regmap_write(priv->regmap, reg,
 > 146				     cpu_to_le32p((u32 *)&msg->tx_buf[i]));
   147		}
   148	
   149		dev_dbg(priv->dev, "HEAD : 0x%08x\n", peci_head);
   150		print_hex_dump_debug("TX : ", DUMP_PREFIX_NONE, 16, 1,
   151				     msg->tx_buf, msg->tx_len, true);
   152	
   153		priv->status = 0;
   154		regmap_write(priv->regmap, ASPEED_PECI_CMD, PECI_CMD_FIRE);
   155		spin_unlock_irqrestore(&priv->lock, flags);
   156	
   157		err = wait_for_completion_interruptible_timeout(&priv->xfer_complete,
   158								timeout);
   159	
   160		spin_lock_irqsave(&priv->lock, flags);
   161		dev_dbg(priv->dev, "INT_STS : 0x%08x\n", priv->status);
   162		regmap_read(priv->regmap, ASPEED_PECI_CMD, &peci_state);
   163		dev_dbg(priv->dev, "PECI_STATE : 0x%lx\n",
   164			FIELD_GET(PECI_CMD_STS_MASK, peci_state));
   165	
   166		regmap_write(priv->regmap, ASPEED_PECI_CMD, 0);
   167	
   168		if (err <= 0 || priv->status != PECI_INT_CMD_DONE) {
   169			if (err < 0) { /* -ERESTARTSYS */
   170				rc = (int)err;
   171				goto err_irqrestore;
   172			} else if (err == 0) {
   173				dev_dbg(priv->dev, "Timeout waiting for a response!\n");
   174				rc = -ETIMEDOUT;
   175				goto err_irqrestore;
   176			}
   177	
   178			dev_dbg(priv->dev, "No valid response!\n");
   179			rc = -EIO;
   180			goto err_irqrestore;
   181		}
   182	
   183		/**
   184		 * Note that rx_len and rx_buf size can be an odd number.
   185		 * Byte handling is more efficient.
   186		 */
   187		for (i = 0; i < msg->rx_len; i++) {
   188			u8 byte_offset = i % 4;
   189	
   190			if (byte_offset == 0) {
   191				reg = i < 16 ? ASPEED_PECI_R_DATA0 + i % 16 :
   192					       ASPEED_PECI_R_DATA4 + i % 16;
   193				regmap_read(priv->regmap, reg, &rx_data);
   194			}
   195	
   196			msg->rx_buf[i] = (u8)(rx_data >> (byte_offset << 3));
   197		}
   198	
   199		print_hex_dump_debug("RX : ", DUMP_PREFIX_NONE, 16, 1,
   200				     msg->rx_buf, msg->rx_len, true);
   201	
   202		regmap_read(priv->regmap, ASPEED_PECI_CMD, &peci_state);
   203		dev_dbg(priv->dev, "PECI_STATE : 0x%lx\n",
   204			FIELD_GET(PECI_CMD_STS_MASK, peci_state));
   205		dev_dbg(priv->dev, "------------------------\n");
   206	
   207	err_irqrestore:
   208		spin_unlock_irqrestore(&priv->lock, flags);
   209		return rc;
   210	}
   211	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
