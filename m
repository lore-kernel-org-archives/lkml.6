Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CCAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6FE208DC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6FE208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeH1Fm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45045 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeH1Fm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so1707320oih.11;
        Mon, 27 Aug 2018 18:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QzDXKJRZ1NfXO/zchmL3RpkdyVIVMbNPxhZUYRavYSk=;
        b=ZtLeAM2xv47ED9wtWsSEAtglHm6CfF0lkI9y8zBvDtxTDQMJTxysMtKywg566wbKBt
         zBgrB2w+QZRDTdPy2bR4GJ0kGAbiEpP826UvESaNuyF8f0WLDqLuODMwxkmmg/EV6Dni
         sywon6wT5HwK/URf9sb7iiWmadCzFoKDHmxbl5j+x4XDrn1tgOcMbda2X0AxvLJ0uKo8
         nDLUYCZpWvSsoXRR5YzjQFwuNeMmFHGOasyijtPPyQvppjA5iYiihwUuH7JxX/lz4hth
         1l/lXrI9bis6TNiX2SFohBNTG0lJLAURizPU+EmYu3P983GZGBjE858Ec1+tQdor9vFS
         dGEg==
X-Gm-Message-State: APzg51CIv3+Sid8ANWEISSNCVZWDl7tbgjxqKF6BJP77aBlDz7e71kLq
        wNv50abC+qwS1rw2Dl2339dFIjc=
X-Google-Smtp-Source: ANB0VdYfwje2kxcGdaQT3S12CXl9YmpbhlLTCKRRFWi8adKMCTZ7mVarT10AO5OQ7y9uQqc4xB++Zw==
X-Received: by 2002:aca:3003:: with SMTP id w3-v6mr354779oiw.231.1535421192823;
        Mon, 27 Aug 2018 18:53:12 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH] drm: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:20 -0500
Message-Id: <20180828015252.28511-19-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/drm_modes.c     | 4 ++--
 drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 02db9ac82d7a..24a750436559 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -716,8 +716,8 @@ int of_get_drm_display_mode(struct device_node *np,
 	if (bus_flags)
 		drm_bus_flags_from_videomode(&vm, bus_flags);
 
-	pr_debug("%pOF: got %dx%d display mode from %s\n",
-		np, vm.hactive, vm.vactive, np->name);
+	pr_debug("%pOF: got %dx%d display mode\n",
+		np, vm.hactive, vm.vactive);
 	drm_mode_debug_printmodeline(dmode);
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index c79659ca5706..23670907a29d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -579,7 +579,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 	hdmi_cfg = (struct hdmi_platform_config *)
 			of_device_get_match_data(dev);
 	if (!hdmi_cfg) {
-		dev_err(dev, "unknown hdmi_cfg: %s\n", of_node->name);
+		dev_err(dev, "unknown hdmi_cfg: %pOFn\n", of_node);
 		return -ENXIO;
 	}
 
-- 
2.17.1

