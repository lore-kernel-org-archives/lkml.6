Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B2ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFEB20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAU8Wq5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFEB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeKAIIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbeKAIIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EA2A20847;
        Wed, 31 Oct 2018 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027288;
        bh=rzDPkeEr9kLeXeKZ4wipr11tdhJiiCXPsbyc9XLnd5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAU8Wq5p1Ge6Bl7/tbFhyQfFOtrLqOXkcPepqQHXb8Xd0SwBOvAEY5tyD8NxQFwCJ
         gDHBV9XOtCbnUZsurfNM93p6C9cyx2KUr5KjTriL9AyTe4h1t7/GlP6apFr5JYRq91
         jyGMIcR0HIUIM0+dlKFHT8bX8iXQA7hXWSncYYuw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 014/126] lightnvm: pblk: fix race condition on metadata I/O
Date:   Wed, 31 Oct 2018 19:06:02 -0400
Message-Id: <20181031230754.29029-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

[ Upstream commit d8adaa3b86324c6186d0adf74bc256bdacfffdb6 ]

In pblk, when a new line is allocated, metadata for the previously
written line is scheduled. This is done through a fixed memory region
that is shared through time and contexts across different lines and
therefore protected by a lock. Unfortunately, this lock is not properly
covering all the metadata used for sharing this memory regions,
resulting in a race condition.

This patch fixes this race condition by protecting this metadata
properly.

Fixes: dd2a43437337 ("lightnvm: pblk: sched. metadata on write thread")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-write.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index f353e52941f5..89ac60d4849e 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -417,12 +417,11 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
 	}
 
+	spin_lock(&l_mg->close_lock);
 	emeta->mem += rq_len;
-	if (emeta->mem >= lm->emeta_len[0]) {
-		spin_lock(&l_mg->close_lock);
+	if (emeta->mem >= lm->emeta_len[0])
 		list_del(&meta_line->list);
-		spin_unlock(&l_mg->close_lock);
-	}
+	spin_unlock(&l_mg->close_lock);
 
 	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
@@ -491,14 +490,15 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
 	struct pblk_line *meta_line;
 
 	spin_lock(&l_mg->close_lock);
-retry:
 	if (list_empty(&l_mg->emeta_list)) {
 		spin_unlock(&l_mg->close_lock);
 		return NULL;
 	}
 	meta_line = list_first_entry(&l_mg->emeta_list, struct pblk_line, list);
-	if (meta_line->emeta->mem >= lm->emeta_len[0])
-		goto retry;
+	if (meta_line->emeta->mem >= lm->emeta_len[0]) {
+		spin_unlock(&l_mg->close_lock);
+		return NULL;
+	}
 	spin_unlock(&l_mg->close_lock);
 
 	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
-- 
2.17.1

