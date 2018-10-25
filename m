Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314CDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2DE20840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1r6fOc+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2DE20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJYWoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeJYWoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:07 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C92020840;
        Thu, 25 Oct 2018 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476672;
        bh=t0o7lloEpgGRl8ztTpA1vDu5AdBE7RRPNJQaV8Lajn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1r6fOc+T1zat4kV1cdLT8+G8yPDLiEEhevWiJauR08JMHoCzziDuCP8MpYG6QcCTw
         VGEgHDI0Vxr2jowuAtp0C41c8f8fe1KIKaEGCwMfi/1v2vkme8Ax4sWNViZiiNScPE
         uuVrqsYtESmczFbAKoIkexHF3mltcd4JPY2oALh8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 12/46] powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=n
Date:   Thu, 25 Oct 2018 10:10:19 -0400
Message-Id: <20181025141053.213330-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit c1e150ceb61e4a585bad156da15c33bfe89f5858 ]

When CONFIG_NUMA is not set, the build fails with:

  arch/powerpc/platforms/pseries/hotplug-cpu.c:335:4:
  error: déclaration implicite de la fonction « update_numa_cpu_lookup_table »

So we have to add update_numa_cpu_lookup_table() as an empty function
when CONFIG_NUMA is not set.

Fixes: 1d9a090783be ("powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index d5f2ee882f74..66c72b356ac0 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -81,6 +81,9 @@ static inline int numa_update_cpu_topology(bool cpus_locked)
 {
 	return 0;
 }
+
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
-- 
2.17.1

