Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA026C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E423216F3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E423216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbeHCE6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:58:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:63304 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbeHCE6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:58:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="69687702"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2018 20:04:25 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 14/18] serial: intel: Add CCF support
Date:   Fri,  3 Aug 2018 11:02:33 +0800
Message-Id: <20180803030237.3366-15-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
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

Changes in v2: None

 drivers/tty/serial/lantiq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 36479d66fb7c..35518ab3a80d 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -26,7 +26,9 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 
+#ifdef CONFIG_LANTIQ
 #include <lantiq_soc.h>
+#endif
 
 #define PORT_LTQ_ASC		111
 #define MAXPORTS		2
@@ -744,14 +746,23 @@ lqasc_probe(struct platform_device *pdev)
 	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
+#if (IS_ENABLED(CONFIG_LANTIQ) && !IS_ENABLED(CONFIG_COMMON_CLK))
 	ltq_port->freqclk = clk_get_fpi();
+#else
+	ltq_port->freqclk = devm_clk_get(&pdev->dev, "freq");
+#endif
+
 	if (IS_ERR(ltq_port->freqclk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
 	}
 
 	/* not all asc ports have clock gates, lets ignore the return code */
+#if (IS_ENABLED(CONFIG_LANTIQ) && !IS_ENABLED(CONFIG_COMMON_CLK))
 	ltq_port->clk = clk_get(&pdev->dev, NULL);
+#else
+	ltq_port->clk = devm_clk_get(&pdev->dev, "asc");
+#endif
 
 	ltq_port->tx_irq = irqres[0].start;
 	ltq_port->rx_irq = irqres[1].start;
-- 
2.11.0

