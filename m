Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3907C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1552175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="JIivbSlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfBDUW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:22:29 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39925 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfBDUTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:31 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so2920239itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Wde6ywv5CF0puEGzOKeSGxb2sXn9lYuppXAmRLphNEk=;
        b=JIivbSlbp2j/EJ4lWyi9eHg5ZUpbMLDwVOvGctIZGJvvJ8XzHh7LdcyYnz7H+Ag8k1
         DQAqYfC7FwlsOfjzlNtyw1xZUu4L3xn0JxOK/rzJiOKiz68duOudGzngUQcw2YH9RpF4
         L332KkqM07bzhZBUUwng35EvYo/WcegzTPo8AAghxRszniDf5fmxwgTeEzwOI0HzG5sn
         cSm1jzDu7vb/zkjOvBooKXStTm5A7asXbVwwjwOJiWJjZkV2NWhGe67xIAU0HzeBBohS
         HPOwWPcOPYRIzIzakv7sLuZzP+YBeGcKfNWhTrBNwr8elEEyYMvRpP7nd38zWrjCTRUH
         mfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Wde6ywv5CF0puEGzOKeSGxb2sXn9lYuppXAmRLphNEk=;
        b=K6JEFU2PHgjkqZgYqi+EearYzlgbL8ZYcbh0Hc+iq+uyc1e07EddIWFMlEdDv4BJdX
         bQJRNG9V3eDuK5lp2Jn/iJLmIcDypeOktO8P2nPlBAxO2TGEPohQQIIVH5nA1V9BSqal
         eSiErfvPnBCiiefgEWinSgHpZtcTFaV2dRsSmgtBrGiUknV6o+n05GNtiuKGNehxhwy3
         XM/bsIPutZsjUmHePsBiUCAPnDUtuqz3Fn4L2U2qsZp96Adpv3Nsrcjte/Le+OoLA3DY
         mAuFIgZXjmR4MW+fabjBsrLidLlsxrqF0MZ9f3vrJDAgo8HOd8YFiVcl4ryJ+XvIyiz8
         OuSg==
X-Gm-Message-State: AHQUAuZrFMAXv90lIvMf/v8T4r159dfy7uf3SRZzzEn45FBh3opncNHO
        8B8Y24ZK/8kvhfzjrYbYqtzY/w==
X-Google-Smtp-Source: AHgI3IZFEfx8auZYTldQHlrfwtdXc3aKOjTgWiYOOmN2SQ6WaM/4XDXaPzI22T9ppFP6Viw9wLwGiw==
X-Received: by 2002:a5e:d503:: with SMTP id e3mr827208iom.291.1549311570756;
        Mon, 04 Feb 2019 12:19:30 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id x79sm470003ita.34.2019.02.04.12.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:19:30 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: Add LM96000 as a trivial device
Date:   Mon,  4 Feb 2019 13:19:04 -0700
Message-Id: <20190204201906.8859-3-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204201906.8859-1-jgebben@sweptlaser.com>
References: <20190204201906.8859-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM96000 is a temperature sensor and fan controller based
on the LM85.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index cc64ec63a6ad..d79fb22bde39 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -322,6 +322,8 @@ properties:
           - ti,ads7830
             # Temperature Monitoring and Fan Control
           - ti,amc6821
+            # Temperature sensor with integrated fan control
+          - ti,lm96000
             # I2C Touch-Screen Controller
           - ti,tsc2003
             # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
-- 
2.17.1

