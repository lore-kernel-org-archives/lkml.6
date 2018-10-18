Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F424ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91B321473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmvbM/n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91B321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeJSCBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbeJSCBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:01:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4524421473;
        Thu, 18 Oct 2018 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885559;
        bh=B7UFHkokjjPNiSVD8SAc/uX9onBGmI8cn6jXCmG7yBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmvbM/n9RCAx/AElMLxaFWoALt3DveIRGr0D2cwOfwNWTvTxVnVZg3xr7q1qqgH46
         bBPHPGQ8GmGwsvYbgqo1ukjHouGO7DLc/NIS4icOlGYj836/dwxOPuKwEMBHKsm+pC
         ngg0IpahNa/WVDUUiTblvfqSaUWya9oqve87Y+Yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 47/53] powerpc/numa: Use associativity if VPHN hcall is successful
Date:   Thu, 18 Oct 2018 19:54:40 +0200
Message-Id: <20181018175424.614074034@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/numa.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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


