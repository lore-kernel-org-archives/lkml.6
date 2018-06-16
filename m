Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC369C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B082088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B082088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756870AbeFPDIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:08:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:51107 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756850AbeFPDIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:08:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 20:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="233011923"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2018 20:07:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 5/8] x86/umwait.c: Add sysfs interface to show tsc_khz
Date:   Fri, 15 Jun 2018 20:06:12 -0700
Message-Id: <1529118375-90191-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User wait process or any other process wants to know tsc frequency to
convert seconds to tsc ticks. Kernel already gets tsc freqency in kernel
internal variable tsc_khz. The sysfs interface /sys/devices/system/cpu/
user_mwait/tsc_khz exposes the internal variable tsc_khz in decimal to
user.

tsc_khz and the interface are available only on CPU that supports
X86_FEATURE_TSC_KNOW_FREQ.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/power/umwait.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
index fd7b18d9ed02..33b3ccb40cb9 100644
--- a/arch/x86/power/umwait.c
+++ b/arch/x86/power/umwait.c
@@ -7,7 +7,8 @@
  */
 /*
  * umwait.c adds control of user wait states that user enters through user wait
- * instructions umwait or tpause.
+ * instructions umwait or tpause. It also dumps tsc_khz to user so user process
+ * can convert seconds to tsc for umwait or other usages.
  */
 #include <linux/cpu.h>
 #include <asm/msr.h>
@@ -49,7 +50,14 @@ static ssize_t umwait_disable_c0_2_store(struct device *dev,
 	return count;
 }
 
+static ssize_t tsc_khz_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "%d\n", tsc_khz);
+}
+
 static DEVICE_ATTR_RW(umwait_disable_c0_2);
+static DEVICE_ATTR_RO(tsc_khz);
 
 static struct attribute *umwait_attrs[] = {
 	&dev_attr_umwait_disable_c0_2.attr,
@@ -92,6 +100,15 @@ static int __init umwait_init(void)
 	if (ret)
 		return ret;
 
+	/* Only add the tsc_khz interface when the value is known. */
+	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+		ret = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_tsc_khz.attr,
+					      umwait_attr_group.name);
+		if (ret)
+			goto out_group;
+	}
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait/intel:online",
 				umwait_cpu_online, NULL);
 	if (ret < 0)
-- 
2.5.0

