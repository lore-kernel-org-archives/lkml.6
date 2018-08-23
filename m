Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A952C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200112150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200112150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeHXBCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:02:04 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:53162 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeHXBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:02:04 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id SlWU1y00N3XaVaC06lWUon; Thu, 23 Aug 2018 23:30:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsxBU-0005j7-8G; Thu, 23 Aug 2018 23:30:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsxBU-0004us-5z; Thu, 23 Aug 2018 23:30:28 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Mohammed Khajapasha <mkhaja@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Drop useless check for dev.of_node
Date:   Thu, 23 Aug 2018 23:30:27 +0200
Message-Id: <20180823213027.18856-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2:

    drivers/tty/serial/qcom_geni_serial.c: In function ‘qcom_geni_serial_probe’:
    drivers/tty/serial/qcom_geni_serial.c:1261: warning: ‘drv’ may be used uninitialized in this function

Indeed, if dev.of_node is NULL, drv will be used uninitialized, and
dereferenced in uart_add_one_port().  However, as this driver supports
DT only, dev.of_node will always be valid.

Hence remove the useless check for dev.of_node, killing the warning as a
side effect.

Fixes: 8a8a66a1a18a1dbd ("tty: serial: qcom_geni_serial: Add support for flow control")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 29ec343872466e49..1cfbb6745a8cc7d0 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1263,14 +1263,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
 		console = true;
 
-	if (pdev->dev.of_node) {
-		if (console) {
-			drv = &qcom_geni_console_driver;
-			line = of_alias_get_id(pdev->dev.of_node, "serial");
-		} else {
-			drv = &qcom_geni_uart_driver;
-			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
-		}
+	if (console) {
+		drv = &qcom_geni_console_driver;
+		line = of_alias_get_id(pdev->dev.of_node, "serial");
+	} else {
+		drv = &qcom_geni_uart_driver;
+		line = of_alias_get_id(pdev->dev.of_node, "hsuart");
 	}
 
 	port = get_port_from_line(line, console);
-- 
2.17.1

