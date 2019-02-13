Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133BBC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C939620835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026650;
	bh=6JkXZgU+8gSIgO+8waHN99SUQskISg9iLCzYDiLVzlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S2gxshMRK3MxQrT0yiFTW9hO0JxivYhnVEgPqVxc/pmKEf1B6iDJFfhXfA8bJ68K4
	 fxYSuDbmqIa8Yl/puSWiynHbmZ3YdDHhmF6rRRZ4gx7d6/RjeYCG5QOmUccKeyyOAw
	 oULhd5wmM3iuhHqvAo8ncHSztyROEhx11bJKzzQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbfBMC53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388230AbfBMChG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6137B222C7;
        Wed, 13 Feb 2019 02:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025426;
        bh=6JkXZgU+8gSIgO+8waHN99SUQskISg9iLCzYDiLVzlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=no61RIYA1NxMRzoFZKgfm+d0P7hDL56Xwx7bzJZQ6LbYqOgtp8kQ6rXuNMpmE2hFX
         uCuZUYT+ypie6JeUHPglj2Cuhce9zhdKQKOavpsEGHiCBKPflV2nL6xs1fhUG1VyYK
         lmZ6nNC59X+DHRdaTJKhCmtsZrN3B7Z+f2SqYTHA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 03/83] pvcalls-front: read all data before closing the connection
Date:   Tue, 12 Feb 2019 21:35:41 -0500
Message-Id: <20190213023701.20286-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
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

