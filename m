Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D9A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bv1vaPdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D9A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeILO6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:58:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41379 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeILO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:58:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so1246744edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=q7StzQyd+okywPPbXDjrtJCN5bAcIFHgFQlaxztz5dY=;
        b=bv1vaPdS27Frv9kiMDM1C8J0zLCjFcroQZ21iJ8vgCOocCsPIUyHTNVJ+Ur717+HcE
         +D+D1Efmfvvijv6BcOwkHJ6qhBKbVefkwuZyt9s/8oBrpDdpQcrP0HLWndHWzFixz+2X
         M6SiSfzreyp3uGwR0InXc1KXmJrd7kX1eW/tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=q7StzQyd+okywPPbXDjrtJCN5bAcIFHgFQlaxztz5dY=;
        b=e5tqYDpqwj4l47WcwfsO3rQKiK4AghB6khc88T9Vohl+H1ICo/ED/DoGFFk/atMapH
         cgCr5xLX+zULxFBmmza9cXO7ASj5XaCXoiPX/fQuADnoeK51GZmVJCguFqasziEirnOG
         viFbkVMBokghf9VTU5l9UyPFKUp4hl9dS1BzLOiaAOG/ZQzcYiqkjgUTj1v8Hsyb25Ie
         kT8ptluFl+hS8pEi/i8MtkPPr2XMNs5nSZF7clVjE61sXpLzHOb7R2/ujQD2taflRA47
         rOms7LkLr5Qswx+1ZWitAFP7Qfm5X+TiBryZN/O0TD6OPw94m+pH0bnzXTPj0xH4J4yV
         5r7Q==
X-Gm-Message-State: APzg51BW2Vc7irMaAJj4boeQr0iTcoNUZfby1cyIWOdGkuBkWHUvv3sH
        Vc4cUeAR6HTGlNf9tAzaSWYpbTKLhk0=
X-Google-Smtp-Source: ANB0Vdbm77Mjkf/grj+hcc5T8y/aN9BwFRQLDqSnaD0UTh7LOTGD58oJldSSr1WKjRAD+c6ENGBVQw==
X-Received: by 2002:a50:cb8c:: with SMTP id k12-v6mr1878289edi.171.1536746091680;
        Wed, 12 Sep 2018 02:54:51 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id h40-v6sm420603edh.88.2018.09.12.02.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:54:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 13/16] dt-bindings: thermal: Fix a typo in documentation
Date:   Wed, 12 Sep 2018 15:22:58 +0530
Message-Id: <b55d8da64011d35ca16956feb17f89262b6a33b9.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c(1) + x(1) was actually meant to be c(1) * x(1).

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index eb7ee91556a5..ca14ba959e0d 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -152,7 +152,7 @@ Optional property:
   Elem size: one cell	the sensors listed in the thermal-sensors property.
   Elem type: signed	Coefficients defaults to 1, in case this property
 			is not specified. A simple linear polynomial is used:
-			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
+			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.
 
 			The coefficients are ordered and they match with sensors
 			by means of sensor ID. Additional coefficients are
-- 
2.17.1

