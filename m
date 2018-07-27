Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFEBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9992089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9992089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbeG0LL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:11:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:11:26 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1152AF8;
        Fri, 27 Jul 2018 09:50:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Fietze <roman.fietze@telemotive.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.17 66/66] can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit before checking can.ctrlmode
Date:   Fri, 27 Jul 2018 11:45:59 +0200
Message-Id: <20180727093816.450558232@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Fietze <roman.fietze@telemotive.de>

commit 393753b217f05474e714aea36c37501546ed1202 upstream.

Inside m_can_chip_config(), when setting up the new value of the CCCR,
the CCCR_NISO bit is not cleared like the others, CCCR_TEST, CCCR_MON,
CCCR_BRSE and CCCR_FDOE, before checking the can.ctrlmode bits for
CAN_CTRLMODE_FD_NON_ISO.

This way once the controller was configured for CAN_CTRLMODE_FD_NON_ISO,
this mode could never be cleared again.

This fix is only relevant for controllers with version 3.1.x or 3.2.x.
Older versions do not support NISO.

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/m_can/m_can.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1111,7 +1111,8 @@ static void m_can_chip_config(struct net
 
 	} else {
 	/* Version 3.1.x or 3.2.x */
-		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE);
+		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE |
+			  CCCR_NISO);
 
 		/* Only 3.2.x has NISO Bit implemented */
 		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)


