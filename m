Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722F9204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eS0Vn+aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722F9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeJYQ7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:59:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44662 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJYQ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:59:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2-v6so614862pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aylbF+KphT/AvettPMbEwjRWJ1QIqako4887YEXm61c=;
        b=eS0Vn+aL1jT9oV9FcXRiSVx+ak9a1dP4AoPNp/aj8EOcLhehdHLoJ4fa2ZGb9cSeFq
         WA6sanDVxrGErQ1Avd58Z/W4GqbRMyIgjMp9BOmakA3v3OPwkbk4OQeexvjLPrDvqqni
         bFH9Av/1POALP5FTEFlfSoFdAFSJ+PS9OZbFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aylbF+KphT/AvettPMbEwjRWJ1QIqako4887YEXm61c=;
        b=pDZJwVttKdjwt0YNL+1ArFt/zjN8hCyo9kuB9ArCttV9O5prLng2jb6Uvm6Mmnffr6
         qcUTD0rrM1RejNWFASYO1ISnPhok9gjOpxAg8Qc7fbVEEuY+arBd+iaB+ZW4l5LnHEnC
         3ZHM4wD7/K7nlZ1ZE8i7aaFAmy0B2AIsjO+I7WeQlB8DU/loUU01WZXFN9E2gdICNxmb
         kOKd4HFrGlQWkm02T9bUegiLLPcI8f3gesRKbeuDYrJXvEctZyHxcAbRZqG4cm06ZhNf
         KmDm4LIA2pGxc9HSAG3xs0dxys0wtT3nJJEL21i8LSoxebwgIimbiXhSYAQfdGn8e6Yu
         YXvA==
X-Gm-Message-State: AGRZ1gILuOU2HOcjl8mcA6wFfwmd9u0rl/tjdfxb3+nQROUQNOGp+61P
        XzqqEEF41eOyVk7hLeuhV5elNw==
X-Google-Smtp-Source: AJdET5f56cD/cq5xlFx6xsPt7ylBeQ5M5cXj9ooBtpUEGdZ++37KtN6gilcuPtAiTdri27tNEyPGcA==
X-Received: by 2002:a62:8787:: with SMTP id i129-v6mr627413pfe.150.1540456079722;
        Thu, 25 Oct 2018 01:27:59 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id x13-v6sm20624892pge.13.2018.10.25.01.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 01:27:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
Date:   Thu, 25 Oct 2018 13:57:51 +0530
Message-Id: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example text says the capacity value should be 446, while the
example have it set to 578 instead. Fix the mismatch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 9b5685a1d15d..7a0d6b429c8d 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -61,7 +61,7 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
 Example 1 (ARM 64-bit, 6-cpu system, two clusters):
 capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
 supposing cluster0@max-freq=1100 and custer1@max-freq=850,
-final capacities are 1024 for cluster0 and 446 for cluster1
+final capacities are 1024 for cluster0 and 578 for cluster1
 
 cpus {
 	#address-cells = <2>;
-- 
2.19.1.568.g152ad8e3369a

