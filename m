Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869B7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64024012
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D64024012
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeGEKFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:05:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57971 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGEKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:05:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fb18m-0008Gr-TL; Thu, 05 Jul 2018 10:05:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fjes: use currently unused variable my_epid and max_epid
Date:   Thu,  5 Jul 2018 11:05:32 +0100
Message-Id: <20180705100532.22277-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables my_epid and max_epid are currently assigned and not being
used - however, I suspect they were intended to be used in the for-loops
to reduce the dereferencing of hw.  Replace hw->my_epid and hw->max_epid
with these variables.

Cleans up clang warnings:
warning: variable 'my_epid' set but not used [-Wunused-but-set-variable]
variable 'max_epid' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/fjes/fjes_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 750954be5a74..d3eae1239045 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1395,8 +1395,8 @@ static void fjes_watch_unshare_task(struct work_struct *work)
 
 	while ((unshare_watch_bitmask || hw->txrx_stop_req_bit) &&
 	       (wait_time < 3000)) {
-		for (epidx = 0; epidx < hw->max_epid; epidx++) {
-			if (epidx == hw->my_epid)
+		for (epidx = 0; epidx < max_epid; epidx++) {
+			if (epidx == my_epid)
 				continue;
 
 			is_shared = fjes_hw_epid_is_shared(hw->hw_info.share,
@@ -1453,8 +1453,8 @@ static void fjes_watch_unshare_task(struct work_struct *work)
 	}
 
 	if (hw->hw_info.buffer_unshare_reserve_bit) {
-		for (epidx = 0; epidx < hw->max_epid; epidx++) {
-			if (epidx == hw->my_epid)
+		for (epidx = 0; epidx < max_epid; epidx++) {
+			if (epidx == my_epid)
 				continue;
 
 			if (test_bit(epidx,
-- 
2.17.1

