Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9725BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDAD2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDAD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeIFPyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:54:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIFPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:54:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxsJu-0003k9-Ja; Thu, 06 Sep 2018 11:19:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] agp: check for index out of range before accessing maxes_table[index]
Date:   Thu,  6 Sep 2018 12:19:30 +0100
Message-Id: <20180906111930.18743-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently maxes_table[index] is accessed before index is checked to
be out of range.  Fix this by performing the out of range check on
index first.  Also don't check against a hard-coded maximum value
but use the array size instead.

Detected by static analysis with cppcheck:
"Array index 'index' is used before limits check"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/agp/backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
index 38ffb281df97..4e07f01833a2 100644
--- a/drivers/char/agp/backend.c
+++ b/drivers/char/agp/backend.c
@@ -121,7 +121,8 @@ static int agp_find_max(void)
 #endif
 	index = 1;
 
-	while ((memory > maxes_table[index].mem) && (index < 8))
+	while ((index < ARRAY_SIZE(maxes_table) - 1) &&
+	       (memory > maxes_table[index].mem))
 		index++;
 
 	result = maxes_table[index - 1].agp +
-- 
2.17.1

