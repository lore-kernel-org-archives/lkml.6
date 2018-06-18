Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F71C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BEE20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BEE20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030515AbeFRIiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:38:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968071AbeFRIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:36:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C187CBB;
        Mon, 18 Jun 2018 08:36:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 133/189] can: dev: increase bus-off message severity
Date:   Mon, 18 Jun 2018 10:13:49 +0200
Message-Id: <20180618081214.568513882@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

[ Upstream commit 71c23a821c6bcacba71a094efe49ee689605906b ]

bus-off is usually caused by hardware malfunction or configuration error
(baud rate mismatch) and causes a complete loss of communication.

Increase the "bus-off" message's severity from netdev_dbg() to
netdev_info() to make it visible to the user.

A can interface going into bus-off is similar in severity to ethernet's
"Link is Down" message, which is also printed at info level.

It is debatable whether the the "restarted" message should also be
changed to netdev_info() to make the interface state changes
comprehensible from the kernel log. I have chosen to keep the
"restarted" message at dbg for now as the "bus-off" message should be
enough for the user to notice and investigate the problem.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -604,7 +604,7 @@ void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	netdev_dbg(dev, "bus-off\n");
+	netdev_info(dev, "bus-off\n");
 
 	netif_carrier_off(dev);
 


