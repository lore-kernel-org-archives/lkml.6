Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC66C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D432086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D432086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeKHIFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:05:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40293 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeKHIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so2401114oth.7;
        Wed, 07 Nov 2018 14:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxS87lQ3nj/74C5MLjne/ka159Uu8qEX99KCto3gKTo=;
        b=meWnCiX82bToAzyxv1hdhSSj5jkNJPKu3FtAQRp5Coc7NKO3GPWgM33kGXmifRwQVT
         bWjJRkElvrKGLd0hN627FdqHX9NcJaHzluEFaYhuziXuTbz7T1cUCbo885LYrsqgbkrb
         W0V9ZQ9ys0fj5YxxhmPXg1TbCE+dQjWEetAjOHmQQZMhu6Y4PAJEq1Jn9Gr6HMu5bNN9
         BAmdubRT24GQkAdLbat1PzNAXEgOpfRHMgH91cqnU3eq9s71+aAMmX8SeLvPV3BJuJ38
         FLmyVFxLWuP7Xy0oHheQ7VhthrzbToosN6cTT58LBjVcQmAp9ryJmlyfihoLhYBtkNpz
         xCAA==
X-Gm-Message-State: AGRZ1gIYsjSJJQVST5W6GBl6zFQ9cLbd+jwfgqLoFgjQ0t6g3WfMJroA
        qiWL281nXF0E1Pme8fHrHJaYA14=
X-Google-Smtp-Source: AJdET5esAhSyCAWxV89RWPnblBh3W1RfqdDVB4p3WMaH24CBMWYxIlEIBmdRO175RF/Nk7CDVkLL0g==
X-Received: by 2002:a9d:654c:: with SMTP id q12mr1338592otl.338.1541629918818;
        Wed, 07 Nov 2018 14:31:58 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f9sm750959oth.17.2018.11.07.14.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:31:57 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 5/8] sparc: Convert to using %pOFn instead of device_node.name
Date:   Wed,  7 Nov 2018 16:31:48 -0600
Message-Id: <20181107223151.14991-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

This was originally applied for 4.19, but reverted. The problematic
changes to prom_{32,64}.c have been dropped.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/auxio_64.c | 4 ++--
 arch/sparc/kernel/power.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 6145658d915a..e1b10f88ffb4 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -115,8 +115,8 @@ static int auxio_probe(struct platform_device *dev)
 		auxio_devtype = AUXIO_TYPE_SBUS;
 		size = 1;
 	} else {
-		printk("auxio: Unknown parent bus type [%s]\n",
-		       dp->parent->name);
+		printk("auxio: Unknown parent bus type [%pOFn]\n",
+		       dp->parent);
 		return -ENODEV;
 	}
 	auxio_register = of_ioremap(&dev->resource[0], 0, size, "auxio");
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index 92627abce311..d941875dd718 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -41,8 +41,8 @@ static int power_probe(struct platform_device *op)
 
 	power_reg = of_ioremap(res, 0, 0x4, "power");
 
-	printk(KERN_INFO "%s: Control reg at %llx\n",
-	       op->dev.of_node->name, res->start);
+	printk(KERN_INFO "%pOFn: Control reg at %llx\n",
+	       op->dev.of_node, res->start);
 
 	if (has_button_interrupt(irq, op->dev.of_node)) {
 		if (request_irq(irq,
-- 
2.19.1

