Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE6FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35632173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYt7kJyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35632173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeHTV3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:29:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39089 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHTV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:29:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id j201-v6so345525lfg.6;
        Mon, 20 Aug 2018 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dosDfoX2lLtKRM7stKlq06j/xqPONJf6rhUbBAZA3A=;
        b=lYt7kJySiIkQG5dCEZZYyHekHe1WO3mA42KOewv7dTKhwxPZZV9YL129N8DbJTEn2y
         IAXptQODRZ9bNzaoreSBu5Q0MWCgb+DA771iZTtiaNNXBKixt3yWs8WSx5CZ6OwgUne1
         MJHFcaeYt28Jmm/0fXRcj5iiVqqQyMwdZheHeQ0rpXKMj3aWmlop88lKYExjVaC9iCZ9
         gCYc9DXOMj/mpht1B5ZC3m3TlEti9qEZX4t9uhfIyZkAiXJL0dCzMTDEfrSUTw7qa/kT
         ZbK4zPosEultQpbvhOaILKOhfeqXKpC3gO5dMqIuWBvQmsfTpt0yM12fcHUuZsxLO7k+
         w3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3dosDfoX2lLtKRM7stKlq06j/xqPONJf6rhUbBAZA3A=;
        b=qfeULCaSIwGporgMCdjipE2q2b3c0zRanYVTjrcB0aMGKWRVrlW2hEhdPzjXrjtUue
         KJ7g/fPcrQL3gax+63Tcb60HPoYrn5e3UKXbuTDUUdOex/0FF4PlWWD3b4RJRI8hv9Ps
         9qmeTeT74DmKtOiMGdVAGYwGNAYAw/nnuuLCaOnJ8mDC+4x+vXCkeUGk/SfBZV8W8Ow8
         mq+TdJDrtCK8C/HmwDiWVn72kNmRYuvLt1JIke1eKicqgtVrmjHfKJMtjwNI1oYNapuv
         KUsQ5vazZ4sViAwh9RUVNYgYOi1nR8WeWij3TqfYtNuuE2yltWWO2eRGlv5vxwl4zHnf
         AeaA==
X-Gm-Message-State: AOUpUlGRFU1NdVqDHun+zyp2mjrJ+tLRwkxY0q7loMP21b3KEqUM7x4/
        DA9EYzmZNSrVlOsWISIMBCA=
X-Google-Smtp-Source: AA+uWPwCCKr9vbqiCyZ0TV8HrKGZRAnyXByKBh8OBSxL82xY1pf4MTmwnQnBvqdjc9BdAvug9zVXmg==
X-Received: by 2002:a19:5353:: with SMTP id h80-v6mr15760581lfb.9.1534788759832;
        Mon, 20 Aug 2018 11:12:39 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id g16-v6sm379918lfb.5.2018.08.20.11.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 11:12:39 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 3/3] ARM: OMAP1: ams-delta: register MODEM device earlier
Date:   Mon, 20 Aug 2018 20:13:33 +0200
Message-Id: <20180820181333.2527-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amstrad Delta MODEM device used to be initialized at arch_initcall
before it was once moved to late_initcall by commit f7519d8c8290 ("ARM:
OMAP1: ams-delta: register latch dependent devices later"). The purpose
of that change was to postpone initialization of devices which depended
on latch2 pins until latch2 converted to GPIO device was ready.

After recent fixes to GPIO handling, it was possible to moove
registration of most of those device back to where they were before.
The same can be safely done with the MODEM device as initialization
of GPIO pins it depends on was moved to machine_init by preceding
patch.

Move registration of the MODEM device to arch_initcall_sync, not to
arch_initcall, so it is never exposed to potential conflictinh
registration order hazard against OMAP serial ports.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c865c6921af8..a98783f98f3a 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -896,11 +896,28 @@ static int __init modem_nreset_init(void)
 /*
  * This function expects MODEM IRQ number already assigned to the port
  * and fails if it's not.
+ * The MODEM device requires its RESET# pin kept high during probe.
+ * That requirement can be fulfilled in several ways:
+ * - with a descriptor of already functional modem_nreset regulator
+ *   assigned to the MODEM private data,
+ * - with the regulator not yet controlled by modem_pm function but
+ *   already enabled by default on probe,
+ * - before the modem_nreset regulator is probed, with the pin already
+ *   set high explicitly.
+ * The last one is already guaranteed by ams_delta_latch2_init() called
+ * from machine_init.
+ * In order to avoid taking over ttyS0 device slot, the MODEM device
+ * should be registered after OMAP serial ports.  Since those ports
+ * are registered at arch_initcall, this function can be called safely
+ * at arch_initcall_sync earliest.
  */
 static int __init ams_delta_modem_init(void)
 {
 	int err;
 
+	if (!machine_is_ams_delta())
+		return -ENODEV;
+
 	if (ams_delta_modem_ports[0].irq < 0)
 		return ams_delta_modem_ports[0].irq;
 
@@ -913,6 +930,7 @@ static int __init ams_delta_modem_init(void)
 
 	return err;
 }
+arch_initcall_sync(ams_delta_modem_init);
 
 static int __init late_init(void)
 {
@@ -922,10 +940,6 @@ static int __init late_init(void)
 	if (err)
 		return err;
 
-	err = ams_delta_modem_init();
-	if (err)
-		return err;
-
 	/*
 	 * Once the modem device is registered, the modem_nreset
 	 * regulator can be requested on behalf of that device.
-- 
2.16.4

