Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72048C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE3120882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675490;
	bh=SbQWuKOFwUFj4m7tvmdd14cyKqZ6Jc8j5/TzWpp56tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vyKZ0V3oePdq5ZTxNW3Z0qImu+1XDTx1qj3tmW4IEVrNUETUIl3IWwPGtXKL7FiG3
	 9PpGAJ3q+iDdzlkrrK/jPAvHQb5Qt+MAzYCfAy5eSO4WuvKcXkRDYdTwEdQbejl8xh
	 RXGazh12M/qXgzVKzyIey9kM86TOoWaiUxIo2S1c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE3120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeLMEb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbeLMEbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCAA320672;
        Thu, 13 Dec 2018 04:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675485;
        bh=SbQWuKOFwUFj4m7tvmdd14cyKqZ6Jc8j5/TzWpp56tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5yCNsRkqEQ+xgUWLd/URYLNAFyMdX9ukBnqyNCXicWiAJWQmyOJ9v3wqDkDEhKCh
         8VFN/87pt40bxPW2yYvYZ0HToXmtmaOsFkSIcwTGrNav0jbVmHu3GiEaigcIMtFJR9
         y8VQ0sLFD8tuMfhoXtQTqvBI2FoCljq4UPxybbIg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/41] clk: mmp: Off by one in mmp_clk_add()
Date:   Wed, 12 Dec 2018 23:30:32 -0500
Message-Id: <20181213043054.75891-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2e85c57493e391b93445c1e0d530b36b95becc64 ]

The > comparison should be >= or we write one element beyond the end of
the unit->clk_table[] array.

(The unit->clk_table[] array is allocated in the mmp_clk_init() function
and it has unit->nr_clks elements).

Fixes: 4661fda10f8b ("clk: mmp: add basic support functions for DT support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mmp/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/clk.c b/drivers/clk/mmp/clk.c
index ad8d483a35cd..ca7d37e2c7be 100644
--- a/drivers/clk/mmp/clk.c
+++ b/drivers/clk/mmp/clk.c
@@ -183,7 +183,7 @@ void mmp_clk_add(struct mmp_clk_unit *unit, unsigned int id,
 		pr_err("CLK %d has invalid pointer %p\n", id, clk);
 		return;
 	}
-	if (id > unit->nr_clks) {
+	if (id >= unit->nr_clks) {
 		pr_err("CLK %d is invalid\n", id);
 		return;
 	}
-- 
2.19.1

