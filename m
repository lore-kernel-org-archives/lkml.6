Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB5AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6CC21A52
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XmfVoMdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6CC21A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbeHGH1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:27:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38767 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbeHGH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:27:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so7962588pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 22:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FYmgDqGIYZE7AwVwri2JVn1gQgTGaRcVTGj7r05KcB8=;
        b=XmfVoMdbLXyKZtxynE6K/a+8+EAnv5m0CXInAiPYlq66qPGJPE4tPiTk6rzRLd3ue9
         Q8nAMGvJnjdpacNsKuf9DCUlgm6SP5VT3AoWTf32HQ0OquHIOaR0jJOeF7iUo0WyKHUH
         AhT+pTZC43DFnrKNtqhBZLBHAGIc03pUAADWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FYmgDqGIYZE7AwVwri2JVn1gQgTGaRcVTGj7r05KcB8=;
        b=HYiuHtomqwGzSAfN6B6aaILYtwOOXwNzRJREwEFnidNhXL2HmrvTnulIEHlpyO+Tbn
         9q9T9LrHNZaEN74sGNO62vzExHlry6hHIt8sttAXQGkIb88Fb8QkwfYWEW/PWzHM7tiU
         mJWJCUpXGkT4yy+WEZAtq+wJDfloGewNp3pRhsx5wZkrOwwc0by7SKvYXU74FurSPnUr
         BNA8iGm4RxH0TUsWThx9XyehWeIq7Q42sfi/GD+36VP9Q9J3Pp1xrHCU849aiAJpxV4z
         ozsSR7r7j5qD1TtjqK1MXIJKts2ACVcI4a3UyMF6DmC4yvBignUdkf9haS+lP57JXkl1
         gdtA==
X-Gm-Message-State: AOUpUlGzF+cTs4yM9DxLuSAHgcltGR+fnlSebbVuLSDcEFTlPS7vZ1K+
        obYvCdYLEhNOA2ZOaZ1jBgcmfg==
X-Google-Smtp-Source: AAOMgpfJbqcrmr41soYMJXQeQLIAfYfybwywNg40ZbJDln4ur/Y3IIbCqkG5eBLttsBsSwYY6r/fFw==
X-Received: by 2002:a63:c00b:: with SMTP id h11-v6mr16707570pgg.279.1533618886202;
        Mon, 06 Aug 2018 22:14:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id i3-v6sm373164pgq.35.2018.08.06.22.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 22:14:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH] dt-bindings: phy: qcom-qmp: Cleanup the 'reg' documentation as per review
Date:   Mon,  6 Aug 2018 22:14:12 -0700
Message-Id: <20180807051412.126003-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 8b1087fa3a27 ("phy: qcom-qmp: Fix dts bindings to
reflect reality") landed there was some review feedback that 'reg'
should have been documented differently.  Fix it as per review
feedback.

As per that feedback:
- Subject should have been 'dt-bindings: phy:' which this patch now
  has.
- We should leave no ambiguity in the ordering of 'reg' ranges even if
  'reg-names' are also specified.
- Normally using reg-names is discouraged unless there's a strong
  reason it's needed (like if there are optional ranges).  In this
  case reg-names wasn't needed but the driver already landed relying
  on reg-names so we'll just document it and move on.

Fixes: 8b1087fa3a27 ("phy: qcom-qmp: Fix dts bindings to reflect reality")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 0c7629e88bf3..2b161bf15d5d 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -12,14 +12,17 @@ Required properties:
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
 
- - reg:
-   - For "qcom,sdm845-qmp-usb3-phy":
-     - index 0: address and length of register set for PHY's common serdes
-       block.
-     - named register "dp_com" (using reg-names): address and length of the
-       DP_COM control block.
-   - For all others:
-     - offset and length of register set for PHY's common serdes block.
+- reg:
+  - index 0: address and length of register set for PHY's common
+             serdes block.
+  - index 1: address and length of the DP_COM control block (for
+             "qcom,sdm845-qmp-usb3-phy" only).
+
+- reg-names:
+  - For "qcom,sdm845-qmp-usb3-phy":
+    - Should be: "reg-base", "dp_com"
+  - For all others:
+    - The reg-names property shouldn't be defined.
 
  - #clock-cells: must be 1
     - Phy pll outputs a bunch of clocks for Tx, Rx and Pipe
-- 
2.18.0.597.ga71716f1ad-goog

