Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC71ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9793820846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="V8mF7mLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9793820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=castello.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeGWF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:57:07 -0400
Received: from gateway30.websitewelcome.com ([192.185.180.41]:36774 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbeGWF5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:57:07 -0400
X-Greylist: delayed 1505 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 01:57:06 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 87F3429BA
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:09:28 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hSA4f4nJBPvAdhSA4f93xm; Sun, 22 Jul 2018 23:09:28 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gJVPbSk8857ZuGk+QxKMuYs5yDFc6WURhmrUyWbVopE=; b=V8mF7mLan7WuQZHhQs0W4Btj6a
        in/OmnpeF30FNmgKSDA7l9f4KgWNEfVUbwBNpb7ZLSq9FiDOl8vLS19cjy+HHCxLXSA2yknxPQihb
        40o7csNwcDg3aOXsJg+dtYrNb+/PbfafMJODUmkAOjUK7auRZAx9TQuGMmepqPzcWR4dfWAi5bPqp
        WQJrw64u/4ZHq2sMwddyG8W3FN+acJOk+H9OcE0yt/Bm7nZSpHLUc0ZcDg9ljziQrYfM7jj9wwksZ
        9wZwlve20i9G5C0+cLLkApDrMdiC3JxVl0GYeQhGWpfUK/SODJBt1JzyxCszmpyaX4lIFppqi6yUf
        QFPrFy9Q==;
Received: from [191.189.20.114] (port=7927 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1fhSA3-001oyu-H1; Mon, 23 Jul 2018 01:09:28 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 0/4] power: supply: MAX17040: Add IRQ for low level and alert SOC changes 
Date:   Mon, 23 Jul 2018 00:08:12 -0400
Message-Id: <20180723040816.19455-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.13.3
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.20.114
X-Source-L: No
X-Exim-ID: 1fhSA3-001oyu-H1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.20.114]:7927
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 1
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add IRQ handler for low level SOC alert, define a devicetree 
binding attribute to configure the alert level threshold and check for changes
in SOC for send uevents.

Max17040 have a pin for alert host about low level state of charge and this 
alert can be configured in a threshold from 1% up to 32% of SOC.

Tested on Raspberry Pi Zero W, with a SparkFun Lipo Fuel Gauge module based on
MAXIM MAX17043.

Matheus Castello (4):
  power: supply: max17040: Add IRQ handler for low SOC alert
  power: supply: max17040: Config alert SOC low level threshold from FDT
  dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
  power: supply: max17040: Send uevent in SOC changes

 .../bindings/power/supply/max17040_battery.txt     | 24 ++++++
 drivers/power/supply/max17040_battery.c            | 95 ++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

-- 
2.13.3

