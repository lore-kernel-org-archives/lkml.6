Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeC2GS1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 02:18:27 -0400
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:11655 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750716AbeC2GS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 02:18:26 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <rafel.j.wysocki@intel.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH] hwmon, via-cputemp: support new centaur CPUs
Date: Thu, 29 Mar 2018 14:17:53 +0800
Message-ID: <1522304273-17817-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 drivers/hwmon/via-cputemp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 07a0cb0..aa0d040 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -136,6 +136,11 @@ static int via_cputemp_probe(struct platform_device *pdev)
 	data->id = pdev->id;
 	data->name = "via_cputemp";
 
+	if (c->x86_model == 7) {
+		data->msr_temp = 0x1423;
+		goto test_access;
+	}
+
 	switch (c->x86_model) {
 	case 0xA:
 		/* C7 A */
@@ -152,6 +157,7 @@ static int via_cputemp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+test_access:
 	/* test if we can access the TEMPERATURE MSR */
 	err = rdmsr_safe_on_cpu(data->id, data->msr_temp, &eax, &edx);
 	if (err) {
@@ -283,6 +289,7 @@ static int via_cputemp_down_prep(unsigned int cpu)
 	{ X86_VENDOR_CENTAUR, 6, 0xa, }, /* C7 A */
 	{ X86_VENDOR_CENTAUR, 6, 0xd, }, /* C7 D */
 	{ X86_VENDOR_CENTAUR, 6, 0xf, }, /* Nano */
+	{ X86_VENDOR_CENTAUR, 7, X86_MODEL_ANY, },
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, cputemp_ids);
-- 
1.9.1
