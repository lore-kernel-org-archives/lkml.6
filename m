Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF05C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F96E21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297721;
	bh=YAOqE4H/olGGboQJy4TLsozCY6rNyLJVHbmuiHLXt3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j0hzA5DXdnHDTkz/LIs3dUSw6P5yyuP9g9hYQE4dUQnA4+/DcBxKcCaacS+HTiJpF
	 guKMhkw2IzB8ChiP+Z9bbAqivCH1aUOmY22/qIlBnXD52BhKpFK0ojP2pJoXklfF7c
	 miu1NcCRFVRabjCDrupwTh1zgkKGb2lhXB/kyS3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeLTJWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731230AbeLTJV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA7621720;
        Thu, 20 Dec 2018 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297717;
        bh=YAOqE4H/olGGboQJy4TLsozCY6rNyLJVHbmuiHLXt3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mclaaZpCu+iYWz7ygRpesZKXtxSLraoak+m87fNVSJTLd3nIWKrdMBmaq2oHHY36b
         vVQdRJUBm0KTXAEosLy09dLAI6ndJDaIGrNGCJqzutEqNCck77cQ4aCvoHQsFkfYJ3
         bstOZ5Ganso+fX9ge9mZhNAldmSbJcLBysB3l15U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 30/40] clk: mmp: Off by one in mmp_clk_add()
Date:   Thu, 20 Dec 2018 10:18:42 +0100
Message-Id: <20181220085827.664183382@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 61893fe73251..18b6c9b55b95 100644
--- a/drivers/clk/mmp/clk.c
+++ b/drivers/clk/mmp/clk.c
@@ -182,7 +182,7 @@ void mmp_clk_add(struct mmp_clk_unit *unit, unsigned int id,
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



