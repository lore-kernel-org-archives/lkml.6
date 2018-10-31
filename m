Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545CFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B5E20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="txKsLTfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B5E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeKAIGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbeKAIGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041D82082E;
        Wed, 31 Oct 2018 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027156;
        bh=U0FIY94KVxxOVM7ehnAIkhqOiUTwYdf3xzS1h5Sw7lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txKsLTfLMtUeNt9vzm8UUfdxbr6woQ1HVSxSSpBUUBYhtmA2FY/0GVZbP+IpItBo+
         xsRpm9xOz+BYT5xvuSZsIgo6U54yG9Tez5KbQtph+TDQhVbzdwPEyYvpllHxABfdjd
         ZmxeaQYZhVLjJAAvv+lmVBaQNrjQO4EtkcwVOY9E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 015/146] lightnvm: pblk: fix two sleep-in-atomic-context bugs
Date:   Wed, 31 Oct 2018 19:03:30 -0400
Message-Id: <20181031230541.28822-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 7325b4bbe5952e3e939f15de812f2ee0c0d33ca9 ]

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 754:
	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048:
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434:
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980:
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976:
	spin_lock in pblk_recov_l2p

[FUNC] bio_map_kern(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 762:
	bio_map_kern in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048:
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434:
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980:
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976:
	spin_lock in pblk_recov_l2p

To fix these bugs, the call to pblk_line_replace_data()
is moved out of the spinlock protection.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-recovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index e232e47e1353..df75d9caec45 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -956,12 +956,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		}
 	}
 
-	spin_lock(&l_mg->free_lock);
 	if (!open_lines) {
+		spin_lock(&l_mg->free_lock);
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
 							&l_mg->meta_bitmap));
+		spin_unlock(&l_mg->free_lock);
 		pblk_line_replace_data(pblk);
 	} else {
+		spin_lock(&l_mg->free_lock);
 		/* Allocate next line for preparation */
 		l_mg->data_next = pblk_line_get(pblk);
 		if (l_mg->data_next) {
@@ -969,8 +971,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			l_mg->data_next->type = PBLK_LINETYPE_DATA;
 			is_next = 1;
 		}
+		spin_unlock(&l_mg->free_lock);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	if (is_next)
 		pblk_line_erase(pblk, l_mg->data_next);
-- 
2.17.1

