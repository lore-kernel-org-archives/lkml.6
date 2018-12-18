Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4415CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DCF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="EqZdGbpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeLRMTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:19:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33813 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeLRMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:18:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so15712351wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sr4wuOWXsEDaIHmkdgp5/mtEUfBN4wQ+UuMd8Oge7B4=;
        b=EqZdGbpNUKx1T/vwDwk3desDmKTHP2e28GVlgVSY4w3rfP2d5HecQH+DYwRsvXSaa4
         gR3blQRULTvGOsOh6gKGHfmTg10TZ2iJpOTYymZuNyU3Q47iWOPKubvcx9voiVtyOyTe
         8fyRpPsXBLXgVSFN0TKLiDPcqVegcxdYuYGv6tpxv/FiZzf2KGFEvWZ2cSsP1p/8xnOU
         BIDRdKUHtHP0ZCBFo6lQD2QUtMItAHlTSUmdEj1IyduV543TfP9st1nvXRTzA5ZIvSuq
         qrH88bYKpzBKS1dtK06lfFpALG2rdomM96qTIROEwSgVw9NxVW+QxbKC7UupZW/hW4iK
         31Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=sr4wuOWXsEDaIHmkdgp5/mtEUfBN4wQ+UuMd8Oge7B4=;
        b=iQxCc4pyMsS6sDwk0reMwJVwpJ4UuJC+efwMZZEHMXhdNQmy5UoDNi2mivCB3b/l36
         JSAaPTuDLD2q1tBnxfY0FdjL5re1skxc+tJ2hy5AHe/2jioqzMsiHaiHFoxqp7Fw39rY
         mgrm5O145wWaod0x6Y6ddmcYLG3fgrFPH8aoPjTv0+Cqr3vNom2OCYUmyjIlx9KNPKzR
         xxTUyI0qTtk1SSf5Bs/bTSNk9EtAkwOxDqLjGgN02viNcgwCeOV8vZXjCt5ZK/IcXyl4
         1bB9ZC5QuU7DAMPFPPZcXRqURfhcQzB/GQEsnCCNE5io9XWGDgbLpgPf9fhWmiQlMqJ3
         tc8Q==
X-Gm-Message-State: AA+aEWbG7lxPKy+G/zlIF2Hy24D0O0kpPBLBzAUgvyCA8LwW1/b8vZ1f
        eoTLoruLmRRiJzUL9fYiLueVsuh/boIuwg==
X-Google-Smtp-Source: AFSGD/UCRtnbBFtHMIKnjndA6yC3das3xoHh1I4qGT2mMOH0yKDXmZ05nsOBOlnUZEpEiyBRSTBQXA==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr15450222wrq.175.1545135530534;
        Tue, 18 Dec 2018 04:18:50 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id m6sm2594800wrv.24.2018.12.18.04.18.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 04:18:49 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] serial: uartps: Check if the device is a console
Date:   Tue, 18 Dec 2018 13:18:40 +0100
Message-Id: <863488c6f6d7f3d8c53d46f442f25ec2f46ee651.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

While checking for console_suspend_enabled also check if the
device is a console.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0140644391df..9cdc36be5b13 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1255,7 +1255,7 @@ static int cdns_uart_suspend(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && may_wake) {
+	if (console_suspend_enabled && uart_console(port) && may_wake) {
 		unsigned long flags = 0;
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1293,7 +1293,7 @@ static int cdns_uart_resume(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && !may_wake) {
+	if (console_suspend_enabled && uart_console(port) && !may_wake) {
 		clk_enable(cdns_uart->pclk);
 		clk_enable(cdns_uart->uartclk);
 
-- 
1.9.1

