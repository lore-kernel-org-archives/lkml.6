Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F381EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA57F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc1tK/1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA57F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeKSRgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:36:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34579 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKSRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:36:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so25208582ljd.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 23:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBb3a4hWtaHZwpV0DBM1ehv0fImjohELlIgLSGXL7yo=;
        b=Vc1tK/1tr5TVqXv1yFSwORx/LydYEsKqUN6t5rFAZDLbqkQQa2/5ybvY97fW0N6qsA
         qNq6ogqDH/W94s5NKhzcRSha9xkbtcjJMb2D86/sVVqqZQLrgvA2t6KogSdf/lQ63PPF
         zX7SCa18Quqhj8f6hqTFpFXo8JYBRjYHUHsPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBb3a4hWtaHZwpV0DBM1ehv0fImjohELlIgLSGXL7yo=;
        b=iLnBaW36EiZBOZr4GN1i2Ez465CPKv9uh1OSvDf0V+2skaSjnagZjOtkblkku+fsad
         el3Yi0eky4HUO/rwcJyjmT+eilJ3uDr54sKdxcfZCt4AJg/OXDr/Q8jxeKzKz+Asf/L9
         zlSMxxu1u3X107ZAzxZREZ4y6FP7Id0+Q5jxDt6OwS3W5QMT3nuEPGTpY1z46vRqhOOE
         urL/SfBaW0BcorqrB6zQ6FLN+/MKVf7i/3xk6jcq3pJTz2fPB3mbHFjAqWWpF5znNtLI
         n2+Veo7UTvNFXQ7xem0GRWsXKPfXSC6o5JKZn8cRk1+aZHaR3Xlv1sNEfEZkXAYLy1vq
         8QTQ==
X-Gm-Message-State: AGRZ1gIxkZKNe0MO+SS6eRuz6mY+2z1fQ1rjd2R1TEGzxxVSiZuc1vcw
        tACHzfA/SbOdaG1MLI2Jq5hPmA==
X-Google-Smtp-Source: AJdET5e5KGGqt6EEnhu2kIWTNGaZENoP6ZxNr8WJuWIuggFbI4OE1M/yGXoRI/KdwPZmYJHeQRCnLA==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr11047186ljg.22.1542611633409;
        Sun, 18 Nov 2018 23:13:53 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 10sm5531584lff.62.2018.11.18.23.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 23:13:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/5 v7] regulator: fixed/gpio: Update device tree bindings
Date:   Mon, 19 Nov 2018 08:11:24 +0100
Message-Id: <20181119071126.8889-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119071126.8889-1-linus.walleij@linaro.org>
References: <20181119071126.8889-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate the open drain binding for fixed regulator and indicate
that we prefer this to be passed in the GPIO phandle flags.

Clarify that the line inversion semantics for fixed and GPIO
regulators completely overrides the active low flags in the
phandle flags.

Unfortunately this can not be changed to prefer that we pass
the flags in the phandle: the bindings have been specified and
deployed such that the presence/absence of this flag and only
that controls the line inversion semantics. The crucial semantic
is that the absence of the flag means the core will assume
the line is active low, which in GPIO terms is an exception,
as GPIO lines are normally assumed to be active high.

This special device tree semantic cannot be changed without
introducing a whole new compatible string for the fixed and
GPIO regulators, so we just contain the situation.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Resend with the rest.
ChangeLog v3->v6:
- Resending.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Collect Rob's ACK.
---
 .../bindings/regulator/fixed-regulator.txt          | 13 +++++++++++--
 .../bindings/regulator/gpio-regulator.txt           |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
index 0c2a6c8a1536..a7a1cd0dfa6e 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
@@ -8,10 +8,19 @@ Optional properties:
 - gpio: gpio to use for enable control
 - startup-delay-us: startup time in microseconds
 - enable-active-high: Polarity of GPIO is Active high
-If this property is missing, the default assumed is Active low.
+  If this property is missing, the default assumed is Active low.
+  If the phandle flags to the GPIO handle also flag the line as active
+  low or high, that will be ignored for fixed regulators and the
+  presence or absence of this flag solely controls the inversion
+  semantics.
+-vin-supply: Input supply name.
+
+Deprecated properties:
 - gpio-open-drain: GPIO is open drain type.
   If this property is missing then default assumption is false.
--vin-supply: Input supply name.
+  Do not use this property in new device trees: instead use the
+  phandle flag to indicate to the GPIO provider that the line
+  should be handled as open drain.
 
 Any property defined as part of the core regulator
 binding, defined in regulator.txt, can also be used.
diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index 1f496159e2bb..8fef3e5358a2 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -14,6 +14,10 @@ Optional properties:
 			  defualt is LOW if nothing is specified.
 - startup-delay-us	: Startup time in microseconds.
 - enable-active-high	: Polarity of GPIO is active high (default is low).
+			  If the phandle flags to the GPIO handle also flag the line as
+			  active low or high, that will be ignored for fixed regulators
+			  and the presence or absence of this flag solely controls the
+			  inversion semantics.
 - regulator-type	: Specifies what is being regulated, must be either
 			  "voltage" or "current", defaults to voltage.
 
-- 
2.19.1

