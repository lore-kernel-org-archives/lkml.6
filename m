Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA779C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF28218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151224;
	bh=JAz3KF9eotQYq14cZdWM9jc3/3OIqvKcqhwxtAL3HHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bSglPKOgDi7191xhZQfBjiEakTBX0wGZ4W52+tHzX6gmz7KiYq9cQhtcioySgynB
	 X99SiRdlbF21Jc1mIDQhnzs2Z+21UJe8Qa3pkafAcWfzBvBlwfLe/o6hPWBmfgXoZK
	 RfR6d4gwQ1+/AKw5XXA0MNa7P4cj1bNweJM48fyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeLRQkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeLRQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E053218A4;
        Tue, 18 Dec 2018 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151218;
        bh=JAz3KF9eotQYq14cZdWM9jc3/3OIqvKcqhwxtAL3HHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF3cPhkTULHRscYxi9Js4khZ33AQrqu6h+Y918bdzh/4npAs6txBQdHIM1bSDNiLq
         CkU0nZfor9Tmz7ksOg8x+w8w/+oJassBGKJkYGjrALOJ0XIy23vi70jf4qoD03VeWk
         uOO++8dNspEfOjCuCKbGNUM7I5Hw8FXFl0c7YAmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/44] i2c: aspeed: fix build warning
Date:   Tue, 18 Dec 2018 17:39:17 +0100
Message-Id: <20181218163927.733959335@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

Upstream commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
properly") reworked the interrupt handling and fixed a warning in the process:

drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_bus_irq':
drivers/i2c/busses/i2c-aspeed.c:567:1: error: label 'out' defined but not used [-Werror=unused-label]

The warning is still present in v4.19.8 and can be fixed either by applying
that original patch, or by adding a simple #ifdef.

Here, I choose the second simpler option as the original patch seems too
invasive for a stable backport.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a4f956c6d567..a19fbff16861 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -555,7 +555,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	spin_lock(&bus->lock);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	if (aspeed_i2c_slave_irq(bus)) {
+	if (IS_ENABLED(CONFIG_I2C_SLAVE) && aspeed_i2c_slave_irq(bus)) {
 		dev_dbg(bus->dev, "irq handled by slave.\n");
 		ret = true;
 		goto out;
@@ -564,7 +564,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	ret = aspeed_i2c_master_irq(bus);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 out:
+#endif
 	spin_unlock(&bus->lock);
 	return ret ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
2.19.1



