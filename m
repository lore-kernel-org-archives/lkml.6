Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OjNsIPtIGVuPTAAAmS7hNA
	; Thu, 07 Jun 2018 15:04:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ABDD6608BA; Thu,  7 Jun 2018 15:04:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18C6D601C3;
	Thu,  7 Jun 2018 15:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18C6D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936028AbeFGPEE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:04:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41554 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936013AbeFGPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:04:00 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbk-0005hL-4B; Thu, 07 Jun 2018 15:09:44 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002xb-OW; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jason Dillaman" <dillaman@redhat.com>,
        "Ilya Dryomov" <idryomov@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.391853158@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 177/410] rbd: whitelist RBD_FEATURE_OPERATIONS
 feature bit
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

From: Ilya Dryomov <idryomov@gmail.com>

commit e573427a440fd67d3f522357d7ac901d59281948 upstream.

This feature bit restricts older clients from performing certain
maintenance operations against an image (e.g. clone, snap create).
krbd does not perform maintenance operations.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -117,8 +117,11 @@ static int atomic_dec_return_safe(atomic
 
 #define RBD_FEATURE_LAYERING	(1<<0)
 #define RBD_FEATURE_STRIPINGV2	(1<<1)
-#define RBD_FEATURES_ALL \
-	    (RBD_FEATURE_LAYERING | RBD_FEATURE_STRIPINGV2)
+#define RBD_FEATURE_OPERATIONS		(1<<8)
+
+#define RBD_FEATURES_ALL	(RBD_FEATURE_LAYERING |		\
+				 RBD_FEATURE_STRIPINGV2 |	\
+				 RBD_FEATURE_OPERATIONS)
 
 /* Features supported by this (client software) implementation. */
 
