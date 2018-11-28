Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C976C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304A12133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MfAxF1a0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304A12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeK2Jh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45412 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeK2Jh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so18064290plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h81bvo1jaeL7v1YBgR+oC0YJdYTsfdkfWXE2JJry8l8=;
        b=MfAxF1a0EDLGMbIXsL0AsypmHJkVF1shXrcZ+pBfivaOrj6CZZaHET7NyAUfOnriMe
         TS6NuEevAOKVMWX7+ClZ5K/1HRrLzXDOythEz1Unq8eCihMetjaG/J9MPPk2uAKuVOrS
         +zxaje4zoLUf4xmnpnaxQ7fqz3CzmoHKKJYNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h81bvo1jaeL7v1YBgR+oC0YJdYTsfdkfWXE2JJry8l8=;
        b=Si/g/rm28FXu/6pMt945ApsDhLzR2YafedlougfU4xNeBSlVwyXaYV8DgOVefSO3Qf
         kVhMBjvbc3//r9lgXTKRMVtjX4khLJomw+UMB6LgsThFNNr2bvFjBz1rAlcQBaH8SlL+
         NAiK4aT0cIUGFA4agmFerviovM04yPtfTvKmzCszihBx0MWRZVrAR3HFTsbPwZ0RcpHq
         bwfZv/WdQZ7v38E8kSa9KRRLtN9GBY6kr86NSFQGIfuVyIk4njxhMpERjYRZSA3IOHn5
         MT23dybM0JUft/5Nkl3r8VGmrVCr84IzSkfm2iNKWkZeMIkrTocjTFjIsFuUYQB3BcnY
         B58w==
X-Gm-Message-State: AA+aEWa/OfSQwFsvpOhaLjeZDIHM8b5kGJUkwFm3AdeJLEWEPPm8Owr/
        g4a94+8s2eKP9jGYwC5eu3rCzw==
X-Google-Smtp-Source: AFSGD/UcncJ+iK5GAhklX88ri/Ff6f58N4PohzMwPxvB4xmGOjfo1bVgmtasmXLgXyPpufZ5skS21g==
X-Received: by 2002:a17:902:e08b:: with SMTP id cb11mr39145198plb.263.1543444486477;
        Wed, 28 Nov 2018 14:34:46 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id y26-v6sm12364813pfi.123.2018.11.28.14.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:45 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
Date:   Wed, 28 Nov 2018 14:34:26 -0800
Message-Id: <20181128223428.177313-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181128223428.177313-1-evgreen@chromium.org>
References: <20181128223428.177313-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
one register region required.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index b72871ac90cb2..da4edb146a983 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -25,7 +25,7 @@ Required properties:
 
 - reg: Base address and length of the register in the following order:
 	- Host controller register map (required)
-	- SD Core register map (required)
+	- SD Core register map (required for msm-v4 and below)
 - interrupts: Should contain an interrupt-specifiers for the interrupts:
 	- Host controller interrupt (required)
 - pinctrl-names: Should contain only one value - "default".
-- 
2.18.1

