Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC5A208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC5A208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbeG0Ltt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:49:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbeG0Lts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:49:48 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB646CD1;
        Fri, 27 Jul 2018 10:28:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>,
        Michal Simek <michal.simek@xilinx.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3.18 25/27] can: xilinx_can: fix RX overflow interrupt not being enabled
Date:   Fri, 27 Jul 2018 12:27:02 +0200
Message-Id: <20180727102649.966719982@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
References: <20180727102649.049641021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anssi Hannula <anssi.hannula@bitwise.fi>

commit 83997997252f5d3fc7f04abc24a89600c2b504ab upstream.

RX overflow interrupt (RXOFLW) is disabled even though xcan_interrupt()
processes it. This means that an RX overflow interrupt will only be
processed when another interrupt gets asserted (e.g. for RX/TX).

Fix that by enabling the RXOFLW interrupt.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/xilinx_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -102,7 +102,7 @@ enum xcan_reg {
 #define XCAN_INTR_ALL		(XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |\
 				 XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK | \
 				 XCAN_IXR_RXNEMP_MASK | XCAN_IXR_ERROR_MASK | \
-				 XCAN_IXR_ARBLST_MASK)
+				 XCAN_IXR_RXOFLW_MASK | XCAN_IXR_ARBLST_MASK)
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BTR_SJW_SHIFT		7  /* Synchronous jump width */


