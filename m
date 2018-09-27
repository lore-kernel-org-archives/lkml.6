Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A268221546
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A268221546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeI0Pu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:50:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeI0Pu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:50:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 805011133;
        Thu, 27 Sep 2018 09:33:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 14/28] net: hp100: fix always-true check for link up state
Date:   Thu, 27 Sep 2018 11:06:38 +0200
Message-Id: <20180927090638.286163623@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
References: <20180927090637.687829444@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit a7f38002fb69b44f8fc622ecb838665d0b8666af ]

The operation ~(p100_inb(VG_LAN_CFG_1) & HP100_LINK_UP) returns a value
that is always non-zero and hence the wait for the link to drop always
terminates prematurely.  Fix this by using a logical not operator instead
of a bitwise complement.  This issue has been in the driver since
pre-2.6.12-rc2.

Detected by CoverityScan, CID#114157 ("Logical vs. bitwise operator")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hp/hp100.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -2636,7 +2636,7 @@ static int hp100_login_to_vg_hub(struct
 		/* Wait for link to drop */
 		time = jiffies + (HZ / 10);
 		do {
-			if (~(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
+			if (!(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
 				break;
 			if (!in_interrupt())
 				schedule_timeout_interruptible(1);


