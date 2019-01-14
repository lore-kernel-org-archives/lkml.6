Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA48C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8E820657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVXzZCdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfANCgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:36:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34810 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfANCgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:36:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so14543457lfc.1;
        Sun, 13 Jan 2019 18:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaPAdD6nBm2/G0wO+WyEu2DKrepgQ79BwnkVCxBp/YU=;
        b=GVXzZCdqQS0XR+7QioUCXnOAS2AAbtjDUfryu0klfpViosw3oX4AMkU6RpYkMLJljv
         zwtbdFI90Y0S3RhYEC8XgUCoh6Rlg1bgDkZLN8mfQ/G7e6Uudc1hI0+sMFFmysk9BmhG
         rtS+UcSeBPejC5JaOcJE0i8trcbsXGD3fuxddBQ8iikTtoK1FXf5mh92Wj0tOU3+GEEw
         5QPS1ptTxNT8BPHpggQkgNOFNxDhWz+G6By/7yOS9WKjiPL4vvxVI5h+Zb0aT5xjLPOi
         kPJ5yxsUavffrU5LbiQr8Fxcmbi1mFflIfw75tJPaFHurNIrv6TqghFIM0Ofj7lAikZY
         HTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaPAdD6nBm2/G0wO+WyEu2DKrepgQ79BwnkVCxBp/YU=;
        b=L3jaHcnJVMwJNMgHj1viBj1w4V7OI1epKifR+TG+HkrNkvc402I4qU6poOBMGHG920
         0PTa1yb4gYXfeAI1NAIQ0stQVGR3RtSwQl/7InEcGDawjmrgKDV4XvfCdaHdiHVLHh/A
         csDcvdoYzBIi+hi6tG0nBRXK/Mc3P36vzwNOxL66etDP89RNaXeheDysb02Q7tcakLtT
         DRonjQbQLosV9E533enfHku3ocxxhciy45wGfmkihRWpQSJjol5htvOdfFUAAoxwxYu5
         3lbqoBq2nHZFClOyROEWrgr7sHm6O8cruFLysc+yPYcshxN9peMyNcp/LRMVT7YVDTMg
         TeoA==
X-Gm-Message-State: AJcUukcU9LuO1BMWxOmn6/Or82tLYZpEZEv3JBHik4MXlzQiIjNxZ30v
        ja8mHiyWH7zEQBrUS8F5P/T/itIbH/Xj8A==
X-Google-Smtp-Source: ALg8bN54oSB5yE4r9o3UqypWAWUfQMXho0mEAJLixrQ0hsNTIbaAdHR8v4vo3oK2ldgfi8H7EoxEGQ==
X-Received: by 2002:a19:d5:: with SMTP id 204mr11517509lfa.116.1547433397427;
        Sun, 13 Jan 2019 18:36:37 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id m4-v6sm16876897ljb.58.2019.01.13.18.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 18:36:37 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-watchdog@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 4/4] watchdog: hpwdt: Make panic behaviour configurable
Date:   Mon, 14 Jan 2019 07:36:17 +0500
Message-Id: <20190114023617.10656-5-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114023617.10656-1-mironov.ivan@gmail.com>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option to not panic on NMI even if it was caused by iLO.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/watchdog/hpwdt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 95d002b5b120..b12858491189 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -37,6 +37,10 @@ static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
+static bool panic_on_nmi = true;
+#endif /* CONFIG_HPWDT_NMI_DECODING */
+
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
 static unsigned long __iomem *hpwdt_nmistat;
 static unsigned long __iomem *hpwdt_timer_reg;
@@ -146,7 +150,10 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
 
 static int hpwdt_my_nmi(void)
 {
-	return ioread8(hpwdt_nmistat) & 0x6;
+	int nmistat = ioread8(hpwdt_nmistat);
+
+	iowrite8(nmistat & ~0x6, hpwdt_nmistat);
+	return nmistat & 0x6;
 }
 
 /*
@@ -168,7 +175,10 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		 "4. iLO Event Log\n",
 		 mynmi, ulReason, smp_processor_id());
 
-	nmi_panic(regs, "hpwdt: NMI: Not continuing");
+	if (panic_on_nmi)
+		nmi_panic(regs, "hpwdt: NMI: Not continuing");
+
+	pr_emerg("Dazed and confused, but trying to continue\n");
 
 	return NMI_HANDLED;
 }
@@ -376,6 +386,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 #ifdef CONFIG_HPWDT_NMI_DECODING
 module_param(pretimeout, bool, 0);
 MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
-#endif
+
+module_param(panic_on_nmi, bool, 0);
+MODULE_PARM_DESC(panic_on_nmi, "Cause panic on NMI induced by iLO (default=1)");
+#endif /* CONFIG_HPWDT_NMI_DECODING */
 
 module_pci_driver(hpwdt_driver);
-- 
2.20.1

