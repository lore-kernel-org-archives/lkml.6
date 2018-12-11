Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8724C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A4D20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544321;
	bh=w06d0gsqifNvWk7Uo1DaAyX/g3DMORjB53DbmOBCNXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zco3vmy2CxH5Hj+GXK4NPWp5nhSmdwkcuZXRWcdHFp3ZsW8KBQFCAkig0DgOChHkN
	 kD9uFXrU/yxQk2coAYTHo0u3IW2ctv5MZPe/FFIz03Uv4ntE925Rue1jJHPR6oHDDq
	 DbUSD/HifbetX4MkDEXGXNAv2XRKhG27lrqZM2zw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A4D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbeLKQFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbeLKPzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C572146F;
        Tue, 11 Dec 2018 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543719;
        bh=w06d0gsqifNvWk7Uo1DaAyX/g3DMORjB53DbmOBCNXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7H7GCaA9hBzYr/5AzClOAfux74I/XE79JAjBMX3l/q96nzV5rNgk0BrN3QK3KNKg
         D3rY8omfYU/i96SEUihfQQ8yh2MVszR0iB4XU/pRz6WbU4Ya8/giwVH7xM9sE7A4VC
         ZwKCjHlCzGgvB9hWaO+nJ0JVCljIHwwnwNjWJk34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 005/118] iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()
Date:   Tue, 11 Dec 2018 16:40:24 +0100
Message-Id: <20181211151644.435882036@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 4a03e5090952..188f4eaed6e5 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -596,7 +596,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			pr_err("%s: Page request without PASID: %08llx %08llx\n",
 			       iommu->name, ((unsigned long long *)req)[0],
 			       ((unsigned long long *)req)[1]);
-			goto bad_req;
+			goto no_pasid;
 		}
 
 		if (!svm || svm->pasid != req->pasid) {
-- 
2.19.1



