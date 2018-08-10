Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3343AC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E389A22455
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOUTMHrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E389A22455
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeHJUYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:24:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39697 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbeHJUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:24:55 -0400
Received: by mail-pl0-f67.google.com with SMTP id w14-v6so4341053plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AqR/PqYzzBuT/vbk6GCgvnwim/3ASCroxnBmM/gm6rY=;
        b=AOUTMHrTasJZzVbuTgY9eg1zHstYwmxsU8aQ8ty4UDHLUtHGNvlvKELKFt7SCk6+Or
         0ETnZdlh+E0Nc1B7TxWzUEkS1SwT5tQ8JYgbGUeBtKn5LImLSosJ6BFc5rh+OLAaK7ZU
         6bKiBto9VP1HKU1O/G3rVvQPll1dPMHJ4ZEak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AqR/PqYzzBuT/vbk6GCgvnwim/3ASCroxnBmM/gm6rY=;
        b=Tbv8rP6zukW9u5aNwwfn7l6EczcGZsZjfiNeOE7yZdM4X5cQziC+/Yt6yK9iQEO0st
         aze2tzWc5GxTTHj0VaYMkpqWoV21gOZNjUfFw98gPZQky8y9Em/NTy+CQcieN3B3y6qg
         FvxNB/dN3UxdyJd6PMQpo1tIAy7NH/b1rkwWmLRK5h8/SUDK0miPESCccm15rFdxNOZP
         5jvdLU1RpMUPnOT+mX+aR719XG6guw6Cmg0FdvbOFjbxCovk9kzMMrfjhTl/1XE/jbsT
         coha50tqSWT7fU/O+/wHk9PwPZwf8PSOpvRd3S5qZuqI0P07SUDr09F07tkxlZSXIE4p
         qOZQ==
X-Gm-Message-State: AOUpUlGJbYGVX9K6qG1eCmbgZlK8RG4YgPENsGVtvet3FmC8JpJSh6Au
        mUT77CpCArhD4ykMINBbqFJ+
X-Google-Smtp-Source: AA+uWPxI6Vz9BgrY2OCjB+IcSCE/GPGTKgin4EjLzC89tjlflXhGc7hi1A3N4dU7s8E8eM1bJTXB/Q==
X-Received: by 2002:a17:902:4381:: with SMTP id j1-v6mr7059782pld.104.1533923643153;
        Fri, 10 Aug 2018 10:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id l127-v6sm16981262pfc.55.2018.08.10.10.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 10:54:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/4] dt-bindings: arm: hisilicon: Add binding for Hi3670 SoC
Date:   Fri, 10 Aug 2018 23:23:36 +0530
Message-Id: <20180810175339.25421-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Hi3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 199cd36fe1ba..14f54f569c63 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -8,6 +8,10 @@ HiKey960 Board
 Required root node properties:
 	- compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
 
+Hi3670 SoC
+Required root node properties:
+	- compatible = "hisilicon,hi3670";
+
 Hi3798cv200 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3798cv200";
-- 
2.17.1

