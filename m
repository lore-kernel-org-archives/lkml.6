Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CA5C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4110D2145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eqiVLNYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLAMEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35384 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeLAMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so3215579pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Af+pB+6KYWG/war09y7KjqxVZ2laXeJjW1k19D2PuXo=;
        b=eqiVLNYql5hobYHZOsC+uBixktHTEz5qCejw0Xf2tlizgV4BCc9zn9JeMKl6a7cGZu
         XahwOB0NUCXyN+2zJtsi5SjvDpPD+nVEw48CI5yGHCac+lDwyq02JewstTYNQP3rtauP
         yc3CcRruaZfBQ7ukB8R2DbdSqPmMsKzebv3+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Af+pB+6KYWG/war09y7KjqxVZ2laXeJjW1k19D2PuXo=;
        b=cYNJgZDFSaAB2foN21DGtatXSuprh0rEr4fCvL3FdsEItV5HAlpSw0gQy81ZV+x5o3
         3A1aZgDACeBnT9C8sTE67zqxGsBqImxA+ugkT1nFUDMPk9rGHfFNXysQfeJoTxEH/AuB
         gUShBmc8pM/auZr1QFo6B4iyJtQpl+FpCHt1hBRGPx/eI+MGOPKdM4vl8dMvh75yAuKs
         35IxinD39lOvSLAHS8c+Bg/U75LALIgWDm4Heoako6zQxYsSQZTvTJJBjttdaWouWw7r
         9g716rLPEgivK41p3uWUNlRYxoZ1KWhogllnle3NDnfSRhlJGr3/xtynMFDvp3jywpwS
         jRmA==
X-Gm-Message-State: AA+aEWZfM32wl0BiiTzrxuJPaENdrXXO4mKs2s27ZwidFEDf1jic3MRn
        SqUK6aesDlSHjyV/9v+ytaaHEQ==
X-Google-Smtp-Source: AFSGD/XqwPiekgMOIJhtR3M4IEWaj3fNMnBTDXwMLxI8TiroG1xCYJ3Pcm2crLJRYrw6ofdoCkmXgA==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr6498839pgq.67.1543625605751;
        Fri, 30 Nov 2018 16:53:25 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:25 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/8] dt-bindings: msm/dsi: Add ref clock for PHYs
Date:   Fri, 30 Nov 2018 16:52:47 -0800
Message-Id: <20181201005254.139908-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181201005254.139908-1-mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the PHY drivers to get the ref clock from the DT.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in V3:
- added note that the ref clock is only required for new DTS
  files/entries

Changes in v2:
- add the ref clock for all PHYs, not only the 10nm one
- updated commit message
---
 Documentation/devicetree/bindings/display/msm/dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
index dfc743219bd88..9ae9469427207 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi.txt
+++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
@@ -106,6 +106,7 @@ Required properties:
 - clocks: Phandles to device clocks. See [1] for details on clock bindings.
 - clock-names: the following clocks are required:
   * "iface"
+  * "ref" (only required for new DTS files/entries)
   For 28nm HPM/LP, 28nm 8960 PHYs:
 - vddio-supply: phandle to vdd-io regulator device node
   For 20nm PHY:
-- 
2.20.0.rc1.387.gf8505762e3-goog

