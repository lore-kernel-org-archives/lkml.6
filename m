Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D416C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF0720883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw6X/Uc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfASJBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42552 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfASJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so13586138lja.9;
        Sat, 19 Jan 2019 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OMj0V3WJlVkkkCXQcxklvPa9pcGHx9O1wUkkzb/B9s=;
        b=Tw6X/Uc0MUuK+PT73msgsRYGPY+ozTfKqL1QOFm9Cn1I+w5Pplr+NUSCWafA+9TXC2
         3YPBGa1ID9agIZPoXCcsWz7RVW7/RoB8K9JayCe/XbHRqFDHsVGlarq1NRRTm4K50oCX
         Gql/oy8Oz5ArBD3xNR+7NYHS3Ard/u2TgCW+d2s03c92ZmbAq8aZQ6bwBOawP0H+DDa+
         xVinIVy6tG1aZrCz2lxiS3s0ccDcco06Jnr0GPrnZYXu9+jB4oFEw0tmsELxmTC4pXUH
         W5H0hnGfpjYBNK/t9tzYZLdYuEBga9XourFMY64dhvjMb9fExP++LdVBSdcWX4r/EyRs
         LP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3OMj0V3WJlVkkkCXQcxklvPa9pcGHx9O1wUkkzb/B9s=;
        b=mdAhaEz29gYZ8pgsAtBoDCEL+XgTVw22BPy/BXOaZficAfJZDuwGC4SJqCGfBUCJOz
         5GDmO+S7YvTjdWl161+er552q+rfDA2al52B3+joVb8U3NyjlotTPFzbCzvXW+mKr276
         yr2np/IC3GCKf7+tjxo0MQWem00S5Kk2LPXuBaf4mGpxFXMiE1A6rtLbnuuSMSyEAt0d
         sxAEgsE/N9MMbVvu3Bw4PWx1T2npvIa3HfgIEfjr2qW9KuPa++CERYJ87o5pldg6C88P
         82mx1C55LPS9WWmXj1yScMVTuArfir06BHXYAQMCZkVvKXAJd1Dp9O+vIbolzxmN6DVG
         2EzA==
X-Gm-Message-State: AJcUukfTDHhTrguBhSp9NBcuqTMicarWxNTyHYK6UFZpbeOIyPJF+Ibo
        yybM+kEd86BLFuCRw/bc1k8=
X-Google-Smtp-Source: ALg8bN75d8KF6zxVqbHsI+CxWM2wPItbUYip48+WFfPJZvUf0l+8fJTi7R6wWv+PSPdWNHFFYEz44w==
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr12418732lje.88.1547888463852;
        Sat, 19 Jan 2019 01:01:03 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1254995lji.45.2019.01.19.01.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 01:01:03 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 2/6] dt-bindings: rtc: Add quartz-load-femtofarads property
Date:   Sat, 19 Jan 2019 10:00:27 +0100
Message-Id: <20190119090031.29147-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119090031.29147-1-sam@ravnborg.org>
References: <20190119090031.29147-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quartz-load-femtofarads are relevant for
several users. Add it as a common property in rtc.
Note that valid values and default values must be documented.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Suggested-by: Rob Herring <robh+dt@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 7c8da6926095..41eb335ea816 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -21,12 +21,16 @@ Optional properties
 The following properties may not be supported by all drivers. However, if a
 driver wants to support one of the below features, it should adapt the bindings
 below.
-- trickle-resistor-ohms : Selected resistor for trickle charger. Should be given
-                          if trickle charger should be enabled
-- trickle-diode-disable : Do not use internal trickle charger diode Should be
-                          given if internal trickle charger diode should be
-                          disabled
-- wakeup-source :         Enables wake up of host system on alarm
+- trickle-resistor-ohms :   Selected resistor for trickle charger. Should be given
+                            if trickle charger should be enabled
+- trickle-diode-disable :   Do not use internal trickle charger diode Should be
+                            given if internal trickle charger diode should be
+                            disabled
+- wakeup-source :           Enables wake up of host system on alarm
+- quartz-load-femtofarads : The capacitive load of the quartz(x-tal),
+                            expressed in femto Farad (fF).
+                            The default value shall be listed (if optional),
+                            and likewise all valid values.
 
 Trivial RTCs
 ------------
-- 
2.12.0

