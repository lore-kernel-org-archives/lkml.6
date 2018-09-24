Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D11C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710E72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710E72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeIXQaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:30:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:52905 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeIXQaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:30:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="259755312"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga005.jf.intel.com with ESMTP; 24 Sep 2018 03:28:53 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 09/14] serial: lantiq: Add CCF support
Date:   Mon, 24 Sep 2018 18:27:58 +0800
Message-Id: <20180924102803.30263-10-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous implementation uses platform-dependent API to get the clock.
Those functions are not available for other SoC which uses the same IP.
The CCF (Common Clock Framework) have an abstraction based APIs for
clock. In future, the platform specific code will be removed when the
legacy soc use CCF as well.
Change to use CCF APIs to get clock and rate. So that different SoCs
can use the same driver.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 34b1ef3c12ce..88210de00f35 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -744,14 +744,22 @@ lqasc_probe(struct platform_device *pdev)
 	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
-	ltq_port->freqclk = clk_get_fpi();
+	if (IS_ENABLED(CONFIG_LANTIQ) && !IS_ENABLED(CONFIG_COMMON_CLK))
+		ltq_port->freqclk = clk_get_fpi();
+	else
+		ltq_port->freqclk = devm_clk_get(&pdev->dev, "freq");
+
+
 	if (IS_ERR(ltq_port->freqclk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
 	}
 
 	/* not all asc ports have clock gates, lets ignore the return code */
-	ltq_port->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ENABLED(CONFIG_LANTIQ) && !IS_ENABLED(CONFIG_COMMON_CLK))
+		ltq_port->clk = clk_get(&pdev->dev, NULL);
+	else
+		ltq_port->clk = devm_clk_get(&pdev->dev, "asc");
 
 	ltq_port->tx_irq = irqres[0].start;
 	ltq_port->rx_irq = irqres[1].start;
-- 
2.11.0

