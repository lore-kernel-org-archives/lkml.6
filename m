Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2543C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6072177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6072177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbeHDLJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:09:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeHDLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:09:18 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D099389C;
        Sat,  4 Aug 2018 09:09:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 058/124] media: smiapp: fix timeout checking in smiapp_read_nvm
Date:   Sat,  4 Aug 2018 11:00:47 +0200
Message-Id: <20180804082704.679780201@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -981,7 +981,7 @@ static int smiapp_read_nvm(struct smiapp
 		if (rval)
 			goto out;
 
-		for (i = 0; i < 1000; i++) {
+		for (i = 1000; i > 0; i--) {
 			rval = smiapp_read(
 				sensor,
 				SMIAPP_REG_U8_DATA_TRANSFER_IF_1_STATUS, &s);
@@ -992,11 +992,10 @@ static int smiapp_read_nvm(struct smiapp
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


