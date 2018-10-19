Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB929ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAB421470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E5ulmdwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAB421470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeJTE1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:27:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34743 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeJTE1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:27:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so16333157plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypr1b3a+zTVdUsID9jpNzwdeEbE3kjN+Jye3j5dNozs=;
        b=E5ulmdwKluwmNGIOt/jql1ysD/0xZKGGOcItwTmi+EPPB6A/MwVdHyxS93zpYYKAzA
         AfoEHspCw9abUiseXBZPFdaN4X0UBbFKWR+zA0bzfa+rmKuSwOiW4jBgJg8QKg+dAlbI
         DfR5NoRi0QLCtTzIh5WPBN5mhcf/bqvq4VdY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypr1b3a+zTVdUsID9jpNzwdeEbE3kjN+Jye3j5dNozs=;
        b=td9YmLUnXUwlrcaVIyyaZDbVzpqQbTlsoEJcyQ4nq8l6cbXmjjp3OFFeaDKvlDH6ZK
         muogo64NmkSl/X7gTaTrr0OKv3hCjxD0BxCMNTgefS9puaT1NtYKqItFi9J/WA8GYMwB
         G2HlFrKsfM9F/t2Y04T7kStlnta1xFsc0ACJlttGXR3H4zv818O1Bl+1Javjv38+sSlU
         ExKv6/PqFg0jUaY+cg3C6ln3e92AcWuZvcVIZKJf9HxSBZ5TFXqu1nFxKDYT7dici5tZ
         0Tplof02fSfKp55aq9P+lKMJIINp7PshCCTd301T7YnSGiMajuaJmLJ1pIxu8EaEcM3M
         R4hg==
X-Gm-Message-State: ABuFfogqBbUTylc9QzULiu4qXUlq1Tx0AjIuS8Nq8gcjv1ekRwPRCJST
        jgnkxhXo/qvAkVPJliSk0MV19A==
X-Google-Smtp-Source: ACcGV63l9PCzkCFguh++1dbH5hO4c7VDo4aZTvkBcrQOxkODTpeNviy5w0TXpgWq04LfYELdrl9eAA==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11-v6mr34975271plb.219.1539980407151;
        Fri, 19 Oct 2018 13:20:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id i184-v6sm38281573pfg.88.2018.10.19.13.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 13:20:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sandeep Panda <spanda@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, jsanka@codeaurora.org,
        ryandcase@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] dt-bindings: drm/bridge: sn65dsi86: Add panel-hpd-delay
Date:   Fri, 19 Oct 2018 13:19:39 -0700
Message-Id: <20181019201940.138179-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timing diagram of some eDP panels says that you're supposed to
wait for HPD to be asserted before the aux channel is operational.

In some cases, however, it's better to just hardcode the max delay
instead of trying to use HPD.  Why?

The sn65dsi86 datasheet says that it only reports the debounced
HPD signal to software.  It will tell software about HPD assertion
as quickly as 100 ms after it's asserted, but sometimes it might
take 400 ms because it's timed with a very inaccurate ring
oscillator.  In practice it was measured at 200 ms on at least
one system.

On a particular panel, HPD was asserted 84 ms after power was given.
This same panel specified that HPD would always be asserted within
200 ms of applying power.  Thus on this panel with the measured
84 ms to assert HPD + the 200 ms measured debounce we'd wait 284 ms
which is 84 ms longer than just hardcoding the sleep.

Let's allow boards to explicitly choose the hardcoded delay by adding
a device tree attribute for it.  A few notes:
a) This delay can't easily be in the panel bindings because the delay
   wouldn't actually be needed if the same panel were hooked somewhere
   else (someplace with more sane HPD behavior).
b) The nice thing about being able to set this delay is that it's also
   useful on boards where HPD wasn't hooked up at all (for whatever
   reason).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../bindings/display/bridge/ti,sn65dsi86.txt          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
index 0a3fbb53a16e..1a1ca0f7a1d8 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
@@ -33,6 +33,15 @@ Optional properties:
 
 - suspend-gpios: specification for GPIO1 pin on bridge (active low)
 
+- ti,panel-hpd-delay-ms: Assume that HPD from the panel will be asserted within
+			 this many milliseconds after giving power to the panel.
+			 With this number we can ignore the HPD signal from
+			 the panel and just hardcode a delay.  This is useful
+			 to do because the bridge chip only provides the
+			 debounced HPD signal to software and the timing of the
+			 debounce is very inaccurate so it's often faster to
+			 hardcode the max from the panel spec.
+
 Required nodes:
 This device has two video ports. Their connections are modelled using the
 OF graph bindings specified in Documentation/devicetree/bindings/graph.txt.
@@ -62,6 +71,8 @@ edp-bridge@2d {
 	clock-names = "refclk";
 	clocks = <&input_refclk>;
 
+	ti,panel-hpd-delay-ms = <200>;
+
 	ports {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.19.1.568.g152ad8e336-goog

