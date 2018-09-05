Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2242C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6780E20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6780E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeIFAJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36321 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeIFAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:29 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so15955536oie.3;
        Wed, 05 Sep 2018 12:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7aN5Q50ZwUddwkIjc7Sz8kupEdtSiBHeR4i+os989Q=;
        b=nGNNmmCmBG3HsKWQY5ds3F3aV+d4oxaIbo1VxieBsk1DaD36x+3JDVKBn7qaLXx4da
         +oFwIYueklgMAI2EL32scFTTFY/o1KxaypZC5lpWW+QRjLR6js6z2bjlXJcv9An47isl
         MUVi/t40R/K4RoZWJGMqk68+yH34DTIvEPREX4nfcYakv3dQS7tnl8OysYoG7AXUrpCk
         f/We3BPoSImSmqWKjYuKyQ4M5ZMlJniTsrikkrA3F9gf+XMVD66CZ+8Y9rwPagaC6t3d
         6COGuTxSO5LiqHH1naTHrsj4o3ab+jlxQX4gnww0aMj46rO7Kn8DHRf04uIfkgHvT1ac
         OOkw==
X-Gm-Message-State: APzg51AB6H9RiZXuciI8K86oXk9Ljr6o5KgObDeCR/knwTuOOY5sy2Eo
        DZXhFmLIjFf82OSOUA87S+Cf2EI=
X-Google-Smtp-Source: ANB0Vdbu4qeU1LW0AMRGPj/6ktzY5EuVzk+89ObPTxbShlFlJeEjQWmE3KLdBdszQ7lEdM0vVohxQw==
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr33049047oie.152.1536176271371;
        Wed, 05 Sep 2018 12:37:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:50 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 10/21] openrisc: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:27 -0500
Message-Id: <20180905193738.19325-11-robh@kernel.org>
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

This also fixes a leaked reference for cpus node.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/openrisc/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 9d28ab14d139..e17fcd83120f 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -158,9 +158,8 @@ static struct device_node *setup_find_cpu_node(int cpu)
 {
 	u32 hwid;
 	struct device_node *cpun;
-	struct device_node *cpus = of_find_node_by_path("/cpus");

-	for_each_available_child_of_node(cpus, cpun) {
+	for_each_of_cpu_node(cpun) {
 		if (of_property_read_u32(cpun, "reg", &hwid))
 			continue;
 		if (hwid == cpu)
--
2.17.1
