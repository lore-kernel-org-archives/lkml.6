Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6732087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf7Z/iTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfAHSyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:54:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35250 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfAHSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so4344918ljb.2;
        Tue, 08 Jan 2019 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ETDqOF4bAwwBfWUMhw5KfrkBn9FRtphGWxtS6EWrTkg=;
        b=Kf7Z/iTkm1YXWGinu5RBDLKaiahUux/K3RG8yvYGGxaCDP/s2+mQq97lpPDIygbMZL
         rDOo/HbvfCoBn6AFREyyyOj2p4WGtv1/lVJqRSXVZq1ZGPP9tkOpcYT/dqjgylFmeHZh
         fRAuHMvQLRpSf1TsY+l7/1E+UGco66u5NzfPIA24ryxrL2UN0wvO1VPYr0ZGnXlej5sh
         x7RY8tedeOtfugOSk/g0qn+BsLqxtX+Ycr4hmnZcljbGakol2UwIcHpmJ4r77ce0oqyD
         JKm7SZLslJMd0SmHvvgwqLefNjNWDRPdh8V59qcMF9w4KMfTZqLOWzB0dgokrJIZrVBE
         3ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ETDqOF4bAwwBfWUMhw5KfrkBn9FRtphGWxtS6EWrTkg=;
        b=amq/1VcFiO0Ft5PG4EzqGyHZ2pia8dHho5fhfA/dSzhD1yo/N57oDhQaqNeup0Jp1q
         pH4a6XdQVUyEUEmP+r5lfcgpVrxswUj0Cy9czjb/6LH0czSxaAhE2FCNsfSKop0qzeNC
         /qqWJ/fW22ptg4be9/xqd2JIRprBf63KH91uzvlj5PrnYMy3rdl8TQusQj02TgbW0ylX
         SPacWmWyIXG3jC+OYVnFCVIEhsGndHWYlNt1Efqh4o44NaFBIoSbmCzNYFw9DdZNh1nW
         ULHyJw50Do/6LZqsRc8ZZli2esU6mHazDReZNEUjRE7bKO4D+ReXt26T/RPyXfSfaQNC
         3tmA==
X-Gm-Message-State: AJcUukfdBNpR/HQBb/Y5e+1vrnTEWY0+vrbfnZeshmQrSZWMsWI4NC1R
        crXIla+g59hLQakD9khuZBs=
X-Google-Smtp-Source: ALg8bN7BwCMqQrOwN40k32aHt7hpdKqq2sWZxX5bnE58huJGq5kCBB5TrT74l2b+qlJVjYNtEwNxaQ==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr448152ljh.63.1546973679592;
        Tue, 08 Jan 2019 10:54:39 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a11sm13321648lff.68.2019.01.08.10.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:54:39 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] devicetree: property-units: Add femtofarads unit
Date:   Tue,  8 Jan 2019 19:54:10 +0100
Message-Id: <20190108185414.26922-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108185414.26922-1-sam@ravnborg.org>
References: <20190108185414.26922-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dealing with capacitance of 0.5 pF then
a smaller unit is preferred.
Add femtofarads to deal with this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/property-units.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index 45ce054d844d..bfd33734faca 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -31,6 +31,7 @@ Electricity
 -microwatt-hours: micro Watt-hours
 -microvolt	: micro volts
 -picofarads	: picofarads
+-femtofarads	: femtofarads
 
 Temperature
 ----------------------------------------
-- 
2.12.0

