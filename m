Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC0C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42F21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8Qaafz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF42F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeJIBzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbeJIBzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:55:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 314222087D;
        Mon,  8 Oct 2018 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024115;
        bh=YL/cQBf4WJA6l6lJiAKDXPfsJgVRatIxVRL4ZJc234Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8Qaafz87h+bzHtiSm8oIaY+d3z8h/bY8eqANhoMnyfW0KuhWanxabCfn0ipNTlQw
         ohEdHTq6hVNDicpQPHQuZwLBz82vQrLWN7RyeqVyT6LHipO6UqFx77K3dIUMPTG0nH
         lsPIqXFtwE6QUfSjEzkX1rGk/EG1XlSMKxamE++M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4.14 03/94] serial: mvebu-uart: Fix reporting of effective CSIZE to userspace
Date:   Mon,  8 Oct 2018 20:30:44 +0200
Message-Id: <20181008175605.221329159@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

commit e0bf2d4982fe7d9ddaf550dd023803ea286f47fc upstream.

Apparently, this driver (or the hardware) does not support character
length settings. It's apparently running in 8-bit mode, but it makes
userspace believe it's in 5-bit mode. That makes tcsetattr with CS8
incorrectly fail, breaking e.g. getty from busybox, thus the login shell
on ttyMVx.

Fix by hard-wiring CS8 into c_cflag.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700 serial port")
Cc: stable <stable@vger.kernel.org> # 4.6+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/mvebu-uart.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -327,8 +327,10 @@ static void mvebu_uart_set_termios(struc
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= STAT_RX_RDY | STAT_BRK_ERR;
 
-	if (old)
+	if (old) {
 		tty_termios_copy_hw(termios, old);
+		termios->c_cflag |= CS8;
+	}
 
 	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
 	uart_update_timeout(port, termios->c_cflag, baud);


