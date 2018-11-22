Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23355208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbQSPHXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23355208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407464AbeKWGjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392612AbeKWGjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:39:07 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B30E920892;
        Thu, 22 Nov 2018 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916694;
        bh=cwX8T2UuizqYn/t/ShPVi15m5tmnVm++uYm1cOHkMGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbQSPHXecwMfe9IWIYjisILqlhxhO9+om+r6ElQ1rpSsNdiDDO6X/YSx97ciTr8yO
         aBJVRBosa9CJ3Mj7dMrUhvjhztpXPtpNW8PzMY+DpRYyJ9QywuzbLY4doyhs9Rn3Y0
         zoqdad1hnUAWAbxnfcIQXdr0GHM3lVrFGDD+KJvA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 3.18 6/7] powerpc/numa: Suppress "VPHN is not supported" messages
Date:   Thu, 22 Nov 2018 14:57:48 -0500
Message-Id: <20181122195749.14086-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195749.14086-1-sashal@kernel.org>
References: <20181122195749.14086-1-sashal@kernel.org>
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
index b9d1dfdbe5bb..ae9d3bf79612 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1479,7 +1479,7 @@ static long vphn_get_associativity(unsigned long cpu,
 
 	switch (rc) {
 	case H_FUNCTION:
-		printk(KERN_INFO
+		printk_once(KERN_INFO
 			"VPHN is not supported. Disabling polling...\n");
 		stop_topology_update();
 		break;
-- 
2.17.1

