Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2834BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D342175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=compulab.co.il header.i=@compulab.co.il header.b="itbMgepe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D342175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compulab.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeHMUOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:14:43 -0400
Received: from softlayer.compulab.co.il ([50.23.254.55]:51342 "EHLO
        compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbeHMUOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:14:43 -0400
X-Greylist: delayed 2606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Aug 2018 16:14:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=compulab.co.il; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=39UePiHbFAVZbtidvD6EHE0giUzBprqe5hJufJEqkqs=; b=itbMgepeYQT4ont2ghwofGkgO5
        RJhAmJ62LFu/ILAPINhgCG6Gksn9sSCQAuQPwXRBczn4XVcy63Ni8qvDQGa7gJ6MAUdfErWx/FAr6
        cj3jSeVJ3fHAJYr1sZp2A738e/hUjuijoiYC2IsYWi+Bth5e1fUAzBoOClVJb8b8JQTvqS701QjXY
        lwSWMddB1XL/vX9RpWeYhHptYqyjS8ObyZpIT716taXp1zzoeHP583a7peG3SFuUbRmXX050Ycnop
        Wgf+daSEZLSNQu95VItnDblYpvLhH0mjXt7gwJFds7aWdmFXTL2WUPJIfcFVKGIcXt/7rRrYlWJZH
        3QdOvxDg==;
Received: from [37.142.126.90] (port=39234 helo=zimbra-mta.compulab.co.il)
        by softlayer.compulab.co.il with esmtp (Exim 4.87)
        (envelope-from <kirill.kapranov@compulab.co.il>)
        id 1fpG0t-000299-Kc; Mon, 13 Aug 2018 19:48:15 +0300
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id ADC7448280F;
        Mon, 13 Aug 2018 19:48:14 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IksGcmip7Bhd; Mon, 13 Aug 2018 19:48:14 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 39E4D48280E;
        Mon, 13 Aug 2018 19:48:14 +0300 (IDT)
X-Virus-Scanned: amavisd-new at zimbra-mta.compulab.co.il
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6H0mJxOblER5; Mon, 13 Aug 2018 19:48:14 +0300 (IDT)
Received: from kkk.compulab.local (lifshitz-linux.compulab.local [192.168.11.10])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 097FD482805;
        Mon, 13 Aug 2018 19:48:14 +0300 (IDT)
From:   Kirill Kapranov <kirill.kapranov@compulab.co.il>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, l.stach@pengutronix.de
Cc:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Subject: [PATCH] spi:fix IDR collision on systems with both fixed and dynamic SPI bus numbers
Date:   Mon, 13 Aug 2018 19:48:10 +0300
Message-Id: <20180813164810.16769-1-kirill.kapranov@compulab.co.il>
X-Mailer: git-send-email 2.11.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - softlayer.compulab.co.il
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - compulab.co.il
X-Get-Message-Sender-Via: softlayer.compulab.co.il: acl_c_recent_authed_mail_ips_text_entry: kirill.kapranov@compulab.co.il|compulab.co.il
X-Authenticated-Sender: softlayer.compulab.co.il: kirill.kapranov@compulab.co.il
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems where some controllers get a dynamic ID assigned and some have
a fixed number (e.g. from ACPI tables), the current implementation might
run into an IDR collision: in case of a fixed bus number is gotten by a
driver (but not marked busy in IDR tree) and a driver with dynamic bus
number gets the same ID and predictably fails.

Fix this by means of checking-in fixed IDsin IDR as far as dynamic ones
at the moment of the controller registration.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)

Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec395a6baf9c..97e303185d5b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2170,6 +2170,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
 		ctlr->bus_num = id;
+	} else {
+	/* devices with a fixed bus num must check-in with the num */
+		mutex_lock(&board_lock);
+		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
+			ctlr->bus_num + 1, GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr"))
+			return id == -ENOSPC ? -EBUSY : id;
+		ctlr->bus_num = id;
 	}
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
-- 
2.11.0

