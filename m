Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5728D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5728D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeJWXEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWXEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:04:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9104356D5;
        Tue, 23 Oct 2018 14:40:28 +0000 (UTC)
Received: from ceranb.redhat.com (ovpn-204-227.brq.redhat.com [10.40.204.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01D1462A8A;
        Tue, 23 Oct 2018 14:40:26 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "be2net: remove desc field from be_eq_obj"
Date:   Tue, 23 Oct 2018 16:40:26 +0200
Message-Id: <20181023144026.26180-1-ivecera@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 23 Oct 2018 14:40:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mentioned commit needs to be reverted because we cannot pass
string allocated on stack to request_irq(). This function stores
uses this pointer for later use (e.g. /proc/interrupts) so we need
to keep this string persistently.

Fixes: d6d9704af8f4 ("be2net: remove desc field from be_eq_obj")

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/emulex/benet/be.h      | 1 +
 drivers/net/ethernet/emulex/benet/be_main.c | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index 58bcee8f0a58..ce041c90adb0 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -185,6 +185,7 @@ static inline void queue_tail_inc(struct be_queue_info *q)
 
 struct be_eq_obj {
 	struct be_queue_info q;
+	char desc[32];
 
 	struct be_adapter *adapter;
 	struct napi_struct napi;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 534787291b44..bff74752cef1 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3488,11 +3488,9 @@ static int be_msix_register(struct be_adapter *adapter)
 	int status, i, vec;
 
 	for_all_evt_queues(adapter, eqo, i) {
-		char irq_name[IFNAMSIZ+4];
-
-		snprintf(irq_name, sizeof(irq_name), "%s-q%d", netdev->name, i);
+		sprintf(eqo->desc, "%s-q%d", netdev->name, i);
 		vec = be_msix_vec_get(adapter, eqo);
-		status = request_irq(vec, be_msix, 0, irq_name, eqo);
+		status = request_irq(vec, be_msix, 0, eqo->desc, eqo);
 		if (status)
 			goto err_msix;
 
-- 
2.18.1

