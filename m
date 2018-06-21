Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FB6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC11120883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kczQ+RmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC11120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932808AbeFUILO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:11:14 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:56836 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeFUILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:11:12 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5L8B8EV005718;
        Thu, 21 Jun 2018 03:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529568668;
        bh=D+XJdwKstcK+TcLkNKoGXdn8DDPyuAZcCfVh+LiwT/s=;
        h=From:To:CC:Subject:Date;
        b=kczQ+RmA8DKFtVsOI1lMH+Zz1fp6PZsdjcCmjomeF2T+1TBeX0tc6wkA5dIA6JSF2
         nDrmVTrzkdx/zPeeUz9RJ/FC3VPe7WTRklWPLsn4FpXHjph2Y46cDQcmh51GYibe6o
         GdLsI5IGXgWtAgvK5gMN3dzoQ9jo0PKqUdJWMaeY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8B8Ku030174;
        Thu, 21 Jun 2018 03:11:08 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 03:11:08 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 03:11:08 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8B5aU024513;
        Thu, 21 Jun 2018 03:11:06 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-clk@vger.kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH v2 0/4] clk: clk: Add functions to save/restore clock context en-masse
Date:   Thu, 21 Jun 2018 13:40:16 +0530
Message-ID: <1529568620-19765-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deep enough power saving mode can result into losing context of the clock
registers also, and they need to be restored once coming back from the power
saving mode. Hence add functions to save/restore clock context.

Tested for DS0 on am437x-gp-evm

Based on top of linux-next

Changes in v2:

        * Renamed clk_dflt_restore to clk_gate_restore_context

Keerthy (2):
  clk: clk: Add clk_gate_restore_context function
  soc: ti: pm33xx: Save/restore clk context based on enable_off_mode
    setting

Russ Dill (2):
  clk: clk: Add functions to save/restore clock context en-masse
  clk: ti: Add functions to save/restore clk context

 arch/arm/mach-omap2/pm33xx-core.c    |  15 +++++
 drivers/clk/clk.c                    |  93 ++++++++++++++++++++++++++
 drivers/clk/ti/clock.h               |   2 +
 drivers/clk/ti/divider.c             |  36 ++++++++++
 drivers/clk/ti/dpll.c                |   6 ++
 drivers/clk/ti/dpll3xxx.c            | 124 +++++++++++++++++++++++++++++++++++
 drivers/clk/ti/gate.c                |   3 +
 drivers/clk/ti/mux.c                 |  29 ++++++++
 drivers/soc/ti/pm33xx.c              |  13 ++++
 include/linux/clk-provider.h         |   9 +++
 include/linux/clk.h                  |  25 +++++++
 include/linux/clk/ti.h               |   6 ++
 include/linux/platform_data/pm33xx.h |   1 +
 13 files changed, 362 insertions(+)

-- 
1.9.1

