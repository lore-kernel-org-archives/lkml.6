Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06F8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80278218A4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b3qeFX1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfAKXCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:02:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39143 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfAKXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:01:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so6915921pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eIc4oeKz2RJk2pso4UuY5Z1RPzK8cIkZNxwIDy9xKCI=;
        b=b3qeFX1S2rZkkGN1SceDlcs8eGljxazkI9rDIfxpxEwFZrBjNzlCBPxOAUu2IVtbld
         uyvqLOp/stpTpUaHzzDHrLp0j2ltHD3NgnOB/vyeX6M532FXmzkVyJI7cXvJFn2TjegL
         gOHN6PwV5EWJnBT5ezyEbIxh+KYv4wjY0VKW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eIc4oeKz2RJk2pso4UuY5Z1RPzK8cIkZNxwIDy9xKCI=;
        b=ZgN+f0TXP5PYTEZ6tTW+vrymU3fY7f/AdD80wepYUjQo9Bo2VjxeZXHZU2a+DQkTu4
         UDoy7Pqn248nxxfx0Qwx0QRpyKuqxAKh90bWTmmimA0lCBH1NIrq4MOCJQ+Cnq+BJo62
         9Rnk1egcvrCVqOrHnqI0uJHDmaJprqOrxJSYSg4p3zCbcjMmKzsmNg8c27Nfrn/A+TX8
         ecftZR2qhV5bxDQz4X2F67pNJU9ulLWix5jeePpJw4C2shomqvR0uS9OSirGR0jZnpQS
         z/Qvp0doXlXPZhw8Saxv3oLdEH6sjeMopgy98bMWqGSdmIu+rrTPj5H8lQ7muGgOczsN
         YaOg==
X-Gm-Message-State: AJcUuke+YuDrH1NDrJGF8rQ/B4+VBmR5b7WWAYGaa1TgV66GaJfG1JMM
        IDr6oO8FfDZi3+dGDfaLpTguvQ==
X-Google-Smtp-Source: ALg8bN6dOyIPlWt14PukLlJ1eMDaKkoS2SQAx2b5gNoHeBoRCSUFkL1HRZ4o89fkqTjlRvd5Mvm3wA==
X-Received: by 2002:a63:d846:: with SMTP id k6mr15337476pgj.251.1547247717574;
        Fri, 11 Jan 2019 15:01:57 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:01:56 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/8] dt-bindings: phy: qcom-ufs: Add resets property
Date:   Fri, 11 Jan 2019 15:01:23 -0800
Message-Id: <20190111230129.127037-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a resets property to the PHY that represents the PHY reset
register in the UFS controller itself. This better describes the
complete specification of the PHY, and allows the PHY to perform
its initialization in a single function, rather than relying on
back-channel sequencing of initialization through the PHY framework.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 Documentation/devicetree/bindings/ufs/ufs-qcom.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
index 21d9a93db2e97..985f5e99ab332 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
@@ -29,6 +29,7 @@ Optional properties:
 - vdda-pll-max-microamp : specifies max. load that can be drawn from pll supply
 - vddp-ref-clk-supply   : phandle to UFS device ref_clk pad power supply
 - vddp-ref-clk-max-microamp : specifies max. load that can be drawn from this supply
+- resets : specifies the PHY reset in the UFS controller
 
 Example:
 
-- 
2.18.1

