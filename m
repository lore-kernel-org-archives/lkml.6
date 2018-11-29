Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD1FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A309C20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpsRiHjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A309C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeK2RHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbeK2RHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:07:51 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5BC20834;
        Thu, 29 Nov 2018 06:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471420;
        bh=8yDP87yKf/LWdMwEI42Wy5eB0hsWdF6vCDlZZPRi04E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpsRiHjQVb0uqskttwNETKWaBDtrUsEzm/OlpQqI64B7lfgtQX3Taw8gYfWyEKcQj
         4AdkenCFtPMAKCcucr1lgLqgHFKEvyvUkRlFS9vCLZA8rDNMUxsg7A7/OlsWQBAASI
         PBomNs9GDyMyjRyToyCMZecA5sMJS7NCuhPsvfJw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 02/18] iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()
Date:   Thu, 29 Nov 2018 01:03:14 -0500
Message-Id: <20181129060331.160224-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060331.160224-1-sashal@kernel.org>
References: <20181129060331.160224-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 19ed3e2dd8549c1a34914e8dad01b64e7837645a ]

When handling page request without pasid event, go to "no_pasid"
branch instead of "bad_req". Otherwise, a NULL pointer deference
will happen there.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Fixes: a222a7f0bb6c9 'iommu/vt-d: Implement page request handling'
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f846f0140a9d..7dc2f8d415b6 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -558,7 +558,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			pr_err("%s: Page request without PASID: %08llx %08llx\n",
 			       iommu->name, ((unsigned long long *)req)[0],
 			       ((unsigned long long *)req)[1]);
-			goto bad_req;
+			goto no_pasid;
 		}
 
 		if (!svm || svm->pasid != req->pasid) {
-- 
2.17.1

