Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190AFC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00D620868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LU17DI2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00D620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLHRCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:02:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43757 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeLHRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:02:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so6540277wrs.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
        b=LU17DI2qahHMqaJQXOzP8agwl5/WHXt+pRvIXohaL4ByJLN5o7fmrX8MY9gw6tuA1V
         OQFMKTOjxDkhVXmqRSAEbDUYZDuMVGNRU0CdO0rcdGuB7dgckkXLcZKMgCiJxyG9B2eB
         6O3Kgpao1vr3bgbMawA1iP+3by/c7J4qXtX5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
        b=IjDSS72X5rJpLja95us49GHeKl41Yi/wi2p/eycHMdlZlcFiGQg+ChNeiuYXowS2Tm
         nujFdoPSR/efCp1hp/szwZkf8hdUqbw8CVX9YgS+rrRnem01P0zHrhHJCgpqlSbbIVHF
         AiRN8klcJJryAw87b1QP5XECLyHZZEzKFHs+FWBue/knskWBUUgV6sXQw5NmpYWFfcmi
         16BRRgyZlvC8SZwOdreACSQff0jz03v7/hhs9ZEPpmCx9MM8kpDJFRCoALJTFfn4nCTH
         svU/B5kFN+6bJsq6GnqaRNmgZdL1TpJOUcLUpnx8ktEEZ0JQ33PPo+Ks6oloKGOpmw8F
         SQgw==
X-Gm-Message-State: AA+aEWZ8OfQ9BV/de68Y6oyViWQ84pGQJElU5el/glKIiJN9QnyD5xKC
        IC1pXfpt3T58CdGnvMCBxKOb9w==
X-Google-Smtp-Source: AFSGD/VbNYHXX+JW6bwUfEkzdejqlsGdAkV5AHeqd7yvAnD3CO4WbNLC3vhm9xT7rrRK3dxZ7rW0yA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr4969911wru.222.1544288554348;
        Sat, 08 Dec 2018 09:02:34 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Dec 2018 09:02:33 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
        arnd@arndb.de, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v12 7/7] MAINTAINERS: add a maintainer for the interconnect API
Date:   Sat,  8 Dec 2018 19:02:16 +0200
Message-Id: <20181208170216.32555-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
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
