Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76420818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XasJiZL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBVCpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:45:02 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:44425 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBVCpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:45:01 -0500
Received: by mail-io1-f73.google.com with SMTP id k24so642419ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ja6C4Evr5MwHkWzudMuLRqd3IlhaKdz864YHQ3if3rU=;
        b=XasJiZL/aDOWlt+mCcinSIq6L8B2SSuFQA8YcyMnfy4cx/sXEWfrS6hNROg3TRYj+X
         SLczGz21yk0KLGtimJnaMNYmewA6JlE3qh89IM6mn/KMj2oM5VV+tnI454TLMMrOg3ZC
         TYuMgU86WDPzkLjUGTR+xx609rF5WHYZ19C32id8SpRE3i3H+wfYv8M302SUNMIKvj6E
         QjEckkrWBtVrcNife5L07pA4Fp6pgRMx8hY4LL1JKXSiBn/c1S3GAjKrwcUW6rypIeFi
         cVBGV2Uv5SE+RPpcoDOtNwEhuVuuCrfTV9DAhFFd3lSo/gFHY3fiGKCn0HqAQGW0MJVe
         Jg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ja6C4Evr5MwHkWzudMuLRqd3IlhaKdz864YHQ3if3rU=;
        b=iDb2mjEyd0mcUwdmitRCEJiIu2waUZzfUJJfPLvIBTMotPJEGlzrURqAGHemsSnb9Y
         1/IYUQhUAVZqveh4bjzaIeO0FNaBoADEY5nceO2DxZ9J5PBaIMyWrgILQEoy2OGoC4y2
         SiOb7L/acSacaGpzBPZHLz43hdZG68vc36VC6S2E4nDZG0HvWjwrTvlm5clMmYZ4zjQ8
         ca7uA1xql/M95UTQCSIeLwIB/EDJej0KqIL49LxWEWfiH7sIlDWhTVQN9bror5qMwUVZ
         Sn3NJh7V5FaymSL0y6UsB0T4V+q/56OryFaSATh9pGk/N6Uk28LQJbCXqU+Y/Whr+Cgb
         ygsw==
X-Gm-Message-State: AHQUAub2HIhYDCbBsXUeC4VDAxdjZ/mufBNNNIf17NOyuKh7sGfnsjg/
        lNZWcC3+wZmPyPocUhP3kgAO76HnMVg=
X-Google-Smtp-Source: AHgI3IZhkPKUxuCiKh7DObbWo6t3OGuXidnp9wCx/TtPgoij4MzBF3KUFdblfKnFlD/vcGF0hSpMeJyIfFE=
X-Received: by 2002:a24:c546:: with SMTP id f67mr1199522itg.28.1550803500131;
 Thu, 21 Feb 2019 18:45:00 -0800 (PST)
Date:   Fri, 22 Feb 2019 02:44:55 +0000
Message-Id: <20190222024455.20802-1-xmdong@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] iommu/vt-d: Handle hotplug devices' default identity mapping setting
From:   James Dong <xmdong@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        James Dong <xmdong@google.com>, Jis Ben <jisben@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With specific Linux command line option such as "iommu=pt", some types
of hotplug devices will be assigned to the static 1:1 iommu domain by
default during kernel init.

If such a hotplug device is rescanned after being removed, for example,
with following sample commands:
  echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove
  echo 1 > /sys/bus/pci/rescan
, an iommu group for this hotplug device will be added without attaching
it to the default static 1:1 domain. As a result, this device's I/O
operation won't work.

Keep hotplug devices with default static 1:1 iommu mapping in their default
domain after such hotplug devices are rescanned.

Signed-off-by: James Dong <xmdong@google.com>
Reported-by: Jis Ben <jisben@google.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..4b02949e58ca 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5230,6 +5230,7 @@ static int intel_iommu_add_device(struct device *dev)
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
 	u8 bus, devfn;
+	int ret = 0;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -5242,8 +5243,19 @@ static int intel_iommu_add_device(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	if (!iommu_group_default_domain(group) &&
+	    !find_domain(dev) && iommu_should_identity_map(dev, 0)) {
+		ret = domain_add_dev_info(si_domain, dev);
+		if (!ret)
+			pr_info("identity mapping for device %s\n",
+				dev_name(dev));
+		else
+			pr_info("identity mapping failed (%d) for device %s\n",
+				ret, dev_name(dev));
+	}
+
 	iommu_group_put(group);
-	return 0;
+	return ret;
 }
 
 static void intel_iommu_remove_device(struct device *dev)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

