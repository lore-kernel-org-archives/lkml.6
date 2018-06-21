Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD7C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3618A223E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GPB8j8Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3618A223E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeFUV3S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933946AbeFUV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CCjWeuIcI4vHVyGY1m7zhPkItei4hVsL+lm4Vmi5J0E=; b=GPB8j8TbUmA2IQatxPGpmoxV4
        rX+Vj5JmZ/+whFDY1StsUmJnZbDSkWasgxreJ3tHE5evPcmAyOOr6RlAJjeeoQK3jkoy1r/60Nstr
        HJIS7nlOwWSAJaWD3sjZjpI4iSucWBf/UZoYtBpNycAhMM4+dKN+heqwD0M6/BGyQjEzwHPBD7klB
        iEPMbZ0kkhuTw0PCEQ7DOPq1gSS1FNUuZ+HAyFHXRq+HOHZNW++vG125rYjUBbgUzx1e86WfT5CZI
        3Dtotl8HwNazs8yRdfau1iEoxnxjOGt3JNYOU/DLJmMpAYG5PN0xFbAe/sxLHecyJ/0Poi0Sbo0/N
        Buj2nuRxw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78f-0001bw-D8; Thu, 21 Jun 2018 21:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 14/26] media: Convert entity ID allocation to new IDA API
Date:   Thu, 21 Jun 2018 14:28:23 -0700
Message-Id: <20180621212835.5636-15-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a call to ida_pre_get().

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/media/media-device.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/media/media-device.c b/drivers/media/media-device.c
index ae59c3177555..d51088bcd735 100644
--- a/drivers/media/media-device.c
+++ b/drivers/media/media-device.c
@@ -575,18 +575,12 @@ int __must_check media_device_register_entity(struct media_device *mdev,
 	entity->num_links = 0;
 	entity->num_backlinks = 0;
 
-	if (!ida_pre_get(&mdev->entity_internal_idx, GFP_KERNEL))
-		return -ENOMEM;
-
-	mutex_lock(&mdev->graph_mutex);
-
-	ret = ida_get_new_above(&mdev->entity_internal_idx, 1,
-				&entity->internal_idx);
-	if (ret < 0) {
-		mutex_unlock(&mdev->graph_mutex);
+	ret = ida_alloc_min(&mdev->entity_internal_idx, 1, GFP_KERNEL);
+	if (ret < 0)
 		return ret;
-	}
+	entity->internal_idx = ret;
 
+	mutex_lock(&mdev->graph_mutex);
 	mdev->entity_internal_idx_max =
 		max(mdev->entity_internal_idx_max, entity->internal_idx);
 
@@ -632,7 +626,7 @@ static void __media_device_unregister_entity(struct media_entity *entity)
 	struct media_interface *intf;
 	unsigned int i;
 
-	ida_simple_remove(&mdev->entity_internal_idx, entity->internal_idx);
+	ida_free(&mdev->entity_internal_idx, entity->internal_idx);
 
 	/* Remove all interface links pointing to this entity */
 	list_for_each_entry(intf, &mdev->interfaces, graph_obj.list) {
-- 
2.17.1

