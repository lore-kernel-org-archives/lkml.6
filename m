Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F48DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AF0206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NURqSslh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfBDSl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:41:57 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33962 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfBDSl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:41:57 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D082010C1A4C;
        Mon,  4 Feb 2019 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549305716; bh=rIFGvddQGWCBAgXkovzBiPzWqnjlK/FvnwDxnEJ7ElE=;
        h=From:To:Cc:Subject:Date:From;
        b=NURqSslhdiDsjPBK+hkjI9Qb4C+1qXpjSOT2ScOx+CI2cqxQ0cBBl5cA+8+jv/H4S
         nDWW6k954w/vTGoLpDpFd8o7Egs384F4dYiYispN39pfjtMyMSfTnFQzp6GyVjAtuh
         S0ZKx8tRtkgt9fEkeKqrJZ9FlZ+vjEff+yCQIrDs9oUzkHz8aFMFvRg8vPLc8pYYo+
         1VW7HPp5K/jad9SDKW4VnzEbiLPV8kHSGjAWr8xT8qFFGqtIbZVWzNBJwyxjYiw6OD
         7HMk4ipy+vrRNEBR/SC+eJJyThAsr3stcq9rL2LhbNuZZX41NjABQbewohstxM7jJV
         Mqkb1pq3TcHhg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0C73FA0095;
        Mon,  4 Feb 2019 18:41:53 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH] ARC: fix actionpoints configuration detection
Date:   Mon,  4 Feb 2019 21:41:51 +0300
Message-Id: <20190204184151.9113-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix reversed logic while actionpoints configuration (full/min)
detection.

Fixies: 7dd380c338f1e ("ARC: boot log: print Action point details")
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index feb90093e6b1..def19b0ef8c6 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -212,7 +212,7 @@ static void read_arc_build_cfg_regs(void)
 	READ_BCR(ARC_REG_AP_BCR, ap);
 	if (ap.ver) {
 		cpu->extn.ap_num = 2 << ap.num;
-		cpu->extn.ap_full = !!ap.min;
+		cpu->extn.ap_full = !ap.min;
 	}
 
 	READ_BCR(ARC_REG_SMART_BCR, bcr);
-- 
2.14.5

