Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB4B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzWbGje/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB4B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeIHASI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:18:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44246 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHASH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:18:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so12280741edb.11;
        Fri, 07 Sep 2018 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxWemkutHzdYemrD0OoMLEweuBox7qiGFhOxdgLjLOw=;
        b=QzWbGje/tnh4TnhxYhVWgOTfwYHfYt5oQ9aoo2TymqgxoXPeGPrhYfZMyyTvIhkEq7
         S417fN/IrQGRehfA2egAP7AWusBx6Qb5CWid8ycr9j7MFAOQuK1KReNz48x+9ieYwXTJ
         5BCIEyu5R2QlWBW7VyYL2b7w11ifgq/vSt0Nrye2BzrNMGVVQOMT/lXko8CjLBfOExX0
         nP04cT2xzeUQs46UmclSEuwMf1QyC04XfbJ5N+P98q6Z3hXQe3sRsa3mMVvdYb/7wp75
         8zQIguNxk1XBx/RZjgsfJbluXo0NBDFPqELEn12C7PkiFYuDH14HcYjPFfh++Ucx8sl4
         Csqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QxWemkutHzdYemrD0OoMLEweuBox7qiGFhOxdgLjLOw=;
        b=MTrlu25knwRcrLoOxA3Dr9ZWOI6T7DgvT3TpYeWpreJwa3dAGHA29k60hzuxjTi7pI
         2TYfJCspNeHc/it9HEsuWvbT/v2ZJKRL3Tjl8bftdpVc9c5mPUQqLNDQA4URT/u+VycD
         XIwNKxWwc88UUcWciMPVGo3G7mieHlwaWG1GD7Hc8kQAIbR+felz6Z5GRujfLDdtoVmR
         wlOgmzoX8133xLznOKFNkM/dG1iqh3iY1U1YOxIVbGzg6tBxlUcoqARopY142Xl9mN9C
         L8E9p0pqHzp5q0OWcfKudQEXIPwPsxEjRL1BJoyF9mMKDNJW0AGgjZlTEnqCrVicHNTz
         rcmw==
X-Gm-Message-State: APzg51CiVmEBDDtb6D0HAYwBGBChCjNL0BpHTAAdIsjIr90Jmxa5ptrQ
        7Rm+50mY7nvwjHOEfAE4PPI2BQ3umf8=
X-Google-Smtp-Source: ANB0VdbfLIoD7FlcbiG2uq8mKsLfnSuKJF7j48COUm/bGxWe18BsmYtelusEMXVTmhklxk9crSMrnw==
X-Received: by 2002:a50:cd9d:: with SMTP id p29-v6mr10574720edi.159.1536348942201;
        Fri, 07 Sep 2018 12:35:42 -0700 (PDT)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h34-v6sm4868808eda.58.2018.09.07.12.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:35:41 -0700 (PDT)
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
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 0/5] add quartz load support to NXP rtc drivers
Date:   Fri,  7 Sep 2018 21:35:03 +0200
Message-Id: <20180907193508.24974-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180822183555.GA24084@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rtc drivers for NXP pcf8523 and pcf85063
have different configuration of the quartz load.

pcf8523 hardcode the quartz load to 12.5 Pf
pcf85063 uses the reset default of 7 pF

Introduce a new property to the bindings for the two
rtc devices to specify if the quartz load is 12.5 pF.

Update all in-kernel DT files using the pcf8523 to specify this property.
And finally update the drivers to support the property.

NOTE:
This has the side-effect that any users of the
pcf8523 driver using out-of-tree DTS files needs to
add the new property to get the same behaviour as before.

	Sam

Søren Andersen (5):
      dt-binding: rtci-pcf8523: add binding with quartz_load property
      dt-binding: rtc-pcf85063: add binding with quartz load property
      dts: add nxp,quartz_load_12.5pf to all pcf8523 nodes
      rtc: pcf8523: add quartz load configuration from DT
      rtc: pcf85063: add quartz load configuration from DT

 .../devicetree/bindings/rtc/nxp,pcf85063.txt       | 19 +++++++++++++
 .../devicetree/bindings/rtc/nxp,pcf8523.txt        | 19 +++++++++++++
 .../devicetree/bindings/trivial-devices.txt        |  2 --
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts       |  1 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |  1 +
 arch/arm/boot/dts/imx6q-h100.dts                   |  1 +
 arch/arm/boot/dts/imx6q-novena.dts                 |  1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  1 +
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       |  1 +
 drivers/rtc/rtc-pcf85063.c                         | 31 ++++++++++++++++++++++
 drivers/rtc/rtc-pcf8523.c                          |  6 ++---
 12 files changed, 79 insertions(+), 5 deletions(-)
