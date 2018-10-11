Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5995FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1759C204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1759C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeJKXDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:03:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51095 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:03:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gAczi-0001A7-V6; Thu, 11 Oct 2018 15:35:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: visorbus: fix memory leak on parser_ctx
Date:   Thu, 11 Oct 2018 16:35:22 +0100
Message-Id: <20181011153522.26237-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the call to visorchannel_signalinsert fails the error
return path does not free parser_ctx.  Fix this by kfree'ing it on
the error return path.

Detected by CoverityScan, CID#1451916 ("Resource leak")

Fixes: a35e3268da51 ("staging: unisys: visorchipset: remove local_addr in handle_command")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/visorbus/visorchipset.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/visorbus/visorchipset.c b/drivers/visorbus/visorchipset.c
index ca752b8f495f..09d1536edfb1 100644
--- a/drivers/visorbus/visorchipset.c
+++ b/drivers/visorbus/visorchipset.c
@@ -1383,8 +1383,10 @@ static int handle_command(struct controlvm_message inmsg, u64 channel_addr)
 	controlvm_init_response(&ackmsg, &inmsg.hdr, CONTROLVM_RESP_SUCCESS);
 	err = visorchannel_signalinsert(chipset_dev->controlvm_channel,
 					CONTROLVM_QUEUE_ACK, &ackmsg);
-	if (err)
+	if (err) {
+		kfree(parser_ctx);
 		return err;
+	}
 	switch (inmsg.hdr.id) {
 	case CONTROLVM_CHIPSET_INIT:
 		err = chipset_init(&inmsg);
-- 
2.17.1

