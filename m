Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7656EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E8C218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaVku2eO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfAaSG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:06:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45922 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfAaSGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:06:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so3305268edb.12;
        Thu, 31 Jan 2019 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Spvj1aXjtPpiHKV6tIt1Dff7PW1cp6KBnnoKkHYDIwo=;
        b=kaVku2eOA5PY99iDda5fa6jQcUgVZVErdLGHjsUrhm7dfj/uD2PlvQNh2qgZwD1qsX
         xLoM2IxZp0UpHDFs8hRSVYRdc2ZLnXKa28ZVTaSCQZgOum+HWmRarE2v8p2oWDklOnC0
         x8bnXg0XO09BBcPn8HuBYBnuWES7mqgZGKNZ3zQ7rVYuiE+JU7R2neSYa1U+yjvITQok
         6Ql9VfWrox6aRlKfonQHzuGWRrjxZfep1sVl7dN/0bVfRHMQbadQpSinPMeZDSjm4ECj
         0v/KVV8V95U4608BsUgi577OSncF8Vn4mpPvBsaXbhwL9BeDCxbwOHM3e+Pe+2sG9mxE
         pdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Spvj1aXjtPpiHKV6tIt1Dff7PW1cp6KBnnoKkHYDIwo=;
        b=hn5vfq8Pr/2TnzA2LUc0ZJvqIrbL9e5oSlCnE0JG4v/kkJloldl6dHJjNs1bVG7LpH
         Eu9EgJIi8EOeBXeQEFt4pWJGG0TUcZutXlD707inBKD0iwCjx7ySfK03iLvNccfHMrDM
         WEhLQ3QCkUFGQgUdXsd6/deE0JFyTo35GTr3k+hSOTO2rxvBHWrXlqi4xDyITzubWYE/
         65kM4VxPTVGAQOgr8hjmwknLHaAgNB1wFyLcGFz/WpPw/Rs7/7JRZvASRLouJAXcKIL4
         1FMeSSGrxJtxbhUk9rB5zbL9jkt5Zz7omEq5y3YPjUd5PxwkfH+EGilAiiusXNn4xeAz
         RAlQ==
X-Gm-Message-State: AJcUukcSXju4zKcs3Dey0JPTedIkv85kHg9LYH0MAx4wEgod3+fo27MA
        D6YMkWQ9I4tZ4FpxOo+1Jog=
X-Google-Smtp-Source: ALg8bN6I044GGdctYhw7YLNI+sj6rT1xzCGad80eNZdVzssn4k/JWMMAsThg0pC4VzDabf3nextjgQ==
X-Received: by 2002:aa7:c248:: with SMTP id y8mr34675650edo.205.1548958013470;
        Thu, 31 Jan 2019 10:06:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id e51sm1476890edd.35.2019.01.31.10.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:06:52 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] serial: mps2-uart: Add parentheses around conditional in mps2_uart_shutdown
Date:   Thu, 31 Jan 2019 11:06:28 -0700
Message-Id: <20190131180627.19944-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/tty/serial/mps2-uart.c:351:6: warning: logical not is only
applied to the left hand side of this bitwise operator
[-Wlogical-not-parentheses]
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^                ~
drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses after the
'!' to evaluate the bitwise operator first
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^
             (                                       )
drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses around left
hand side expression to silence this warning
        if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
            ^
            (               )
1 warning generated.

As it was intended for this check to be the inverse of the one at the
bottom of mps2_init_port, add parentheses around the whole conditional.

Fixes: 775ea4ea2fd9 ("serial: mps2-uart: support combined irq")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/tty/serial/mps2-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 4404eb7d118f..587b42f754cb 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -348,7 +348,7 @@ static void mps2_uart_shutdown(struct uart_port *port)
 
 	mps2_uart_write8(port, control, UARTn_CTRL);
 
-	if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
+	if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
 		free_irq(mps_port->rx_irq, mps_port);
 		free_irq(mps_port->tx_irq, mps_port);
 	}
-- 
2.20.1

