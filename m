Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF308ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD11020880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD11020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbeGWNoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:44:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388242AbeGWNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:44:05 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2C3DBBCF;
        Mon, 23 Jul 2018 12:43:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sanjeev Bansal <sanjeevb.bansal@broadcom.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 014/107] tg3: Add higher cpu clock for 5762.
Date:   Mon, 23 Jul 2018 14:41:08 +0200
Message-Id: <20180723122413.524246405@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanjeev Bansal <sanjeevb.bansal@broadcom.com>

[ Upstream commit 3a498606bb04af603a46ebde8296040b2de350d1 ]

This patch has fix for TX timeout while running bi-directional
traffic with 100 Mbps using 5762.

Signed-off-by: Sanjeev Bansal <sanjeevb.bansal@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -9278,6 +9278,15 @@ static int tg3_chip_reset(struct tg3 *tp
 
 	tg3_restore_clk(tp);
 
+	/* Increase the core clock speed to fix tx timeout issue for 5762
+	 * with 100Mbps link speed.
+	 */
+	if (tg3_asic_rev(tp) == ASIC_REV_5762) {
+		val = tr32(TG3_CPMU_CLCK_ORIDE_ENABLE);
+		tw32(TG3_CPMU_CLCK_ORIDE_ENABLE, val |
+		     TG3_CPMU_MAC_ORIDE_ENABLE);
+	}
+
 	/* Reprobe ASF enable state.  */
 	tg3_flag_clear(tp, ENABLE_ASF);
 	tp->phy_flags &= ~(TG3_PHYFLG_1G_ON_VAUX_OK |


