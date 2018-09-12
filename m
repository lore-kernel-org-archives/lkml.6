Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE9C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653BC20892
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bKXWgFYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653BC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeILRYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:24:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36235 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILRYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:24:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so985259pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 05:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX9BUw85r/ljBlG69pn1fPXhcwk59z61wwuJst7K/bM=;
        b=bKXWgFYdYIx83fDBI2COUboshCd0lK/+e9T26PIVVX9l3XNMozx550yLq4eqTyQr8j
         NJGLaSAkx11UxQWrkXSxuEt1TryIe/+PSFEV6jWV7vXLC+Iv6xM5OF95+t0kqLFQKR+w
         kX/xE8rLcMtH131xvqf7iDfgLqcEe/FX6giWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX9BUw85r/ljBlG69pn1fPXhcwk59z61wwuJst7K/bM=;
        b=qTxgrgyR62egJWz3GeM0L87YMS1TeRGj5lDdTCfybxq1dIbA32vM1JxNTbSevkd1oP
         VPgPlNWVZIXjmmRuAQWjvM4h9QDSioecH4AR9owfeGS6yjY+SRDJS+XJtJUmgkuAhLOS
         GKPap2Qj/KPaWTakG1XPjHCmF6UN1mTHqSnaqeFHvMZLlumKBckw+qbrUBpAGcCkO67v
         n8yJj5ycZcPrtZBOeDu6GWRdfvrmvAgfnqwzU3l/vrNtaBWzzY2HcqXRhO97GHO3T34P
         O838woL0QLbUMQgAR5/5O2qAxTDbGJDhNlaTOlNEFVeqfVp+h53PBM/4Jo/9B06pDzv1
         7oRw==
X-Gm-Message-State: APzg51AR2St1UVYv5NE/5k7y3oFi9gIeJd9JpmgI+6rWW7RqOM4W3Xcl
        0vf6/a603ZVd1pae4fCqEp+OJ3T12A0=
X-Google-Smtp-Source: ANB0VdbX4zKz7vWdnWRgyVJhjDWH1K7K0KZNWpJnUsJ1TQrpUxvo3qKPPYYObYwB+bTyZ4FBvOHACw==
X-Received: by 2002:a63:ba1c:: with SMTP id k28-v6mr1965745pgf.76.1536754808557;
        Wed, 12 Sep 2018 05:20:08 -0700 (PDT)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id t9-v6sm1729038pgi.87.2018.09.12.05.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 05:20:07 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, ryans.lee@maximintegrated.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/2] ASoC: max9892x: Add documentation for reset-gpio support
Date:   Wed, 12 Sep 2018 20:19:54 +0800
Message-Id: <20180912121955.33048-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max98927 codec driver will support reset-gpio binding so it can toggle
reset line in its probe function.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
index f6171591ddc61..8bf30483eedcd 100644
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ b/Documentation/devicetree/bindings/sound/max9892x.txt
@@ -29,6 +29,8 @@ Required properties:
                    Range : 0 (off), 1 (on),  Default : 0
 
   - reg : the I2C address of the device for I2C
+  - reset-gpio: reset gpio the chip is connected to. This is supported
+                on max98927.
 
 Example:
 
@@ -38,4 +40,5 @@ codec: max98927@3a {
    imon-slot-no = <1>;
    interleave-mode = <0>;
    reg = <0x3a>;
+   reset-gpio = <&tlmm 75 GPIO_ACTIVE_LOW>;
 };
-- 
2.16.4

