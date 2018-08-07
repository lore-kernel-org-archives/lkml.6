Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06105C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D85021731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D85021731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390774AbeHGVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389195AbeHGVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:33 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C650C3EE;
        Tue,  7 Aug 2018 18:57:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 39/85] media: smiapp: fix timeout checking in smiapp_read_nvm
Date:   Tue,  7 Aug 2018 20:51:41 +0200
Message-Id: <20180807172358.789080421@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 7a2148dfda8001c983f0effd9afd8a7fa58e99c4 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/smiapp/smiapp-core.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -939,7 +939,7 @@ static int smiapp_read_nvm(struct smiapp
 		if (rval)
 			goto out;
 
-		for (i = 0; i < 1000; i++) {
+		for (i = 1000; i > 0; i--) {
 			rval = smiapp_read(
 				sensor,
 				SMIAPP_REG_U8_DATA_TRANSFER_IF_1_STATUS, &s);
@@ -950,11 +950,10 @@ static int smiapp_read_nvm(struct smiapp
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


