Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4EA2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ifh4qIIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4EA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeLJN4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:56:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54356 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeLJN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:56:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so3595789wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ8fgTNKEzlulFo0jglvRy93ay062mbv4LQ6PKEe/gQ=;
        b=Ifh4qIIogkIlOT5ZnX1slKO4f03/6yQT9zBvBopvAkosWoAwy3WBFU9MSAtQ6THa/p
         hL6vDcQsuDjkHyhy0QsSAbZeKmOKoB40v+tO/rMT5PiTYHT2N3JFBiNiteudDC70ASIP
         GRg6lyDod3DRMB4m6tPWOsgfCJrHvUKluEQGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ8fgTNKEzlulFo0jglvRy93ay062mbv4LQ6PKEe/gQ=;
        b=omMzWmVSFZPwkP4Ti9IJPcJ3edd1dnjXFEL9z9IHq2/ymZQKLqRSUYGNY4vo3BsNlw
         DWYjdQO7D/++3/hSw8LV4ysjQSc3YkQcJ4hDLaJePq3VX0r8FxXenf9sh0oldlcs/HfH
         UgXU8Xpq4sSX/LogRN671ll9UmYERz0sUseUt0xbwdDjzrFzqcX6sXYxi7jgPKG5Q64q
         D/CTLJs6pPG1G6KWERFwgAClGeZx1qgkdCjWPYS6cnYUgyr3ZZg65SvpJWwro+bcL7BK
         JItYzvKGkWl9lNFhsBxXarR/XXc13LW7dxuBafbX0spVotHczhOxcHRSaVHnTS5n4IcL
         sF4g==
X-Gm-Message-State: AA+aEWbcW5QGkvJf2DPjoGkG4ZZRW7z0zZbrNgvsmm7Ze+EEYF4+i9rf
        1lCGar20lfqhoczvbEmlHmlrRQ==
X-Google-Smtp-Source: AFSGD/U7Kcu70sbKMqXjj48JO5tvS6LST0JMd4ghPglM1XYQBeYb7USk0thl8srRmlHADDC3AQIrCw==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr10116856wma.123.1544450198145;
        Mon, 10 Dec 2018 05:56:38 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c14sm8612506wme.13.2018.12.10.05.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:56:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings/gic-v3: Add msm8996 compatible string
Date:   Mon, 10 Dec 2018 13:56:30 +0000
Message-Id: <20181210135633.30283-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
References: <20181210135633.30283-1-srinivas.kandagatla@linaro.org>
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
2.19.2

