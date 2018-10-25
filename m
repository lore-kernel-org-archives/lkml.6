Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC07FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14472082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14472082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeJYQZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:25:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:33000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeJYQZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:25:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 862CCAC17;
        Thu, 25 Oct 2018 07:54:17 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] xen/pvh: don't try to unplug emulated devices
Date:   Thu, 25 Oct 2018 09:54:15 +0200
Message-Id: <20181025075415.18798-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Xen PVH guest has no associated qemu device model, so trying to
unplug any emulated devices is making no sense at all.

Bail out early from xen_unplug_emulated_devices() when running as PVH
guest. This will avoid issuing the boot message:

[    0.000000] Xen Platform PCI: unrecognised magic value

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/platform-pci-unplug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
index 66ab96a4e2b3..96d7f7d39cb9 100644
--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -134,6 +134,10 @@ void xen_unplug_emulated_devices(void)
 {
 	int r;
 
+	/* PVH guests don't have emulated devices. */
+	if (xen_pvh_domain())
+		return;
+
 	/* user explicitly requested no unplug */
 	if (xen_emul_unplug & XEN_UNPLUG_NEVER)
 		return;
-- 
2.16.4

