Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C8EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE18320C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE18320C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeGLJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:42:38 -0400
Received: from www.osadl.org ([62.245.132.105]:60885 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeGLJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:42:38 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6C9T86K021688;
        Thu, 12 Jul 2018 11:29:14 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Wang Long <long.wanglong@huawei.com>,
        Haifeng Yan <yanhaifeng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/3] ARM: hisi: fix error handling and missing of_node_put
Date:   Thu, 12 Jul 2018 11:28:22 +0200
Message-Id: <1531387704-13265-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
References: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_iomap() can return NULL which seems critical here and thus should be
explicitly flagged so that the cause of system halting can be understood.
As of_find_compatible_node() is returning a device node with refcount
incremented it must be explicitly decremented here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 7fda91e73155 ("ARM: hisi: enable smp for HiP01")
---

Problem located by experimental coccinelle script

Patch was compile tested with: hisi_defconfig (implies CONFIG_SMP=y)

There are two change related checkpatch warnings about
"WARNING: Avoid crashing the kernel - try using WARN_ON"
but here the BUG_ON() seems adequate.

Patch is against 4.18-rc3 (localversion-next is next-20180712)

 arch/arm/mach-hisi/hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index a129aae..3b0d1c6 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -219,10 +219,10 @@ void hip01_set_cpu(int cpu, bool enable)
 
 	if (!ctrl_base) {
 		np = of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
-		if (np)
-			ctrl_base = of_iomap(np, 0);
-		else
-			BUG();
+		BUG_ON(!np);
+		ctrl_base = of_iomap(np, 0);
+		of_node_put(np);
+		BUG_ON(!ctrl_base);
 	}
 
 	if (enable) {
-- 
2.1.4

