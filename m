Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF2CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A372086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A372086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeLLNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbeLLNVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:21:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63DA058E29;
        Wed, 12 Dec 2018 13:21:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC1760C5C;
        Wed, 12 Dec 2018 13:21:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4C67E9013; Wed, 12 Dec 2018 14:21:10 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     spice-devel@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/18] drm/qxl: drop unused fields from struct qxl_device
Date:   Wed, 12 Dec 2018 14:20:56 +0100
Message-Id: <20181212132109.8126-6-kraxel@redhat.com>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 12 Dec 2018 13:21:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slot_id_bits and slot_gen_bits can be read directly from qxlrom instead.
va_slot_mask is never used anywhere.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h |  3 ---
 drivers/gpu/drm/qxl/qxl_kms.c | 10 ++--------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index d015d4fff1..3ebe66abf2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -232,9 +232,6 @@ struct qxl_device {
 
 	struct qxl_memslot main_slot;
 	struct qxl_memslot surfaces_slot;
-	uint8_t		slot_id_bits;
-	uint8_t		slot_gen_bits;
-	uint64_t	va_slot_mask;
 
 	spinlock_t	release_lock;
 	struct idr	release_idr;
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index a9288100ae..3c1753667d 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -78,9 +78,9 @@ static void setup_slot(struct qxl_device *qdev,
 
 	slot->generation = qdev->rom->slot_generation;
 	high_bits = (qdev->rom->slots_start + slot->index)
-		<< qdev->slot_gen_bits;
+		<< qdev->rom->slot_gen_bits;
 	high_bits |= slot->generation;
-	high_bits <<= (64 - (qdev->slot_gen_bits + qdev->slot_id_bits));
+	high_bits <<= (64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits));
 	slot->high_bits = high_bits;
 
 	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx\n",
@@ -235,12 +235,6 @@ int qxl_device_init(struct qxl_device *qdev,
 		r = -ENOMEM;
 		goto cursor_ring_free;
 	}
-	/* TODO - slot initialization should happen on reset. where is our
-	 * reset handler? */
-	qdev->slot_gen_bits = qdev->rom->slot_gen_bits;
-	qdev->slot_id_bits = qdev->rom->slot_id_bits;
-	qdev->va_slot_mask =
-		(~(uint64_t)0) >> (qdev->slot_id_bits + qdev->slot_gen_bits);
 
 	idr_init(&qdev->release_idr);
 	spin_lock_init(&qdev->release_idr_lock);
-- 
2.9.3

