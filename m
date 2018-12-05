Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B466B20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="id4yHN3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B466B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeLEXwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:52:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53766 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLEXwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:52:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so14949410wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9epHOq5LFKHLkiQ00/c569NHAFDtVOTxCz4SUovsHM=;
        b=id4yHN3Vf02QJ1PJ89JVDE076s9hk+Tml7Ts8MU3pR8BZZHsx6k95l8H4TgQ3GnQ0X
         4WwyhWJHam3tBgF5ccnUF0S2gd1ebuAlbU+d23XWMzwXHVt0DH/bMcMQBpd17ZycLmG2
         T/g0p/rcKSHhLyuXjR0aYmkTriq4VQU/4j7K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9epHOq5LFKHLkiQ00/c569NHAFDtVOTxCz4SUovsHM=;
        b=mu1YY7Ww7GGt0UJFW5h5F7W6tn0YW2v8sHcJxEGxvf7VhtuUvcoCC11Vf1/JVyROgN
         pwACRXtTFehrxe0KOUJjqLEu1cNIDKgyfM6F146o6mErJyR9lEiY2sFM4+ha8OkabOcx
         snhqnvIDemmupEkNIX53S2zfQAB2CWnsLQtPuu0Ti1XMgg3E6c0qY4S4yOE8KMVepRrf
         ES5GjVmHalsrr3DLjH7MnnWBDGrOMEy3XIwbbEDc3JxUrMJWPbasHUl4ZICwQx4r8zL/
         oMAHumCsJpVW8VJ6hrkOjEWsEg94N+Eh6fPOiTwG0wEJoy1TxtgqqH9nbCy2SUrnKei0
         44XA==
X-Gm-Message-State: AA+aEWYzev5mjbqXmU8NkSnc33hAdfQ3WaEty9k6G1mdTWhMfT+TQVZN
        adwgY0AlzPIUBiPlvWRY4j0mvA==
X-Google-Smtp-Source: AFSGD/Ul5OJP189LT1g2uSzGTdLp1sw7Bwr7ypYcykIz2JwJSN25oYXLaNdGty5fZASIuM0Fuyzjjw==
X-Received: by 2002:a1c:cf82:: with SMTP id f124mr18249282wmg.95.1544053952866;
        Wed, 05 Dec 2018 15:52:32 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com. [213.198.161.243])
        by smtp.gmail.com with ESMTPSA id x15sm19113324wrs.27.2018.12.05.15.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:52:32 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 3/4] dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
Date:   Thu,  6 Dec 2018 05:22:19 +0530
Message-Id: <20181205235220.3461-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181205235220.3461-1-jagan@amarulasolutions.com>
References: <20181205235220.3461-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures, it support chipdata which is similar to
existing GT1151 and require AVDD28 supply for some boards.

Document the compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- drop example node 

 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index c4622c983e08..59c89276e6bb 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
-- 
2.18.0.321.gffc6fa0e3

