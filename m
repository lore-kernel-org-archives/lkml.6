Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139BBC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D981120835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D981120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeJNXO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:14:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbeJNXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:04 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cZ-E9; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000Vs-BG; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.622542791@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 260/366] net: atm: Fix potential Spectre v1
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

commit acf784bd0ce257fe43da7ca266f7a10b837479d2 upstream.

ioc_data.dev_num can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:
net/atm/lec.c:702 lec_vcc_attach() warn: potential spectre issue
'dev_lec'

Fix this by sanitizing ioc_data.dev_num before using it to index
dev_lec. Also, notice that there is another instance in which array
dev_lec is being indexed using ioc_data.dev_num at line 705:
lec_vcc_added(netdev_priv(dev_lec[ioc_data.dev_num]),

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/atm/lec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -41,6 +41,9 @@ static unsigned char bridge_ula_lec[] =
 #include <linux/module.h>
 #include <linux/init.h>
 
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #include "lec.h"
 #include "lec_arpc.h"
 #include "resources.h"
@@ -695,8 +698,10 @@ static int lec_vcc_attach(struct atm_vcc
 	bytes_left = copy_from_user(&ioc_data, arg, sizeof(struct atmlec_ioc));
 	if (bytes_left != 0)
 		pr_info("copy from user failed for %d bytes\n", bytes_left);
-	if (ioc_data.dev_num < 0 || ioc_data.dev_num >= MAX_LEC_ITF ||
-	    !dev_lec[ioc_data.dev_num])
+	if (ioc_data.dev_num < 0 || ioc_data.dev_num >= MAX_LEC_ITF)
+		return -EINVAL;
+	ioc_data.dev_num = array_index_nospec(ioc_data.dev_num, MAX_LEC_ITF);
+	if (!dev_lec[ioc_data.dev_num])
 		return -EINVAL;
 	vpriv = kmalloc(sizeof(struct lec_vcc_priv), GFP_KERNEL);
 	if (!vpriv)

