Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2777CC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98A72147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBGOWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:22:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:14454 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfBGOWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:22:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 06:22:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="120681829"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2019 06:22:48 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1grkZi-0006QM-RR; Thu, 07 Feb 2019 16:22:46 +0200
Date:   Thu, 7 Feb 2019 16:22:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 00/28] thunderbolt: Software connection manager
 improvements
Message-ID: <20190207142246.GG9224@smile.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:10PM +0300, Mika Westerberg wrote:
> Hi,
> 
> Software connection manager (drivers/thunderbolt/tb.c) is used on older
> Apple hardware with Light Ridge, Cactus Ridge or Falcon Ridge controllers
> to create PCIe tunnels when a Thunderbolt device is connected. Currently
> only one PCIe tunnel is supported. On newer Alpine Ridge based Apple
> systems the driver starts the firmware which then takes care creating
> tunnels.
> 
> This series improves the software connection manager so that it will
> support:
> 
>   - Full PCIe daisy chains (up to 6 devices)
>   - Display Port tunneling
>   - P2P networking
> 
> We also add support for Titan Ridge based Apple systems where we can use
> the same flows than with Alpine Ridge to start the firmware.
> 
> Note in order to prevent possible DMA attacks on these systems we should
> make sure IOMMU is enabled. One option is to force dmar_platform_optin()
> return true on Apple hardware. However, it is not part of this series. I'm
> trusting people using Linux on such systems to take care of it.  :-)
> 
> Previous version of the patch series can be viewed here:
> 
>   https://lkml.org/lkml/2019/1/29/924


From code style and some other things we discussed off list the series looks
good to me.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Though minor comments per individual patches are provided.

> 
> Changes from v1:
> 
>   * Added ACK from David
> 
>   * Add constant (TMU_ACCESS_EN) for BIT(20) when TMU access is enabled. We
>     keep it in cap.c close to the LR/ER workaround. Also we enable/disable
>     only during capability walk. If it turns we need to have it enabled
>     elsewhere we can move it to switch.c and enable just once during
>     switch enumeration.
> 
>   * Use 0 to mean no cap_adap instead of negative value. This follows
>     cap_phy.
> 
>   * Use correct PCI IDs (_BRIDGE) in the last patch where we start firmware
>     on Titan Ridge. It wrongly used NHI PCI IDs in v1.
> 
> Mika Westerberg (28):
>   net: thunderbolt: Unregister ThunderboltIP protocol handler when suspending
>   thunderbolt: Do not allocate switch if depth is greater than 6
>   thunderbolt: Enable TMU access when accessing port space on legacy devices
>   thunderbolt: Add dummy read after port capability list walk on Light Ridge
>   thunderbolt: Move LC specific functionality into a separate file
>   thunderbolt: Configure lanes when switch is initialized
>   thunderbolt: Set sleep bit when suspending switch
>   thunderbolt: Properly disable path
>   thunderbolt: Cache adapter specific capability offset into struct port
>   thunderbolt: Rename tunnel_pci to tunnel
>   thunderbolt: Generalize tunnel creation functionality
>   thunderbolt: Add functions for allocating and releasing hop IDs
>   thunderbolt: Add helper function to iterate from one port to another
>   thunderbolt: Extend tunnel creation to more than 2 adjacent switches
>   thunderbolt: Deactivate all paths before restarting them
>   thunderbolt: Discover preboot PCIe paths the boot firmware established
>   thunderbolt: Add support for full PCIe daisy chains
>   thunderbolt: Scan only valid NULL adapter ports in hotplug
>   thunderbolt: Generalize port finding routines to support all port types
>   thunderbolt: Rework NFC credits handling
>   thunderbolt: Add support for Display Port tunnels
>   thunderbolt: Run tb_xdp_handle_request() in system workqueue
>   thunderbolt: Add XDomain UUID exchange support
>   thunderbolt: Add support for DMA tunnels
>   thunderbolt: Make tb_switch_alloc() return ERR_PTR()
>   thunderbolt: Add support for XDomain connections
>   thunderbolt: Make rest of the logging to happen at debug level
>   thunderbolt: Start firmware on Titan Ridge Apple systems
> 
>  drivers/net/thunderbolt.c        |   3 +
>  drivers/thunderbolt/Makefile     |   4 +-
>  drivers/thunderbolt/cap.c        |  90 +++-
>  drivers/thunderbolt/ctl.c        |   2 +-
>  drivers/thunderbolt/icm.c        |  15 +-
>  drivers/thunderbolt/lc.c         | 179 ++++++++
>  drivers/thunderbolt/path.c       | 326 +++++++++++++--
>  drivers/thunderbolt/switch.c     | 466 ++++++++++++++++++---
>  drivers/thunderbolt/tb.c         | 529 ++++++++++++++++++------
>  drivers/thunderbolt/tb.h         |  67 ++-
>  drivers/thunderbolt/tb_msgs.h    |  11 +
>  drivers/thunderbolt/tb_regs.h    |  50 ++-
>  drivers/thunderbolt/tunnel.c     | 681 +++++++++++++++++++++++++++++++
>  drivers/thunderbolt/tunnel.h     |  75 ++++
>  drivers/thunderbolt/tunnel_pci.c | 226 ----------
>  drivers/thunderbolt/tunnel_pci.h |  31 --
>  drivers/thunderbolt/xdomain.c    | 142 ++++++-
>  include/linux/thunderbolt.h      |   8 +
>  18 files changed, 2389 insertions(+), 516 deletions(-)
>  create mode 100644 drivers/thunderbolt/lc.c
>  create mode 100644 drivers/thunderbolt/tunnel.c
>  create mode 100644 drivers/thunderbolt/tunnel.h
>  delete mode 100644 drivers/thunderbolt/tunnel_pci.c
>  delete mode 100644 drivers/thunderbolt/tunnel_pci.h
> 
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


