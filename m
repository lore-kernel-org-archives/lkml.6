Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 959F2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C915208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MnUM7f7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C915208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934191AbeFLUVF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:21:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35397 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeFLUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:20:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id c22-v6so119008pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w7WUnYdQJVMcSzZoxupiQCcgfxRPRjU/e1SHOb0pfpk=;
        b=MnUM7f7EoQu7nls/SwzWNojr0hK90sfV5FqWFLeaBpOzjrrfMwkFuWr5bn+EBJjiJh
         GUb4ysqOyGR477L2rciE13JApi20Twef9T5YoHUKrCy8s6ftam5pjCInn8uY8gYFf+/9
         7R+HCoprSWAyhMh59pN4eg0L5oT3uHv8cUAys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w7WUnYdQJVMcSzZoxupiQCcgfxRPRjU/e1SHOb0pfpk=;
        b=MFPbgipvYBc6LH6XLOXxKo3xiKnDxwap7YuKkabAyan7TOzLu8v21B4UyIO6ZNH+Ti
         7/D3ZmeGXs5VnL7u2SB3e31sRd+5A7hPufS//wMYYrTlxvHzS54fDjOB+hl+u9zZa1Aq
         ftINBIRfwn1Vx6ebRtM2sUYn2B+F7d6PNQaTa1o13Gvjd05VHzUD5J0EW2qX0YYUwAc/
         v3zZJ0wKey8o7JTGVi0yN1lGv1CHwXaO8csYDBXYMxBlfO290FbRlZY/6GeQDnIzrghP
         K7Dd6LXuH3yGP9QBhj7RCyddzZOYfY310yR8cj3NVxKmKzLb2jkOYUyHkwNbnRgTQC0g
         K6Gw==
X-Gm-Message-State: APt69E0ToHAu+arUDy7ORVG5Yu3ptwNlQw2sb1LWVa7wIPqNeybfonqL
        my8/5t1eaveFihzxqTl1aXAAHQ==
X-Google-Smtp-Source: ADUXVKK858UGeUyVsv8eccUUa2GK+EnGBO7b8kRsLBzjFCJ2jtlmehgtrQMjqX24DWE9i8UIOQSI6A==
X-Received: by 2002:aa7:818b:: with SMTP id g11-v6mr1928413pfi.50.1528834851235;
        Tue, 12 Jun 2018 13:20:51 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id z28-v6sm1136732pfl.169.2018.06.12.13.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:20:50 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Phil Reid <preid@electromag.com.au>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] dt-bindings: power: sbs-battery: re-document "ti,bq20z75"
Date:   Tue, 12 Jun 2018 13:20:42 -0700
Message-Id: <20180612202042.107603-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180612202042.107603-1-briannorris@chromium.org>
References: <20180612202042.107603-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This compatible property was documented before the driver was renamed to
"SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
bq20z75->sbs rename to dt bindings")). The driver has continued to
support this property as an alternative to "sbs,sbs-battery", and
because we've noticed there are some lingering TI specifics (in the
manufacturer-specific portion of the SBS spec), we'd like to start using
this property again to differentiate.

In typical DT fashion, the <vendor>,<part-number> specifics should be
used ahead of the generic "sbs,sbs-battery" string, so we can handle
vendor specifics -- so document this. Language borrowed mostly from
Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt

Also fixup the example to use this property (it's already implying that
it's "bq20z75@b"); fixup the node name to be generic ("battery", not
"<part-number>"); and fixup some whitespace.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Rhyland Klein <rklein@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: add Rhyland's Acked-by
v3: no change
v4: add Rob's Reviewed-by
v5:
 * note "sbs,sbs-battery" as a fallback for vendor,part-number
 * improve the Example
 * I still kept the {Acked,Reviewed}-by, since the substance of the
   change is essentially the same. Apologies if that is not proper.
---
 .../bindings/power/supply/sbs_sbs-battery.txt        | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index c40e8926facf..4e78e51018eb 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -2,7 +2,11 @@ SBS sbs-battery
 ~~~~~~~~~~
 
 Required properties :
- - compatible : "sbs,sbs-battery"
+ - compatible: "<vendor>,<part-number>", "sbs,sbs-battery" as fallback. The
+     part number compatible string might be used in order to take care of
+     vendor specific registers.
+     Known <vendor>,<part-number>:
+       ti,bq20z75
 
 Optional properties :
  - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
@@ -14,9 +18,9 @@ Optional properties :
 
 Example:
 
-	bq20z75@b {
-		compatible = "sbs,sbs-battery";
-		reg = < 0xb >;
+	battery@b {
+		compatible = "ti,bq20z75", "sbs,sbs-battery";
+		reg = <0xb>;
 		sbs,i2c-retry-count = <2>;
 		sbs,poll-retry-count = <10>;
 		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
-- 
2.18.0.rc1.242.g61856ae69a-goog

