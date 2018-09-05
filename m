Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E99C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5CD20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5CD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeIFAJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40328 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeIFAJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so15924978oig.7;
        Wed, 05 Sep 2018 12:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wal0t/pq4j6SHZM6giP5gRDOGILfFfu2UrsgCKzgCyY=;
        b=iuCAHhVRieFUXudS26/i4l77r7BnNXdj4s1SyJmXl5EfBQsBnIUuFAYb12t4OC4d2x
         AXlm9zbRtBjs67lJsJtJFJjR2usaC+ocprn/UyuxZ+RhnUP3QAJ6Y8cH2Cb6oDf84RRq
         Ic9aKH76mdRwwtljfJWlwAYlXggdzAE9xPKNsF5P2kH7+B+HyU8UScHeLtmXq4kDppWE
         BTO6t9UrGdOS+GqTLyOVn3GVczfhOHfaKXb9K1b0GPPFBlML8fTavdzwYqvPsQH35N19
         hlB7GdYNUHWqRwIpbvyQogS2rkx9k6grAFPJ+2PcQWgTdrAZvV9RHNdDC2ZrRdI944hQ
         4stw==
X-Gm-Message-State: APzg51AAgijYUfJ0KnurAk8s6J3yhTQrXK3JVvyvfF45cydtVPiVfQcF
        RVaK3vjvDBJhcW751DEgKdnSmC8=
X-Google-Smtp-Source: ANB0VdZFiuCQ3LKMdACW8r68bDOdReYPLulpeXUSIO+PGwEWpFUFtm8li3z+sQPMVZ2cjtkVZ51miw==
X-Received: by 2002:aca:b904:: with SMTP id j4-v6mr33254543oif.89.1536176276566;
        Wed, 05 Sep 2018 12:37:56 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 14/21] riscv: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:31 -0500
Message-Id: <20180905193738.19325-15-robh@kernel.org>
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

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/riscv/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 56abab6a9812..3c59afe67951 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -52,7 +52,7 @@ void __init setup_smp(void)
 	struct device_node *dn = NULL;
 	int hart, im_okay_therefore_i_am = 0;

-	while ((dn = of_find_node_by_type(dn, "cpu"))) {
+	for_each_of_cpu_node(dn) {
 		hart = riscv_of_processor_hart(dn);
 		if (hart >= 0) {
 			set_cpu_possible(hart, true);
--
2.17.1
