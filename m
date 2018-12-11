Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B47D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I79SxOfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B47D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeLKV0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:26:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42452 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:26:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so11899460lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jnq+OwVAjE2KpWBcTMnLqNlM72PMDoCsAblvBeKtC1I=;
        b=I79SxOfZpg/9n7k+GwS77IsKuVLBqDEHYw7ZijXiQTIX7tbpUaFhYVz3ng6msCB/x/
         1U0itLE8kqKvdBjWivRINgNaBx+KibSBS4eVZWEIgxV4pvn1EF1/0xg8M/PFRMbSUtlF
         SYQyClyWQzgFvZtb5OY9Tr1AUd5cA5+BXw5dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jnq+OwVAjE2KpWBcTMnLqNlM72PMDoCsAblvBeKtC1I=;
        b=UrSXD60C964s5CEZYUgcb9Wjqlj4aBaTmhEPdC5PX1ZF3Ymrm1sGJ8aj1TlxwAxiNF
         WlyNb3/8z+UcSXV97ukjlT2W5Iue92M9d37yFCHghwKBG635FrIaVs+ewKhY/c1THCsB
         v9UgiOb4LXvE5YHNJbVoA7cZVGO4A+xlRqivTkvXJaiUwPbqFIC21WP4IYMoWPOlc2Gu
         tplSBGNOIXwYwwDbhVQjVUWPXtxfCOcDjGrwD1FsBIAK7ApABsyDOW8wKPEuGCPJnffL
         IFRnAGQciz9w0LTUhKFrQT0ayy7w1R3fhghSLdYl0tosmzNRueiwEo7cD1gfHbapOlSk
         CH4Q==
X-Gm-Message-State: AA+aEWZO5RF5/9LOxz8PZoF5kRjKietQ9QTqeTpxZHJi0FSKz//NZCR5
        wyXrSLSHFamkgEckdWHTBKoRiA==
X-Google-Smtp-Source: AFSGD/VoNfRD13Hcqud0/t/sT3yWQ5p1+G4N21nWLCaEK8qvvZH77QtZvxRShyGxjlpfFk7UiPUDog==
X-Received: by 2002:a19:d58e:: with SMTP id m136mr11091455lfg.70.1544563604148;
        Tue, 11 Dec 2018 13:26:44 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id y11-v6sm2873870ljc.85.2018.12.11.13.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:26:42 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/5 v8] regulator: fixed/gpio: Update device tree bindings
Date:   Tue, 11 Dec 2018 22:24:26 +0100
Message-Id: <20181211212428.28327-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211212428.28327-1-linus.walleij@linaro.org>
References: <20181211212428.28327-1-linus.walleij@linaro.org>
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
ChangeLog v7->v8:
- Rebase on recent fixes on the for-4.21 branch.
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
2.19.2

