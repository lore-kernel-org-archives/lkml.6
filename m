Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D9C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED121216F3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED121216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeHCE6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:58:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:19289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbeHCE6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:58:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="251328318"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2018 20:04:21 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 13/18] serial: intel: Replace clk_enable/clk_disable with clk generic API
Date:   Fri,  3 Aug 2018 11:02:32 +0800
Message-Id: <20180803030237.3366-14-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk driver has introduced new clock APIs that replace
the existing clk_enable and clk_disable.
 -clk_enable() APIs is replaced with clk_prepare_enable().
 -clk_disable() API is replaced with clk_disable_unprepare().

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 drivers/tty/serial/lantiq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 28086d52e980..36479d66fb7c 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -309,7 +309,7 @@ lqasc_startup(struct uart_port *port)
 	int retval;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
+		clk_prepare_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
 	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
@@ -377,7 +377,7 @@ lqasc_shutdown(struct uart_port *port)
 	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
 	if (!IS_ERR(ltq_port->clk))
-		clk_disable(ltq_port->clk);
+		clk_disable_unprepare(ltq_port->clk);
 }
 
 static void
@@ -631,7 +631,7 @@ lqasc_console_setup(struct console *co, char *options)
 	port = &ltq_port->port;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
+		clk_prepare_enable(ltq_port->clk);
 
 	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
-- 
2.11.0

