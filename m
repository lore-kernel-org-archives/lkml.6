Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55153C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3F520652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130891;
	bh=MHDIOxkUn4EiLwNSZyiCjaMu7EBxCblc2NqgR78EnT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWzxcJOLCo09nks7hJ+EjsPtvbjeodowdFGB5J4tgcd16sgCd41seU8OwNxeROQmV
	 oqCL9WuFtVl4V0LWLmWv+Al/xS9VF+szzF/o6hSsVxq8t3/Ppld97z/UlDdiqfU7T0
	 28OKvSsZTECHMy6L96w07BQhtPXOg4rMP2rINqKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfBYVla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732663AbfBYVdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115F021848;
        Mon, 25 Feb 2019 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130403;
        bh=MHDIOxkUn4EiLwNSZyiCjaMu7EBxCblc2NqgR78EnT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCL/8c0EP+V98WNBHoYf7nxGQFwfpUR7Qd9lqKZtLx09oa89xW4HHCwHZqy5X8RZg
         SxYJ1MNfR7uPo5RnmildHhv7/G9+vOXEBfyqNDqflayL8CFwMPxVH0VroilzJ8jTmK
         CH8n8XPCLKo9aqgdTxn/j/4tJ6REeOAHwye0ZT/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 111/183] leds: lp5523: fix a missing check of return value of lp55xx_read
Date:   Mon, 25 Feb 2019 22:11:24 +0100
Message-Id: <20190225195113.395124303@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a2e74feee2b2f..fd64df5a57a5e 100644
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



