Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C416820BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C416820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeGQA3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:29:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730092AbeGQA3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:29:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C2297C6CA;
        Tue, 17 Jul 2018 00:00:08 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D0062026E1A;
        Tue, 17 Jul 2018 00:00:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/nouveau: Grab RPM ref when i2c bus is in use
Date:   Mon, 16 Jul 2018 19:59:28 -0400
Message-Id: <20180716235936.11268-5-lyude@redhat.com>
In-Reply-To: <20180716235936.11268-1-lyude@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 17 Jul 2018 00:00:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 17 Jul 2018 00:00:08 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c bus can be both accessed by DRM itself, along with any of it's
devnodes (/sys/class/i2c). So, we need to make sure that all codepaths
using the i2c bus keep the GPU resumed.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
index 807a2b67bd64..1de48c990b80 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
@@ -119,18 +119,28 @@ nvkm_i2c_bus_release(struct nvkm_i2c_bus *bus)
 	BUS_TRACE(bus, "release");
 	nvkm_i2c_pad_release(pad);
 	mutex_unlock(&bus->mutex);
+	pm_runtime_put_autosuspend(pad->i2c->subdev.device->dev);
 }
 
 int
 nvkm_i2c_bus_acquire(struct nvkm_i2c_bus *bus)
 {
 	struct nvkm_i2c_pad *pad = bus->pad;
+	struct device *dev = pad->i2c->subdev.device->dev;
 	int ret;
+
 	BUS_TRACE(bus, "acquire");
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
 	mutex_lock(&bus->mutex);
 	ret = nvkm_i2c_pad_acquire(pad, NVKM_I2C_PAD_I2C);
-	if (ret)
+	if (ret) {
 		mutex_unlock(&bus->mutex);
+		pm_runtime_put_autosuspend(dev);
+	}
 	return ret;
 }
 
-- 
2.17.1

