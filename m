Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72276C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180BC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAHerfIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180BC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbeGSOFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:05:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46592 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeGSOFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so7429951ljj.13;
        Thu, 19 Jul 2018 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9w9JS9k45Mkm5m6z6QbcilGriIHYUaz9xF/Kh7/wMsg=;
        b=EAHerfIFmDkA4tYulL8XOj7zSQ/Tj5C9ju7Rz0va8KSfSrWFzC4ZcgcllmTOujnfca
         ZUBE28NQ/q3xnoxlixGXAomAq3892SYnNp3FgpQxQTL7dbivnpf+y5NhRs4VgDzEP2rW
         gzWs0S9iYoFCfrl5hUlYxknRl0axXRiYC/+7c693cUZ0G62cKBYsLFoDGSyJi46Z6VFT
         sew2kvNHc/qbWx4uf8+YIP/OkxrlevkDmPfO4jNIHFig9NcHKCEnG/zAEzyEl3SoHW3P
         jFnfjUdGQ9V/bWrvd5S8JBG5PH3W0VYBNGT/vF2BwCvikJzYr+h1YAJQiBklwLxesPCq
         5M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9w9JS9k45Mkm5m6z6QbcilGriIHYUaz9xF/Kh7/wMsg=;
        b=Bymxq2hZMT0+OWf75kuXZfKm3ynGm0WNzn499mr7R1l93CgQMnxVrWHvVi5RvTCo2+
         ldMRnSDuZ4yiVJa6Sg8nUugGZPxs+WQ7JexbYqCpfm+shsdZ+jc6JjovcQ/+SWwdMzu1
         ZF3LPWNpRxE+VOjIn7FpIP9x/S3hx2suhLOtuKXn/CTZtKKNbsKzkBIRyOwljRfMzrHw
         J4xAqPHolGfsfs6nsIdcBCFNbtS+Wtr7z4EExjDNRn5Tw2qUaDpQe/ERzwRUjLLSJuyK
         0Dq1sNjlmpM88bKQfj1SjPwgxtHNk5eGOwUunYHX9a8pT8ZpjG1zRfZr5pFzXiC/AB+0
         X+wg==
X-Gm-Message-State: AOUpUlGk+hC0fZPBTEl5JYaoaZV54qUZ8GikpSc9y9Dgl6cFd8buMep7
        yfFNyj36KQxPrfq46a7Ws0o=
X-Google-Smtp-Source: AAOMgpeUJj0VElUl7eydUGd2K1JU6oGOLSPyPgADmuSi2b4wZult1THA8Th28ZC341I3ndOsxedX/A==
X-Received: by 2002:a2e:5c4:: with SMTP id 187-v6mr7444933ljf.28.1532006552285;
        Thu, 19 Jul 2018 06:22:32 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] dt: bindings: tegra20-emc: Document interrupt property
Date:   Thu, 19 Jul 2018 16:21:25 +0300
Message-Id: <20180719132132.16153-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719132132.16153-1-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMC has a dedicated interrupt that is used to notify about completion of
HW operations. Document the interrupt property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
index 4c33b29dc660..a6fe401d0d48 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
@@ -10,6 +10,7 @@ Properties:
   and chosen using the ramcode board selector. If omitted, only one
   set of tables can be present and said tables will be used
   irrespective of ram-code configuration.
+- interrupts : Should contain EMC General interrupt.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -20,6 +21,7 @@ Example:
 		#size-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
+		interrupts = <0 78 0x04>;
 	}
 
 
-- 
2.18.0

