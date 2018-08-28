Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27751C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F6020843
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ISe9GizE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F6020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeH1Ofn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:35:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35812 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeH1Ofn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:35:43 -0400
Received: from localhost.localdomain (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 90BF45C1D1B;
        Tue, 28 Aug 2018 12:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1535453076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=OqkpdlblSB+D0XN7J/WgwCP87GbJNXuNYB7NpVoflhw=;
        b=ISe9GizEUurXL+jqenhPCC8mVdQVXISyS4hJOimcta8V/R0k2tVmyfDgQp5avbBNfARmP5
        uqAY1uvcmofvByfLJ9Uu6+oov/oydyVuCwE9kt7vgoRZIjYlJRFfpf6D3+UfaqbqMlbp7I
        AV1f2D7Eg7mEL62glVaOkfAKjjyRJKk=
From:   Stefan Agner <stefan@agner.ch>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, peter@hurleysoftware.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>, stable@vger.kernel.org
Subject: [PATCH] tty: serial: lpuart: avoid leaking struct tty_struct
Date:   Tue, 28 Aug 2018 12:44:24 +0200
Message-Id: <20180828104424.19860-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
This fixes a memory leak observable when opening/closing the tty in a
loop. This is also reported by kmemleak:

unreferenced object 0xc9d17000 (size 1024):
  comm "(agetty)", pid 389, jiffies 4294943045 (age 100.670s)
  hex dump (first 32 bytes):
    01 54 00 00 01 00 00 00 00 8c 9b c8 80 58 9b c8  .T...........X..
    48 58 c4 c0 00 00 00 00 00 00 00 00 00 00 00 00  HX..............
  backtrace:
    [<(ptrval)>] kmem_cache_alloc_trace+0x160/0x2b8
    [<(ptrval)>] alloc_tty_struct+0x44/0x254
    [<(ptrval)>] tty_init_dev+0x44/0x1c8
    [<(ptrval)>] tty_open+0x268/0x414
    [<(ptrval)>] chrdev_open+0xb4/0x1bc
    [<(ptrval)>] do_dentry_open+0x1c0/0x388
    [<(ptrval)>] vfs_open+0x34/0x38
    [<(ptrval)>] path_openat+0x5b0/0x11bc
    [<(ptrval)>] do_filp_open+0x7c/0xe8
    [<(ptrval)>] do_sys_open+0x188/0x20c
    [<(ptrval)>] sys_openat+0x14/0x18
    [<(ptrval)>] ret_fast_syscall+0x0/0x28
    [<(ptrval)>] 0xbee0a460
    [<(ptrval)>] 0xffffffff

I *think* the statement that accessing tty_struct without using
tty_port_tty_get is safe in this case is true. It would be good if
somebody with more TTY knowledge could review the change.

--
Stefan

 drivers/tty/serial/fsl_lpuart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 51e47a63d61a..3f8d1274fc85 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -979,7 +979,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	struct circ_buf *ring = &sport->rx_ring;
 	int ret, nent;
 	int bits, baud;
-	struct tty_struct *tty = tty_port_tty_get(&sport->port.state->port);
+	struct tty_port *port = &sport->port.state->port;
+	struct tty_struct *tty = port->tty;
 	struct ktermios *termios = &tty->termios;
 
 	baud = tty_get_baud_rate(tty);
-- 
2.18.0

