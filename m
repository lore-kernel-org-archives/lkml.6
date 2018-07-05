Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72458C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1692424069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RExt/q7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1692424069
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGEFJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:09:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37317 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbeGEFJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:09:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so685807plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KAJCBsemJlgT/QnylL6EQ0Yj1P5RRi51n+cG9dVKjek=;
        b=RExt/q7+50GEAh2eSQNniC/kUdsSxIgX2ckEL3pffN+bYZKOQcXRnD38H9Ym95taqo
         4UdX62yu0ERwExbQmhOY7CGe/Rb5Af6uJAKMVryOn7nb65XhaQlo1iu4Wy6VJyDvsRYq
         FclNhtlIBSaisInjDjwT295tynMj2PYFJFiDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KAJCBsemJlgT/QnylL6EQ0Yj1P5RRi51n+cG9dVKjek=;
        b=NnbtkaI8H10Aa0SRSjqBOingq0+aGHWgyNF7k5pDTQL33rHQ7zgTUEzN8GlBR9sAjk
         rVx5171P8QgyFt+jZubQb7cy62t7RPdzjXUNqndgirRVND3olJNZHjB56gCyS0uOgYqS
         UJZSBNZrB6x3U4v7K58EfGtbwPL0uY+TLMsrfDCf42inH4aqVF9fZms7kMw9WPORgzTS
         R6Nb2QzOKfLZc+4iKmYSYIYZA1PccBH0LCRX60I3lpSom7It2zl0RMLe07dmWbdnKRMh
         3LgWR4z5YlDfq4g2TBNxGwSFqF8tJpt1FcQCGfbcOg/xfN7Ng0cxHRbaLhCpauwiFTXB
         +OLw==
X-Gm-Message-State: APt69E1OBQNQhbCtjqqQFYcjcWgHaVe+fdatW3XpMDmWcDyCMPdpfi31
        1kcp7iVDOFmmu+CUntA3VI9MBg==
X-Google-Smtp-Source: AAOMgpfYcM9aStFkkfdnMWZCbQ1R/hz0mFSSep4bDGL8gUd7pK5EmuzjKFuAzq0rKx3z2EV640dsMA==
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr4574483plo.283.1530767371158;
        Wed, 04 Jul 2018 22:09:31 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id 204-v6sm9391498pfc.131.2018.07.04.22.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 22:09:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: thermal: Allow multiple devices to share cooling map
Date:   Thu,  5 Jul 2018 10:39:23 +0530
Message-Id: <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow cooling devices sharing same trip point with same contribution
value to share the cooling map as well. Otherwise the same information
will be duplicated for each device sharing the trip point.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index cc553f0952c5..eb7ee91556a5 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -97,8 +97,8 @@ get assigned to trip points of the zone. The cooling devices are expected
 to be loaded in the target system.
 
 Required properties:
-- cooling-device:	A phandle of a cooling device with its specifier,
-  Type: phandle +	referring to which cooling device is used in this
+- cooling-device:	A list of phandles of cooling devices with their specifiers,
+  Type: phandle +	referring to which cooling devices are used in this
     cooling specifier	binding. In the cooling specifier, the first cell
 			is the minimum cooling state and the second cell
 			is the maximum cooling state used in this map.
@@ -276,12 +276,7 @@ thermal-zones {
 			};
 			map1 {
 				trip = <&cpu_alert1>;
-				cooling-device = <&fan0 5 THERMAL_NO_LIMIT>;
-			};
-			map2 {
-				trip = <&cpu_alert1>;
-				cooling-device =
-				    <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				cooling-device = <&fan0 5 THERMAL_NO_LIMIT>, <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 			};
 		};
 	};
-- 
2.18.0.rc1.242.g61856ae69a2c

