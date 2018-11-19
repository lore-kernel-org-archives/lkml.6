Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ED1208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zJQ0Thvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ED1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbeKTC41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbeKTC41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E2642086A;
        Mon, 19 Nov 2018 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645140;
        bh=XT0m9EPqQ7fL2Fgk9ulOB82kJflQuxCKS/w6cwajjEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJQ0ThvgJk94dSLXNMqgheNjjBBh+ejl8uuAEe7u0izn0WG21YUSw2HJ9GnifigVw
         gi8VO0QcuoeLo7l6Wixst0YSwzD7y3ZcDH5QEpDVtWyxZJXj5B4077XDDFJ26J/JCO
         NMowE6Z2PMw4OkgkBk4OagpNsqSPU6S0VT9fBXpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 4.19 050/205] serial: sh-sci: Fix could not remove dev_attr_rx_fifo_timeout
Date:   Mon, 19 Nov 2018 17:25:57 +0100
Message-Id: <20181119162626.245533965@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3102,6 +3102,7 @@ static struct uart_driver sci_uart_drive
 static int sci_remove(struct platform_device *dev)
 {
 	struct sci_port *port = platform_get_drvdata(dev);
+	unsigned int type = port->port.type;	/* uart_remove_... clears it */
 
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
@@ -3112,8 +3113,7 @@ static int sci_remove(struct platform_de
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_trigger.attr);
 	}
-	if (port->port.type == PORT_SCIFA || port->port.type == PORT_SCIFB ||
-	    port->port.type == PORT_HSCIF) {
+	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF) {
 		sysfs_remove_file(&dev->dev.kobj,
 				  &dev_attr_rx_fifo_timeout.attr);
 	}


