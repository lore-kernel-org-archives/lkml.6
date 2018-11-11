Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9376C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D3C214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D3C214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbeKLGBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:01:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52580 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730702AbeKLGBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:01:50 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtA-0000oP-7P; Sun, 11 Nov 2018 19:59:20 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001Qm-9P; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Colin Ian King" <colin.king@canonical.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.33574780@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 059/366] media: smiapp: fix timeout checking in
 smiapp_read_nvm
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 7a2148dfda8001c983f0effd9afd8a7fa58e99c4 upstream.

The current code decrements the timeout counter i and the end of
each loop i is incremented, so the check for timeout will always
be false and hence the timeout mechanism is just a dead code path.
Potentially, if the RD_READY bit is not set, we could end up in
an infinite loop.

Fix this so the timeout starts from 1000 and decrements to zero,
if at the end of the loop i is zero we have a timeout condition.

Detected by CoverityScan, CID#1324008 ("Logically dead code")

Fixes: ccfc97bdb5ae ("[media] smiapp: Add driver")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -899,7 +899,7 @@ static int smiapp_read_nvm(struct smiapp
 		if (rval)
 			goto out;
 
-		for (i = 0; i < 1000; i++) {
+		for (i = 1000; i > 0; i--) {
 			rval = smiapp_read(
 				sensor,
 				SMIAPP_REG_U8_DATA_TRANSFER_IF_1_STATUS, &s);
@@ -910,11 +910,10 @@ static int smiapp_read_nvm(struct smiapp
 			if (s & SMIAPP_DATA_TRANSFER_IF_1_STATUS_RD_READY)
 				break;
 
-			if (--i == 0) {
-				rval = -ETIMEDOUT;
-				goto out;
-			}
-
+		}
+		if (!i) {
+			rval = -ETIMEDOUT;
+			goto out;
 		}
 
 		for (i = 0; i < SMIAPP_NVM_PAGE_SIZE; i++) {

