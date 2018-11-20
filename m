Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6326FC18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370BC208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370BC208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeKUBXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:39304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729917AbeKUBXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E379FAE4A;
        Tue, 20 Nov 2018 14:54:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 08/16] staging: vchiq_core: remove unnecessary safety checks in vchiq_init_state
Date:   Tue, 20 Nov 2018 15:53:43 +0100
Message-Id: <20181120145351.30390-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq_init_state() checks the initial contents of slot_zero are correct.
These are set in vchiq_init_slots(), using the same hard-coded defaults
as the checks. Both functions are called sequentially and Video Core
isn't yet aware of the slot's address. There is no way the contents of
slot_zero changed in between functions, making the checks useless.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_core.c          | 59 -------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 34a892011296..dee5ea7bfe4f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2170,65 +2170,6 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 		return VCHIQ_ERROR;
 	}
 
-	/* Check the input configuration */
-
-	if (slot_zero->magic != VCHIQ_MAGIC) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("Invalid VCHIQ magic value found.");
-		vchiq_loud_error("slot_zero=%pK: magic=%x (expected %x)",
-			slot_zero, slot_zero->magic, VCHIQ_MAGIC);
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if (slot_zero->version < VCHIQ_VERSION_MIN) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("Incompatible VCHIQ versions found.");
-		vchiq_loud_error("slot_zero=%pK: VideoCore version=%d (minimum %d)",
-			slot_zero, slot_zero->version, VCHIQ_VERSION_MIN);
-		vchiq_loud_error("Restart with a newer VideoCore image.");
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if (VCHIQ_VERSION < slot_zero->version_min) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("Incompatible VCHIQ versions found.");
-		vchiq_loud_error("slot_zero=%pK: version=%d (VideoCore minimum %d)",
-			slot_zero, VCHIQ_VERSION, slot_zero->version_min);
-		vchiq_loud_error("Restart with a newer kernel.");
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if ((slot_zero->slot_zero_size != sizeof(VCHIQ_SLOT_ZERO_T)) ||
-		 (slot_zero->slot_size != VCHIQ_SLOT_SIZE) ||
-		 (slot_zero->max_slots != VCHIQ_MAX_SLOTS) ||
-		 (slot_zero->max_slots_per_side != VCHIQ_MAX_SLOTS_PER_SIDE)) {
-		vchiq_loud_error_header();
-		if (slot_zero->slot_zero_size != sizeof(VCHIQ_SLOT_ZERO_T))
-			vchiq_loud_error("slot_zero=%pK: slot_zero_size=%d (expected %d)",
-				slot_zero, slot_zero->slot_zero_size,
-				(int)sizeof(VCHIQ_SLOT_ZERO_T));
-		if (slot_zero->slot_size != VCHIQ_SLOT_SIZE)
-			vchiq_loud_error("slot_zero=%pK: slot_size=%d (expected %d)",
-				slot_zero, slot_zero->slot_size,
-				VCHIQ_SLOT_SIZE);
-		if (slot_zero->max_slots != VCHIQ_MAX_SLOTS)
-			vchiq_loud_error("slot_zero=%pK: max_slots=%d (expected %d)",
-				slot_zero, slot_zero->max_slots,
-				VCHIQ_MAX_SLOTS);
-		if (slot_zero->max_slots_per_side != VCHIQ_MAX_SLOTS_PER_SIDE)
-			vchiq_loud_error("slot_zero=%pK: max_slots_per_side=%d (expected %d)",
-				slot_zero, slot_zero->max_slots_per_side,
-				VCHIQ_MAX_SLOTS_PER_SIDE);
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if (VCHIQ_VERSION < slot_zero->version)
-		slot_zero->version = VCHIQ_VERSION;
-
 	local = &slot_zero->slave;
 	remote = &slot_zero->master;
 
-- 
2.19.1

