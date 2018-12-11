Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5886BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC72133F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543363;
	bh=+MN5MAMwSsv7bXvk7A8NjXvMtALwdgGc6u7V17QHQ/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FeZSBEuOzsgDZYHBX4utIVi8PbC/WYLIHjzMZRKtJ8Jur4Z6rwfngDUGC9x4ZPAuN
	 cjax3DhfDKvqGttOUDSn2CwPQMyte0XknSzR9VkZFyl5jygF0c2Rq4GFT+oMAtJYcV
	 PWnSKZOHQKy0KaFT9yu5umT4jt5NDFNV0eA5+fwU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCC72133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeLKPtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbeLKPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B67BB208E7;
        Tue, 11 Dec 2018 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543357;
        bh=+MN5MAMwSsv7bXvk7A8NjXvMtALwdgGc6u7V17QHQ/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vid3kHyELOLJmrJ/rByAi9mRomvJxFaJRbRAu4LR0VAfZwJKHhusenQs7+QO1gY5v
         nwQ8e5M2LS24Ur7ejwTz9itCzvL3aL1xNmhwgpkIbCJEdr3HxPbwE5edSdFE1W2oo6
         DKNKTJWR1rCecSdaSVBBg/ZxCOo5q5Dpm4pZp9nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 02/51] iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()
Date:   Tue, 11 Dec 2018 16:41:10 +0100
Message-Id: <20181211151612.561273075@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



