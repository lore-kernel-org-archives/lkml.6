Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id umhiMQJYGVsVfgAAmS7hNA
	; Thu, 07 Jun 2018 16:08:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B2E2D6089E; Thu,  7 Jun 2018 16:08:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2671E6063F;
	Thu,  7 Jun 2018 16:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2671E6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935856AbeFGQFI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:05:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39249 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933014AbeFGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zr-Hw; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002pC-AW; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kalle Valo" <kvalo@codeaurora.org>,
        "Colin Ian King" <colin.king@canonical.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.629788027@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 099/410] wl1251: check return from call to
 wl1251_acx_arp_ip_filter
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit ac1181c60822292176ab96912208ec9f9819faf8 upstream.

Currently the less than zero error check on ret is incorrect
as it is checking a far earlier ret assignment rather than the
return from the call to wl1251_acx_arp_ip_filter. Fix this by
adding in the missing assginment.

Detected by CoverityScan, CID#1164835 ("Logically dead code")

Fixes: 204cc5c44fb6 ("wl1251: implement hardware ARP filtering")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/ti/wl1251/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1199,8 +1199,7 @@ static void wl1251_op_bss_info_changed(s
 		WARN_ON(wl->bss_type != BSS_TYPE_STA_BSS);
 
 		enable = bss_conf->arp_addr_cnt == 1 && bss_conf->assoc;
-		wl1251_acx_arp_ip_filter(wl, enable, addr);
-
+		ret = wl1251_acx_arp_ip_filter(wl, enable, addr);
 		if (ret < 0)
 			goto out_sleep;
 	}
