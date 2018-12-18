Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FB5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FDD2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="CPuj/r/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeLRMS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:18:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40765 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeLRMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:18:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so1890368wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eSWAZ8hE+0QmxOSC1nocpx2/Vn+e5jpinCbecxT0A1U=;
        b=CPuj/r/i3UFd+YIrnxG0g630Kds/PAKQUZcebI8OCjummw+9fT9Cv8Q4tAn91hUzR+
         j1AsMVfOWONddLGNp6Ig3rGdBPrSSWShb86H15qWzlMyPWSfAW5pxwadN9/LdnLLGvAa
         LXU2XAqubaXg2La+Q1FMeCM8H4Q1MzdlpPQ+aKpk1Jv/8kgip+Ql8Sb4PjHvjGhzA48P
         Bux30y7bSPIxQJnf8jnLsQ2vst0DMSERSxV9n74WAb1+Binw1xBPJhy4rks+JufyOimA
         rceETvjlvJX7Extac0QySHselFY1jKEU5mR57JRcCQp2/PGFDYiTC0GVy4fJIqtBqZEV
         OOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=eSWAZ8hE+0QmxOSC1nocpx2/Vn+e5jpinCbecxT0A1U=;
        b=FKTWa5zVFistxrzD0Sl8ewjLVeqZ168V8WL1eVtmz6GFgWE4R1dnFbAAnftiEDMcLK
         t1MCwnORIxm/lSWHgp65qq0sG6ZVKD4uMJ4hvOM75qIZN1NB0HLYjwwRE8YjB3zKE+Ko
         nIfcguZdSQudHU2bHpz9y5DxMJN4eB5e64uA8ZLv5pDXVrZ9driEAhuhYZMLb3zkJSyn
         vKXKGBuvfE2/9/y3NdRm7Z0SaZWnTP13OtsF5bFJWIWb/ZKLJiXh7yxMVfri8c3NkmLD
         mld4DDgRLjCSvHiH67+cCfCuBMsM1HKpNIg96iWC5FemGSJw+4WOJuZ0kQL10vojhviY
         1q6Q==
X-Gm-Message-State: AA+aEWYvBniW2ieS1ld8Nzd3ytqBpWrOTSbbNs+u+CAqJlMR4AO6Q3R0
        Lml/3xpeMJy8O485m93Jo5j2flNlOE02Xg==
X-Google-Smtp-Source: AFSGD/VsDGPBBDng6W5LtjkbuBDOleG+qY9bwFQ71ITJ8/+DcG9OwXkaK+TcXJneJQBU8Ao+XuFlpg==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr3014484wmc.25.1545135532031;
        Tue, 18 Dec 2018 04:18:52 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e19sm4269935wrc.25.2018.12.18.04.18.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 04:18:51 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] serial: uartps: Fix error path when alloc failed
Date:   Tue, 18 Dec 2018 13:18:41 +0100
Message-Id: <2c90972b04a6f87100f6bcc4f6fa4630de025874.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cdns_uart_console allocation failed there is a need to also clear
ID from ID list.

Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9cdc36be5b13..c6d38617d622 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1508,8 +1508,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
 					 GFP_KERNEL);
-	if (!cdns_uart_console)
-		return -ENOMEM;
+	if (!cdns_uart_console) {
+		rc = -ENOMEM;
+		goto err_out_id;
+	}
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-- 
1.9.1

