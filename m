Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC60C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3DE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgAsy/X1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfAUJnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:43:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33442 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfAUJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:43:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so22521713wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ck6DLVRueLESAEqb4AoHP+TEzN+C6zqqxI0IKduFKsg=;
        b=fgAsy/X1T8FkFz6QZlONhE+x+uB651Hhgt5TQ62+Cwu9FLLUQKQRK23xxkJnhKtba/
         sUpW5kRl054HPY1UgDlN0sN9WNoDilzFzG+Yzg+FMIuQ2xwxlEe33FNrwH1te+Fp7Zof
         CZMdN1thqAa40adQvQaPZEtMk2I2X5VRxkNK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ck6DLVRueLESAEqb4AoHP+TEzN+C6zqqxI0IKduFKsg=;
        b=GUMsK3nhPIpNViKuq30laqPCB8WgBQTcblXX81XSoum76JagCmx+LisQhcQ/r1ABYe
         +HTPAWHwPwNFhvJdj4QxguqeO+OGBErxSGKHqeWunIGURIzUFhxxH5sJMjJaFmrfB7ge
         TiEkvv6rsw/Py9LRhymbtUAuX+wVUXDY3jXm75YeZzL37C0zfKQVJ0SwHSKx48UV2tp2
         NichFPnyXIyhJ+6tbMaIhyeqno2CGOH6/VWExnLi9xP3PoyyH2oBjLWkT42YnK/pwNL9
         HhdxnFaPxQmuDgh8VbHcFzJs85bSU9QJTTAqn6wEi/mvVuKAYb8ugYlnTSWJJlj5xl/Z
         cltg==
X-Gm-Message-State: AJcUukcaIEGnSZfnUjh74nnJlU7mb5oeDOkYe/npToQkdqTijGYvGPqZ
        HxkitCn5NmAY+TD6mvM9NWfzEuFd7rw=
X-Google-Smtp-Source: ALg8bN4WbDWHoM2bd4PWUv69WHZtu7Hb2Hyg8e8odjqUllgsz0h4WwhodxaCHj5307WcwcDLWyetwA==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr28676742wrx.221.1548063782484;
        Mon, 21 Jan 2019 01:43:02 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id o5sm31176759wrw.46.2019.01.21.01.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 01:43:01 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        swboyd@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 1/2] thermal: of-thermal: Print name of device node with error
Date:   Mon, 21 Jan 2019 15:12:22 +0530
Message-Id: <04fc346fe98b9ada6a2bf8f18103fe2fe20240a4.1548063429.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easier to debug devicetree definition in case of errors.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/of-thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a1e47d..2df059cc07e2 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay-passive property\n");
+		pr_err("%pOFn: missing polling-delay-passive property\n", np);
 		goto free_tz;
 	}
 	tz->passive_delay = prop;
 
 	ret = of_property_read_u32(np, "polling-delay", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay property\n");
+		pr_err("%pOFn: missing polling-delay property\n", np);
 		goto free_tz;
 	}
 	tz->polling_delay = prop;
-- 
2.17.1

