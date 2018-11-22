Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B62C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6930720870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7v6cdp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6930720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407159AbeKWGgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbeKWGgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:36:54 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B733920864;
        Thu, 22 Nov 2018 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916562;
        bh=J8fd+RdSOCcFObM5X+Gf/Z7EkEy3Eaymnt/mEDiVnfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7v6cdp5/skyH4t7qqMzix8SWcAw7E4E3n37/ilQ1+1XbAmp0OL32r4UCWCvJ83cG
         OK5rDTPJxTR2zTd88G64xySM3X9SXBGdWz4VXE6do2Ph15IX5JkrQGOuBS1amAUv3l
         nBamhsqbwNr5axWcjQhex1/DWWshS+lzzvcEit8Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 17/21] powerpc/numa: Suppress "VPHN is not supported" messages
Date:   Thu, 22 Nov 2018 14:54:48 -0500
Message-Id: <20181122195452.13520-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

[ Upstream commit 437ccdc8ce629470babdda1a7086e2f477048cbd ]

When VPHN function is not supported and during cpu hotplug event,
kernel prints message 'VPHN function not supported. Disabling
polling...'. Currently it prints on every hotplug event, it floods
dmesg when a KVM guest tries to hotplug huge number of vcpus, let's
just print once and suppress further kernel prints.

Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9fead0796364..40fb9a8835fe 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1261,7 +1261,7 @@ static long vphn_get_associativity(unsigned long cpu,
 
 	switch (rc) {
 	case H_FUNCTION:
-		printk(KERN_INFO
+		printk_once(KERN_INFO
 			"VPHN is not supported. Disabling polling...\n");
 		stop_topology_update();
 		break;
-- 
2.17.1

