Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3395DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5698208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5698208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbeGaCRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:17:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732276AbeGaCRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24B6840241DE;
        Tue, 31 Jul 2018 00:40:07 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C978216875;
        Tue, 31 Jul 2018 00:40:06 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] drm/nouveau: Call pm_runtime_get_noresume() from hpd handlers
Date:   Mon, 30 Jul 2018 20:39:53 -0400
Message-Id: <20180731003954.19962-9-lyude@redhat.com>
In-Reply-To: <20180731003954.19962-1-lyude@redhat.com>
References: <20180731003954.19962-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 00:40:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 00:40:07 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't and don't need to try resuming the device from our hotplug
handlers, but hotplug events are generally something we'd like to keep
the device awake for whenever possible. So, grab a PM ref safely in our
hotplug handlers using pm_runtime_get_noresume() and mark the device as
busy once we're finished.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 8409c3f2c3a1..5a8e8c1ad647 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1152,6 +1152,11 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 	const char *name = connector->name;
 	struct nouveau_encoder *nv_encoder;
 
+	/* Resuming the device here isn't possible; but the suspend PM ops
+	 * will wait for us to finish our work before disabling us so this
+	 * should be enough
+	 */
+	pm_runtime_get_noresume(drm->dev->dev);
 	nv_connector->hpd_task = current;
 
 	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
@@ -1171,6 +1176,9 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 	}
 
 	nv_connector->hpd_task = NULL;
+
+	pm_runtime_mark_last_busy(drm->dev->dev);
+	pm_runtime_put_autosuspend(drm->dev->dev);
 	return NVIF_NOTIFY_KEEP;
 }
 
-- 
2.17.1

