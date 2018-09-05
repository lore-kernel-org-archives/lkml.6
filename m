Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27EC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08EB20867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08EB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIFAJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32784 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeIFAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so15991242oip.0;
        Wed, 05 Sep 2018 12:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ogh2LMa7oIMA73dH0bBLUtgkzUXNill/EWPZtdCSSbg=;
        b=M4GzTlCedGuW29+CZCFar2Vvb7YCYXW6z2s6nDJkVCy5rKL3Z6xJGru98xolCbDWUC
         VZz6GySp82n2096AVb0xKOuvYVrIHetTqBp7614jkB9jSIMSqkXXFBvx4biAMUMQGkp8
         yDWXAICx8zG59MfeW4E+oia3jnCIxTHxKlbaxhFvdsuyaOlbGv/SnVl30r0IdDTSnsZV
         KgUeSpP0LJ7x0xFkvumORWqhMqL9aLPj3ocWX1VD/91ZAnOMhErHkDI8Lz4Bgt1SsZ/c
         ljR7rQiCtkVS9NV2qcueTcC1uKjJQdPGPg4165nq9CiE4g7wl3lOG6Vgiai22UXMa5b6
         bhMQ==
X-Gm-Message-State: APzg51DxxZaoMrdDRRr1I2BZGi74c/KZKv3hfrnG9Z5gv0XwhwW6+/Jz
        ZJASfiEpQnjFkXgbrQhfeyUl7XA=
X-Google-Smtp-Source: ANB0VdYy8er6nHvLgDbKnmGZO8vuumx5HLrC0DYxBCR6alj2Cmintu2H9bil5N92ompwznusfPPPRQ==
X-Received: by 2002:a54:4091:: with SMTP id i17-v6mr19204570oii.352.1536176267710;
        Wed, 05 Sep 2018 12:37:47 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/21] arm64: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:23 -0500
Message-Id: <20180905193738.19325-7-robh@kernel.org>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 25fcd22a4bb2..96b8f2f51ab2 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -602,7 +602,7 @@ static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;

-	for_each_node_by_type(dn, "cpu") {
+	for_each_of_cpu_node(dn) {
 		u64 hwid = of_get_cpu_mpidr(dn);

 		if (hwid == INVALID_HWID)
--
2.17.1
