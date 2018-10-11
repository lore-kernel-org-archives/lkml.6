Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA65C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D286921476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB/gOMYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D286921476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbeJKXQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbeJKXQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2A72085B;
        Thu, 11 Oct 2018 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272925;
        bh=LEzw4FQ3ZScLP2FPHSA7VvMJQuyFG3Up9q/HQV6X0/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB/gOMYGVIEoB7Yk8mGmz1vSgzYB9BR4Txpf9cNlhUKQ3XMZiv5lJwSDpRAADJETg
         H7pvL05qW7TDLxb9AEBy1fFJagp4I5cmJ7vgg5kN/HvIbNyh8G6UB6xM6k/sLMOV76
         AbQ1+cw5B1d52Ant6MhwKwEEOMIHGc3BCSZSDgUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4.18 09/44] clocksource/drivers/timer-atmel-pit: Properly handle error cases
Date:   Thu, 11 Oct 2018 17:39:47 +0200
Message-Id: <20181011152452.921242512@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 52bf4a900d9cede3eb14982d0f2c5e6db6d97cc3 upstream.

The smatch utility reports a possible leak:

smatch warnings:
drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init() warn: possible memory leak of 'data'

Ensure data is freed before exiting with an error.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/timer-atmel-pit.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -180,26 +180,29 @@ static int __init at91sam926x_pit_dt_ini
 	data->base = of_iomap(node, 0);
 	if (!data->base) {
 		pr_err("Could not map PIT address\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto exit;
 	}
 
 	data->mck = of_clk_get(node, 0);
 	if (IS_ERR(data->mck)) {
 		pr_err("Unable to get mck clk\n");
-		return PTR_ERR(data->mck);
+		ret = PTR_ERR(data->mck);
+		goto exit;
 	}
 
 	ret = clk_prepare_enable(data->mck);
 	if (ret) {
 		pr_err("Unable to enable mck\n");
-		return ret;
+		goto exit;
 	}
 
 	/* Get the interrupts property */
 	data->irq = irq_of_parse_and_map(node, 0);
 	if (!data->irq) {
 		pr_err("Unable to get IRQ from DT\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 
 	/*
@@ -227,7 +230,7 @@ static int __init at91sam926x_pit_dt_ini
 	ret = clocksource_register_hz(&data->clksrc, pit_rate);
 	if (ret) {
 		pr_err("Failed to register clocksource\n");
-		return ret;
+		goto exit;
 	}
 
 	/* Set up irq handler */
@@ -236,7 +239,8 @@ static int __init at91sam926x_pit_dt_ini
 			  "at91_tick", data);
 	if (ret) {
 		pr_err("Unable to setup IRQ\n");
-		return ret;
+		clocksource_unregister(&data->clksrc);
+		goto exit;
 	}
 
 	/* Set up and register clockevents */
@@ -254,6 +258,10 @@ static int __init at91sam926x_pit_dt_ini
 	clockevents_register_device(&data->clkevt);
 
 	return 0;
+
+exit:
+	kfree(data);
+	return ret;
 }
 TIMER_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
 		       at91sam926x_pit_dt_init);


