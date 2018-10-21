Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2076CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBAA2083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nolKrCGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBAA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeJVCrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:47:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35530 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:47:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so18774457pff.2;
        Sun, 21 Oct 2018 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1C7x6341gi9POCBcP0SdnBSVOwP5ZFSDAiXUabHa3Pc=;
        b=nolKrCGszriJhyLktF5iZZdKjBD6ronJuQfA4WWs1Hmfs3gm6XAAXj1TcGPWE+ncZ0
         gnuYkg2HmZDX9ztvbDvoJPr6pmOhoZ6kyHNFWO/v1fS4ofiJGui62FBENkmTvf6sIAjJ
         PYzQNncRwqy+hSNj9qmdYHeixiB74f0xV0VASOXRuVdtXEclsdp/EuM9Snpe7TZRSngP
         Im6vaqozx9waU73U8ocIYu7tGBFSUATbAevWIlD7WTYF7kcRXAj0R292UJWyI3xllYEh
         FNIvsuflGxSor3DvhNfBW5irNksKPgxAcQZVXQMAeiYgnbSv6Bfkt/W6H6FX3uPyvwqd
         hg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1C7x6341gi9POCBcP0SdnBSVOwP5ZFSDAiXUabHa3Pc=;
        b=erPbTVNCaN6pk+kxZRxYW3SE3S8sNv9gtiftII9PyYSpzq4AkkbhK32RGfOqYC5men
         IpDNg93Qt8lhDU4UC7o+M5nkwmaEbZB0kJEIzkIM8m0WogHLSy3DL628ikVQ5gez2l24
         bV+A791YMRs5jAQ2wMhKC00qe0aovoybqjMA0puu3CGLDrgF7OIz+GPoNSPObHkctKYN
         M1qeEkF9mq2kAIyzgrBtxxAK24VlXqStIFuISm6lNYO4r7Siy4ZC3M+oSsMYonxRwPW1
         s9ZBXbYohouK9gltX8PMXsoANDsVq+peq1ygT3xR3eA6TywVX1QU+CqNaT+2hQ4Zg7j9
         Pg3A==
X-Gm-Message-State: ABuFfoituI7GKYZfqIKi5ePHUBy12n502x64uqfR81XLextQ2I0KBNAv
        NOmTgcTD5upvyaWnOYQc9mM=
X-Google-Smtp-Source: ACcGV60kp5kH6AROQ/NjtHIH002g6qdrwlxtzLC7+uWOReG2vX3EDy+fLq4gyApc2oVxmKh2fx72KA==
X-Received: by 2002:a63:e141:: with SMTP id h1-v6mr40210810pgk.47.1540146721809;
        Sun, 21 Oct 2018 11:32:01 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:32:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] ARM: dts: tegra20: Add interrupt entry to External Memory Controller
Date:   Sun, 21 Oct 2018 21:30:48 +0300
Message-Id: <20181021183052.32023-5-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 20869757d32f..526f623f201a 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -632,6 +632,7 @@
 	memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.19.0

