Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E14EC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FEE20673
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7xAs8JN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FEE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLGP3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:29:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43815 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeLGP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:29:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so4156156wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
        b=D7xAs8JNPPya8GVhcKCgjUJ+JMGyVzW4mh+aMFhWFaqg32QM2wWlBQna9NoxPN21Uj
         ZcxVkarFmapau66SYXcDVLKh4pGBtVPT4uie54JuN2jAyq1ST0ZDfLq74YDa5pCh6if1
         ny4s7+twU+uaLkc2fUgwYhfaWjPpUssOyJw44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
        b=NgYiUMYWEkwfl4SimGtjybdEH4xQmJBRRm126tnMWAgYsEmzMm5scYoY8Mz6XfjAAH
         8ZmVb3D6J6eDbwr/l9VgUDpmXmVstoKtwGrnwQmcQslpK+wg0jzni2gaP8ZKGW3RYlo0
         1kBDEKYxjG+V8HzUw82Qtgrhjgj8jiFjBsOIAyGUJ8yqR/dAmXyfDyPwk2Izk8cVlL4y
         PktKZw+TW36bl1466p1N81h+7lx09mmL4nVORoHbRqeP1KeY0btvU2MUvornLMPeRENC
         b84Rh/RDVECLKWI6obory96yR/OXEddHJ5kpbEFbjvx3bXl5DGek+vn/xxs/MJMziQ4j
         wBFg==
X-Gm-Message-State: AA+aEWa02ISkGPu2j4eF8ge8GhGUp3VCIXDhOt9d8f5K63H7StwdjZjc
        MalqPBmg/LFAMUAh+ZYk5a8Zjw==
X-Google-Smtp-Source: AFSGD/VG5tq955HoOVCaG6geZh98mkykDzR3qPv/MCr9bvaZc6yjQnhYOG7toBvFcgNFh/0BiJ+O1A==
X-Received: by 2002:adf:b592:: with SMTP id c18mr2147050wre.89.1544196575708;
        Fri, 07 Dec 2018 07:29:35 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 07:29:35 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v11 7/8] MAINTAINERS: add a maintainer for the interconnect API
Date:   Fri,  7 Dec 2018 17:29:16 +0200
Message-Id: <20181207152917.4862-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..4f426863ff3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7694,6 +7694,16 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTERCONNECT API
+M:	Georgi Djakov <georgi.djakov@linaro.org>
+S:	Maintained
+F:	Documentation/interconnect/
+F:	Documentation/devicetree/bindings/interconnect/
+F:	drivers/interconnect/
+F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-provider.h
+F:	include/linux/interconnect.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
