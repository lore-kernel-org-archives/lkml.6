Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5469AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8EB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8EB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeGYLbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:31:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:16905 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbeGYLbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:31:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 03:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,401,1526367600"; 
   d="scan'208";a="59325489"
Received: from hu.sh.intel.com ([10.239.160.33])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2018 03:20:28 -0700
From:   Chen Hu <hu1.chen@intel.com>
Cc:     Chen Hu <hu1.chen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: stop passing NULL in uart_resume_port
Date:   Wed, 25 Jul 2018 18:04:50 +0800
Message-Id: <20180725100450.22300-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.13.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found the baud rate is changed after S3 on some Intel Broxton
platforms. The baud rate should be restored during resume. However, some
set_termios() callback such as dw8250_set_termios() for DesignWare 8250
will skip setting if old termios is NULL. We address this issue via
passing a dummy.

Signed-off-by: Chen Hu <hu1.chen@intel.com>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f02965936f2e..8b815f1539e8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2217,6 +2217,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	struct device *tty_dev;
 	struct uart_match match = {uport, drv};
 	struct ktermios termios;
+	static struct ktermios dummy;
 
 	mutex_lock(&port->mutex);
 
@@ -2277,7 +2278,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			pm_runtime_put_autosuspend(uport->dev);
 			if (ret == 0) {
 				if (tty)
-					uart_change_speed(tty, state, NULL);
+					uart_change_speed(tty, state, &dummy);
 				pm_runtime_get_sync(uport->dev);
 				spin_lock_irq(&uport->lock);
 				ops->set_mctrl(uport, uport->mctrl);
-- 
2.13.0

