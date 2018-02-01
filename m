Return-Path: <sboyd@codeaurora.org>
X-Google-Smtp-Source: AH8x226Id+32J2G1wMU7AUasudlbWLrJFq/oRG5bhbj4I9APuTtzylJB5rJAXeV9Hdm+x7o4SlF5
ARC-Seal: i=1; a=rsa-sha256; t=1517504612; cv=none;
        d=google.com; s=arc-20160816;
        b=DMw1LxTqaAc025Ws+aFsATfLTYOejO/1K/zwmA6ZTy3vrpG8hflgfzbGjx6nYAo9Gz
         2hcLgulwlzlk0BU79x2KJhsPDIILOVdajcx72cpapafA35B3t+42QNIx2Cx0CWiqOtxe
         H0LkI6TSji8pKYYuUGqwmrYn0Lh0f3u3M71IUahcJJfEI682GPIom+esrccccLnbHm8J
         xrusMsh9SQF//rV3lit/Hvm4EDFkC4EcdZRpEUi03+rqf42CK6OsrntCnGlKwmOkJZBc
         phlLgn4gz/hU2zDbjO7Fxtdj5Tid9H3JvLi+9ndfXIUTnD5zgGQziZujvVwWVLPcFQ1g
         VWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=qhPUoUIBGcYz521V3+2EGP39od30WGmsSRS8UwsluM0=;
        b=vxHVoRCYwivB7lVHu0xDMdzYissLTj9kSzomnHHwKBI78C7pyHAW6dy9zMZ93fEqf/
         HNr+cakq9i1rtgFSUS6jOINQPGiLB5nSbeOQoAwaRdwhPCeX8NXU2/UImexsl6LddJ/9
         5G6xApqTm6nLXpFP7d2xPF9UqdXuQ+///hRIuxWhmjVi0JnszLS+amcei1o2LOTxjq2L
         WJbEdJARRl4hEiJ8FUZnjbPF/hIHzCDerJ6HBmbzo1A/25RVy19TaxAPAd/mBnamwBTx
         0p663n5YY/n3DzmptUCvNsdM3lCRekWH/P2ExApSN6f/xL+bF9CFlgfrq5SZPMZVDhUg
         eVog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FLh4wUfz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dhr7byDn;
       spf=pass (google.com: domain of sboyd@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sboyd@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FLh4wUfz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dhr7byDn;
       spf=pass (google.com: domain of sboyd@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sboyd@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2743B61195
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
From: Stephen Boyd <sboyd@codeaurora.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2] irqchip/gic-v3: Ignore disabled ITS nodes
Date: Thu,  1 Feb 2018 09:03:29 -0800
Message-Id: <20180201170329.26916-1-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.15.0.374.g5f9953d2c365
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591218916774125343?=
X-GMAIL-MSGID: =?utf-8?q?1591218916774125343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some platforms there's an ITS available but it's not enabled
because reading or writing the registers is denied by the
firmware. In fact, reading or writing them will cause the system
to reset. We could remove the node from DT in such a case, but
it's better to skip nodes that are marked as "disabled" in DT so
that we can describe the hardware that exists and use the status
property to indicate how the firmware has configured things.

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c               | 2 ++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c          | 2 ++
 drivers/irqchip/irq-gic-v3-its.c                       | 2 ++
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 14a8c0a7e095..25a98de5cfb2 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -132,6 +132,8 @@ static int __init its_pci_of_msi_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 833a90fe33ae..8881a053c173 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -154,6 +154,8 @@ static void __init its_pmsi_of_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..1d3056f53747 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3314,6 +3314,8 @@ static int __init its_of_probe(struct device_node *node)
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
 			pr_warn("%pOF: no msi-controller property, ITS ignored\n",
 				np);
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 5064d5ddf581..fc2013aade51 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -73,6 +73,8 @@ static int __init its_fsl_mc_msi_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
