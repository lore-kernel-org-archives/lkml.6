Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15A3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6595B26C6F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6595B26C6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936120AbeFZObx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:31:53 -0400
Received: from mail.netline.ch ([148.251.143.178]:52561 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935535AbeFZObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:31:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id B9E2D2A604F;
        Tue, 26 Jun 2018 16:31:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8_XT_7TIJPtH; Tue, 26 Jun 2018 16:31:49 +0200 (CEST)
Received: from kaveri (252.228.127.176.dynamic.wline.res.cust.swisscom.ch [176.127.228.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 5E4B02A604C;
        Tue, 26 Jun 2018 16:31:48 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fXp0V-0003jL-Gd; Tue, 26 Jun 2018 16:31:47 +0200
From:   =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH] dma-buf: Move BUG_ON from _add_shared_fence to _add_shared_inplace
Date:   Tue, 26 Jun 2018 16:31:47 +0200
Message-Id: <20180626143147.14296-1-michel@daenzer.net>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

Fixes the BUG_ON spuriously triggering under the following
circumstances:

* ttm_eu_reserve_buffers processes a list containing multiple BOs using
  the same reservation object, so it calls
  reservation_object_reserve_shared with that reservation object once
  for each such BO.
* In reservation_object_reserve_shared, old->shared_count ==
  old->shared_max - 1, so obj->staged is freed in preparation of an
  in-place update.
* ttm_eu_fence_buffer_objects calls reservation_object_add_shared_fence
  once for each of the BOs above, always with the same fence.
* The first call adds the fence in the remaining free slot, after which
  old->shared_count == old->shared_max.

In the next call to reservation_object_add_shared_fence, the BUG_ON
triggers. However, nothing bad would happen in
reservation_object_add_shared_inplace, since the fence is already in the
reservation object.

Prevent this by moving the BUG_ON to where an overflow would actually
happen (e.g. if a buggy caller didn't call
reservation_object_reserve_shared before).

Cc: stable@vger.kernel.org
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 drivers/dma-buf/reservation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
index 314eb1071cce..532545b9488e 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -141,6 +141,7 @@ reservation_object_add_shared_inplace(struct reservation_object *obj,
 	if (signaled) {
 		RCU_INIT_POINTER(fobj->shared[signaled_idx], fence);
 	} else {
+		BUG_ON(fobj->shared_count >= fobj->shared_max);
 		RCU_INIT_POINTER(fobj->shared[fobj->shared_count], fence);
 		fobj->shared_count++;
 	}
@@ -230,10 +231,9 @@ void reservation_object_add_shared_fence(struct reservation_object *obj,
 	old = reservation_object_get_list(obj);
 	obj->staged = NULL;
 
-	if (!fobj) {
-		BUG_ON(old->shared_count >= old->shared_max);
+	if (!fobj)
 		reservation_object_add_shared_inplace(obj, old, fence);
-	} else
+	else
 		reservation_object_add_shared_replace(obj, old, fobj, fence);
 }
 EXPORT_SYMBOL(reservation_object_add_shared_fence);
-- 
2.18.0

