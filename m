Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3147DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61C22082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="TPVMMP2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61C22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeLENVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:21:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35663 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLENVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:21:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so12835264wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=w60EavONrQQDo0N1GYLfef4PCoyBWjUWB42v/HtDc48=;
        b=TPVMMP2jup59fvlKK+MD6keIBC57Z0XacB4D98bkAAd2wWIMxekQnO2rOIT7NQiwP4
         jzAqqc7X565Wrnl0IKsl1JFHS7t+1puE6V3ubC2M3Zb1clBAx4ZNKwGErHgY1mU7jHg8
         w9rC1bgCPRPHDIRqtnnLeDIy+LxKQFbsB6LxzSEK5Wu/62Ue4cJDlBGbF2C/nrLr8k76
         tiSGaFzHaEZwJzNjQuE8TBezPiFLFQFfC9tqXfzcQn6b7tlT/o3uN0+kuI09zg/rcusL
         cy8JKv2UvhVETYpfQQoEgzUfeJd7C24HQ3tGOL3H4GCbn4lP20cC3EImuZGZG8GJCcYW
         CTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=w60EavONrQQDo0N1GYLfef4PCoyBWjUWB42v/HtDc48=;
        b=bdB0skV2pKz5bd8A/83xmz8EUiMkbxP2HnaP5VFowz08ma7bN8QvXpfE0tPp61FAmq
         blC2IwkxRIRLRtd4lANIsvSghaOoMp1fKQabiiSpBGSlX6g177FNLVLkGX6yMM6q7Y6V
         Kq3EsewE2CdJYhqkVHG47rIpXCHLSRvZOAfkcCLFbuSv+EBfCBL61PRyCWx9FbsHxnME
         J5Y4ZiswZ6VgD+3fAjrf9ieehrivPlHHhU7eu5D2VOzKNX65HZ9VUDICEuoO/xPFG6D1
         k083AQ2Y1h5/rncbHZxcvTzXirDdwbNyGFc/1MfEnoYEEF6Q/UmP9D/TNkxCGDX/s1CZ
         bxDw==
X-Gm-Message-State: AA+aEWbbZ+KcTEAlos2jLJyiZGZU8eRvrQx6EUZ2b6D3gL+czTppc023
        KlQUzAdXNLA1cKZ6MJLBTxx2wyqbILLqiQ==
X-Google-Smtp-Source: AFSGD/VqY7wakmLzIJz4rMPviH9oXPoeLZXXfp5xhvN7bMC7Au2ZTpuEAT3sV5LL2Hy7wtZrO6U8Hg==
X-Received: by 2002:a1c:2981:: with SMTP id p123mr15793071wmp.19.1544016063107;
        Wed, 05 Dec 2018 05:21:03 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v132sm1563514wme.20.2018.12.05.05.21.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 05:21:02 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: uartps: Fix error path when alloc failed
Date:   Wed,  5 Dec 2018 14:21:01 +0100
Message-Id: <97107b23d9b3cca32c4fba3b474fe55ea4d338f4.1544016059.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cdns_uart_console allocation failed there is a need to also clear
ID from ID list.

Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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

