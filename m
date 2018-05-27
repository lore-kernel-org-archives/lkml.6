Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032678AbeE0OvG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 10:51:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:26557 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965011AbeE0OvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 10:51:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="42578915"
Date: Sun, 27 May 2018 22:50:58 +0800
From: kbuild test robot <lkp@intel.com>
To: David Lechner <david@lechnology.com>
Cc: kbuild-all@01.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nitin Patil <nitin@mindsensors.com>
Subject: Re: [PATCH v2 4/4] drm/tinydrm: new driver for ILI9341 display panels
Message-ID: <201805272045.EwwwImqG%fengguang.wu@intel.com>
References: <20180525193623.15533-5-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525193623.15533-5-david@lechnology.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Lechner/drm-tinydrm-new-dirver-for-ILI9341-displays/20180527-182036
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/tinydrm/ili9341.c:128:30: sparse: too many arguments for function mipi_dbi_enable_flush
>> drivers/gpu/drm/tinydrm/ili9341.c:132:19: sparse: incorrect type in initializer (different argument counts) @@    expected void ( *enable )( ... ) @@    got void ( *enable )( ... ) @@
   drivers/gpu/drm/tinydrm/ili9341.c:132:19:    expected void ( *enable )( ... )
   drivers/gpu/drm/tinydrm/ili9341.c:132:19:    got void ( *<noident> )( ... )
   drivers/gpu/drm/tinydrm/ili9341.c:135:23: sparse: undefined identifier 'drm_gem_fb_simple_display_pipe_prepare_fb'
   drivers/gpu/drm/tinydrm/ili9341.c: In function 'yx240qv29_enable':
   drivers/gpu/drm/tinydrm/ili9341.c:128:2: error: too many arguments to function 'mipi_dbi_enable_flush'
     mipi_dbi_enable_flush(mipi, crtc_state, plane_state);
     ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/tinydrm/ili9341.c:21:0:
   include/drm/tinydrm/mipi-dbi.h:70:6: note: declared here
    void mipi_dbi_enable_flush(struct mipi_dbi *mipi);
         ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tinydrm/ili9341.c: At top level:
   drivers/gpu/drm/tinydrm/ili9341.c:132:12: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .enable = yx240qv29_enable,
               ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/tinydrm/ili9341.c:132:12: note: (near initialization for 'ili9341_pipe_funcs.enable')
   drivers/gpu/drm/tinydrm/ili9341.c:135:16: error: 'drm_gem_fb_simple_display_pipe_prepare_fb' undeclared here (not in a function); did you mean 'tinydrm_display_pipe_prepare_fb'?
     .prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                   tinydrm_display_pipe_prepare_fb
   cc1: some warnings being treated as errors

vim +132 drivers/gpu/drm/tinydrm/ili9341.c

    49	
    50	static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
    51				     struct drm_crtc_state *crtc_state,
    52				     struct drm_plane_state *plane_state)
    53	{
    54		struct tinydrm_device *tdev = pipe_to_tinydrm(pipe);
    55		struct mipi_dbi *mipi = mipi_dbi_from_tinydrm(tdev);
    56		u8 addr_mode;
    57		int ret;
    58	
    59		DRM_DEBUG_KMS("\n");
    60	
    61		ret = mipi_dbi_poweron_conditional_reset(mipi);
    62		if (ret < 0)
    63			return;
    64		if (ret == 1)
    65			goto out_enable;
    66	
    67		mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_OFF);
    68	
    69		mipi_dbi_command(mipi, ILI9341_PWCTRLB, 0x00, 0xc1, 0x30);
    70		mipi_dbi_command(mipi, ILI9341_PWRSEQ, 0x64, 0x03, 0x12, 0x81);
    71		mipi_dbi_command(mipi, ILI9341_DTCTRLA, 0x85, 0x00, 0x78);
    72		mipi_dbi_command(mipi, ILI9341_PWCTRLA, 0x39, 0x2c, 0x00, 0x34, 0x02);
    73		mipi_dbi_command(mipi, ILI9341_PUMPCTRL, 0x20);
    74		mipi_dbi_command(mipi, ILI9341_DTCTRLB, 0x00, 0x00);
    75	
    76		/* Power Control */
    77		mipi_dbi_command(mipi, ILI9341_PWCTRL1, 0x23);
    78		mipi_dbi_command(mipi, ILI9341_PWCTRL2, 0x10);
    79		/* VCOM */
    80		mipi_dbi_command(mipi, ILI9341_VMCTRL1, 0x3e, 0x28);
    81		mipi_dbi_command(mipi, ILI9341_VMCTRL2, 0x86);
    82	
    83		/* Memory Access Control */
    84		mipi_dbi_command(mipi, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
    85	
    86		/* Frame Rate */
    87		mipi_dbi_command(mipi, ILI9341_FRMCTR1, 0x00, 0x1b);
    88	
    89		/* Gamma */
    90		mipi_dbi_command(mipi, ILI9341_EN3GAM, 0x00);
    91		mipi_dbi_command(mipi, MIPI_DCS_SET_GAMMA_CURVE, 0x01);
    92		mipi_dbi_command(mipi, ILI9341_PGAMCTRL,
    93				 0x0f, 0x31, 0x2b, 0x0c, 0x0e, 0x08, 0x4e, 0xf1,
    94				 0x37, 0x07, 0x10, 0x03, 0x0e, 0x09, 0x00);
    95		mipi_dbi_command(mipi, ILI9341_NGAMCTRL,
    96				 0x00, 0x0e, 0x14, 0x03, 0x11, 0x07, 0x31, 0xc1,
    97				 0x48, 0x08, 0x0f, 0x0c, 0x31, 0x36, 0x0f);
    98	
    99		/* DDRAM */
   100		mipi_dbi_command(mipi, ILI9341_ETMOD, 0x07);
   101	
   102		/* Display */
   103		mipi_dbi_command(mipi, ILI9341_DISCTRL, 0x08, 0x82, 0x27, 0x00);
   104		mipi_dbi_command(mipi, MIPI_DCS_EXIT_SLEEP_MODE);
   105		msleep(100);
   106	
   107		mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_ON);
   108		msleep(100);
   109	
   110	out_enable:
   111		switch (mipi->rotation) {
   112		default:
   113			addr_mode = ILI9341_MADCTL_MX;
   114			break;
   115		case 90:
   116			addr_mode = ILI9341_MADCTL_MV;
   117			break;
   118		case 180:
   119			addr_mode = ILI9341_MADCTL_MY;
   120			break;
   121		case 270:
   122			addr_mode = ILI9341_MADCTL_MV | ILI9341_MADCTL_MY |
   123				    ILI9341_MADCTL_MX;
   124			break;
   125		}
   126		addr_mode |= ILI9341_MADCTL_BGR;
   127		mipi_dbi_command(mipi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
 > 128		mipi_dbi_enable_flush(mipi, crtc_state, plane_state);
   129	}
   130	
   131	static const struct drm_simple_display_pipe_funcs ili9341_pipe_funcs = {
 > 132		.enable = yx240qv29_enable,
   133		.disable = mipi_dbi_pipe_disable,
   134		.update = tinydrm_display_pipe_update,
   135		.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
   136	};
   137	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
