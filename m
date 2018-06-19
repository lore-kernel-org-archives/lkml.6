Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AFFC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BA120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BA120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967336AbeFSVrX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:47:23 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38357 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964888AbeFSVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:47:18 -0400
Received: by mail-yw0-f196.google.com with SMTP id w13-v6so450949ywa.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wLVnH7vIuGi0xSrrr/f9kAJNZm3q+kno8SThjP7bEPk=;
        b=rJI9EiVbtyuNC+1y+z/Bw5lvq+1OcNqR8eyCPq8XtrRPYlyinHJo6F7RGquE4jhBKS
         cKgpMqEnKCwEP2jIy2LbZDKQ4a1aI5va2TDKukJfQEgBux0wSlWQrWgtg/dOMfONnJLQ
         q6TLtauvajHgFmcw81kM/7w1Jdd7Zep1KJkIsvXraI727y9YzcPECti2qoA2Rg4kJib5
         JHBnb5Fs5ZD13Fqwgn8XrFH3JQYnbqXviNzCto608NPrZvyVfCy8sfPVwd6PPUGjmFkN
         Pav0V7ZIOBiHzx1c94HBaQk99cx9okbA2zhtFs8ZCwNsePrGv5W8KK35SgPUJsWnDXbu
         ZgQg==
X-Gm-Message-State: APt69E2A9mrNrhV/pmzo/9lNBUy3JKt1IJi6mcUcj6vBo1FZ+gGoylEm
        VDxQkKQV8Oex6oTLCRxA/A==
X-Google-Smtp-Source: ADUXVKK95K8qb9qEUxyZffW815yMRebygAB5bY6ffYmiYsR8JhWIoRoWunrDUe6Q+dKD/gP3UWe7Kw==
X-Received: by 2002:a0d:c905:: with SMTP id l5-v6mr9331254ywd.308.1529444837527;
        Tue, 19 Jun 2018 14:47:17 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id x66-v6sm333612ywc.76.2018.06.19.14.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:47:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/5] MIPS: bmips: remove unnecessary call to register "simple-bus"
Date:   Tue, 19 Jun 2018 15:47:08 -0600
Message-Id: <20180619214710.22066-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
References: <20180619214710.22066-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core will register "simple-bus" by default, so it is not necessary
for arch specific code to do so unless there are custom match entries,
auxdata or parent device. Neither of those apply here, so remove the call.

Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/bmips/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3b6f687f177c..231fc5ce375e 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -202,13 +202,6 @@ void __init device_tree_init(void)
 	of_node_put(np);
 }
 
-int __init plat_of_setup(void)
-{
-	return __dt_register_buses("simple-bus", NULL);
-}
-
-arch_initcall(plat_of_setup);
-
 static int __init plat_dev_init(void)
 {
 	of_clk_init(NULL);
-- 
2.17.1

