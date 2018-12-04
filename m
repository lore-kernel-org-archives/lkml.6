Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686C8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291F320834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ihoyobrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291F320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeLDWnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45481 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLDWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so9002721plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rk6X5pKnxV95z6KQvKq1Hv1+znClMJzYhnOq13KHZuc=;
        b=IhoyobrcuCM4RaW1fpG9q9N1ff+E1dQNkDDD3sHYVVahH4x/LEwQWG9mBd8bDj3ckh
         xXYFuAPBk7FF3lPbXa4sF41kJ4Fm/9Bh5tD13bFu8pB8FPTpfrA/4lhR+bSM4FJeI+XE
         VokJrDBBGWJWk6bHurSUY6xSy4MDgKYszRr0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rk6X5pKnxV95z6KQvKq1Hv1+znClMJzYhnOq13KHZuc=;
        b=msink9K0wDowsErLL9HvCcGU5v5HHfkbpCtHKF5+j3pw6OSBQRpoaGZtnoxqJ9fbBL
         q8PdCWNHN9G0y+W15eUwAkg5+RaU79mnErlLSbxpj9a/djdm+OS9/oG9mhvV1K/eTf2v
         HTMckpubRfZdt0juiH4RtHiFWm1G+oBsHda6vnNfI0GOrU6e7SIvLem80PCVvKH10qbn
         reu5p4wV6JqkJL1QkAjI447qfGyp02f32LkKQB4OZZ5r97MG5a9fFjilSktYMvL80BZe
         wJ6PO1/fRFOxrnYLPXNBDmOg9iheJc164mpD9i4eOmh8kgCi6XUUNX5rOC7q8PHtMVm3
         VRAg==
X-Gm-Message-State: AA+aEWYUgx68mL6uv4zCu/D9e3G5s0xDmGV6Nv9/uSpOpwVmr71kIMRQ
        KOiE4utV7jR0f+7ak5bWUtHqUw==
X-Google-Smtp-Source: AFSGD/URXNhqlYca2QpaYxQuQH4XXLrFFJeA1nn2YVQk1aHia8xdQu8XHvTTY/m1IGgGQGuz76/3iQ==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr20853810plp.69.1543963394140;
        Tue, 04 Dec 2018 14:43:14 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:13 -0800 (PST)
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
Subject: [PATCH v4 1/8] dt-bindings: msm/dsi: Add ref clock for PHYs
Date:   Tue,  4 Dec 2018 14:42:27 -0800
Message-Id: <20181204224234.62619-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204224234.62619-1-mka@chromium.org>
References: <20181204224234.62619-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the PHY drivers to get the ref clock from the DT.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Chnages in v4:
- added "Reviewed-by" tags from Stephen and Doug

Changes in v3:
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

