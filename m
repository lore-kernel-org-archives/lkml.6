Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4A4C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29C620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29C620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeILT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:59:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39440 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727992AbeILT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1322832|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03271;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CpxA9jF_1536764002;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CpxA9jF_1536764002)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 12 Sep 2018 22:53:22 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V4 20/27] dt-bindings: timer: C-SKY Multi-processor timer
Date:   Wed, 12 Sep 2018 22:52:02 +0800
Message-Id: <e301225bda1dc8dfe7aa5b1b2bbe83b82403f47d.1536758961.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../devicetree/bindings/timer/csky,mptimer.txt     | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
new file mode 100644
index 0000000..0d7369f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
@@ -0,0 +1,46 @@
+============================
+C-SKY Multi-processors Timer
+============================
+
+C-SKY multi-processors timer is designed for C-SKY SMP system and the
+regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
+
+ - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
+ - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
+ - PTIM_CCVR "cr<3, 14>" Current counter value reg.
+ - PTIM_LVR  "cr<6, 14>" Window value reg to triger next event.
+
+==============================
+timer node bindings definition
+==============================
+
+        Description: Describes SMP timer
+
+        PROPERTIES
+
+        - compatible
+                Usage: required
+                Value type: <string>
+                Definition: must be "csky,mptimer"
+	- clocks
+		Usage: required
+		Value type: <node>
+                Definition: must be input clk node
+        - interrupt
+                Usage: required
+                Value type: <u32>
+                Definition: must be timer irq num defined by soc
+        - interrupt-parent:
+                Usage: required
+		Value type: <node>
+                Definition: must be interrupt controller node
+
+Examples:
+---------
+
+	timer: timer {
+		compatible = "csky,mptimer";
+		clocks = <&dummy_apb_clk>;
+		interrupts = <16>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

