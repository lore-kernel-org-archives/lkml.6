Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745B4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FDB20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FDB20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeGLJml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:42:41 -0400
Received: from www.osadl.org ([62.245.132.105]:51758 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeGLJmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:42:40 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6C9T86M021688;
        Thu, 12 Jul 2018 11:29:24 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Wang Long <long.wanglong@huawei.com>,
        Haifeng Yan <yanhaifeng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 3/3] ARM: hisi: handle of_iomap and fix missing of_node_put
Date:   Thu, 12 Jul 2018 11:28:24 +0200
Message-Id: <1531387704-13265-4-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
References: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relying on an unchecked of_iomap() which can return NULL is problematic
here, an explicit check seems mandatory. Also the call to
of_find_compatible_node() returns a device node with refcount incremented
therefor an explicit of_node_put() is needed here. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 22bae4290457 ("ARM: hi3xxx: add hotplug support")
---

Problem found by an experimental coccinelle script

The way  id  is used is a bit redundant with the function return - not
really clear if this "double indication" is intentional or just happened ?
Also note that hi3xxx_hotplug_init probably should be bool as that is how
it is being used - the error return is not actually interpreted beyond
detection of failure in its only call site hi3xxx_set_cpu().

Patch was compile tested with: hisi_defconfig (implies CONFIG_SMP=y)

Patch is against 4.18-rc3 (localversion-next is next-20180712)

 arch/arm/mach-hisi/hotplug.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 40857bf..4036ffe 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -148,13 +148,20 @@ static int hi3xxx_hotplug_init(void)
 	struct device_node *node;
 
 	node = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
-	if (node) {
-		ctrl_base = of_iomap(node, 0);
-		id = HI3620_CTRL;
-		return 0;
+	if (!node) {
+		id = ERROR_CTRL;
+		return -ENOENT;
 	}
-	id = ERROR_CTRL;
-	return -ENOENT;
+
+	ctrl_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!ctrl_base) {
+		id = ERROR_CTRL;
+		return -ENOMEM;
+	}
+
+	id = HI3620_CTRL;
+	return 0;
 }
 
 void hi3xxx_set_cpu(int cpu, bool enable)
-- 
2.1.4

