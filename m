Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33459ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2F6206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2F6206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeGQJ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:29:48 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:40094 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbeGQJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:29:48 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id BkyC1y0073XaVaC01kyCCu; Tue, 17 Jul 2018 10:58:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1ffLoC-0008UX-0A; Tue, 17 Jul 2018 10:58:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ffLoB-00067o-UI; Tue, 17 Jul 2018 10:58:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chris Brandt <chris.brandt@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Fix use-after-free on subsequent port startup
Date:   Tue, 17 Jul 2018 10:58:10 +0200
Message-Id: <20180717085810.23502-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sci_request_irq() checks port->irqstr[j] for a NULL pointer, to decide
if a fallback interrupt name string should be allocated or not.

While this string is freed during port shutdown, the pointer is not
zeroed.  Hence on a subsequent startup of the port, it will still be
pointing to the freed memory, leading to e.g.

    WARNING: CPU: 0 PID: 404 at fs/proc/generic.c:388 __proc_create+0xbc/0x260
    name len 0

or to a crash (the latter is more likely with CONFIG_DEBUG_SLAB=y, due
to the poisoning of freed memory).

Instead of zeroeing the pointer at multiple places, preinitialize
port->irqstr[j] to zero to fix this.

Fixes: 8b0bbd956228ae87 ("serial: sh-sci: Add support for R7S9210")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5808edfe3f7be404..f8e53ac5c17dfb94 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1872,6 +1872,7 @@ static int sci_request_irq(struct sci_port *port)
 		}
 
 		desc = sci_irq_desc + i;
+		port->irqstr[j] = NULL;
 		if (SCIx_TEIDRI_IRQ_EXISTS(port)) {
 			/*
 			 * ERI and BRI are muxed, just register ERI and
-- 
2.17.1

