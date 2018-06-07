Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8O5VEAIzGVtBRwAAmS7hNA
	; Thu, 07 Jun 2018 13:37:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC6EC608BA; Thu,  7 Jun 2018 13:37:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 69174606DD;
	Thu,  7 Jun 2018 13:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69174606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932788AbeFGNhl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:37:41 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:37770 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932744AbeFGNhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:37:38 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id vpdc1x00e3XaVaC06pdcDo; Thu, 07 Jun 2018 15:37:37 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQv6e-0000CV-3L; Thu, 07 Jun 2018 15:37:36 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQugS-0007NT-1Q; Thu, 07 Jun 2018 15:10:32 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] net: mscc: ocelot: Fix uninitialized error in ocelot_netdevice_event()
Date: Thu,  7 Jun 2018 15:10:30 +0200
Message-Id: <1528377030-28319-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.1.2:

    drivers/net/ethernet/mscc/ocelot.c: In function ‘ocelot_netdevice_event’:
    drivers/net/ethernet/mscc/ocelot.c:1129: warning: ‘ret’ may be used uninitialized in this function

If the list iterated over by netdev_for_each_lower_dev() is empty, ret
is never initialized, and converted into a notifier return value.

Fix this by preinitializing ret to zero.

Fixes: a556c76adc052c97 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This may be unlikely to happen, but given the notifier is called for any
(also non-ocelot) network device, better be safe than sorry.
---
 drivers/net/ethernet/mscc/ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c8c74aa548d96e00..fb2c8f8071e64d3b 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1126,7 +1126,7 @@ static int ocelot_netdevice_event(struct notifier_block *unused,
 {
 	struct netdev_notifier_changeupper_info *info = ptr;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	int ret;
+	int ret = 0;
 
 	if (netif_is_lag_master(dev)) {
 		struct net_device *slave;
-- 
2.7.4
