Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2795C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88270222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025222;
	bh=6JkXZgU+8gSIgO+8waHN99SUQskISg9iLCzYDiLVzlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+0Z2gIoaxTz3uxVfWP3Zo8CTxoGwfVak/iqFGNRIVkgadW769GuoFH1Sy40GRljp
	 VvngHqVRm35svzzZ+4N0fZWIeINda+xXev/NN7LCCOEZhTtKZoobLWjbcQ3HWK2Rhg
	 BAxbNgZK14xZ+WEmrck77uRLoWBKvf6zZqwy8V5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbfBMCdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbfBMCdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958D0222BA;
        Wed, 13 Feb 2019 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025220;
        bh=6JkXZgU+8gSIgO+8waHN99SUQskISg9iLCzYDiLVzlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cNDTRH+yRIxtqa+Ar1NIPNetQtPPkYM4K4qtYLkGLncgnxnK/5eRMRs9pzlI678E
         5tFMq68rZjyTJ6A9TRFxUXlPAaOc9tzMQ4rK9F0lChN7FaiJBg+OZkJxrpt9KCySLK
         zqgoAswSd7s4PRApWrh5nFFm3sphgFqDWSBvkjt0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 003/105] pvcalls-front: read all data before closing the connection
Date:   Tue, 12 Feb 2019 21:31:54 -0500
Message-Id: <20190213023336.19019-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <sstabellini@kernel.org>

[ Upstream commit b79470b64fa9266948d1ce8d825ced94c4f63293 ]

When a connection is closing in_error is set to ENOTCONN. There could
still be outstanding data on the ring left by the backend. Before
closing the connection on the frontend side, drain the ring.

Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 77224d8f3e6f..e5d95aab2cb8 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -560,15 +560,13 @@ static int __read_ring(struct pvcalls_data_intf *intf,
 	error = intf->in_error;
 	/* get pointers before reading from the ring */
 	virt_rmb();
-	if (error < 0)
-		return error;
 
 	size = pvcalls_queued(prod, cons, array_size);
 	masked_prod = pvcalls_mask(prod, array_size);
 	masked_cons = pvcalls_mask(cons, array_size);
 
 	if (size == 0)
-		return 0;
+		return error ?: size;
 
 	if (len > size)
 		len = size;
-- 
2.19.1

