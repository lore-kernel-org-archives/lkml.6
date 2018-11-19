Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008ABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EF4208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1c5pTmVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EF4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbeKTDCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbeKTDCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0DB206BA;
        Mon, 19 Nov 2018 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645477;
        bh=suUWlLA2WcGV/X21lbN7QpO75Bm1QiU3Cz0cxhEG5JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1c5pTmVkhism41hW/TAoFz2OF0FFFUaMZ37kO3sLbi6O8RHuH0xTLl/RFrW88Zs0/
         9qVMYWL8Pb2kMQ+9o0Q2/jhskralhDDvzfiKWZ6j3sUosN1iUOdZOM18i/N9EP+ECu
         cS6CMNT3u6Ex1Cvc8Igpw0ed0CGjFfIELQ/bB6Mo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 176/205] drm/amdgpu: Suppress keypresses from ACPI_VIDEO events
Date:   Mon, 19 Nov 2018 17:28:03 +0100
Message-Id: <20181119162640.893779703@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 582f58de36834096a91cc1de2540c2f7269f850d upstream.

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
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -358,7 +358,9 @@ out:
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
@@ -372,11 +374,16 @@ static int amdgpu_atif_handler(struct am
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
@@ -385,7 +392,7 @@ static int amdgpu_atif_handler(struct am
 		count = amdgpu_atif_get_sbios_requests(atif, &req);
 
 		if (count <= 0)
-			return NOTIFY_DONE;
+			return NOTIFY_BAD;
 
 		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
 


