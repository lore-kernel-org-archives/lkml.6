Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADBAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D5E20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HIQwPujD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D5E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKCGyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:54:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46123 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeKCGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:54:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so1558314plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/218tbqYfFYsBPGuhJ4jRp/KJJyqAyXjQYUAJueIJAw=;
        b=HIQwPujDGHbE0eemGaXVPA4oXY2ITV39RDp31VfruMJpV/Gb1Box6rFLnGt5Us3vTl
         nJXX5nV0RT2S+lvR/2JOqcNXKIgEWLSHPUU9HsmR936AIfDqmryOd4n/nFvR7On/pvsd
         B/EGLKM8wtcQlK01dqtvAO3LWbWANknLOkX/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/218tbqYfFYsBPGuhJ4jRp/KJJyqAyXjQYUAJueIJAw=;
        b=fvsEZ2R9P1xsTg78+cekh2JzFy2KCb5gYzwcftZweMBvBYMtXyEyHI0eQwdrH+ShtD
         Mo/BQQU7tbd7JkmN6ombRKpZ967E+v+s5dZ5ibhaGAdPJQfeBesj1FFHwBFM2HXoR5OQ
         qwrzMjxvAP/gtVFb0ajSwwMgh6rF1oQBxAGxsuZGo31D7rafo1ZT80FbbqNdhY1Q6xAK
         9VJMnuzwA6z21DWRsSdfINgZXvtjiOX0nLEvzto6/7MCfhK68IfCf534CFbZFnwSnbkK
         fvUPvi4Iss6cdRWwfL7cWRDEqmtxiy5cH5/45LA+f+lBL2Kn42LRXGQcHWvR9sW8QEzM
         pvVA==
X-Gm-Message-State: AGRZ1gKS6Ky1tvPktcQluazCCnf0e49dN19cjAKTmBmi4RAmqFGeOLCD
        +Sa581OwFuZlZktVesGRyouFIA==
X-Google-Smtp-Source: AJdET5dfIGnnDzIpt0LuWmctxVcZrO+0fVanfeejho0Wf24FbzURFwVe7dYwqoTJsMusQuoq19tr4A==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14-v6mr13316568plq.78.1541195154784;
        Fri, 02 Nov 2018 14:45:54 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id q25-v6sm58332871pfk.154.2018.11.02.14.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:45:54 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] dt-bindings: msm/dsi: Add ref clock for 10nm PHY
Date:   Fri,  2 Nov 2018 14:45:33 -0700
Message-Id: <20181102214534.184593-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the 10nm PHY driver to get the ref clock from the DT.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 Documentation/devicetree/bindings/display/msm/dsi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
index dfc743219bd88..d0d2046ceff69 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi.txt
+++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
@@ -105,6 +105,10 @@ Required properties:
 - power-domains: Should be <&mmcc MDSS_GDSC>.
 - clocks: Phandles to device clocks. See [1] for details on clock bindings.
 - clock-names: the following clocks are required:
+  For 10nm PHY:
+  * "iface"
+  * "ref"
+  For other PHYs:
   * "iface"
   For 28nm HPM/LP, 28nm 8960 PHYs:
 - vddio-supply: phandle to vdd-io regulator device node
-- 
2.19.1.930.g4563a0d9d0-goog

