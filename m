Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D351C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055C52146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SA4K1Rqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055C52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeK3JiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:38:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44091 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeK3JiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:38:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so3323719otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6rPh/rh1j/B5PJ7a0qP/YC8Qynn+4nZWm4wlGneDPew=;
        b=SA4K1Rqjmg548jntNTLRoJWTKq3auGH3O0bbUEwFmLjcdGOikv0ZlUnK5Kz3EL6PQx
         ZDTB0lEmh9TCpBCuH9RsDxWA+m2XTjwBOlo8/DplSvwQO69dCeIzD6uD9Osj+syzXh5r
         7yAbjv9rp9u8Hd7jvGWNyYgkz347Pv4en9oa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6rPh/rh1j/B5PJ7a0qP/YC8Qynn+4nZWm4wlGneDPew=;
        b=d7vpjTShZ6s22SDVoNAOosw36uxyF5rv55F53T3V5DfBOaUjaG3C33gWmEMs3RfxQj
         uSw9xJjmVwbu1Qn0UOQ1Bmxq5iLMkGJmaLSzezX69Pkm7HZOjEVzFHaO0SOVWjWsFwFL
         1FGbeL/UImGrRpHzcKWpyLvsEFYXomTKN6uU5JbSjxZq8+FHcbImrlhvrIyqL6ya4qEH
         BCTNo/YmBS+E+wtI1Ji1kMFu/zEIY32iO5EdgWH2GZRvEZYj9qHVVTTxHshL06MGErXi
         ayU7UsO+5vQjqXtoqDbsM2aLYZWmeiJCorAyLXNEolDa+19X1bJen2HTkU/w8fODyYEJ
         uVmQ==
X-Gm-Message-State: AA+aEWYj5hOsk0stvrW9TXNZzQ330R1mrlD07uyPGZ9JWVXvwflCyRAL
        vLw+hZ/Nd6iBD7ODVtkkqo6Jfw==
X-Google-Smtp-Source: AFSGD/XaifEk7OzJSHf+bDrVKQP6AM6h20i33Wtmg+FN6+ty/puE1hKccobrja/fPGPA+KouGwMjLw==
X-Received: by 2002:a9d:6d81:: with SMTP id x1mr1917023otp.17.1543530675368;
        Thu, 29 Nov 2018 14:31:15 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:d408:b2c2:72bf:467a])
        by smtp.gmail.com with ESMTPSA id l20sm1057777otp.47.2018.11.29.14.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:31:14 -0800 (PST)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>
Subject: [PATCH] MAINTAINERS: Remove unused Qualcomm SoC mailing list
Date:   Thu, 29 Nov 2018 16:31:06 -0600
Message-Id: <1543530666-32141-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the linux-soc mailing list from the Qualcomm SoC
entry.  We use the linux-msm and there is no need to have the second
one and this clears the list for use by others.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..be25ffe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1922,7 +1922,6 @@ ARM/QUALCOMM SUPPORT
 M:	Andy Gross <andy.gross@linaro.org>
 M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
-L:	linux-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/qcom/
 F:	arch/arm/boot/dts/qcom-*.dts
-- 
2.7.4

