Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9A7DEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2E920896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkBzV63O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2E920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756147AbeFONtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:49:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53324 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755645AbeFONtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:49:22 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so2732311itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ivA9BtQexR618h01Wysq/Z5mUUCw6rpk+TJAA/oNKsM=;
        b=FkBzV63OYJUaKOLoGudf4EWeCgJaSN77y/dBU1vJ6Dr+Q7qE/zDwTDt7tp4KIJkuNQ
         yjbmlOhl3urVMvwgTOuFdMXYm4KQb+v6MNAzBoS22/6nUIVlZBjegLLZ43J8TuYjNX5u
         zvVC8foXrnszQ205n1K72LFzbQsIXcfbN4fJ4ArzPbaUknkcoRAyS6Fm4/CTxCvHgTi+
         0Kgx0lPLJcIPcVxowV0CBnQKJ+8+gbKtcPEpIApOBTtmfmeepo6mPII1DvTnm4wukgxr
         9K4c346eDv8VTX1+2KsAygCmu2sVO6gmHbiJewCBs7ygOXvriraQJSJQ2gcWpTHBTgqN
         wlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ivA9BtQexR618h01Wysq/Z5mUUCw6rpk+TJAA/oNKsM=;
        b=DwNHa1RuGmAxdXGlrDtNbddDEWkcBovyRd/GWFYGUVA/qu/CvkG19LH4ZEMaKmYQG9
         TUpqeDTUxNwXkb6ULSLHYaUZB0JCJcidkMlnGhe1hLfhE7cbwpcroTXj+nqeO34v1lNJ
         IpXZQIJc1cdS4/7P0ml9ijGGSZygU6dzHkJABLTUUBLclqiQ1eTkaQGyfr8+D9pW4WAA
         B09jB+ekP5funCXKCqYU7vKFTZF+JfD1fXr2cZOuJfCO+CDwAnjWEm8C6CExMNrozs+V
         oCIp+f9m+NaEqlsz+a9hGw5mjQMlpcbohsCoQTu5KNM6Oy1DO6kXumD8xEXxqSGZXkWr
         ukgA==
X-Gm-Message-State: APt69E0KhRjzuV5Sg2l72iddLnY23Gtsh1hHGmOX7AOTir0tup8kzy7B
        +ZV0HvwWusV/r7heb9rpHdbcQg==
X-Google-Smtp-Source: ADUXVKIqeQ57q7DExgyIWIWTok57BbQDmxxuS5YMPkl9gpZksXQM2hEwDfXomNmsxEQzqVzCDjZ7Cg==
X-Received: by 2002:a24:250e:: with SMTP id g14-v6mr1264282itg.24.1529070561585;
        Fri, 15 Jun 2018 06:49:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-65-120-235.hsd1.mn.comcast.net. [73.65.120.235])
        by smtp.gmail.com with ESMTPSA id x5-v6sm2708833ioa.65.2018.06.15.06.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 06:49:20 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>
Subject: [PATCH] ARM: dts: logicpd-torpedo-som: Disable twl_keypad
Date:   Fri, 15 Jun 2018 08:49:13 -0500
Message-Id: <20180615134913.29418-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no keys connected to the keypad pins on any of the
logicpd torpedo SOM's.

This eliminates some splat about malformed keypad properies

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 7d2302e8706c..9354da4efe09 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -196,3 +196,7 @@
 &twl_gpio {
 	ti,use-leds;
 };
+
+&twl_keypad {
+	status = "disabled";
+};
-- 
2.17.1

