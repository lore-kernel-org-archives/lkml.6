Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D798C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2021916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xekeLArv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBGLRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:17:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45241 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfBGLRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:17:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id q15so11040561wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbpoBRsypdTGREkLevfYOmN/+f576KJEExTxTQozG1I=;
        b=xekeLArv2SqmtefnkYskRI5SOxiZlgYE/u+IpxrKpPoL9f4dMAk+VWS9YMso+XSKso
         RtzyKMM9rVn9ZnzMy7bBBDx7zPGDa3lVhbbddrjV5QgRscd3qxa0HO5ar6PFMsgOvBH7
         Fp3FyHFPlNBqHO6NqpFw85H/QIXQBE2q1gg/rpq32Pr7YyPFSi5i+cXclkMBSdaSPu+N
         WDCOrIEuvVP60iD2Fzqxx04lYuwvFCAIFdV0Iq7+Mo4LIbbWT02GTpVoLBhfPuWgQrrH
         rSwP/BIsTPKM32+B9mvzgOgDGho6IUV6MvlJlcnnRTsaiS2oRxh2VYlm9/Wr5tKfvDU2
         A0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbpoBRsypdTGREkLevfYOmN/+f576KJEExTxTQozG1I=;
        b=i97NUMAA5Ez9lxwH5HUWE3EhYnGLig0s3wSKIocl6VDB4+Na9VDmPFvJNKm7uHpAfo
         iEl3nsq8l2WeGhJKPxTRiTav0V9gLbH+L1+YJczhcdBG0LjOUeO09/kYEneMfBIa0KcL
         kd+imV40klSZ0RqCaleAtwBjcxx7tlPwI1NrHGmbRqmof+T8H9aEvEwq6mz6sd/fqejE
         jp+l7qkj/89hRaSG0dQzz5F9Qj4AfAmuVIn1fyN638X93cOy/8FYvRymH5CefIqxQ0ny
         AxpCZLCAK07VtnGEBSR89G37bUoiRbP/SVpkM8HhwJt52KntHUUuKqhX0y5KbQxAVzDB
         vJWA==
X-Gm-Message-State: AHQUAuYhct5o6spjfjoER+NXg/MImkhFg5f/sqW0tDU/s50+q07Qb5CE
        q+RppM6D2qBiq3USQJ5iZx4jdA==
X-Google-Smtp-Source: AHgI3Ibyx9sci/B29k7DCAhPNZF6PlgRln+oZkpPg2znflAAlKybEU+QoLbKXKr0XAj6mQA6iRhgJw==
X-Received: by 2002:adf:9123:: with SMTP id j32mr12508598wrj.122.1549538261159;
        Thu, 07 Feb 2019 03:17:41 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net. [95.121.90.42])
        by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 03:17:40 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh@kernel.org,
        bjorn.andersson@linaro.org
Cc:     swboyd@chromium.org, andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: [PATCH v4 1/4] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Thu,  7 Feb 2019 12:17:31 +0100
Message-Id: <20190207111734.24171-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is not used by any driver.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/phy/qcom-dwc3-usb-phy.txt        | 37 -------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt b/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
deleted file mode 100644
index a1697c27aecd..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Qualcomm DWC3 HS AND SS PHY CONTROLLER
---------------------------------------
-
-DWC3 PHY nodes are defined to describe on-chip Synopsis Physical layer
-controllers.  Each DWC3 PHY controller should have its own node.
-
-Required properties:
-- compatible: should contain one of the following:
-	- "qcom,dwc3-hs-usb-phy" for High Speed Synopsis PHY controller
-	- "qcom,dwc3-ss-usb-phy" for Super Speed Synopsis PHY controller
-- reg: offset and length of the DWC3 PHY controller register set
-- #phy-cells: must be zero
-- clocks: a list of phandles and clock-specifier pairs, one for each entry in
-  clock-names.
-- clock-names: Should contain "ref" for the PHY reference clock
-
-Optional clocks:
-  "xo"		External reference clock
-
-Example:
-		phy@100f8800 {
-			compatible = "qcom,dwc3-hs-usb-phy";
-			reg = <0x100f8800 0x30>;
-			clocks = <&gcc USB30_0_UTMI_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-
-		phy@100f8830 {
-			compatible = "qcom,dwc3-ss-usb-phy";
-			reg = <0x100f8830 0x30>;
-			clocks = <&gcc USB30_0_MASTER_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-- 
2.20.1

