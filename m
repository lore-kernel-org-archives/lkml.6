Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5D62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FW03Y217"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeLQMVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:21:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47178 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeLQMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:20:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBHCK0R2115492;
        Mon, 17 Dec 2018 06:20:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545049200;
        bh=sKg8EdeqXwg0y0wxtSFqOXok0QC3UOS3dOgdEGnJVqE=;
        h=From:To:CC:Subject:Date;
        b=FW03Y217v6M8s9xaWMTNZ50ajoOOvMhlCCTTvoE5ztuL02XdS5Dm4CxNjqCkqtKBn
         9vQ9TJP4L+uVk3f3ybf0Gvdq+TGkhEigiXfeULZbShDZ900sfuiR8VNehvgMYO2dCh
         6uFFFqqEqm6TceVxxZOHf0M161S2xUNHbE+icOaY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBHCK0DF009431
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 06:20:00 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 06:19:59 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 06:19:59 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBHCJuXM023433;
        Mon, 17 Dec 2018 06:19:57 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <jarkko.nikula@bitmer.com>, <tony@atomide.com>, <nsekhar@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
Subject: [PATCH 0/9] ASoC/ARM: Merge the davinci and omap audio directories
Date:   Mon, 17 Dec 2018 14:21:33 +0200
Message-ID: <20181217122142.6652-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since RFC:
- Added Jarkko's Acked-by/Tested-by for the {omap->ti} changes
- Rebased on top of next-20181210 (20181214+ is not booting on any of my boards)

For Texas Instruments audio support we have two directories at the moment:
davinci
omap

In reality TI have the following SoC lines supported by Linux:
daVinci
OMAP
Sitara
Keystone

We already needed to have cross directory 'links' for DRA7x/AM5 since they use
McASP (davinci directory) and sDMA (omap directory).
Keystone II line of SoCs are using drivers from davinci directory (McASP and
EDMA). Which is kind of fine as they are in the same place.

With the new AM654 (http://www.ti.com/lit/pdf/spruid7) we will have completely
new DMA and there is no place to put that as it does not belong under davinci
or omap, but it makes no sense to create yet another TI related directory just
for the small udma-pcm.

Another issue with the current support is how the Kconfigs are written.
The DAI drivers are depending on the ASoC platform drivers and it is a bit of a
mess at the moment.
For simple-sound-card one need to know what DMA is used and then select the DAI
driver (if the Kconfig is right).
I have also cleaned up the Kconfig prompts and comments a bit to be more
precise.

As can be seen in the diffstat I tried to do the merger with minimal code
change, resisting the urge to rename the davinci-i2c driver to davinci-asp.

With the merger I have created a new Kconfig structure:
- Submenu for TI related settings for clarity
- Only the DAI drivers are selectable and the platform drivers are selected
  based on the available (enabled) DMA engines
- The remaining ASoC machine drivers are selecting the DAIs they need
- The davinci-evm is now a single entry, combining all the various daVinci EVMS
  it supports and selects the needed DAIs based on the enabled boards

The series also includes patches to updated the arch/arm/ files (defconfigs,
source files using audio Kconfig symbols).

I think I have catched all (I hope) issues regarding to Kconfig thanks to the
various autobuild machines out there kindly testing my linux-next-wip branch.

Mark, Tony, Sekhar: This series - as I mentioned - is based on next-20181210.
Not sure what tag, branch, commit  I should base this, but I can resend v2 if
needed.

Regards,
Peter
---
Peter Ujfalusi (9):
  ASoC: ti: Merge davinci and omap directories
  MAINTAINERS: Add entry for sound/soc/ti and update the OMAP audio
    support
  ARM: OMAP1: Makefile: Update for new MCBSP Kconfig option
  ARM: OMAP2: Update for new MCBSP Kconfig option
  ARM: davinci: dm365-evm: Update for the new ASoC Kcofnig options
  ARM: omap2plus_defconfig: Update the audio options
  ARM: omap1_defconfig: Do not select ASoC by default
  ARM: davinci_all_defconfig: Update the audio options
  ASoC: ti: Kconfig: Remove the deprecated options

 MAINTAINERS                                   |  11 +-
 arch/arm/configs/davinci_all_defconfig        |   5 +-
 arch/arm/configs/omap1_defconfig              |   2 -
 arch/arm/configs/omap2plus_defconfig          |  14 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |   4 +-
 arch/arm/mach-omap1/Makefile                  |   2 +-
 arch/arm/mach-omap2/Makefile                  |   2 +-
 arch/arm/mach-omap2/pdata-quirks.c            |   4 +-
 sound/soc/Kconfig                             |   3 +-
 sound/soc/Makefile                            |   3 +-
 sound/soc/davinci/Kconfig                     | 106 ---------
 sound/soc/davinci/Makefile                    |  16 --
 sound/soc/omap/Kconfig                        | 120 ----------
 sound/soc/omap/Makefile                       |  30 ---
 sound/soc/ti/Kconfig                          | 209 ++++++++++++++++++
 sound/soc/ti/Makefile                         |  44 ++++
 sound/soc/{omap => ti}/ams-delta.c            |   0
 sound/soc/{davinci => ti}/davinci-evm.c       |   4 +-
 sound/soc/{davinci => ti}/davinci-i2s.c       |   0
 sound/soc/{davinci => ti}/davinci-i2s.h       |   0
 sound/soc/{davinci => ti}/davinci-mcasp.c     |  14 +-
 sound/soc/{davinci => ti}/davinci-mcasp.h     |   0
 sound/soc/{davinci => ti}/davinci-vcif.c      |   0
 sound/soc/{davinci => ti}/edma-pcm.c          |   0
 sound/soc/{davinci => ti}/edma-pcm.h          |   4 +-
 sound/soc/{omap => ti}/n810.c                 |   0
 sound/soc/{omap => ti}/omap-abe-twl6040.c     |   0
 sound/soc/{omap => ti}/omap-dmic.c            |   0
 sound/soc/{omap => ti}/omap-dmic.h            |   0
 .../omap-hdmi-audio.c => ti/omap-hdmi.c}      |   0
 sound/soc/{omap => ti}/omap-mcbsp-priv.h      |   0
 sound/soc/{omap => ti}/omap-mcbsp-st.c        |   0
 sound/soc/{omap => ti}/omap-mcbsp.c           |   0
 sound/soc/{omap => ti}/omap-mcbsp.h           |   0
 sound/soc/{omap => ti}/omap-mcpdm.c           |   0
 sound/soc/{omap => ti}/omap-mcpdm.h           |   0
 sound/soc/{omap => ti}/omap-twl4030.c         |   0
 sound/soc/{omap => ti}/omap3pandora.c         |   0
 sound/soc/{omap => ti}/osk5912.c              |   0
 sound/soc/{omap => ti}/rx51.c                 |   0
 sound/soc/{omap => ti}/sdma-pcm.c             |   0
 sound/soc/{omap => ti}/sdma-pcm.h             |   4 +-
 42 files changed, 294 insertions(+), 307 deletions(-)
 delete mode 100644 sound/soc/davinci/Kconfig
 delete mode 100644 sound/soc/davinci/Makefile
 delete mode 100644 sound/soc/omap/Kconfig
 delete mode 100644 sound/soc/omap/Makefile
 create mode 100644 sound/soc/ti/Kconfig
 create mode 100644 sound/soc/ti/Makefile
 rename sound/soc/{omap => ti}/ams-delta.c (100%)
 rename sound/soc/{davinci => ti}/davinci-evm.c (99%)
 rename sound/soc/{davinci => ti}/davinci-i2s.c (100%)
 rename sound/soc/{davinci => ti}/davinci-i2s.h (100%)
 rename sound/soc/{davinci => ti}/davinci-mcasp.c (99%)
 rename sound/soc/{davinci => ti}/davinci-mcasp.h (100%)
 rename sound/soc/{davinci => ti}/davinci-vcif.c (100%)
 rename sound/soc/{davinci => ti}/edma-pcm.c (100%)
 rename sound/soc/{davinci => ti}/edma-pcm.h (91%)
 rename sound/soc/{omap => ti}/n810.c (100%)
 rename sound/soc/{omap => ti}/omap-abe-twl6040.c (100%)
 rename sound/soc/{omap => ti}/omap-dmic.c (100%)
 rename sound/soc/{omap => ti}/omap-dmic.h (100%)
 rename sound/soc/{omap/omap-hdmi-audio.c => ti/omap-hdmi.c} (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp-priv.h (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp-st.c (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp.c (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp.h (100%)
 rename sound/soc/{omap => ti}/omap-mcpdm.c (100%)
 rename sound/soc/{omap => ti}/omap-mcpdm.h (100%)
 rename sound/soc/{omap => ti}/omap-twl4030.c (100%)
 rename sound/soc/{omap => ti}/omap3pandora.c (100%)
 rename sound/soc/{omap => ti}/osk5912.c (100%)
 rename sound/soc/{omap => ti}/rx51.c (100%)
 rename sound/soc/{omap => ti}/sdma-pcm.c (100%)
 rename sound/soc/{omap => ti}/sdma-pcm.h (85%)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

