Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5A2C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC962175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025737;
	bh=Nkk6Bi22Unzvml2E+EUGnmysxLz/qtg9Xpo6qA6xPFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lDD676jaQyAoy/9+ho2Us+ZL60gZSKI83oPgqAGO3OnaV3mThmob7CfKtDfaAut5k
	 wUPhmST3hWqaSI1wOp6WyHfP1zTkv+WY8+g1QmOCE/jUiVdXW9+uPLi0tZpemMc5of
	 Tb85c47dFkOKgUQ/LLY1+ybHT+dN9n85IwEklRMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbfBMCmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389405AbfBMCl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:41:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4250222C2;
        Wed, 13 Feb 2019 02:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025717;
        bh=Nkk6Bi22Unzvml2E+EUGnmysxLz/qtg9Xpo6qA6xPFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYWqDX4PRjsgI+o/wjjALxQNcSLb76C05rYvI3d3XGxMC71SRxJt/UsztO3dnoly6
         GR6RGEZTcOOfgwhLn9QKbhn2rNdO78EOXJnQvVDl4o/E63vtpSHtFA6BpCBlwx0NHk
         lr0/FnKmrxtfTyiUFsPV9YLE8zHgp43XipScFX4E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 12/14] atm: he: fix sign-extension overflow on large shift
Date:   Tue, 12 Feb 2019 21:41:36 -0500
Message-Id: <20190213024139.22268-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024139.22268-1-sashal@kernel.org>
References: <20190213024139.22268-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit cb12d72b27a6f41325ae23a11033cf5fedfa1b97 ]

Shifting the 1 by exp by an int can lead to sign-extension overlow when
exp is 31 since 1 is an signed int and sign-extending this result to an
unsigned long long will set the upper 32 bits.  Fix this by shifting an
unsigned long.

Detected by cppcheck:
(warning) Shifting signed 32-bit value by 31 bits is undefined behaviour

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/he.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index c39702bc279d..937f54ccbe6b 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -717,7 +717,7 @@ static int he_init_cs_block_rcm(struct he_dev *he_dev)
 			instead of '/ 512', use '>> 9' to prevent a call
 			to divdu3 on x86 platforms
 		*/
-		rate_cps = (unsigned long long) (1 << exp) * (man + 512) >> 9;
+		rate_cps = (unsigned long long) (1UL << exp) * (man + 512) >> 9;
 
 		if (rate_cps < 10)
 			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
-- 
2.19.1

