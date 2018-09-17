Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B5ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1FC206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1FC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeIRFFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbeIRFFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:05:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6906308427C;
        Mon, 17 Sep 2018 23:35:42 +0000 (UTC)
Received: from masetto.com (ovpn-117-142.phx2.redhat.com [10.3.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DD5382218;
        Mon, 17 Sep 2018 23:35:40 +0000 (UTC)
From:   Al Stone <ahs3@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Stone <ahs3@redhat.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        Keyur Chudgar <kchudgar@apm.com>,
        Quan Nguyen <qnguyen@apm.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] net: apm: xgene: force XGene enet driver to re-balance IRQ usage
Date:   Mon, 17 Sep 2018 17:35:33 -0600
Message-Id: <20180917233533.28626-1-ahs3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 17 Sep 2018 23:35:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the user-space command 'tuned-adm profile network-latency',
the XGene enet driver will cause a hang trying to enable IRQs while
the system is trying to tune itself to be more responsive to network
traffic; dmesg will even tell us that the enables/disables are not
in balance.  With this fix, we force the driver to only enable_irq()
when there has been a previous disable_irq() -- i.e., force the number
of calls to each to be balanced.  This allows the kernel to continue
operating.

In an ideal world, the XGene enet driver would be restructured to avoid
this problem (it seems to be an artifact of when additional packets
arrive and differences of opinion in how the NIC responds under those
circumstances, some of which is controlled by firmware).  In the XGene2
driver, this is not an issue.

However, the XGene (aka Mustang) where this NIC is used is most likely
at the end of its useful life (APM which originally created the XGene
has completely morphed into a new company).  It is unlikely the driver
restructuring that is needed will ever be done.   There are, however,
a bunch of these machines out in the real world, and there are many
of us still using them daily (me, for example).  So, while this patch
is not the ideal way to repair the NIC driver, it does work and allows
us to continue using these boxes for a while longer.

Cc: Iyappan Subramanian <isubramanian@apm.com>
Cc: Keyur Chudgar <kchudgar@apm.com>
Cc: Quan Nguyen <qnguyen@apm.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Al Stone <ahs3@redhat.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 3b889efddf78..90fb87f7e24e 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -866,8 +866,11 @@ static int xgene_enet_napi(struct napi_struct *napi, const int budget)
 	processed = xgene_enet_process_ring(ring, budget);
 
 	if (processed != budget) {
+		struct irq_desc *desc = irq_to_desc(ring->irq);
+
 		napi_complete_done(napi, processed);
-		enable_irq(ring->irq);
+		if (desc && desc->depth > 0)
+			enable_irq(ring->irq);
 	}
 
 	return processed;
-- 
2.17.1

