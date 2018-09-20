Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D5EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AC521525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D32QN1Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AC521525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbeITXnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:43:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37644 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeITXna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:43:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id q5-v6so1229797pli.4;
        Thu, 20 Sep 2018 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBwIuTiMBsD6cj7cWYr6Q/ITOcyWoab9CGhawah+tAg=;
        b=D32QN1GlD0zrEKarp0ZvlO/otvc4ojSZljmjKiYzGSaxYXjXsVqw0E7Kr+YtDsLePr
         7eHJDOy6zzJtupoVqaV6oxNSvZbMRTu4/4foEJUTdKzxoQqZsXSqbcOdbdQA2kYP3qLa
         z0lymhEexRCzXga5PYdxAhlFtnBXAyRntCq/jP6wx4l313lgIFd1KupUTiv5AindKFTp
         3Jq1MhxgcJWeQyZbABRgGj50GGrwQGjoM/QJnv3N5YEMX24b5fw03EEln5X049/fD5i+
         fOzjlQTRDUU9jNeAEPkR172uGb7IHUUM4LVMsNicvKPw1/LBZyQLsc2GGdjHaz5eyB3v
         mTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBwIuTiMBsD6cj7cWYr6Q/ITOcyWoab9CGhawah+tAg=;
        b=D0U1e3Ym2bvHHDdwyotVuwpXhSDRO4Wy+P7l/0+nrOPpzhXpalO/Jh/3wAi8hRM37K
         XjqZYxzOXlrtQ4QZ4biSpQ0GZJ0eIiCuqJKWJbtnMidxRJ33hoZcgmWWmDmpuAP11CBM
         w9P0OpD7wDPPoXXCAmxJFxTaO2TDGLMknqid51QkZYIJquxtFD99v8IxnTu8RznxllpP
         kpcQ0z0FyhpVSWWQTThqIZWgcuCHm2l9UhKzz8Ajy5dUZ/qZi0yrLIR9KN8XbAjndEuu
         YZpyr9YQBM6IbBnXGhTlTacnXicEaYANWQWISFsN/a4XOJO81ViBP5BSwJHxKoH6Iopc
         q0sg==
X-Gm-Message-State: APzg51DiNpcWY3shY9UJrstj/xibNh5nCcTB4wk7o0x1SulNeFWpTM67
        23HcLiY+lBzcuQH6vTZ1uuU=
X-Google-Smtp-Source: ANB0Vdb46Uo7fWuFpkXN8wO4Hr8+pEBtTL76w4FVxqeqjJ/kZnaztZldre3cGUdw8ZWxolw6m/RM0w==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr39698193plb.99.1537466331232;
        Thu, 20 Sep 2018 10:58:51 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:58:50 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv3 2/7] ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid XU3/XU4
Date:   Thu, 20 Sep 2018 17:58:21 +0000
Message-Id: <20180920175826.1284-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

looking at the schematic sd_2 min/max range from 1.8V/2.8V so fix the
regulator min value to 1.8V. Without these changes sdcard will failed
to detect on booting when UHS-I tuning is enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376262.html
Fixed the commit message.
drop the ramp-delay changes.
drop the vmmc-supply/vqmmc-supply changes.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 3a58c935c52a..01593f4537ae 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -224,7 +224,7 @@
 
 			ldo13_reg: LDO13 {
 				regulator-name = "vddq_mmc2";
-				regulator-min-microvolt = <2800000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <2800000>;
 			};
 
-- 
2.17.1

