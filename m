Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A912098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A912098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIXQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:30:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:13994 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeIXQaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:30:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="73244527"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 24 Sep 2018 03:28:47 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 07/14] serial: lantiq: Rename fpiclk to freqclk
Date:   Mon, 24 Sep 2018 18:27:56 +0800
Message-Id: <20180924102803.30263-8-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fpiclk is platform specific, freqclk is more generic.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index e351f80996d3..4acdbdf8fe7a 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -105,7 +105,7 @@ static DEFINE_SPINLOCK(ltq_asc_lock);
 struct ltq_uart_port {
 	struct uart_port	port;
 	/* clock used to derive divider */
-	struct clk		*fpiclk;
+	struct clk		*freqclk;
 	/* clock gating of the ASC core */
 	struct clk		*clk;
 	unsigned int		tx_irq;
@@ -309,7 +309,7 @@ lqasc_startup(struct uart_port *port)
 
 	if (!IS_ERR(ltq_port->clk))
 		clk_enable(ltq_port->clk);
-	port->uartclk = clk_get_rate(ltq_port->fpiclk);
+	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
 	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
@@ -632,7 +632,7 @@ lqasc_console_setup(struct console *co, char *options)
 	if (!IS_ERR(ltq_port->clk))
 		clk_enable(ltq_port->clk);
 
-	port->uartclk = clk_get_rate(ltq_port->fpiclk);
+	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -744,8 +744,8 @@ lqasc_probe(struct platform_device *pdev)
 	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
-	ltq_port->fpiclk = clk_get_fpi();
-	if (IS_ERR(ltq_port->fpiclk)) {
+	ltq_port->freqclk = clk_get_fpi();
+	if (IS_ERR(ltq_port->freqclk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
 	}
-- 
2.11.0

