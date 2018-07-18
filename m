Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB648ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C3220850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C3220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeGROw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:52:29 -0400
Received: from bran.ispras.ru ([83.149.199.196]:17648 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeGROw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:52:29 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 02CEA203B2;
        Wed, 18 Jul 2018 17:14:17 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>, Sean Young <sean@mess.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] media: dm1105: Limit number of cards to avoid buffer over read
Date:   Wed, 18 Jul 2018 17:13:56 +0300
Message-Id: <20180718141356.2515-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm1105_probe() counts number of cards at dm1105_devcount,
but missed bounds check before dereference a card array.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/media/pci/dm1105/dm1105.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index c9db108751a7..1ddb0576fb7b 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -986,6 +986,9 @@ static int dm1105_probe(struct pci_dev *pdev,
 	int ret = -ENOMEM;
 	int i;
 
+	if (dm1105_devcount >= ARRAY_SIZE(card))
+		return -ENODEV;
+
 	dev = kzalloc(sizeof(struct dm1105_dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
-- 
2.18.0

