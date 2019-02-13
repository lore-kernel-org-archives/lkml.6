Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB02C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04CB2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025817;
	bh=y5Z2815UM2p9msbzg/R6sKHukUXIRyh0LicAQnh6Xck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdVxM4ZbwdjW9jTD6hU0IVk1OaGJxMJelIkOqC05w0zAxPPs4GtDIdE/zsEOq7okJ
	 iDqBp6VKZEVDJ2rO/mLVnCJ5OKqPVj8tmpqex5MWQQiKLwaabuR9XbN0KKiOj9FQea
	 TnJwKu3uWmGhdB2ISW+KS2vEdIuFmJ/hSGYyx5ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbfBMCnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389317AbfBMClg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5162175B;
        Wed, 13 Feb 2019 02:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025696;
        bh=y5Z2815UM2p9msbzg/R6sKHukUXIRyh0LicAQnh6Xck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpapn22gL/1jAqFV4dGYHSR4xmRh0GvPQnCmIiPaSk9lsVMmGYK/U5jnYwy4NNo7U
         twbctaZgwlKNkbbBhA9Ad94/+MKIG39Io4+gRcX7T15iWxXXu5YQg2XW92fAuPjZcu
         cqY8n23fMoU+J9AtIEAzI+T/zetxdPfOq6rDfQTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 15/16] leds: lp5523: fix a missing check of return value of lp55xx_read
Date:   Tue, 12 Feb 2019 21:41:11 -0500
Message-Id: <20190213024112.22038-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024112.22038-1-sashal@kernel.org>
References: <20190213024112.22038-1-sashal@kernel.org>
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
index 1d0187f42941..d12370352ae3 100644
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

