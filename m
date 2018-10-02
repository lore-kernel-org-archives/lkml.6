Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB810C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5842064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5842064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeJBURO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbeJBURN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:13 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4220D5AA;
        Tue,  2 Oct 2018 13:33:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 4.14 085/137] tty: serial: lpuart: avoid leaking struct tty_struct
Date:   Tue,  2 Oct 2018 06:24:46 -0700
Message-Id: <20181002132504.463816141@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit 3216c622a24b0ebb9c159a8d1daf7f17a106b3f5 upstream.

The function tty_port_tty_get() gets a reference to the tty. Since
the code is not using tty_port_tty_set(), the reference is kept
even after closing the tty.

Avoid using tty_port_tty_get() by directly access the tty instance.
Since lpuart_start_rx_dma() is called from the .startup() and
.set_termios() callback, it is safe to assume the tty instance is
valid.

Cc: stable@vger.kernel.org # v4.9+
Fixes: 5887ad43ee02 ("tty: serial: fsl_lpuart: Use cyclic DMA for Rx")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/fsl_lpuart.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -983,7 +983,8 @@ static inline int lpuart_start_rx_dma(st
 	struct circ_buf *ring = &sport->rx_ring;
 	int ret, nent;
 	int bits, baud;
-	struct tty_struct *tty = tty_port_tty_get(&sport->port.state->port);
+	struct tty_port *port = &sport->port.state->port;
+	struct tty_struct *tty = port->tty;
 	struct ktermios *termios = &tty->termios;
 
 	baud = tty_get_baud_rate(tty);


