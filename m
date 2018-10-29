Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F0C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B851B20880
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4QcNkmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B851B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeJ2SbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:31:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33221 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbeJ2SbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:31:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id a15-v6so3741677pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RZ9FHApH+90jKzx3eFzIgtrpa6PgcJbkx7WWuT0bFI=;
        b=h4QcNkmAY1KJlxXLbVpKirKOIircySyjrVBhw99VhliOHE5iMiIXYAPV+wJVjNoizm
         erZeGDdSwmccg65uQ5rwAISY/O5KolymTm4b0U2th7L0u7x/F33EJ0qGSKK07iaJVR9m
         Vrcmpijg9OzG8gL4mPTeZyTIVXBTrOA3zCQnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RZ9FHApH+90jKzx3eFzIgtrpa6PgcJbkx7WWuT0bFI=;
        b=QIZK7ULZWbGvgPlkr7fa0JHVAHG5561u2suTPCgvlio3smTEIRtimB9dvfDbG+UUK1
         P2D0jy56CPvA/5LcBDnsDdqKhqh99nL7luC1wz64QYz1uzFuPBG9ZFKMD4aDmILIV0Kl
         wqzrweJtJ9srGzLoHrfAp2nS+zb7wmsjEZ49H+S3MKryo6XvxxmLS2MwVgFKqmjeEyus
         vdSmxSuZObGCyBRxVSAWeDBsXZveq5T0Nn7oT3rczHKg7gUvmWxWBHa0BSWis9iPTJ5C
         +3Y4tzopS+7FfsVTWyU+9BdqAaqX0N+xXL1YXcqoMpIPfBf+aUP1yeli9iYM2sLDwZ8c
         ZrHg==
X-Gm-Message-State: AGRZ1gL+zCVAeBkYH2JCNKl8e7tbkX1iSpsIpPVoLFaqTFnE7dNPhIES
        vgcC2m25Xg4e7MSdvj6Uy3zwgg==
X-Google-Smtp-Source: AJdET5cApD6yK8qe+qCer3t7aPJHFl46Z0z1V8X3x/sCRLJCfcOI+ETy7UK/9iP36S8xqW5lkQ4kBQ==
X-Received: by 2002:a63:5308:: with SMTP id h8-v6mr12856854pgb.358.1540806196626;
        Mon, 29 Oct 2018 02:43:16 -0700 (PDT)
Received: from localhost ([122.172.56.94])
        by smtp.gmail.com with ESMTPSA id 124-v6sm13449129pfb.132.2018.10.29.02.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:43:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] dt-bindings: arm: Explain capacities-dmips-mhz calculations in example
Date:   Mon, 29 Oct 2018 15:13:05 +0530
Message-Id: <1cd2594fff3fb54948dcd2af65ae1867dd1c541a.1540806119.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example contains two values for the capacity currently, 446 in text
and 578 in code. The numbers are all correct but can confuse some of the
readers. This patch tries to explain how the numbers are calculated to
avoid same confusion going forward.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- The numbers weren't incorrect in the example, just that it needs a
  bit more explanation for some people.

 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 9b5685a1d15d..84262cdb8d29 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -59,9 +59,11 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
 ===========================================
 
 Example 1 (ARM 64-bit, 6-cpu system, two clusters):
-capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
-supposing cluster0@max-freq=1100 and custer1@max-freq=850,
-final capacities are 1024 for cluster0 and 446 for cluster1
+The capacities-dmips-mhz or DMIPS/MHz values (scaled to 1024)
+are 1024 and 578 for cluster0 and cluster1. Further normalization
+is done by the operating system based on cluster0@max-freq=1100 and
+custer1@max-freq=850, final capacities are 1024 for cluster0 and
+446 for cluster1 (576*850/1100).
 
 cpus {
 	#address-cells = <2>;
-- 
2.19.1.568.g152ad8e3369a

