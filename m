Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F951C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90E921774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90E921774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeHUJm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:42:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:42:26 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD0C38A5;
        Tue, 21 Aug 2018 06:23:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>
Subject: [PATCH 4.18 20/35] tty: serial: 8250: Revert NXP SC16C2552 workaround
Date:   Tue, 21 Aug 2018 08:20:46 +0200
Message-Id: <20180821055020.877760304@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark <dmarkh@cfl.rr.com>

commit 47ac76662ca9c5852fd353093f19de3ae85f2e66 upstream.

Revert commit ecb988a3b7985913d1f0112f66667cdd15e40711: tty: serial:
8250: 8250_core: NXP SC16C2552 workaround

The above commit causes userland application to no longer write
correctly its first write to a dumb terminal connected to /dev/ttyS0.
This commit seems to be the culprit. It's as though the TX FIFO is being
reset during that write. What should be displayed is:

PSW 80000000 INST 00000000                           HALT
//

What is displayed is some variation of:

T 00000000           HAL//

Reverting this commit via this patch fixes my problem.

Signed-off-by: Mark Hounschell <dmarkh@cfl.rr.com>
Fixes: ecb988a3b798 ("tty: serial: 8250: 8250_core: NXP SC16C2552 workaround")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_port.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -90,8 +90,7 @@ static const struct serial8250_config ua
 		.name		= "16550A",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
-		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
-				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},


