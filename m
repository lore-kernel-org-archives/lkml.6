Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D17C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26F720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCa+TADP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26F720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeK0KIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:08:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35686 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeK0KIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:08:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so4318879plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f5dpDvvGmsVX4Q3pgvV70G7dYzEiWkJ3RyYkEStQQrk=;
        b=eCa+TADPV55IOHsdYRWkQdfbxStE8p7ahibUN65ObPSS03eH3ZDm63wyAsHcj9hAm1
         o5BT7XJLp2xMrg4vWghcioEX3kDxXie2th9VAmLWY0mlNjTwq9yjpfK2wpmScWh7H4B3
         6Q14VPBTJQ8h30nS94iDlxnVp6ZmyUbKjwY6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f5dpDvvGmsVX4Q3pgvV70G7dYzEiWkJ3RyYkEStQQrk=;
        b=JN7LfuP76JKgYycygaAWQd3vUnMs1LQGvHWeQzRIju7F8HxVYXQO5O2XWNXbBEMabw
         qZd9T2VJNctOXQNzEVjKWBSfOrRmUSJf8M31zI3YTE1J1axmveCAflMlvoMRLJcBiUh2
         iURZER7vzHnx4FhnYUyb9ZgubzpwDmqW9r6I4486YbsWQhU6xR2M5cpQtLecix1zDL74
         3HU0z5G+ETes45F4BXQ3r6WqUc0PMhJQ8yqM1ihr+1kZggu5f2Y1mvvDAx4xOjJhdimF
         VCpPRH5/hMJ8Z46TWUKMi/maxC+IocablGKB5vVWxk6qXY34The8R2cbf4g8y9xyoRUd
         S5ng==
X-Gm-Message-State: AA+aEWYhmZ3G+zvkoIkqCO6arn9JPA/7fhWjlHIzTVnD0ttNTDMjL8bN
        N9TwUGv1L6In2spyuGrPRRGI3Q==
X-Google-Smtp-Source: AFSGD/WEXatUWHwd3ZH9l3h/2iqTL4Fn38VcneXiIZNJAi5VuA8lKASXmABx1ourawK0k7mproSCXg==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr29229207pls.71.1543273951868;
        Mon, 26 Nov 2018 15:12:31 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j6sm2128625pfg.126.2018.11.26.15.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:12:31 -0800 (PST)
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
Subject: [PATCH v2 1/7] dt-bindings: msm/dsi: Add ref clock for PHYs
Date:   Mon, 26 Nov 2018 15:11:53 -0800
Message-Id: <20181126231159.122298-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126231159.122298-1-mka@chromium.org>
References: <20181126231159.122298-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the PHY drivers to get the ref clock from the DT.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- add the ref clock for all PHYs, not only the 10nm one
- updated commit message
---
 Documentation/devicetree/bindings/display/msm/dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
index dfc743219bd88..b0485559a719c 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi.txt
+++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
@@ -106,6 +106,7 @@ Required properties:
 - clocks: Phandles to device clocks. See [1] for details on clock bindings.
 - clock-names: the following clocks are required:
   * "iface"
+  * "ref"
   For 28nm HPM/LP, 28nm 8960 PHYs:
 - vddio-supply: phandle to vdd-io regulator device node
   For 20nm PHY:
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

