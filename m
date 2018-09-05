Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE79FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908CC20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVPDI/3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908CC20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeIEXGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:06:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIEXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:06:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so7070051ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7cGGiOPPuQSfMnSWLlFn9j+Wv4tI6/R6usmoTUuIUo=;
        b=TVPDI/3r87k31Mu7OJelf0zrq6HON92qyPFj47h3TliJru8e3OOAB6sNDHpmow0c9f
         +//nZbF6w2m0guVJWcolUXXIhE6PFP9au9vCSKNBiYz5xfvoZzh9BEDWR+0Yd/x9YyP6
         RmaoA0+/2++1cq+NEi25TqqeySiRHBXSwAID0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u7cGGiOPPuQSfMnSWLlFn9j+Wv4tI6/R6usmoTUuIUo=;
        b=r+GPujlwHjFNUx+DF4WVNmvAJ+uGttLn8QqCalO9cXjKlHi9Vhjeatm3TulZIyWaKB
         9YAEj3m0ZArBpqxqWx83jcV4efNUEaMEX8v3WdnQyGryHxIfXHL3aJB5BZX8yTwQNx57
         MqRyQE38X2+sPnU87+xxV8c1SuNeQ8D8EioOP/RgU3XtjTTQ1IZSjTO409fNa2ak7ayQ
         y6otr2bP7fxWUJt/ynz0dA/wJj7DItQ4I88p2p3kvPnixnYZqTEsiew92KTyx8G+lduf
         bz5QjUopK2FIPcIK8bYZxHch2wK4b/oh1VNc+vW9t9zkewdDlTduYVeLdi7N9Q1cYR9u
         XW7A==
X-Gm-Message-State: APzg51BdklYXv2NTD2lgyGSXUdXcjFEpU+NDrJqWJoBmIvov55+0UtlJ
        tLAnMT8jlzZDXN+DiG+zSDXT3A==
X-Google-Smtp-Source: ANB0VdbVZmqJpitfUMjUBDB8mQOO7T9EcgYgyNz0xFW1IXuFCREg3MAqRZrPeBSgD3VyI6RSMgha1Q==
X-Received: by 2002:a2e:240c:: with SMTP id k12-v6mr17632439ljk.135.1536172527663;
        Wed, 05 Sep 2018 11:35:27 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id r1-v6sm433169ljr.81.2018.09.05.11.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 11:35:27 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: msm8916: Drop model and compatible
Date:   Wed,  5 Sep 2018 20:35:16 +0200
Message-Id: <20180905183517.9390-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905183517.9390-1-niklas.cassel@linaro.org>
References: <20180905183517.9390-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DTS board files should always specify model and compatible.

All DTS board files that includes msm8916.dtsi
already specifies model and compatible, and will thus
override the model and compatible in msm8916.dtsi.

Drop model and compatible from msm8916.dtsi,
since they are only a source of confusion.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b8990d62..726a45960742 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -18,9 +18,6 @@
 #include <dt-bindings/thermal/thermal.h>
 
 / {
-	model = "Qualcomm Technologies, Inc. MSM8916";
-	compatible = "qcom,msm8916";
-
 	interrupt-parent = <&intc>;
 
 	#address-cells = <2>;
-- 
2.17.1

