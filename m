Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CABC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2FA20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2FA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIFAJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:23 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45481 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeIFAJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id t68-v6so15894088oie.12;
        Wed, 05 Sep 2018 12:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P8KAoGaqqdG0MEoqvgPjzWestWMNGhkRFyu8R356duA=;
        b=C2aUE40Xk2Sz5tyeCSEOtzaFlZPdiVqkRqJVLMKQ80UACKVPdL3epmkNmDDO8RWZvJ
         O1x9ihpJaRHz+TUz4O2R9YyQh61Z3TAVe3CcvYrCWN43vFyhp3rzPNu3T33B5pdomkri
         6MQ5OzzsQ8Ps+5lZK39nJPV6R19O9JCOjzo4+1qV9cf4x+ldJaD9YfORvX38Xq2Yv3cc
         EUYd8HJwKD0V6WnWjt+qCGEh+2gcprUte8mBwPz94R4DuF95wbGxaknMHapb0f1PEPox
         MaHhY+VNMUHMPEFV+ght3yn8/XZkXMABzcxHETLzAignMCf+H3/bmUE5zT37ZYh4KESi
         x+qg==
X-Gm-Message-State: APzg51DaFQ8ODJlm2YBhspV4bM9sayf74/MXOmhGg28ME2LcpghO65EW
        cQt2N4EfrFuteNJErWPLMCGlHLA=
X-Google-Smtp-Source: ANB0VdZbt7wwLA68lpjpMqoIU1Yw4Hyw7IWtE95slLAvaWO77q/pPqXjwGXZF0iIfmCZluaiww+fEQ==
X-Received: by 2002:aca:720e:: with SMTP id p14-v6mr20428268oic.40.1536176263765;
        Wed, 05 Sep 2018 12:37:43 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/21] ARM: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:20 -0500
Message-Id: <20180905193738.19325-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/arm/kernel/devtree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index ecaa68dd1af5..13bcd3b867cb 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -87,14 +87,11 @@ void __init arm_dt_init_cpu_maps(void)
 	if (!cpus)
 		return;

-	for_each_child_of_node(cpus, cpu) {
+	for_each_of_cpu_node(cpu) {
 		const __be32 *cell;
 		int prop_bytes;
 		u32 hwid;

-		if (of_node_cmp(cpu->type, "cpu"))
-			continue;
-
 		pr_debug(" * %pOF...\n", cpu);
 		/*
 		 * A device tree containing CPU nodes with missing "reg"
--
2.17.1
