Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB028C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52032206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52032206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeIDSlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:41:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35186 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeIDSlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:41:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxC7W-0004J9-35; Tue, 04 Sep 2018 14:15:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, patches@opensource.cirrus.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: arizona: make array mclk_name static, shrinks object size
Date:   Tue,  4 Sep 2018 15:15:53 +0100
Message-Id: <20180904141553.28000-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array mclk_name on the stack but instead make it
static. Makes the object code smaller by 23 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  38050	  11604	     64	  49718	   c236	linux/drivers/mfd/arizona-core.o

After:
   text	   data	    bss	    dec	    hex	filename
  38027	  11604	     64	  49695	   c21f	linux/drivers/mfd/arizona-core.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mfd/arizona-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 5f1e37d23943..918d81a00b37 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -990,7 +990,7 @@ static const struct mfd_cell wm8998_devs[] = {
 
 int arizona_dev_init(struct arizona *arizona)
 {
-	const char * const mclk_name[] = { "mclk1", "mclk2" };
+	static const char * const mclk_name[] = { "mclk1", "mclk2" };
 	struct device *dev = arizona->dev;
 	const char *type_name = NULL;
 	unsigned int reg, val;
-- 
2.17.1

