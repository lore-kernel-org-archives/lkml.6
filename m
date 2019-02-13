Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0BAC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51601222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025397;
	bh=ltQIdRxkoKxmZXJUB5JgI7taR9YjS1zR0ySJSUCT8gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GNR248WVp+LvVEzYxxlP1vq8d7lhwMnTPV5njoZJsDESEWZsaGZ3l0trUBIBnAA0K
	 e2Gcj0DpaISQbs1QnA+In6p/sD0D7+NfsncqrLlHCS+MGeXQCIngMPol+vs2pW5M1Y
	 C9cJG/5j5CsNhjomurrbmWsYBw2lYMikZr4GN1xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbfBMCgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732626AbfBMCg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988BD222CC;
        Wed, 13 Feb 2019 02:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025385;
        bh=ltQIdRxkoKxmZXJUB5JgI7taR9YjS1zR0ySJSUCT8gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdCv8N2kvu0PvhuLWOKJ7Oy3RyAVF4olbbjb/4E6AdT8HqqH4j4ZhQRfNJjfrbWDq
         bPDFyW+rGsY8Icgm4b+0YXbVuf5LuzIKkGMeHFknUHXKlDE2P2lRLhCV8UjiLzidqw
         WRHywlEGW3bf3+gEy0HbDmqMtSOuLrF5ZYZwfkYg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 094/105] leds: lp5523: fix a missing check of return value of lp55xx_read
Date:   Tue, 12 Feb 2019 21:33:25 -0500
Message-Id: <20190213023336.19019-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 248b57015f35c94d4eae2fdd8c6febf5cd703900 ]

When lp55xx_read() fails, "status" is an uninitialized variable and thus
may contain random value; using it leads to undefined behaviors.

The fix inserts a check for the return value of lp55xx_read: if it
fails, returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp5523.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index a2e74feee2b2..fd64df5a57a5 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -318,7 +318,9 @@ static int lp5523_init_program_engine(struct lp55xx_chip *chip)
 
 	/* Let the programs run for couple of ms and check the engine status */
 	usleep_range(3000, 6000);
-	lp55xx_read(chip, LP5523_REG_STATUS, &status);
+	ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
+	if (ret)
+		return ret;
 	status &= LP5523_ENG_STATUS_MASK;
 
 	if (status != LP5523_ENG_STATUS_MASK) {
-- 
2.19.1

