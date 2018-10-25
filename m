Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A47ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C65D20840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yac4KqIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C65D20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJYWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbeJYWne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:34 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B903120847;
        Thu, 25 Oct 2018 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476639;
        bh=8liWpFvj4Yy5bOZJNwV2WosPUSaJW0OzB/5zegTGaXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yac4KqIewOTjtCPgLgEDarm7FJe4QqNMnUkTDRLShhcgwsTaM0oOIzDkDRTMplFaW
         BX5xGh3x1/3AvwCXd5qVH8XMGMoYkwW+KaNTS4InaDX0/D2wwuPO27jj37gBuHFnBd
         TxmZIhuHQZV6rjadHpAFBhA7zzc8rDQtWcFhIPFw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 5/8] powerpc/numa: Use associativity if VPHN hcall is successful
Date:   Thu, 25 Oct 2018 10:10:26 -0400
Message-Id: <20181025141029.213274-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141029.213274-1-sashal@kernel.org>
References: <20181025141029.213274-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

[ Upstream commit 2483ef056f6e42f61cd266452e2841165dfe1b5c ]

Currently associativity is used to lookup node-id even if the
preceding VPHN hcall failed. However this can cause CPU to be made
part of the wrong node, (most likely to be node 0). This is because
VPHN is not enabled on KVM guests.

With 2ea6263 ("powerpc/topology: Get topology for shared processors at
boot"), associativity is used to set to the wrong node. Hence KVM
guest topology is broken.

For example : A 4 node KVM guest before would have reported.

  [root@localhost ~]#  numactl -H
  available: 4 nodes (0-3)
  node 0 cpus: 0 1 2 3
  node 0 size: 1746 MB
  node 0 free: 1604 MB
  node 1 cpus: 4 5 6 7
  node 1 size: 2044 MB
  node 1 free: 1765 MB
  node 2 cpus: 8 9 10 11
  node 2 size: 2044 MB
  node 2 free: 1837 MB
  node 3 cpus: 12 13 14 15
  node 3 size: 2044 MB
  node 3 free: 1903 MB
  node distances:
  node   0   1   2   3
    0:  10  40  40  40
    1:  40  10  40  40
    2:  40  40  10  40
    3:  40  40  40  10

Would now report:

  [root@localhost ~]# numactl -H
  available: 4 nodes (0-3)
  node 0 cpus: 0 2 3 4 5 6 7 8 9 10 11 12 13 14 15
  node 0 size: 1746 MB
  node 0 free: 1244 MB
  node 1 cpus:
  node 1 size: 2044 MB
  node 1 free: 2032 MB
  node 2 cpus: 1
  node 2 size: 2044 MB
  node 2 free: 2028 MB
  node 3 cpus:
  node 3 size: 2044 MB
  node 3 free: 2032 MB
  node distances:
  node   0   1   2   3
    0:  10  40  40  40
    1:  40  10  40  40
    2:  40  40  10  40
    3:  40  40  40  10

Fix this by skipping associativity lookup if the VPHN hcall failed.

Fixes: 2ea626306810 ("powerpc/topology: Get topology for shared processors at boot")
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/numa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d531cbdcba6c..055b211b7126 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1204,7 +1204,9 @@ int find_and_online_cpu_nid(int cpu)
 	int new_nid;
 
 	/* Use associativity from first thread for all siblings */
-	vphn_get_associativity(cpu, associativity);
+	if (vphn_get_associativity(cpu, associativity))
+		return cpu_to_node(cpu);
+
 	new_nid = associativity_to_nid(associativity);
 	if (new_nid < 0 || !node_possible(new_nid))
 		new_nid = first_online_node;
-- 
2.17.1

