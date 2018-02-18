Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeBRNAX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:00:23 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63966
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751292AbeBRNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:00:22 -0500
X-IronPort-AV: E=Sophos;i="5.46,530,1511823600";
   d="scan'208";a="255176123"
Date: Sun, 18 Feb 2018 14:00:18 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: David Daney <david.daney@cavium.com>
cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        kbuild-all@01.org
Subject: Re: [PATCH v3] rtc: isl12026: Add driver. (fwd)
Message-ID: <alpine.DEB.2.20.1802181357370.2777@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concern is about the code on line 400.  I'm not seeing where
num_written could go below 0, in any case.

julia

---------- Forwarded message ----------
Date: Sun, 18 Feb 2018 20:54:49 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3] rtc: isl12026: Add driver.

CC: kbuild-all@01.org
In-Reply-To: <20180215195437.29207-1-david.daney@cavium.com>
References: <20180215195437.29207-1-david.daney@cavium.com>
TO: David Daney <david.daney@cavium.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
CC: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>

Hi David,

I love your patch! Perhaps something to improve:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on v4.16-rc1 next-20180216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Daney/rtc-isl12026-Add-driver/20180218-072946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago

>> drivers/rtc/rtc-isl12026.c:400:8-19: WARNING: Unsigned expression compared with zero: num_written >= 0

# https://github.com/0day-ci/linux/commit/a0c9ca2899586c1317ebcb2ba5d31edde176a58a
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout a0c9ca2899586c1317ebcb2ba5d31edde176a58a
vim +400 drivers/rtc/rtc-isl12026.c

a0c9ca28 David Daney 2018-02-15  347
a0c9ca28 David Daney 2018-02-15  348  static int isl12026_nvm_write(void *p, unsigned int offset,
a0c9ca28 David Daney 2018-02-15  349  			      void *val, size_t bytes)
a0c9ca28 David Daney 2018-02-15  350  {
a0c9ca28 David Daney 2018-02-15  351  	struct isl12026 *priv = p;
a0c9ca28 David Daney 2018-02-15  352  	int ret = -EIO;
a0c9ca28 David Daney 2018-02-15  353  	u8 *v = val;
a0c9ca28 David Daney 2018-02-15  354  	size_t chunk_size, num_written;
a0c9ca28 David Daney 2018-02-15  355  	u8 payload[ISL12026_PAGESIZE + 2]; /* page + 2 address bytes */
a0c9ca28 David Daney 2018-02-15  356  	struct i2c_msg msgs[] = {
a0c9ca28 David Daney 2018-02-15  357  		{
a0c9ca28 David Daney 2018-02-15  358  			.addr	= priv->nvm_client->addr,
a0c9ca28 David Daney 2018-02-15  359  			.flags	= 0,
a0c9ca28 David Daney 2018-02-15  360  			.buf	= payload
a0c9ca28 David Daney 2018-02-15  361  		}
a0c9ca28 David Daney 2018-02-15  362  	};
a0c9ca28 David Daney 2018-02-15  363
a0c9ca28 David Daney 2018-02-15  364  	if (offset >= priv->nvm_cfg.size)
a0c9ca28 David Daney 2018-02-15  365  		return 0; /* End-of-file */
a0c9ca28 David Daney 2018-02-15  366  	if (offset + bytes > priv->nvm_cfg.size)
a0c9ca28 David Daney 2018-02-15  367  		bytes = priv->nvm_cfg.size - offset;
a0c9ca28 David Daney 2018-02-15  368
a0c9ca28 David Daney 2018-02-15  369  	mutex_lock(&priv->lock);
a0c9ca28 David Daney 2018-02-15  370
a0c9ca28 David Daney 2018-02-15  371  	num_written = 0;
a0c9ca28 David Daney 2018-02-15  372  	while (bytes) {
a0c9ca28 David Daney 2018-02-15  373  		chunk_size = round_down(offset, ISL12026_PAGESIZE) +
a0c9ca28 David Daney 2018-02-15  374  			ISL12026_PAGESIZE - offset;
a0c9ca28 David Daney 2018-02-15  375  		chunk_size = min(bytes, chunk_size);
a0c9ca28 David Daney 2018-02-15  376  		/*
a0c9ca28 David Daney 2018-02-15  377  		 * 2 bytes of address, most significant first, followed
a0c9ca28 David Daney 2018-02-15  378  		 * by page data bytes
a0c9ca28 David Daney 2018-02-15  379  		 */
a0c9ca28 David Daney 2018-02-15  380  		memcpy(payload + 2, v + num_written, chunk_size);
a0c9ca28 David Daney 2018-02-15  381  		payload[0] = offset >> 8;
a0c9ca28 David Daney 2018-02-15  382  		payload[1] = offset;
a0c9ca28 David Daney 2018-02-15  383  		msgs[0].len = chunk_size + 2;
a0c9ca28 David Daney 2018-02-15  384  		ret = i2c_transfer(priv->nvm_client->adapter,
a0c9ca28 David Daney 2018-02-15  385  				   msgs, ARRAY_SIZE(msgs));
a0c9ca28 David Daney 2018-02-15  386  		if (ret != ARRAY_SIZE(msgs)) {
a0c9ca28 David Daney 2018-02-15  387  			dev_err(priv->nvm_cfg.dev,
a0c9ca28 David Daney 2018-02-15  388  				"nvmem write error, ret=%d\n", ret);
a0c9ca28 David Daney 2018-02-15  389  			ret = ret < 0 ? ret : -EIO;
a0c9ca28 David Daney 2018-02-15  390  			break;
a0c9ca28 David Daney 2018-02-15  391  		}
a0c9ca28 David Daney 2018-02-15  392  		bytes -= chunk_size;
a0c9ca28 David Daney 2018-02-15  393  		offset += chunk_size;
a0c9ca28 David Daney 2018-02-15  394  		num_written += chunk_size;
a0c9ca28 David Daney 2018-02-15  395  		msleep(ISL12026_NVMEM_WRITE_TIME);
a0c9ca28 David Daney 2018-02-15  396  	}
a0c9ca28 David Daney 2018-02-15  397
a0c9ca28 David Daney 2018-02-15  398  	mutex_unlock(&priv->lock);
a0c9ca28 David Daney 2018-02-15  399
a0c9ca28 David Daney 2018-02-15 @400  	return num_written >= 0 ? num_written : ret;
a0c9ca28 David Daney 2018-02-15  401  }
a0c9ca28 David Daney 2018-02-15  402

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
