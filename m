Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC43C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370C2177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E370C2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbeHMVuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:50:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730352AbeHMVuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5F5987A7A;
        Mon, 13 Aug 2018 19:07:13 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9102110EE77E;
        Mon, 13 Aug 2018 19:07:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()
Date:   Mon, 13 Aug 2018 15:07:00 -0400
Message-Id: <20180813190706.24172-3-lyude@redhat.com>
In-Reply-To: <20180813190706.24172-1-lyude@redhat.com>
References: <20180813190706.24172-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 13 Aug 2018 19:07:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 13 Aug 2018 19:07:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since actual hotplug notifications don't get disabled until
nouveau_display_fini() is called, all this will do is cause any hotplugs
that happen between this drm_kms_helper_poll_disable() call and the
actual hotplug disablement to potentially be dropped if ACPI isn't
around to help us.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index c7ec86d6c3c9..5fdc1fbe2ee5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -835,7 +835,6 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
-	drm_kms_helper_poll_disable(drm_dev);
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm_dev, true);
 	pci_save_state(pdev);
-- 
2.17.1

