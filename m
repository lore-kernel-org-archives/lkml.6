Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E15C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2752080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2752080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeJWTy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:54:59 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:38192 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeJWTy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:54:58 -0400
Received: from tony.xie?rock-chips.com (unknown [192.168.167.73])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5995C3EB;
        Tue, 23 Oct 2018 19:31:44 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id D877F390;
        Tue, 23 Oct 2018 19:31:37 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: tony.xie@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: tony.xie@rock-chips.com
X-UNIQUE-TAG: <f4448ed0684834f905828da3ca93c9ab>
X-ATTACHMENT-NUM: 0
X-SENDER: xxx@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 30768VN3LLL;
        Tue, 23 Oct 2018 19:31:39 +0800 (CST)
From:   Tony Xie <tony.xie@rock-chips.com>
To:     heiko@sntech.de
Cc:     broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
Subject: [PATCH v5 0/5] support a new type of PMIC,including two chips(rk817 and rk809)
Date:   Tue, 23 Oct 2018 19:34:22 +0800
Message-Id: <1540294467-25813-1-git-send-email-tony.xie@rock-chips.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of functions and registers of the rk817 and rk808 are the same,
so they can share allmost all codes.

Their specifications are as follows£º
  1) The RK809 and RK809 consist of 5 DCDCs, 9 LDOs and have the same registers
     for these components except dcdc5.
  2) The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
  3) The RK817 has one switch but The Rk809 has two.

Changes in V2:
1. initialize the pm_pwroff_fn to NULL. 
2. use EXPORT_SYMBOL_GPL to export pm_power_off_prepare.
3. change patch 2/3/4/5 subjects. 

Changes in V3£º
1. change patch 4 subjects
2. replace pr_ with dev_ for printing in patch 2
3. modify switch1 and switch2 configs in patch 2
4. explain gpio information for rk809 and rk817 in patch 4

Changes in V4:
1. modify some codes for patch 2 and patch 5 according to comments 
2. add reviewer mail lists for patch 3 and 4

Changes in V5:
modify some codes for patch 1 according to reveiw comments for v3.
 1) remove the pm_power_off_prepare() and replace with shutdown call-back from syscore
 2) move the macro REGMAP_IRQ_M into the regmap.h and rename it REGMAP_IRQ_LINE
 3) make some dev_warn() log clear

Tony Xie (5):
  mfd: rk808: Add RK817 and RK809 support
  regulator: rk808: add RK809 and RK817 support.
  dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
  rtc: rk808: add RK809 and RK817 support.
  clk: RK808: add RK809 and RK817 support.

 Documentation/devicetree/bindings/mfd/rk808.txt |  44 ++
 drivers/clk/Kconfig                             |   9 +-
 drivers/clk/clk-rk808.c                         |  64 ++-
 drivers/mfd/Kconfig                             |   6 +-
 drivers/mfd/rk808.c                             | 225 +++++++-
 drivers/regulator/Kconfig                       |   4 +-
 drivers/regulator/rk808-regulator.c             | 657 +++++++++++++++++++++++-
 drivers/rtc/Kconfig                             |   4 +-
 drivers/rtc/rtc-rk808.c                         |  68 ++-
 include/linux/mfd/rk808.h                       | 175 +++++++
 include/linux/regmap.h                          |   6 +
 11 files changed, 1193 insertions(+), 69 deletions(-)

-- 
1.9.1


