Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2870E2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2870E2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeI0PkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:40:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeI0PkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:40:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1DDC51113;
        Thu, 27 Sep 2018 09:22:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 31/64] spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers
Date:   Thu, 27 Sep 2018 11:03:48 +0200
Message-Id: <20180927090254.569426729@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
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

From: Kirill Kapranov <kirill.kapranov@compulab.co.il>

commit 1a4327fbf4554d5b78d75b19a13d40d6de220159 upstream.

On systems where some controllers get a dynamic ID assigned and some have
a fixed number (e.g. from ACPI tables), the current implementation might
run into an IDR collision: in case of a fixed bus number is gotten by a
driver (but not marked busy in IDR tree) and a driver with dynamic bus
number gets the same ID and predictably fails.

Fix this by means of checking-in fixed IDsin IDR as far as dynamic ones
at the moment of the controller registration.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2135,6 +2135,15 @@ int spi_register_controller(struct spi_c
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
 		ctlr->bus_num = id;
+	} else {
+		/* devices with a fixed bus num must check-in with the num */
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


