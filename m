Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A9EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5236320892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="El0fMUQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5236320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbeKPUQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38848 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389547AbeKPUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so916151plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmjHQrzH3LPsysyMlkzh+Qm9rUsTXjJj/VyKPq1LnW8=;
        b=El0fMUQ3VTzNvHQ+No7yCC641xxRow2h2idrjFaDry9uLyyOekkFxoZPs17XGeLHtg
         Qr+tx6cU+FPu4OeX1wU737un2FszbXEtLjxKgMbXBLq1kjDeLP+HFFlya1yVbtwXrrXw
         sExaUXVj7dZcDR6VJ5rZgPdZZ9aqwTbf4gfwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmjHQrzH3LPsysyMlkzh+Qm9rUsTXjJj/VyKPq1LnW8=;
        b=NVJDriXZpY0j23v2E5NVDyVwDoNBFQV2sSNRD9gJWVZYBMnUQ/MsYJbk5xrl4K6kD8
         n06SHMaoKwEqrBDI0EINnyYKAiEPXkQ9pCYq+1HBflr1wrC2+IMt5maTLdnMGumPZHOF
         3pfM/0Dh/hbhd/TMteCTjYi/bMHD3LdAVdyCUsm6eky7dsVaxl73Zype/P3Bq6yZOIvu
         DajaRORkUE6Gv/xv69nfcpfpyBMTVL85Efn0iFQ8JqMhrbrSMyD6IEehF2Ps5v1VbB+u
         kfHwen9t9nAQKShWAdwI+H63aaIfvEQk2qdTkZt12t2Q/Hm6HEIT4CL4x1RMHqPRCM06
         3iRw==
X-Gm-Message-State: AGRZ1gLxJ06iPzaNopYTalmLlxS4DlY10EksqpZV3onAR4TYJ9pwuHJl
        tfo47fNzLWp4KOUlMGyttMQxbh7MsKM=
X-Google-Smtp-Source: AJdET5dzsVUVn0P59zjnuOoXv1A6JX0AvMsNwHLSVXEau9JNGRYmlpZCfpGhgRrFE0MWePflodTgQg==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr6181411plq.84.1542362709696;
        Fri, 16 Nov 2018 02:05:09 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id s22-v6sm56173002pfi.15.2018.11.16.02.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:05:09 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] ARM64: dts: hisilicon: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:28 +0530
Message-Id: <89bb8c62404aa875d597da89c18852ce81fb9f26.1542362530.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  9 ++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index d943a96eedee..20ae40df61d5 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1118,12 +1118,18 @@
 					map0 {
 						trip = <&target>;
 						contribution = <1024>;
-						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					};
 					map1 {
 						trip = <&target>;
 						contribution = <512>;
-						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					};
 				};
 			};
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 97d5bf2c6ec5..aec9e371c2a7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -893,7 +893,14 @@
 				cooling-maps {
 					map0 {
 						trip = <&target>;
-						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					};
 				};
 			};
-- 
2.19.1.568.g152ad8e3369a

