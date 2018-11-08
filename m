Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D471AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE4D208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg4/UkPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE4D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbeKIHk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeKIHk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:58 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9765B2081C;
        Thu,  8 Nov 2018 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714608;
        bh=KF1+SMMpaPgtXyqm8gCUM7YzS+VrUMvFDzDc3ijra4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vg4/UkPkVQAHurECDpYfCU9UHO0Z7iLZBVGrWW57NUstOnbi7vZ3ohFTffHMFyJwl
         YzAHL4mwv0tn73UwXVeQy3NLKffPPZ2/jB9836tlr4AqmEz521aJp8gtJbPUA48vS4
         428W6EkbGyhdkVrzCYElZvsr3RKJdvNSygbAqslo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 041/171] i2c: bcm2835: Avoid possible NULL ptr dereference
Date:   Thu,  8 Nov 2018 13:50:11 -0800
Message-Id: <20181108215130.468707918@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ababb08938df7ac245d30a58b95b94ecf8dc04fc ]

Since commit e2474541032d ("bcm2835: Fix hang for writing messages
larger than 16 bytes") the interrupt handler is prone to a possible
NULL pointer dereference. This could happen if an interrupt fires
before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
on the RPi 3. Even this is an unexpected behavior the driver must
handle that with an error instead of a crash.

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than 16 bytes")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index f283b714aa79..7ed09865cb4b 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -128,7 +128,9 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 	}
 
 	if (val & BCM2835_I2C_S_DONE) {
-		if (i2c_dev->curr_msg->flags & I2C_M_RD) {
+		if (!i2c_dev->curr_msg) {
+			dev_err(i2c_dev->dev, "Got unexpected interrupt (from firmware?)\n");
+		} else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
 			bcm2835_drain_rxfifo(i2c_dev);
 			val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
 		}
-- 
2.17.1



