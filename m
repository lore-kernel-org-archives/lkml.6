Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2B3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2566920839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2566920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeIFAJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:29 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46131 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbeIFAJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so15870195oie.13;
        Wed, 05 Sep 2018 12:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jrg1zbMesAMdjnvTSH+V43cpguLxHWMPgV4Z9iIWt8s=;
        b=aFqzOloGM4RfxMM+ggBp5jeia2xvin7AZ7a/pj4fCNwXKh6yLcIu9dYrN6ChcjjrCo
         0KmovKvizi6v7rVBE/bhAEZXxshjKXGTA4ZXzK5JyIdKILAGc6DV0DSU3PCcgUCi4W6d
         okexDvbLL7HMCF43VSlTI0iRSvG7yR1uMPuzULQcboStE15cwTC3b2Q1jOAAUUNDYPbH
         N8KiWW43nhvRLRO7qAtar8it70uUVQjGNM1QK6sR5+iTozHoB/AYBKiMfTow/BW9c/FH
         RSPM7RGLNHs4PHwjPmVnvhFdr/iJMWiVhH1B69g8JCUMZ4I19NThp6oNYjabdW8rz2rk
         fBhw==
X-Gm-Message-State: APzg51DQBqlvYI3mXjamAc/2VaHC8+IAt6nJGSPaiacwZWDO6cNnUHqR
        p1o/RGDbE+CXOX8JUVvDJ/3Ks1Q=
X-Google-Smtp-Source: ANB0VdY/21+LNAdZrCd1NwdjrSI8q6sRPmTXazVsIlHBDAF+oVXHJVLptgmTvjuHhpRNjq1x0HNLGA==
X-Received: by 2002:aca:5d86:: with SMTP id r128-v6mr7292755oib.243.1536176270404;
        Wed, 05 Sep 2018 12:37:50 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH 09/21] nios2: get cpu node with of_get_cpu_node
Date:   Wed,  5 Sep 2018 14:37:26 -0500
Message-Id: <20180905193738.19325-10-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"device_type" use is deprecated for FDT though it has continued to be used
for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
node names by default. This will allow the eventually removal of cpu
device_type properties.

Also, fix a leaked reference by adding a missing of_node_put.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/nios2/kernel/cpuinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
index 93207718bb22..ccc1d2a15a0a 100644
--- a/arch/nios2/kernel/cpuinfo.c
+++ b/arch/nios2/kernel/cpuinfo.c
@@ -47,7 +47,7 @@ void __init setup_cpuinfo(void)
 	const char *str;
 	int len;

-	cpu = of_find_node_by_type(NULL, "cpu");
+	cpu = of_get_cpu_node(0, NULL);
 	if (!cpu)
 		panic("%s: No CPU found in devicetree!\n", __func__);

@@ -120,6 +120,8 @@ void __init setup_cpuinfo(void)
 	cpuinfo.reset_addr = fcpu(cpu, "altr,reset-addr");
 	cpuinfo.exception_addr = fcpu(cpu, "altr,exception-addr");
 	cpuinfo.fast_tlb_miss_exc_addr = fcpu(cpu, "altr,fast-tlb-miss-addr");
+
+	of_node_put(cpu);
 }

 #ifdef CONFIG_PROC_FS
--
2.17.1
