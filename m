Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C95DC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0868821470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KYMFzyXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0868821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeJMFLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:11:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37621 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeJMFLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 01:11:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so6416576pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/2xvSJDGaTwmEZWVkDTPm9IrKZ9HQDc62jBchJwo+4=;
        b=KYMFzyXT0O1cMipC91ANU2CK6QJThBYI/2AiYRorDi/oWFql0YcjeJ6JhNlU/YLNR7
         ZU04ZTwh0fa22n1peHsifRloXqS134UWVrojeF3FWrCVOx3Noq1TwGAh/x0AwYOP8KLt
         QWmuzeZFdiLcDrVpti21FgZnc8E+YDDp/IeEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/2xvSJDGaTwmEZWVkDTPm9IrKZ9HQDc62jBchJwo+4=;
        b=ssRwFrSpIaLV2KxUdN03nZ9+omvXTPTbdXHxtxhKp2PFDBzvT786GW5K+5ZmKgohnd
         iAS5t5Vj8mSPlKHuTAm5Gg9PBcF3KBsd24SSRuMzC+cYADwg8tNSSfcFYNJ+lRwdC3Ft
         gygFl8GXTqUVPmVo0fV09QPA8KsiLSxIASenvESe1UdOewbvgX8T3HHF6llWLTQeUgLL
         ObDlYFk3FsslER/sNJ5ex6j2dE+69F3A8jzHAFBxwp/a7FSe176pWjFtGy93b+oLh7Av
         1OX2rQOrZTmSkJuUv+NeY5J9WHmGTOrsYfuzuOI1SYvWH7LVEepfl+B2Uybx7DG3EE0Q
         8ZKg==
X-Gm-Message-State: ABuFfoid/0BYhLjJN3GdnR0gn8lgIjATanD1ZQCio8/7xVctzaFugwBw
        4nB3fOHgIbu0crKsfZVRCwAPKg==
X-Google-Smtp-Source: ACcGV60or6xUaPcu7Tcu2Ve8+TqQEuZoGbzircERRucHHLvRVomnPNvQYSfR3pLETstTw2VhL/MuRA==
X-Received: by 2002:a62:3a84:: with SMTP id v4-v6mr7649099pfj.118.1539380213472;
        Fri, 12 Oct 2018 14:36:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id q127-v6sm8240570pgq.19.2018.10.12.14.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 14:36:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, sayalil@codeaurora.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        asutoshd@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] dt-bindings: phy-qcom-qmp: Fix several mistakes from prior commits
Date:   Fri, 12 Oct 2018 14:36:32 -0700
Message-Id: <20181012213632.252346-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Digging through the "phy-qcom-qmp" showed me many inconsistencies
between the bindings and the reality of the driver.  Let's fix them
all.

* In commit 2d66eab18375 ("dt-bindings: phy: qmp: Add support for QMP
  phy in IPQ8074") we probably should have explicitly listed that
  there are no clocks for this PHY and also added the reset names in
  alphabetical order.  You can see that there are no clocks in the
  driver where "clk_list" is NULL.

* In commit 8587b220f05e ("dt-bindings: phy-qcom-qmp: Update bindings
  for QMP V3 USB PHY") we probably should have listed the resets for
  this new PHY and also removed the "(Optional)" marking for the "cfg"
  reset since PHYs that need "cfg" really do need it.  It's just that
  not all PHYs need it.

* In commit 7f0802074120 ("dt-bindings: phy-qcom-qmp: Update bindings
  for sdm845") we forgot to update one instance of the string
  "qcom,qmp-v3-usb3-phy" to be "qcom,sdm845-qmp-usb3-phy".  Let's fix
  that.  We should also have added "qcom,sdm845-qmp-usb3-uni-phy" to
  the clock-names and reset-names lists.

* In commit 99c7c7364b71 ("dt-bindings: phy-qcom-qmp: Add UFS phy
  compatible string for sdm845") we should have added the set of
  clocks and resets for "qcom,sdm845-qmp-ufs-phy".  These were taken
  from the driver.

* Cleanup the wording for what properties child nodes have to make it
  more obvious which types of PHYs need clocks and resets.  This was
  sorta implicit in the "-names" description but I found myself
  confused.

* As per the code not all "pcie qmp phys" have resets.  Specifically
  note that the "has_lane_rst" property in the driver is false for
  "ipq8074-qmp-pcie-phy".  Thus make it clear exactly which PHYs need
  child nodes with resets.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index adf20b2bdf71..fbc198d5dd39 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -40,24 +40,36 @@ Required properties:
 		"ref" for 19.2 MHz ref clk,
 		"com_aux" for phy common block aux clock,
 		"ref_aux" for phy reference aux clock,
+
+		For "qcom,ipq8074-qmp-pcie-phy": no clocks are listed.
 		For "qcom,msm8996-qmp-pcie-phy" must contain:
 			"aux", "cfg_ahb", "ref".
 		For "qcom,msm8996-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref".
-		For "qcom,qmp-v3-usb3-phy" must contain:
+		For "qcom,sdm845-qmp-usb3-phy" must contain:
+			"aux", "cfg_ahb", "ref", "com_aux".
+		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
 			"aux", "cfg_ahb", "ref", "com_aux".
+		For "qcom,sdm845-qmp-ufs-phy" must contain:
+			"ref", "ref_aux".
 
  - resets: a list of phandles and reset controller specifier pairs,
 	   one for each entry in reset-names.
  - reset-names: "phy" for reset of phy block,
 		"common" for phy common block reset,
-		"cfg" for phy's ahb cfg block reset (Optional).
+		"cfg" for phy's ahb cfg block reset.
+
+		For "qcom,ipq8074-qmp-pcie-phy" must contain:
+			"phy", "common".
 		For "qcom,msm8996-qmp-pcie-phy" must contain:
-		 "phy", "common", "cfg".
+			"phy", "common", "cfg".
 		For "qcom,msm8996-qmp-usb3-phy" must contain
-		 "phy", "common".
-		For "qcom,ipq8074-qmp-pcie-phy" must contain:
-		 "phy", "common".
+			"phy", "common".
+		For "qcom,sdm845-qmp-usb3-phy" must contain:
+			"phy", "common".
+		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
+			"phy", "common".
+		For "qcom,sdm845-qmp-ufs-phy": no resets are listed.
 
  - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
  - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
@@ -79,9 +91,10 @@ Required properties for child node:
 
  - #phy-cells: must be 0
 
+Required properties child node of pcie and usb3 qmp phys:
  - clocks: a list of phandles and clock-specifier pairs,
 	   one for each entry in clock-names.
- - clock-names: Must contain following for pcie and usb qmp phys:
+ - clock-names: Must contain following:
 		 "pipe<lane-number>" for pipe clock specific to each lane.
  - clock-output-names: Name of the PHY clock that will be the parent for
 		       the above pipe clock.
@@ -91,9 +104,11 @@ Required properties for child node:
 			(or)
 		  "pcie20_phy1_pipe_clk"
 
+Required properties for child node of PHYs with lane reset, AKA:
+	"qcom,msm8996-qmp-pcie-phy"
  - resets: a list of phandles and reset controller specifier pairs,
 	   one for each entry in reset-names.
- - reset-names: Must contain following for pcie qmp phys:
+ - reset-names: Must contain following:
 		 "lane<lane-number>" for reset specific to each lane.
 
 Example:
-- 
2.19.0.605.g01d371f741-goog

