Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E5DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D445A214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gB36B9li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D445A214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeIQGXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:23:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37907 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeIQGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:23:08 -0400
Received: by mail-it0-f65.google.com with SMTP id p129-v6so8907573ite.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zB8Jcp/mlbxi5uhj/a+RaYV9WoQKeS679GNjqNj80tA=;
        b=gB36B9li12NczVqQHD5LYzfwpoA4QMXRVwKdn6xYF6raTMsU56f54FX9mIstzlYK8I
         w3Zi6OLHTiyPf/5nPZq7dwGygmeFaVDF2toPBGxevzYCeCRYDTj4yvuKI1pINrod0ygc
         7duoPq19MXWEqXlwXYeBXny4ZM/150P2oQw24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zB8Jcp/mlbxi5uhj/a+RaYV9WoQKeS679GNjqNj80tA=;
        b=ApwMr+mlOCN93ATGgOVx7rSswExuj+bR0S+l2G5/s4JFBlBM35vBfdJLObqFQXIH4Q
         xxzliVu2E+z2/O19/49isOGhjXCFEYjHaU5DvkRYYv6D3pYcC+qj7DtI4Qvs83kO3tE9
         5a+md3Pf6q92oCigpJVi8AdNO4f92OntHdCRtAsri6Mj3h04rQK8LYlbXpcsr6QyraSA
         dJIrsI2hKnGC2usBjyRmvRVr1S4iqpN3Dxbv1IlVEn2sF6fj52VLkM+plgkpbUzbDC/i
         +JgiuQUPeAdYE5Yad/exfcSvU28+dFME83VR2kw5cu1dKRc9uy7SlXjDZUQe4R8Vkx7G
         UMcQ==
X-Gm-Message-State: APzg51CdRZPVTv7YXxi5F1K1dRl4zeQcOQFlGPr4InfW2CLmpH7zOPdt
        usMWE1tch5Rq4ZS+u91R3uBwwQ==
X-Google-Smtp-Source: ANB0VdYGTvDHjFxRsbPZkbxqTMhxu3+pq8IZ/vwnM/VnzpntfCfOm6JZjlxRbLHKp/6BLAow/IRM+g==
X-Received: by 2002:a02:4306:: with SMTP id s6-v6mr20655931jab.140.1537145895018;
        Sun, 16 Sep 2018 17:58:15 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id f64-v6sm829972ite.4.2018.09.16.17.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:58:14 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 10/14] ASoC: dt-bindings: Add WCD9335 MBHC specific properties
Date:   Sun, 16 Sep 2018 17:57:23 -0700
Message-Id: <20180917005727.32728-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add new bindings required to support MBHC
(Multi Button Headset Control) block in the codec.
This block is used for jack insert/removal detection,
headset type detection and 8 button press/release events.

All these properties are very much specific to board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 5d6ea66..a95a8b4 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:
 	Value type: <string>
 	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
 
+- qcom,mbhc-vthreshold-millivolt:
+	Usage: Optional, only required if headset button support required.
+	Value type: <u32 array>
+	Definition: Must contain an array of 8 threshold voltages in mV for
+		 8 buttons detection on headset.
+
+- qcom,hphl-jack-type-normally-open:
+	Usage: Optional, only required if headset button support required.
+	Value type: <boolean>
+	Definition: present if hphl pin on jack is a NO (Normally Open).
+		If not specified, then its assumed that hphl pin on jack
+		is NC (Normally Closed).
+
+- qcom,gnd-jack-type-normally-open:
+	Usage: Optional, only required if headset button support required.
+	Value type: <boolean>
+	Definition: present if gnd pin on jack is NO (Normally Open).
+		 If not specified, then its assumed that gnd pin on
+		 jack is NC  (Normally Closed).
+
 - vdd-buck-supply:
 	Usage: required
 	Value type: <phandle>
-- 
2.9.3

