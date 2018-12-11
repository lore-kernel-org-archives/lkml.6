Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E31FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D96205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544025;
	bh=5vX2kCUStB/XC/6qH1v0ERWFlQUGIRjCnNhVK3AHfsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHuj8UUu0SWEJ+BuPpNtaa+U1ksv0rQ95UAYgf1AVpKA1te+LSswqrFfgVz88z7mo
	 83NEQWQ4A+64VDFGM+3b8Hvw69PV934g3YnAjAn5QT/GoSGyt2J000UKUilyM05Dn/
	 pH331Y4SF5ifh1p9WRDbKiCY6EtwzdAXR8m9WNhA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D96205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbeLKQAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbeLKP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31E32086D;
        Tue, 11 Dec 2018 15:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543902;
        bh=5vX2kCUStB/XC/6qH1v0ERWFlQUGIRjCnNhVK3AHfsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceUrJDugnXe9wsheX3sZPuekO4cTpczRNwLG7eINTG5TPpad/EnHP1U24Mlo9Xtgj
         kwjuoSz56m9Vrq38TS9RGttSwwobHt7DVFEYU2ysMvlL6zN+8WXNClBKmnRcF1UVDw
         iKLLH1rCLG+zUBM+D0y2pbiCs2a2wTn19r3jSf9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Chanho Park <parkch98@gmail.com>
Subject: [PATCH 4.19 107/118] tty: do not set TTY_IO_ERROR flag if console port
Date:   Tue, 11 Dec 2018 16:42:06 +0100
Message-Id: <20181211151648.587748329@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chanho Park <parkch98@gmail.com>

commit 2a48602615e0a2f563549c7d5c8d507f904cf96e upstream.

Since Commit 761ed4a94582 ('tty: serial_core: convert uart_close to use
tty_port_close') and Commit 4dda864d7307 ('tty: serial_core: Fix serial
console crash on port shutdown), a serial port which is used as
console can be stuck when logging out if there is a remained process.
After logged out, agetty will try to grab the serial port but it will
be failed because the previous process did not release the port
correctly. To fix this, TTY_IO_ERROR bit should not be enabled of
tty_port_close if the port is console port.

Reproduce step:
- Run background processes from serial console
$ while true; do sleep 10; done &

- Log out
$ logout
-> Stuck

- Read journal log by journalctl | tail
Jan 28 16:07:01 ubuntu systemd[1]: Stopped Serial Getty on ttyAMA0.
Jan 28 16:07:01 ubuntu systemd[1]: Started Serial Getty on ttyAMA0.
Jan 28 16:07:02 ubuntu agetty[1643]: /dev/ttyAMA0: not a tty

Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Chanho Park <parkch98@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_port.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -640,7 +640,8 @@ void tty_port_close(struct tty_port *por
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 	tty_port_shutdown(port, tty);
-	set_bit(TTY_IO_ERROR, &tty->flags);
+	if (!port->console)
+		set_bit(TTY_IO_ERROR, &tty->flags);
 	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
 }


