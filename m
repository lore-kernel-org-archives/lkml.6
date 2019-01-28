Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE969C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACA42148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="MfHrq6bA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA1LaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:30:16 -0500
Received: from mout02.posteo.de ([185.67.36.66]:52501 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfA1LaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:30:16 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6D5B62400FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548675013; bh=tgu93XVYDIYuC8NSSqhHjri5VbEMB4SrBgESQDOFZG0=;
        h=From:To:Cc:Subject:Date:From;
        b=MfHrq6bAaywUBGN0QcJm3Tugohv0sQchIbBdaiq1H5KRe3B5EMPNVfpMv1A8qYy1a
         cWnvFUja6zQSM3ZCkDTuNvozEAT64g4/lDLzlZHVFC/Ng1b5s4STdoGZzKvkUK0OKQ
         QZpNLB4DKTAYloKr9B/k8mOdpCull+XfSOdD0NyBWBz5ut+PtQAMjBHsvLmoxxYpfq
         EJAVb6dDRab4UJIqtWkcfu1CFNAkUQJlmU1LXA4+13pwX0kQGNEcWDOpzpj0eBziAP
         ZWKVx4iaRRnEpZ+pVXuhnAxkHUtl2rsy14rH3rlADpt9reykG9wBzU3Q78o0T9QFsr
         1R7DAesVdx2xA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43p6qk4qN7z9rxT;
        Mon, 28 Jan 2019 12:30:10 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH] ipconfig: make the wait for carrier timeout configurable
Date:   Mon, 28 Jan 2019 12:30:05 +0100
Message-Id: <20190128113005.7683-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

commit 3fb72f1e6e61 ("ipconfig wait for carrier") added a
"wait for carrier" policy, with a fixed worst case maximum wait
of two minutes.

This makes the wait for carrier timeout configurable (0 - 240 seconds).

The informative timeout messages introduced with
commit 5e404cd65860 ("ipconfig: add informative timeout messages while
waiting for carrier") were adapted. Message output is done in a fixed
interval of 20 seconds, just like before (240/12).

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

This is really just something we always set shorter on embedded devices
and don't understand why it isn't configurable :)

thanks

                              martin



 net/ipv4/Kconfig    | 11 +++++++++++
 net/ipv4/ipconfig.c |  7 ++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 32cae39cdff6..299c5dbbea97 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -113,6 +113,17 @@ config IP_PNP
 	  on NFS" as well), because all other machines configure the network
 	  in their startup scripts.
 
+config IP_PNP_CARRIER_TIMEOUT
+	int "Wait for carrier timeout (in seconds)"
+	default 120
+	range 0 240
+	depends on IP_PNP
+	help
+	  This defines the timeout waiting for carrier in seconds before
+	  continuing kernel startup.
+
+	  Use the default if unsure.
+
 config IP_PNP_DHCP
 	bool "IP: DHCP support"
 	depends on IP_PNP
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index b9a9873c25c6..e8041c0c2b97 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -85,7 +85,8 @@
 
 /* Define the friendly delay before and after opening net devices */
 #define CONF_POST_OPEN		10	/* After opening: 10 msecs */
-#define CONF_CARRIER_TIMEOUT	120000	/* Wait for carrier timeout */
+/* Wait for carrier timeout */
+#define CONF_CARRIER_TIMEOUT	(CONFIG_IP_PNP_CARRIER_TIMEOUT*1000)
 
 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
@@ -268,7 +269,7 @@ static int __init ic_open_devs(void)
 
 	/* wait for a carrier on at least one device */
 	start = jiffies;
-	next_msg = start + msecs_to_jiffies(CONF_CARRIER_TIMEOUT/12);
+	next_msg = start + msecs_to_jiffies(20000);
 	while (time_before(jiffies, start +
 			   msecs_to_jiffies(CONF_CARRIER_TIMEOUT))) {
 		int wait, elapsed;
@@ -285,7 +286,7 @@ static int __init ic_open_devs(void)
 		elapsed = jiffies_to_msecs(jiffies - start);
 		wait = (CONF_CARRIER_TIMEOUT - elapsed + 500)/1000;
 		pr_info("Waiting up to %d more seconds for network.\n", wait);
-		next_msg = jiffies + msecs_to_jiffies(CONF_CARRIER_TIMEOUT/12);
+		next_msg = jiffies + msecs_to_jiffies(20000);
 	}
 have_carrier:
 	rtnl_unlock();
-- 
2.20.1

