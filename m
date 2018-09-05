Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DCCC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDEE20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDEE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeIFAJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38164 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeIFAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:27 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so15932689oix.5;
        Wed, 05 Sep 2018 12:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BozMFRD6b8JP7Za+m/l6yQcG8PXXn63O1+XHPU/v3vQ=;
        b=p1tY0ZDUQTpli+ES36iOpJs6CPTjDYOcz3Odv85Nyj6K6QnYC2uoDLi8X6QtlB7yWi
         c66uP8SUr+YiUm27GVNcoZCSTdNypD5GeCnonstM96s4q5IhHs4aMIMUj+DOOVUrtuPi
         X7852Ek36agp4ZXMTl498PbYfXluKzUU14mdk3qrrnMmpgft8+NdYVqsK6BHlVMAjAFG
         aVqQ+Gxx79E965wMNF3Wc3lO6p8PuDxJFY3EoB1UpQurImNeCd03EmAYq9+MAVCPDfxs
         97Y3DKQDDzgHMCfvMH9uPbC5htElUz5I7xOG3GC3i7p+6PTxg8Xetc2vurDi6ozCbiAP
         bduw==
X-Gm-Message-State: APzg51DkjnFHj9II6ltFg9pt8JyT/oEbIh2IS3YqHxbYHNdZls7SN9b7
        Ks+L+CogeykScb0wtf26GsIvidU=
X-Google-Smtp-Source: ANB0Vda1L20jgLZ+3VSHLOcJ2ekVRY89KHUESX6Kupzy3r7nfq/ZJtKqZD/bztMXlb8PaMn1acewsg==
X-Received: by 2002:aca:fd4f:: with SMTP id b76-v6mr32231726oii.307.1536176269471;
        Wed, 05 Sep 2018 12:37:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Simek <monstr@monstr.eu>
Subject: [PATCH 08/21] microblaze: get cpu node with of_get_cpu_node
Date:   Wed,  5 Sep 2018 14:37:25 -0500
Message-Id: <20180905193738.19325-9-robh@kernel.org>
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

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/microblaze/kernel/cpu/cpuinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/cpu/cpuinfo.c b/arch/microblaze/kernel/cpu/cpuinfo.c
index 96b3f26d16be..0c52aca87478 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo.c
@@ -89,7 +89,7 @@ static struct device_node *cpu;

 void __init setup_cpuinfo(void)
 {
-	cpu = (struct device_node *) of_find_node_by_type(NULL, "cpu");
+	cpu = of_get_cpu_node(0, NULL);
 	if (!cpu)
 		pr_err("You don't have cpu!!!\n");

@@ -117,6 +117,8 @@ void __init setup_cpuinfo(void)
 	if (cpuinfo.mmu_privins)
 		pr_warn("%s: Stream instructions enabled"
 			" - USERSPACE CAN LOCK THIS KERNEL!\n", __func__);
+
+	of_node_put(cpu);
 }

 void __init setup_cpuinfo_clk(void)
--
2.17.1
