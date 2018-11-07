Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0EEC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56A120989
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOIDwmxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56A120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeKHHBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:01:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46077 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeKHHBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:01:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so16085049ljc.12;
        Wed, 07 Nov 2018 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6vcWWTl3ebvipFnYFugbKnPUdf33cHwYS4fWiZH16YA=;
        b=pOIDwmxdTU/5o5PxIuKV8jqM08VzZVV45NE7w5bIZ6ASsWOcQlLnBAk4evo7O2Fy14
         Nh1S/HncUr8bAV1X4a13zthVzUXMQMEyeDOAIDyS6mYAymVnI6ltZ4gGD9v7+OeRGaY8
         gwh171n6gPTE++MssLD+cDlkGQmpQARx+Kxrh9YCvyfAUqGlvtebYnNpe7F2SqXcpqBj
         Uin2qMpmEoXq7ohkRwf3sBR4w/6rPISPDds8ZRDlF2cegS2op4Pfe1lpE79oHMcRt+HK
         PnfbFVT8jwlx1wVdldXswmm5VCKfSWnuwNp6PcqqBvKzSZM21GTbgfiXTINLNoimhCrC
         eyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6vcWWTl3ebvipFnYFugbKnPUdf33cHwYS4fWiZH16YA=;
        b=Mg/LORJcZHlJlEbFkogx4WvGkdQNHv2lRuxvAA+2fhfIWXKej7lN25hpALwvTDrm41
         b5NZrNUrVdk/9vjp6WnjJsfqyhWOqq8NtOJpfchmUM3Tjv/uQXJgVAkxJTZtfhpY4w23
         yjRYefbpKZacyO78PlPHwopiLRTjF+u+bIlZhz8MgryNE1bOod8kiFNc3qhmDw7487bV
         uJu7q92NXBx7U46gPbJ2Vf2PvFgv4THCo7dKwfxXdQQr2z39OSMUXXL6lmd3/ZSuoSOy
         /3Sl+dS1+iKl21ypuv78V99Pb2PzvL0MgiBMSU3PrFkHcDIyvObkU3jQd39CmFv2nym0
         wOLg==
X-Gm-Message-State: AGRZ1gJAgsEeDOvw7wqhG6dEVuZ/IeUhVtBXtT2Y5diOqLX/k8/MsTkt
        pRZwpm3Ca2/buZZCkucWBH0=
X-Google-Smtp-Source: AJdET5fbY95RO7GxJweu85nwpTviRO1iml9J1JOewsMtlScCz6p6ro2SJGawcWca0LoDSIe58GAv7g==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr1151189ljk.114.1541626130857;
        Wed, 07 Nov 2018 13:28:50 -0800 (PST)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id 18-v6sm310020ljp.49.2018.11.07.13.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 13:28:50 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix possible use of uninitialized field
Date:   Wed,  7 Nov 2018 22:30:31 +0100
Message-Id: <20181107213031.21650-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While playing with initialization order of modem device, it has been
discovered that under some circumstances (early console init, I
believe) its .pm() callback may be called before the
uart_port->private_data pointer is initialized from
plat_serial8250_port->private_data, resulting in NULL pointer
dereference.  Fix it by checking for uninitialized pointer before using
it in modem_pm().

Fixes: aabf31737a6a ("ARM: OMAP1: ams-delta: update the modem to use regulator API")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 1947bc63074e..17e0b386e1b2 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -764,6 +764,9 @@ static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
 	struct modem_private_data *priv = port->private_data;
 	int ret;
 
+	if (!priv)
+		return;
+
 	if (IS_ERR(priv->regulator))
 		return;
 
-- 
2.16.4

