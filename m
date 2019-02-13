Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15529C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9AE222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025573;
	bh=ltQIdRxkoKxmZXJUB5JgI7taR9YjS1zR0ySJSUCT8gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vb+hnnSdjF7Yh9yUCcndfc2Vg/HJ3v2pN4FxHyypd6sU2Um6nDyjyBLj0TPnftpkM
	 +OEVQBE5lQGk2vK+W8KIqZ21I0NLifEOpFkb2Om4n8O3no7GHpnnBjKeAjfZMI0Uf9
	 k96hchUuATzxRS/St3g8EodPydoLXaNMmbNx9/0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbfBMCjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388741AbfBMCja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDED8222CD;
        Wed, 13 Feb 2019 02:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025569;
        bh=ltQIdRxkoKxmZXJUB5JgI7taR9YjS1zR0ySJSUCT8gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+i0FMFz9SszqrXkc/v+ZS3UvSBvdoRbIgcEC8ffHqS5R28ZBXAPMn9QLZTX1UCh9
         tcSsfk0Y5U6LErm9x1O49wFHSwWl1r8uInsiolMVOz3eK1s66pUgxR/TKtAfQub4on
         ku3xHhA7XKblrhluGRC0J8GPl9zRt1+1kgQyfIVU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 75/83] leds: lp5523: fix a missing check of return value of lp55xx_read
Date:   Tue, 12 Feb 2019 21:36:53 -0500
Message-Id: <20190213023701.20286-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
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

