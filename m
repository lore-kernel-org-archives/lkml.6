Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F87214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAJRLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:11:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:53646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728262AbfAJRLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:11:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7433AAFFD;
        Thu, 10 Jan 2019 17:11:45 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        "linux-kernel\@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH] tty/serial: use uart_console_write in the RISC-V SBL early
 console
References: <20181204135507.3706-1-anup@brainfault.org>
        <20181204135507.3706-2-anup@brainfault.org>
        <mvmbm4oehd5.fsf_-_@suse.de>
        <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
        <mvm7efcedop.fsf@suse.de>
        <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
X-Yow:  If I have enough money to buy 5,000 CANS of NOODLE-RONI, can I get a
 VAT of MARSHMALLOW FLUFF free??
Date:   Thu, 10 Jan 2019 18:11:39 +0100
In-Reply-To: <CAAhSdy0suSgKpdz+NUrXzS9Ozp75hMC6ovW4yLf5s0KYJwwocw@mail.gmail.com>
        (Anup Patel's message of "Thu, 10 Jan 2019 21:47:07 +0530")
Message-ID: <mvmsgy0cu9g.fsf_-_@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables proper NLCR processing.

Suggested-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 drivers/tty/serial/earlycon-riscv-sbi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index e1a551aae3..ce81523c31 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -10,13 +10,16 @@
 #include <linux/serial_core.h>
 #include <asm/sbi.h>
 
-static void sbi_console_write(struct console *con,
-			      const char *s, unsigned int n)
+static void sbi_putc(struct uart_port *port, int c)
 {
-	int i;
+	sbi_console_putchar(c);
+}
 
-	for (i = 0; i < n; ++i)
-		sbi_console_putchar(s[i]);
+static void sbi_console_write(struct console *con,
+			      const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+	uart_console_write(&dev->port, s, n, sbi_putc);
 }
 
 static int __init early_sbi_setup(struct earlycon_device *device,
-- 
2.20.1

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
