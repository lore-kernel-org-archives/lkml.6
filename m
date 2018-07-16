Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3631ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D720C07
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31D720C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGQA3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:29:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730736AbeGQA3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4875D81A4EB9;
        Tue, 17 Jul 2018 00:00:10 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBA192026D65;
        Tue, 17 Jul 2018 00:00:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/nouveau: Grab RPM ref when aux bus is in use
Date:   Mon, 16 Jul 2018 19:59:29 -0400
Message-Id: <20180716235936.11268-6-lyude@redhat.com>
In-Reply-To: <20180716235936.11268-1-lyude@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 17 Jul 2018 00:00:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 17 Jul 2018 00:00:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP AUX busses can both be accessed by DRM, and through any of the
userspace dev nodes in /dev/drm_dp_auxN. We need to make sure the GPU
stays on in all of these codepaths.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
index 4c1f547da463..6276b113065c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
@@ -98,18 +98,28 @@ nvkm_i2c_aux_release(struct nvkm_i2c_aux *aux)
 	AUX_TRACE(aux, "release");
 	nvkm_i2c_pad_release(pad);
 	mutex_unlock(&aux->mutex);
+	pm_runtime_put_autosuspend(pad->i2c->subdev.device->dev);
 }
 
 int
 nvkm_i2c_aux_acquire(struct nvkm_i2c_aux *aux)
 {
 	struct nvkm_i2c_pad *pad = aux->pad;
+	struct device *dev = pad->i2c->subdev.device->dev;
 	int ret;
+
 	AUX_TRACE(aux, "acquire");
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
 	mutex_lock(&aux->mutex);
 	ret = nvkm_i2c_pad_acquire(pad, NVKM_I2C_PAD_AUX);
-	if (ret)
+	if (ret) {
 		mutex_unlock(&aux->mutex);
+		pm_runtime_put_autosuspend(dev);
+	}
 	return ret;
 }
 
-- 
2.17.1

