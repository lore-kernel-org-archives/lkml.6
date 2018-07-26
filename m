Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A31C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA14F2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA14F2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeGZKi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:38:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35981 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbeGZKi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:38:28 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ficTX-0002ap-Qb; Thu, 26 Jul 2018 11:22:23 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ore@pengutronix.de>)
        id 1ficTV-0004Vi-Ss; Thu, 26 Jul 2018 11:22:21 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH v8 0/6] provide power off support for iMX6 with external PMIC
Date:   Thu, 26 Jul 2018 11:22:14 +0200
Message-Id: <20180726092220.17250-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018.07.26:
v8 is a rebase against kernel v4.18-rc6. No other changes are made.
Added: linux-imx@nxp.com and yibin.gong@nxp.com to the CC.

2018.05.17:
update patches to version v7

This patch series is providing power off support for Freescale/NXP iMX6 based
boards with external power management integrated circuit (PMIC).
As a first step the PMIC is configured to turn off the system if the
standby pin is asserted. On second step we assert the standby pin.
For this reason we need to use pm_power_off_prepare.

Usage of stnadby pin for power off is described in official iMX6
documentation.

2018.03.05:
As this patch set touches multiple subsystems I think it would make
sense for Shawn Guo to take the all patch set.
The only part which didn't receive an ACK is regulator stuff. So I would
hope that Mark Brown can ACK it.

Kind regards,
Oleksij Rempel

2017.12.06:
Adding Linus. Probably there is no maintainer for this patch set.
No changes are made, tested on v4.15-rc1.

2017.10.27:
Last version of this patch set was send at 20 Jun 2017, this is a rebase against
kernel v4.14-rc6. Probably this set got lost. If I forgot to address some comments,
please point me.

changes:
v7:
 - use EXPORT_SYMBOL_GPL(pm_power_off_prepare) instead of EXPORT_SYMBOL
 - call imx6q_suspend_finish() directly without cpu_suspend()

v6:
 - rename imx6_pm_poweroff to imx6_pm_stby_poweroff
 - fix "MPIC_STBY_REQ" typo in the comment.

v5:
 - remove useless includes from pm-imx6.c patch
 - add Acked-by to "regulator: pfuze100: add fsl,pmic-stby-poweroff property"
   patch

v4:
 - update comment in "regulator: pfuze100: add fsl,pmic-stby-poweroff ..."
   patch
 - add Acked-by to "ARM: imx6q: provide documentation for new ..."
   patch

v3:
 - set pm_power_off_prepare = NULL on .remove.
 - documentation and spelling fixes.
 - use %pf instead of lookup_symbol_name.

Oleksij Rempel (6):
  ARM: imx6q: provide documentation for new fsl,pmic-stby-poweroff
    property
  ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff"
    is set
  kernel/reboot.c: export pm_power_off_prepare
  regulator: pfuze100: add fsl,pmic-stby-poweroff property
  regulator: pfuze100-regulator: provide pm_power_off_prepare handler
  ARM: dts: imx6: RIoTboard provide standby on power off option

 .../devicetree/bindings/clock/imx6q-clock.txt |  8 ++
 .../bindings/regulator/pfuze100.txt           |  7 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts        |  5 +
 arch/arm/mach-imx/pm-imx6.c                   | 25 +++++
 drivers/regulator/pfuze100-regulator.c        | 92 +++++++++++++++++++
 kernel/reboot.c                               |  1 +
 6 files changed, 138 insertions(+)

-- 
2.18.0

