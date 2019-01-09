Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF8BC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9E52075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfAIXjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:39:10 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.109]:49643 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfAIXjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:39:10 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 79339400DAF7F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 17:39:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hNREgJgQQ2PzOhNREgy0c3; Wed, 09 Jan 2019 17:39:08 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=50446 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghNRD-002ypT-NB; Wed, 09 Jan 2019 17:39:07 -0600
Date:   Wed, 9 Jan 2019 17:39:06 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ipmi: msghandler: Fix potential Spectre v1 vulnerabilities
Message-ID: <20190109233906.GA4170@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghNRD-002ypT-NB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:50446
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

channel and addr->channel are indirectly controlled by user-space,
hence leading to a potential exploitation of the Spectre variant 1
vulnerability.

These issues were detected with the help of Smatch:

drivers/char/ipmi/ipmi_msghandler.c:1381 ipmi_set_my_address() warn: potential spectre issue 'user->intf->addrinfo' [w] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1401 ipmi_get_my_address() warn: potential spectre issue 'user->intf->addrinfo' [r] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1421 ipmi_set_my_LUN() warn: potential spectre issue 'user->intf->addrinfo' [w] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1441 ipmi_get_my_LUN() warn: potential spectre issue 'user->intf->addrinfo' [r] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:2260 check_addr() warn: potential spectre issue 'intf->addrinfo' [r] (local cap)

Fix this by sanitizing channel and addr->channel before using them to
index user->intf->addrinfo and intf->addrinfo, correspondingly.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 480d9bd7e1ab..557e98d9364d 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -32,6 +32,7 @@
 #include <linux/moduleparam.h>
 #include <linux/workqueue.h>
 #include <linux/uuid.h>
+#include <linux/nospec.h>
 
 #define IPMI_DRIVER_VERSION "39.2"
 
@@ -1375,10 +1376,12 @@ int ipmi_set_my_address(struct ipmi_user *user,
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		user->intf->addrinfo[channel].address = address;
+	}
 	release_ipmi_user(user, index);
 
 	return rv;
@@ -1395,10 +1398,12 @@ int ipmi_get_my_address(struct ipmi_user *user,
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		*address = user->intf->addrinfo[channel].address;
+	}
 	release_ipmi_user(user, index);
 
 	return rv;
@@ -1415,10 +1420,12 @@ int ipmi_set_my_LUN(struct ipmi_user *user,
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		user->intf->addrinfo[channel].lun = LUN & 0x3;
+	}
 	release_ipmi_user(user, index);
 
 	return rv;
@@ -1435,10 +1442,12 @@ int ipmi_get_my_LUN(struct ipmi_user *user,
 	if (!user)
 		return -ENODEV;
 
-	if (channel >= IPMI_MAX_CHANNELS)
+	if (channel >= IPMI_MAX_CHANNELS) {
 		rv = -EINVAL;
-	else
+	} else {
+		channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 		*address = user->intf->addrinfo[channel].lun;
+	}
 	release_ipmi_user(user, index);
 
 	return rv;
@@ -2257,6 +2266,7 @@ static int check_addr(struct ipmi_smi  *intf,
 {
 	if (addr->channel >= IPMI_MAX_CHANNELS)
 		return -EINVAL;
+	addr->channel = array_index_nospec(addr->channel, IPMI_MAX_CHANNELS);
 	*lun = intf->addrinfo[addr->channel].lun;
 	*saddr = intf->addrinfo[addr->channel].address;
 	return 0;
-- 
2.20.1

