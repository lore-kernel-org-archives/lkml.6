Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A114C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC739206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC739206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeI2FQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:16:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34082 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeI2FQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:16:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12-v6so7599240otl.1;
        Fri, 28 Sep 2018 15:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xF4J/tu6O3fmV6GMsuiSkRFcnUyMm94gMR7WjsV3KQE=;
        b=uFF2Z773HW6R18aaODFits+132IOSGrqfS3hbxbRxbYbdsY427ZDFWgtZtPSiR3aA3
         oOeAdQ0YsVva+38ZN6hLIWcZ31QZdFT4sNBOj2ay8B7RFsmMuhSzdghvaJ8WbnaJ5Mgt
         Yd0lXh5/GkbUrHW1VPW0hh4VvYPk1TVfpDO1gFhQue6OkW7rNHu65lNbjQmI0+eVU0HX
         CMm7LCSon/6wQANYD5LnQJnbIG785uDlQspkMr8z1VkRhOHg0iYxDuvT/Og0YgFw6nRy
         7Js9Krj7k2HTXS0wSwtPCx2yxUE2XwCnf7DJGGjjQjRZXwdoGyKTlLNXpRvnI7Q1uOo6
         kQSQ==
X-Gm-Message-State: ABuFfogScX+DnzDwcGqyKqzzRMIe2XML90QjLWCniYLokNis5ppbZs22
        R0Sz14YLrjAy7wjM/WCzgpJDY1aXrQ==
X-Google-Smtp-Source: ACcGV62kxXsIiugAWX3IYU1ET9CR8rPtSAOa39N8W4xmjARXtv6Y6YW7W82KIDZabytlNPt3f++HbA==
X-Received: by 2002:a9d:5b46:: with SMTP id e6-v6mr489364otj.318.1538175046810;
        Fri, 28 Sep 2018 15:50:46 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s65-v6sm2101652oia.46.2018.09.28.15.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:50:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Subject: [PATCH v2] drm: Convert to using %pOFn instead of device_node.name
Date:   Fri, 28 Sep 2018 17:50:44 -0500
Message-Id: <20180928225044.20132-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

For drm_modes.c, the full node path is already printed out, so printing
just the node name a 2nd time is redundant and can be removed.

Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Acked-by: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Add to commit msg that we're dropping redundant printing of node name.

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

