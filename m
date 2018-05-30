Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030347AbeE3Hqc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:46:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:64455 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030280AbeE3Hq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:46:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,459,1520924400";
   d="scan'208";a="45856189"
Date: Wed, 30 May 2018 15:45:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Maciej Purski <m.purski@samsung.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: Re: [PATCH 08/12] drm/bridge: tc358764: Add DSI to LVDS bridge driver
Message-ID: <201805301553.AcTypuC4%fengguang.wu@intel.com>
References: <1527500833-16005-9-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527500833-16005-9-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20180517]
[cannot apply to drm-exynos/exynos-drm/for-next robh/for-next drm/drm-next v4.17-rc6 v4.17-rc5 v4.17-rc4 v4.17-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/Add-TOSHIBA-TC358764-DSI-LVDS-bridge-driver/20180530-011258
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/bridge/tc358764.c:193:14: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [addressable] [usertype] addr @@    got ed] [addressable] [usertype] addr @@
   drivers/gpu/drm/bridge/tc358764.c:193:14:    expected unsigned short [unsigned] [addressable] [usertype] addr
   drivers/gpu/drm/bridge/tc358764.c:193:14:    got restricted __le16 [usertype] <noident>
>> drivers/gpu/drm/bridge/tc358764.c:197:24: sparse: cast to restricted __le32
>> drivers/gpu/drm/bridge/tc358764.c:175:5: sparse: symbol 'tc358764_read' was not declared. Should it be static?
>> drivers/gpu/drm/bridge/tc358764.c:204:5: sparse: symbol 'tc358764_write' was not declared. Should it be static?

vim +193 drivers/gpu/drm/bridge/tc358764.c

   174	
 > 175	int tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)
   176	{
   177		struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
   178		const struct mipi_dsi_host_ops *ops = dsi->host->ops;
   179		struct mipi_dsi_msg msg = {
   180			.type = MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM,
   181			.channel = dsi->channel,
   182			.flags = MIPI_DSI_MSG_USE_LPM,
   183			.tx_buf = &addr,
   184			.tx_len = 2,
   185			.rx_buf = val,
   186			.rx_len = 4
   187		};
   188		ssize_t ret;
   189	
   190		if (!ops || !ops->transfer)
   191			return -EINVAL;
   192	
 > 193		addr = cpu_to_le16(addr);
   194	
   195		ret = ops->transfer(dsi->host, &msg);
   196		if (ret >= 0)
 > 197			*val = le32_to_cpu(*val);
   198	
   199		dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
   200	
   201		return ret;
   202	}
   203	
 > 204	int tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)
   205	{
   206		struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
   207		const struct mipi_dsi_host_ops *ops = dsi->host->ops;
   208		u8 data[6];
   209		int ret;
   210		struct mipi_dsi_msg msg = {
   211			.type = MIPI_DSI_GENERIC_LONG_WRITE,
   212			.channel = dsi->channel,
   213			.flags = MIPI_DSI_MSG_USE_LPM | MIPI_DSI_MSG_REQ_ACK,
   214			.tx_buf = data,
   215			.tx_len = 6
   216		};
   217	
   218		if (!ops || !ops->transfer)
   219			return -EINVAL;
   220	
   221		data[0] = addr;
   222		data[1] = addr >> 8;
   223		data[2] = val;
   224		data[3] = val >> 8;
   225		data[4] = val >> 16;
   226		data[5] = val >> 24;
   227	
   228		ret = ops->transfer(dsi->host, &msg);
   229	
   230		return ret;
   231	}
   232	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
