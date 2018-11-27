Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4BBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BB720645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W4Xnc0SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BB720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeK1GXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:23:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35716 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeK1GXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:23:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so5801690plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/OwqtmgRAMd4U0V7CJeRYYW1Xv+UBnENuWIkRgDFsI=;
        b=W4Xnc0SALXHsz9j4ByrOWWy847eCAQ6Wd2A84EDRsWc7ccN1/IT4QDaNoKSMM0TDJa
         R+Mg65g8yCPFXcGXoa6IlbEwhL4/q7NUCCY2vfgBJZAl+rRoGp59qH6KwlDM28gUYEHK
         gwApdT7YOjXtHZ3iCv75nd+PnNU8xhwDwErA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/OwqtmgRAMd4U0V7CJeRYYW1Xv+UBnENuWIkRgDFsI=;
        b=fH1qdTBQNYMTkBCOW+Bixa93VJYr1Xt6VgXjRojjNep5uNjHjfzC8EpKhCp4IKNsQ4
         tg4zRLO5/kq2HKlExP3rF/7hVdFPh5KCuyMs2JIOBqwEnT5wOS4xyaF2h3pGBytp4CrY
         gZjEzlXCULKd6sBtD0zZz8fEBRf4VNUOygIgSZzVTSx2XoUP0tnUMzGy5fqy/jWOHu5F
         j3xwwcWn1oWgwHghFhhEVKUpHp09A8l0R/VTPKcL5GU9yuk2TXeiFm/LfKIMfUBcbVw9
         028c8oqdSBlqsqPTEGpZdc1vUj51lr1tUdQUj2aVPw1Sz220AlRd6qkUO6Ag7JTqeniy
         Yncw==
X-Gm-Message-State: AA+aEWaYx23+4SmckjPF/CkonRIoX3kkrbZHQM7Vu8gXpbU1tVetfJQu
        luMdIX97MTSgaB5a7E2vWhv+Gw==
X-Google-Smtp-Source: AFSGD/Xjp/XKfkBczfxJMIw5g2S8f8QQZtyqrvf/+O9/QAWxHFzXJV+OGoclwbuglCmki3KhqcR6Ow==
X-Received: by 2002:a17:902:b701:: with SMTP id d1-v6mr32075209pls.29.1543346692646;
        Tue, 27 Nov 2018 11:24:52 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id i189-v6sm5543091pfc.16.2018.11.27.11.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 11:24:51 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Require #reset-cells in sdm845-videocc
Date:   Tue, 27 Nov 2018 11:24:43 -0800
Message-Id: <20181127192443.136158-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #reset-cells was listed as optional in the bindings for
qcom,sdm845-videocc.  There's no reason for it to be optional.  As per
Stephen [1]:

> We should update the binding to make it a required property. It
> doesn't make any sense why that property would be optional given
> that the hardware either has support for resets or it doesn't.

sdm845 support is still in its infancy so we shouldn't be affecting
any real device trees by modifying the bindings here.

[1] https://lkml.kernel.org/r/154330186815.88331.12720647562079303842@swboyd.mtv.corp.google.com

Fixes: 84b66b211603 ("dt-bindings: clock: Introduce QCOM Video clock bindings")
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/clock/qcom,videocc.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.txt b/Documentation/devicetree/bindings/clock/qcom,videocc.txt
index e7c035afa778..8a8622c65c5a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.txt
@@ -6,8 +6,6 @@ Required properties :
 - reg : shall contain base register location and length
 - #clock-cells : from common clock binding, shall contain 1.
 - #power-domain-cells : from generic power domain binding, shall contain 1.
-
-Optional properties :
 - #reset-cells : from common reset binding, shall contain 1.
 
 Example:
@@ -16,4 +14,5 @@ Example:
 		reg = <0xab00000 0x10000>;
 		#clock-cells = <1>;
 		#power-domain-cells = <1>;
+		#reset-cells = <1>;
 	};
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

