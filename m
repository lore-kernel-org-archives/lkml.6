Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51916C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2E620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ojQM4UTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2E620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeLEXwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:52:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35246 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeLEXwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:52:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so14615504wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34XkaOe01wIOoB3ST9iGxBvvN8UuZkkXm8z0RSalvoM=;
        b=ojQM4UTUB8kZmgqURs1XcmR2d2CHy+4UJTRQa9ultIw82NLt4YdJyqfgJy1n8OId41
         JjORmLT7tTXOh5h4i8ShAl80mJY7/jouv83Kn8Ri0MCqldtI2BCcjFS93whiHUmaXFkp
         fIs+6PgznWffILv35Fj7Ilrz7Y5QHC/2mfLLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34XkaOe01wIOoB3ST9iGxBvvN8UuZkkXm8z0RSalvoM=;
        b=bVD7t3DL+5k3WHYsCmYYkFeelJPMCRKASsb7KonaHJYQ6icMuGRTa2aWA34z7TvMyG
         Pxuk5N3sFTR6ovc1e80LuJCI6qv3fClhYng9MXLV9rxiStCvp+N341XKyHAiU6XHxEVZ
         dWgH3gVOELhkX8bNhRFigme1uEvFwX77GGn9wW/yh6KvLGP5zKnjYMoEDyf8PewHStAT
         wSoG0iPiHBWjSpnrc8YHynzn2KbQCX5Zlp11PVCWxg339hEZiG4b3Q116xWUMI0PzpvM
         NBft7XJIkdfR+IHAI13qAZzEbeuO8VOyLbfOZqudAbm82tEs8deGvqI8hOHXNoJwMqyk
         dTeQ==
X-Gm-Message-State: AA+aEWbVE/jLcw2edHFjrSFFkKZkuIb258AH1WOUvbsDBOXL0ZFCXL69
        IyYKFw1DOX/zjmxaonZsfof8Jw==
X-Google-Smtp-Source: AFSGD/X8R+x8XzOlAAY7qIWjGrfWTNlSph8zGsN/UxuV0PRexFDdSHxvVyQyvBJhnQRgsu6kLwE22w==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr18497621wmj.105.1544053950027;
        Wed, 05 Dec 2018 15:52:30 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com. [213.198.161.243])
        by smtp.gmail.com with ESMTPSA id x15sm19113324wrs.27.2018.12.05.15.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:52:29 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/4] dt-bindings: input: touchscreen: goodix: Document AVDD28-supply property
Date:   Thu,  6 Dec 2018 05:22:17 +0530
Message-Id: <20181205235220.3461-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Goodix CTP controllers are supply with AVDD28 pin.
which need to supply for controllers like GT5663 on some boards
to trigger the power.

So, document the supply property so-that the required board
that used on GT5663 can enable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Rename vcc-supply with AVDD28-supply

 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..c4622c983e08 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,7 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3

