Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5C0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32472145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2GDrYPuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32472145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbeKTDGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732956AbeKTDGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:06:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4268B2145D;
        Mon, 19 Nov 2018 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645723;
        bh=ozgUWiLdVaqSc1MA0QGP5bGZV0M9bGn6RZ92j0JCnFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2GDrYPuHlZ+wLJIamWhm4012AcbpL156+E0Mb3tSMRfF0HyH7dyoU/UBZIvmq2FQE
         JH0oR2zForqtjBy1nlgQDAHrCVAe75holrVpkCsc/wGuzIquVemp6pP/y+2jJ9TEBK
         CKApXBpTxt8vpL249VWOfXkh9bqfyBk1ANzrsE08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 4.18 038/171] serial: sh-sci: Fix could not remove dev_attr_rx_fifo_timeout
Date:   Mon, 19 Nov 2018 17:27:14 +0100
Message-Id: <20181119162625.987417029@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 641a41dbba217ee5bd26abe6be77f8cead9cd00e upstream.

This patch fixes an issue that the sci_remove() could not remove
dev_attr_rx_fifo_timeout because uart_remove_one_port() set
the port->port.type to PORT_UNKNOWN.

Reported-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Fixes: 5d23188a473d ("serial: sh-sci: make RX FIFO parameters tunable via sysfs")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3045,6 +3045,7 @@ static struct uart_driver sci_uart_drive
 static int sci_remove(struct platform_device *dev)
 {
 	struct sci_port *port = platform_get_drvdata(dev);
+	unsigned int type = port->port.type;	/* uart_remove_... clears it */
 
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
@@ -3055,8 +3056,7 @@ static int sci_remove(struct platform_de
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_trigger.attr);
 	}
-	if (port->port.type == PORT_SCIFA || port->port.type == PORT_SCIFB ||
-	    port->port.type == PORT_HSCIF) {
+	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF) {
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_timeout.attr);
 	}


