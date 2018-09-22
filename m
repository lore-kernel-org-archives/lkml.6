Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D4ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A22156E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548A22156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbeIVGfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:35:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391614AbeIVGfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:35:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E470DC01F290;
        Sat, 22 Sep 2018 00:43:52 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B3BE87E4F;
        Sat, 22 Sep 2018 00:43:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        Jim Qu <Jim.Qu@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Suppress keypresses from ACPI_VIDEO events
Date:   Fri, 21 Sep 2018 20:43:44 -0400
Message-Id: <20180922004346.12288-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 22 Sep 2018 00:43:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we return NOTIFY_DONE for any event which we don't think is
ours. However, many laptops will send more then just an ATIF event and
will also send an ACPI_VIDEO_NOTIFY_PROBE event as well. Since we don't
check for this, we return NOTIFY_DONE which causes a keypress for the
ACPI event to be propogated to userspace. This is the equivalent of
someone pressing the display key on a laptop every time there's a
hotplug event.

So, check for ACPI_VIDEO_NOTIFY_PROBE events and suppress keypresses
from them.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 353993218f21..f008804f0b97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -358,7 +358,9 @@ static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,
  *
  * Checks the acpi event and if it matches an atif event,
  * handles it.
- * Returns NOTIFY code
+ *
+ * Returns:
+ * NOTIFY_BAD or NOTIFY_DONE, depending on the event.
  */
 static int amdgpu_atif_handler(struct amdgpu_device *adev,
 			       struct acpi_bus_event *event)
@@ -372,11 +374,16 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 	if (strcmp(event->device_class, ACPI_VIDEO_CLASS) != 0)
 		return NOTIFY_DONE;
 
+	/* Is this actually our event? */
 	if (!atif ||
 	    !atif->notification_cfg.enabled ||
-	    event->type != atif->notification_cfg.command_code)
-		/* Not our event */
-		return NOTIFY_DONE;
+	    event->type != atif->notification_cfg.command_code) {
+		/* These events will generate keypresses otherwise */
+		if (event->type == ACPI_VIDEO_NOTIFY_PROBE)
+			return NOTIFY_BAD;
+		else
+			return NOTIFY_DONE;
+	}
 
 	if (atif->functions.sbios_requests) {
 		struct atif_sbios_requests req;
@@ -385,7 +392,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		count = amdgpu_atif_get_sbios_requests(atif, &req);
 
 		if (count <= 0)
-			return NOTIFY_DONE;
+			return NOTIFY_BAD;
 
 		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
 
-- 
2.17.1

