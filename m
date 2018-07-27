Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92341C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451382089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451382089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbeG0LJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbeG0LJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:00 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D67EBB6;
        Fri, 27 Jul 2018 09:47:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Albert Astals Cid <aacid@kde.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 25/66] r8169: restore previous behavior to accept BIOS WoL settings
Date:   Fri, 27 Jul 2018 11:45:18 +0200
Message-Id: <20180727093811.998796256@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 18041b523692038d41751fd8046638c356d77a36 ]

Commit 7edf6d314cd0 tried to resolve an inconsistency (BIOS WoL
settings are accepted, but device isn't wakeup-enabled) resulting
from a previous broken-BIOS workaround by making disabled WoL the
default.
This however had some side effects, most likely due to a broken BIOS
some systems don't properly resume from suspend when the MagicPacket
WoL bit isn't set in the chip, see
https://bugzilla.kernel.org/show_bug.cgi?id=200195
Therefore restore the WoL behavior from 4.16.

Reported-by: Albert Astals Cid <aacid@kde.org>
Fixes: 7edf6d314cd0 ("r8169: disable WOL per default")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -8272,8 +8272,7 @@ static int rtl_init_one(struct pci_dev *
 		return rc;
 	}
 
-	/* override BIOS settings, use userspace tools to enable WOL */
-	__rtl8169_set_wol(tp, 0);
+	tp->saved_wolopts = __rtl8169_get_wol(tp);
 
 	if (rtl_tbi_enabled(tp)) {
 		tp->set_speed = rtl8169_set_speed_tbi;


