Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6FC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACFA2175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACFA2175A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeHMWGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:06:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729708AbeHMWGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75200818AAEE;
        Mon, 13 Aug 2018 19:22:35 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE662156712;
        Mon, 13 Aug 2018 19:22:35 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lukas Wunner <lukas@wunner.de>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/nouveau: Remove useless poll_enable() call in switcheroo_set_state()
Date:   Mon, 13 Aug 2018 15:22:29 -0400
Message-Id: <20180813192231.28861-2-lyude@redhat.com>
In-Reply-To: <20180813192231.28861-1-lyude@redhat.com>
References: <20180813192231.28861-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 19:22:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 19:22:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't do anything, drm_kms_helper_poll_enable() gets called in
nouveau_pmops_resume()->nouveau_display_resume()->nouveau_display_init()
already.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Karol Herbst <karolherbst@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/gpu/drm/nouveau/nouveau_vga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
index 3da5a4305aa4..09b1d8151881 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vga.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
@@ -46,7 +46,6 @@ nouveau_switcheroo_set_state(struct pci_dev *pdev,
 		pr_err("VGA switcheroo: switched nouveau on\n");
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		nouveau_pmops_resume(&pdev->dev);
-		drm_kms_helper_poll_enable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	} else {
 		pr_err("VGA switcheroo: switched nouveau off\n");
-- 
2.17.1

