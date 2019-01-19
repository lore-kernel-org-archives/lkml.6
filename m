Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB2C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FF22086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MViwAQh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfASJBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42222 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfASJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so12180584lfh.9;
        Sat, 19 Jan 2019 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O6Cnu+m+ozyRU5A39kDFMLt2HxoGeNZAQCbCcxf5biY=;
        b=MViwAQh/6eA/Mg54qq3L+V9EpSw6021BNFbuAOw2TuxXLJJODcWMRptPuzG6Xprinb
         ox4DSVDR04RCyV8mouWRkwh0VXMbDH0wmv+ZThvnRNF6G+Xbrg7FRKBIxWS2RpPEX7LI
         5KIquE0hkbtu0PC+cZtvpL27TqkHmRQ5jJgpHUt48PJ5Vmml3q0xeE+9byr6BA+P/tV8
         BGwojQ5ZRFemBIsoEDY6xH8XQbt5aTvbkH0lh3x1r0cYnbj2Og3FG+u3nVeB6rIlpL1z
         P7ul9+LR1mT2uVzW6lwxU9G9UQlqe09N7zKdh7Tofmtjlxs+BI5OqFeFKcjAIikuGqBf
         3YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=O6Cnu+m+ozyRU5A39kDFMLt2HxoGeNZAQCbCcxf5biY=;
        b=XrbktLzBAaLeDYg27L9+lGWhdqhpl4PuPeHXQ7ybZfEIDXnK/j6G1tOpKo0bQcH0l1
         4Gzo1ujElotINUPIoNU1OY+v6tC4wtob0bbb1yw/+Xf6uWZ4ZIdN4V/KfMD+pHCZsI+6
         q7aeKe8W2+iNnLbP7JvRFxsy7E1ftIK5KBQ5RKro0qFoklTx+fivSE4AqflWg6HbZfeX
         HB0uNioBpUmOHbbz9ooDgfj7iS31X2PKmv+wY36D6Syktu5ErfscB4/hbnOtFvf6XOyg
         g66UKtP0GseryzcvDueQNTSsFY37QAIP52rvN5W4Dq/4uyjAnCvVvQoQiMdtcsh2eslP
         K0cQ==
X-Gm-Message-State: AJcUukc4MjbITiNsy5vrC+xuo1bsD3g1/5+J8wF7KXzrH3PXSLNO3h5f
        hICX0UOn1UI6G2Dr9rWifyg=
X-Google-Smtp-Source: ALg8bN7GJdiedYOk2gqvMd+qObZmk2S1LCgEfdB5TopilMw3gcbIu4bjqOWi/m1qZ7Abspg+Rqazgg==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr14033501lfj.12.1547888462780;
        Sat, 19 Jan 2019 01:01:02 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1254995lji.45.2019.01.19.01.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 01:01:02 -0800 (PST)
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
Subject: [PATCH v3 1/6] devicetree: property-units: Add femtofarads unit
Date:   Sat, 19 Jan 2019 10:00:26 +0100
Message-Id: <20190119090031.29147-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119090031.29147-1-sam@ravnborg.org>
References: <20190119090031.29147-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dealing with capacitance of 0.5 pF then
a smaller unit is preferred.
Add femtofarads to deal with this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

