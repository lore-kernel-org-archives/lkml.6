Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007B1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A598F208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvN4zSs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A598F208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeFROOq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:14:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39218 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934781AbeFRON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:13:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id w12-v6so7592516pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8RDUlxGDYSxrzGB+wTEnrKVLaRdZtvr9TfOeKNnSuM=;
        b=RvN4zSs4ToandhgB6UTVV2h54/SmWYqlxbhFQhRt0loseWh88EYV1L69BM06FarSz2
         GtXnYtOfNwb2h1i36IAXGLmaPaCWjavVV70a0gLocuIH4s9+R//rPQDboX31yNcJsSpI
         5aB3OEZoD1ZB0x1rKHRuh+9peidmOB74NB1WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8RDUlxGDYSxrzGB+wTEnrKVLaRdZtvr9TfOeKNnSuM=;
        b=K66MfTRxLd2alcZemcO3Zchcp+POmaUwbcUc3iFMsKbspooKwF5TUJtfdnefbQ29sJ
         Fv2ENqq+ikA0iO3sovPVqVGFqQ08uGw/qzgdxioVi7pMuM2jPnG4PRUG7ouEaOUSE+BU
         8TW4bqP6Dhh7iJv8mISz8zj45iSIKbSC8OSGIq6ysL/gt3Hx9HS4yLDDU+JIr9a+mxbN
         T8RvFB7eBpPYmYjt/jWT/6Nc+LQhLbHoWGDx5sBTxRnq+FgDLTVpNaXG1uVmHsG2SlJV
         8zj8lDpybhoZpIoZsHqafrqS/n1A+qHDbOlplvTd0IavXrkKAyv2BJwClsqoDp1ukcWp
         RLww==
X-Gm-Message-State: APt69E0VfpTFj6hKWd3t1+CA7vgwG2EhBW0kgwx7uD5dY8X2dRONrKr7
        wYyCJp1mh8P8zdgOQWvjy49G6w==
X-Google-Smtp-Source: ADUXVKLOjtW9dHcqR0+jsnTW+H2UyYKj0RuCxxfLGRyAPDrhvnW7lcFjHZ7eSZpEuKlnGLrl2cqQ4g==
X-Received: by 2002:a62:499b:: with SMTP id r27-v6mr13850789pfi.74.1529331207833;
        Mon, 18 Jun 2018 07:13:27 -0700 (PDT)
Received: from localhost.localdomain ([27.59.118.133])
        by smtp.gmail.com with ESMTPSA id t17-v6sm25813339pfj.75.2018.06.18.07.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 07:13:27 -0700 (PDT)
From:   Vinod Koul <vinod.koul@linaro.org>
X-Google-Original-From: Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/3] dt-bindings: rng: Add new compatible qcom,prng-v2
Date:   Mon, 18 Jun 2018 19:42:58 +0530
Message-Id: <20180618141259.23141-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180618141259.23141-1-vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later qcom chips support v2 of the prng, so add new compatible
qcom,prng-v2 for this.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/rng/qcom,prng.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/qcom,prng.txt b/Documentation/devicetree/bindings/rng/qcom,prng.txt
index 8e5853c2879b..03fd218bd21a 100644
--- a/Documentation/devicetree/bindings/rng/qcom,prng.txt
+++ b/Documentation/devicetree/bindings/rng/qcom,prng.txt
@@ -2,7 +2,8 @@ Qualcomm MSM pseudo random number generator.
 
 Required properties:
 
-- compatible  : should be "qcom,prng"
+- compatible  : should be "qcom,prng" for 8916 etc
+              : should be "qcom,prng-v2" for 8996 and later
 - reg         : specifies base physical address and size of the registers map
 - clocks      : phandle to clock-controller plus clock-specifier pair
 - clock-names : "core" clocks all registers, FIFO and circuits in PRNG IP block
-- 
2.14.4

