Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEF8C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575A82175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025984;
	bh=/iVqUW9Xp+ST9ehK6hZACe4p1b3FWX7kApoMbQsSvTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oln9fcv0q0fGZUqtXd7NdK4uVby6GRRv0uZuAGsEkL8enpJVMyvcThecSCWcHJokC
	 cPMXQhEZ8oZ1+h9IaOL2kJJOoDTG0Go3gEja3XQUAYsE6N8B47C2J3rhQhXyyi/qbi
	 ADus3EnlA5daWWV+nnMbKkITdW3oHi21jZmwWqKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbfBMCqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389084AbfBMCkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD3E222C2;
        Wed, 13 Feb 2019 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025646;
        bh=/iVqUW9Xp+ST9ehK6hZACe4p1b3FWX7kApoMbQsSvTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvbQCNF316x3q+aQXaVwlZp4kqi4D7fMUt4JatUb+rQ4/9bJFB/palbH9loGKBGq1
         55oR2hBV48xFeTjfEIZz7vMwxX+pzOOCj2Nmw9ekobCm0+nUozOTPL1sg//Qn8JHHt
         xO0tAbsmbuBe+X8CtcH8Hq+UfQmKCx0GznVGkcIQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 05/21] mfd: ab8500-core: Return zero in get_register_interruptible()
Date:   Tue, 12 Feb 2019 21:40:24 -0500
Message-Id: <20190213024040.21740-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024040.21740-1-sashal@kernel.org>
References: <20190213024040.21740-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 10628e3ecf544fa2e4e24f8e112d95c37884dc98 ]

This function is supposed to return zero on success or negative error
codes on error.  Unfortunately, there is a bug so it sometimes returns
non-zero, positive numbers on success.

I noticed this bug during review and I can't test it.  It does appear
that the return is sometimes propogated back to _regmap_read() where all
non-zero returns are treated as failure so this may affect run time.

Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ab8500-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 589eebfc13df..2f212bdc187a 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -257,7 +257,7 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
 	mutex_unlock(&ab8500->lock);
 	dev_vdbg(ab8500->dev, "rd: addr %#x => data %#x\n", addr, ret);
 
-	return ret;
+	return (ret < 0) ? ret : 0;
 }
 
 static int ab8500_get_register(struct device *dev, u8 bank,
-- 
2.19.1

