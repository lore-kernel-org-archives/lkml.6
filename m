Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0398C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E8F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547820291;
	bh=dW0UcxR3oDf5wSHJQAAAcQzu3ibwQX5VlQ9GMMZrbRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AC4BWZY1U4+bvaU3nQfjci4rOQUy42FQK60XZWtX/yFL3TPXWv+lD03heGnjpkBSa
	 qJIVOPSJSnSloq8/SIlQNnMVh6QqX6XKGvcxGmFYSWYTtjOyFQpCNPG4owvSVoqP0T
	 7jQzCuBSq7Y97N5cGXiTEN0vbj8lgHBc1EqkWQfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfAROEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:04:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42082 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfAROEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:04:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so10558553lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edUxdz3ce3gWnciU4XX+2JLaYdCsYRbrNsJxn6e+a2w=;
        b=eKdwabdmA+DxmsyxDFPXlaCFW03UswE+cjH4YbDqpNwHOqNNf+AhBbHJTdfy/3mhZ8
         nQ8JaftSHsuLA6yZEY22038e7tXoTiDuRcJ1WwKxhSBOUIJF9yKURPVT4x0dftxLOB3w
         HGHP/LI1nFJoIElSl+tOFtLWKGpazhpaVNR+3vtct7U0sEP8a8bHYWoCNLp717RCA2K4
         4yW5M7WO1W9W/UPE+RldQJtKc9kQkpsFtw43YMHxXEaudKW/9M2QqSFhKpGUVd92v4I2
         A9kIRpjAyznL8cvEqIoe5cHSdY4QGVLWrvu4w7tDrm4g91tstPZ9G0FWaXWB3IOxBqgr
         jVhQ==
X-Gm-Message-State: AJcUuke+wXuUF0L1FND6AbSduNrivPk27skibQFb6g+V09QphHwa/yJb
        pTRrw4sXx6yYtWuWQsWSJDU=
X-Google-Smtp-Source: ALg8bN4Y0esAGk6MK7TV6Wmr5WDkdlU1+vuYa3x5Df7EzCNJYZeGRXCIBufLugzWN9j0rwsKUUrAyw==
X-Received: by 2002:a19:4287:: with SMTP id p129mr13239723lfa.135.1547820281776;
        Fri, 18 Jan 2019 06:04:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z9sm797530lfj.79.2019.01.18.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:04:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gkUlB-0002W0-BQ; Fri, 18 Jan 2019 15:04:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/5] riscv: fix riscv_of_processor_hartid() comment
Date:   Fri, 18 Jan 2019 15:03:06 +0100
Message-Id: <20190118140308.9599-4-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118140308.9599-1-johan@kernel.org>
References: <20190118140308.9599-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The riscv_of_processor_hartid() helper returns -ENODEV when the
specified node isn't an enabled and valid RISC-V hart node.

Also drop the unnecessary parenthesis around errno defines.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/riscv/kernel/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 11ba67f010e7..974d374fd36b 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -17,8 +17,8 @@
 #include <asm/smp.h>
 
 /*
- * Returns the hart ID of the given device tree node, or -1 if the device tree
- * node isn't a RISC-V hart.
+ * Returns the hart ID of the given device tree node, or -ENODEV if the node
+ * isn't an enabled and valid RISC-V hart node.
  */
 int riscv_of_processor_hartid(struct device_node *node)
 {
@@ -27,34 +27,34 @@ int riscv_of_processor_hartid(struct device_node *node)
 
 	if (!of_device_is_compatible(node, "riscv")) {
 		pr_warn("Found incompatible CPU\n");
-		return -(ENODEV);
+		return -ENODEV;
 	}
 
 	if (of_property_read_u32(node, "reg", &hart)) {
 		pr_warn("Found CPU without hart ID\n");
-		return -(ENODEV);
+		return -ENODEV;
 	}
 	if (hart >= NR_CPUS) {
 		pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
-		return -(ENODEV);
+		return -ENODEV;
 	}
 
 	if (of_property_read_string(node, "status", &status)) {
 		pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
-		return -(ENODEV);
+		return -ENODEV;
 	}
 	if (strcmp(status, "okay")) {
 		pr_info("CPU with hartid=%d has a non-okay status of \"%s\"\n", hart, status);
-		return -(ENODEV);
+		return -ENODEV;
 	}
 
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
 		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
-		return -(ENODEV);
+		return -ENODEV;
 	}
 	if (isa[0] != 'r' || isa[1] != 'v') {
 		pr_warn("CPU with hartid=%d has an invalid ISA of \"%s\"\n", hart, isa);
-		return -(ENODEV);
+		return -ENODEV;
 	}
 
 	return hart;
-- 
2.20.1

