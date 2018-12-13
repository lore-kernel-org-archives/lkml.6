Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78206C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C7C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675610;
	bh=joUYN7QztjSPxre9R9Pvo+9Cd07Fp2cVrN9YBR/NM6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DLbYaciEocvHGsSN1aKHjsev682OJUXHC4/vwldJEDjiQDPJI7t1r5F7EYbarVejB
	 FgDqtUlICcTKMJeSTA3Uoe79Cj+sid+LX1tOE/TF22B64DQ9NpxOnvtmc3KKFM+9QZ
	 toRS/zAeo0ClORBhwYED9tdwk9vl3zgM3sxiraug=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C7C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbeLMEd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbeLMEd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE38B20873;
        Thu, 13 Dec 2018 04:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675605;
        bh=joUYN7QztjSPxre9R9Pvo+9Cd07Fp2cVrN9YBR/NM6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isQ0Nbvl4Mz1jjbmD7lcEw7XskCi0o24KxCCVnC4IcsuRAeQLG+YlB+sFrITRdVLj
         xrkkTgqzqLD0QEPghTa8DoR2cqofjWrJ51utfoqqhL7VTQS09FDaPGi/NDHcIhNhb4
         EMfmPCVZbCAjU4s9x3kMs/XcZrrRY/YkdOyHCWJU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 14/23] clk: mmp: Off by one in mmp_clk_add()
Date:   Wed, 12 Dec 2018 23:32:50 -0500
Message-Id: <20181213043259.76643-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043259.76643-1-sashal@kernel.org>
References: <20181213043259.76643-1-sashal@kernel.org>
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

