Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F065EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E60224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E60224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeKMTfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:35:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41647 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKMTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:35:32 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gMV9C-0005Oh-J4; Tue, 13 Nov 2018 09:38:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Korsgaard <jacmet@sunsite.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][serial-next] serial-uartlite: fix null pointer dereference on pointer port
Date:   Tue, 13 Nov 2018 09:38:14 +0000
Message-Id: <20181113093814.27598-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer port is dereferenced on port->private_data when assigning pointer
pdata before port is null checked, leading to a potential null pointer
dereference.  Fix this by assigning pdata after the null pointer check on
port.

Detected by CoverityScan, CID#1475434 ("Dereference before null check")

Fixes: 3b209d253e7f ("serial-uartlite: Do not use static struct uart_driver out of probe()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/uartlite.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 4a7989df5ff5..0eff33cd9f24 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -715,10 +715,12 @@ static int ulite_release(struct device *dev)
 static int __maybe_unused ulite_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
-	struct uartlite_data *pdata = port->private_data;
 
-	if (port)
+	if (port) {
+		struct uartlite_data *pdata = port->private_data;
+
 		uart_suspend_port(pdata->ulite_uart_driver, port);
+	}
 
 	return 0;
 }
-- 
2.19.1

