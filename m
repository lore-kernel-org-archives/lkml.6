Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1FEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176B42087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwBGNfoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176B42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeKLU3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:29:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43005 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeKLU3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:29:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id u5-v6so3444134wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9jOFxZiKTIIWq4Br0AChP52KUuFe4CotZhj3un1D/Q=;
        b=IwBGNfoqczPqk8AolB/96Aqluglps9jIs2FvJ3R+PcOUMZOAX/FhnUoquTqOvHOi0W
         IAujV0a/h0hjEdBtMqgn9+KXYCci2l2+lOVsYKJbQX6l9N0mlFQW4ayLdxTOaj5upr5S
         GSA+reX0ovcWSk+Oo5EMKfJMvdl7AMdnf7mk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9jOFxZiKTIIWq4Br0AChP52KUuFe4CotZhj3un1D/Q=;
        b=L7yAUpgrND7bZqZZVxul3m9LbvDuxx4sxrenj2sUm+PTtiA1Ksyd9Crl1trZttiwUq
         Y4iw7YVUWLOUfMlKV5qkOO+bej1CS+VC3YIaCcYKUZ0FI6lx2aRsxACt0XjLSOv3Aeap
         fs7VTq9g8FIxazJtxICz9dwcF4e0DLhoVma+B7WbWub4Gbt4TRch/iT4PtcZdhbPjqlF
         l8X4wTgFx0eXk5zt7xu915F3cLKK4DJT3HkMxd3r9DPlwbrqPcFTOYr1pAbpT6qQx4YF
         VUqc5TO4dlAHufQOhMJkBAZ9lry2BbP6KTNkWQaKJfGxYlOxEDDjktVvtQkZjF5m5KP3
         IZTg==
X-Gm-Message-State: AGRZ1gLJl4W6t+Nsu4u8MhjK+TMVs7MxXK7EvJK9Q3rHexQv04eKGTTm
        736qaM/jU0p1QZ+0pbt+VHWccw==
X-Google-Smtp-Source: AJdET5e966ULouYu+p5Nn+TB9zIcJOtnJsaEEkCEf7VF9tqjehAKwBT60a2WfterDKXAFH4wBLIpeQ==
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr404788wrc.131.1542019017967;
        Mon, 12 Nov 2018 02:36:57 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id z17-v6sm13747187wrm.65.2018.11.12.02.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:36:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v3 1/4] dt-bindings/gic-v3: Add msm8996 compatible string
Date:   Mon, 12 Nov 2018 10:33:37 +0000
Message-Id: <20181112103340.24702-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
References: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
There are many devices out there with this restriction in place
and there has been no update to this firmware since last few years,
making those devices totally unusable for upstream development.

IIDR register value conflicts with other SoCs, using compatible seems
to be the only way to apply quirks required for msm8996 based SoCs.

Without this quirk many qcom SoCs (atleast 3 that I know) are
unable to boot mainline.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 3ea78c4ef887..b83bb8249074 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -7,7 +7,9 @@ Interrupts (LPI).
 
 Main node required properties:
 
-- compatible : should at least contain  "arm,gic-v3".
+- compatible : should at least contain  "arm,gic-v3" or either
+		"qcom,msm8996-gic-v3", "arm,gic-v3" for msm8996 SoCs
+		to address SoC specific bugs/quirks
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source. Must be a single cell with a value of at least 3.
-- 
2.19.1

