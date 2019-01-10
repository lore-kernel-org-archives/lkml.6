Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2128C20660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfAJOHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:07:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:43610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728181AbfAJOHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:07:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12EA6AC3E;
        Thu, 10 Jan 2019 14:07:20 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
References: <20181204135507.3706-1-anup@brainfault.org>
        <20181204135507.3706-2-anup@brainfault.org>
X-Yow:  This TOPS OFF my partygoing experience!  Someone I DON'T LIKE
 is talking to me about a HEART-WARMING European film..
Date:   Thu, 10 Jan 2019 15:07:18 +0100
In-Reply-To: <20181204135507.3706-2-anup@brainfault.org> (Anup Patel's message
        of "Tue, 4 Dec 2018 19:25:05 +0530")
Message-ID: <mvmbm4oehd5.fsf_-_@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 drivers/tty/serial/earlycon-riscv-sbi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index e1a551aae3..9c51b945b5 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -15,8 +15,11 @@ static void sbi_console_write(struct console *con,
 {
 	int i;
 
-	for (i = 0; i < n; ++i)
+	for (i = 0; i < n; ++i) {
+		if (s[i] == '\n')
+			sbi_console_putchar('\r');
 		sbi_console_putchar(s[i]);
+	}
 }
 
 static int __init early_sbi_setup(struct earlycon_device *device,
-- 
2.20.1

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
