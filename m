Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeEEHQG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:16:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:62111 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeEEHQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:16:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,365,1520924400";
   d="scan'208";a="48457682"
Date: Sat, 5 May 2018 15:15:07 +0800
From: kbuild test robot <lkp@intel.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: kbuild-all@01.org, Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v4 2/3] drm/panel: Add Ilitek ILI9881c panel driver
Message-ID: <201805051322.EipQom5M%fengguang.wu@intel.com>
References: <e9348b12b59e6236a7965ceba94011a1e5b72720.1525447375.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9348b12b59e6236a7965ceba94011a1e5b72720.1525447375.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/drm-panel-Add-Ilitek-ILI9881c-controller-driver/20180505-104031
base:    
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:303:62: sparse: incorrect type in initializer (different modifiers) @@    expected struct ili9881c_instr *instr @@    got structstruct ili9881c_instr *instr @@
   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:303:62:    expected struct ili9881c_instr *instr
   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:303:62:    got struct ili9881c_instr const *
   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c: In function 'ili9881c_prepare':
   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:303:34: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      struct ili9881c_instr *instr = &ili9881c_init[i];
                                     ^

vim +303 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

   284	
   285	static int ili9881c_prepare(struct drm_panel *panel)
   286	{
   287		struct ili9881c *ctx = panel_to_ili9881c(panel);
   288		unsigned int i;
   289		int ret;
   290	
   291		/* Power the panel */
   292		gpiod_set_value(ctx->power, 1);
   293		msleep(5);
   294	
   295		/* And reset it */
   296		gpiod_set_value(ctx->reset, 1);
   297		msleep(20);
   298	
   299		gpiod_set_value(ctx->reset, 0);
   300		msleep(20);
   301	
   302		for (i = 0; i < ARRAY_SIZE(ili9881c_init); i++) {
 > 303			struct ili9881c_instr *instr = &ili9881c_init[i];
   304	
   305			if (instr->op == ILI9881C_SWITCH_PAGE)
   306				ret = ili9881c_switch_page(ctx, instr->arg.page);
   307			else if (instr->op == ILI9881C_COMMAND)
   308				ret = ili9881c_send_cmd_data(ctx, instr->arg.cmd.cmd,
   309							      instr->arg.cmd.data);
   310	
   311			if (ret)
   312				return ret;
   313		}
   314	
   315		ret = ili9881c_switch_page(ctx, 0);
   316		if (ret)
   317			return ret;
   318	
   319		ret = mipi_dsi_dcs_set_tear_on(ctx->dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
   320		if (ret)
   321			return ret;
   322	
   323		mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
   324		if (ret)
   325			return ret;
   326	
   327		return 0;
   328	}
   329	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
