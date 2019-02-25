Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ACFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B961521841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130244;
	bh=bv8RmynnJvoj4ldV1B+Gu0xmpud5WgyWFu2ltYuEyOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qw/Fe1S95+eVn1vOOaf4tIWRLs+/1WPPCUKvpwpOl+mkJOhTKdTxnJS22vNJrV+s1
	 nh1Hpyoc/CpXGXKgaexpVJtDyDs6XU4N3SXkejBR2azZtqpIaFXUwTJ3xrhDBn/k4i
	 hv5goCf9FnNrNTTsBqFR+QUFWoEyHI6/ybPLIzj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfBYVam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731738AbfBYVak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50300217F5;
        Mon, 25 Feb 2019 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130239;
        bh=bv8RmynnJvoj4ldV1B+Gu0xmpud5WgyWFu2ltYuEyOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yC09BeMpM6ObuqV4kL5XTSi6LSDZfqmNdptoZNKel2D/8ta9OMdUQezAdBAnZeP/V
         1/kHNavXicBsfIYY2Mi5Q94tK2YI+HYX0zw0MhrLXDX6ummr1j1LeYVulrz2ffbr3N
         uX7m2nXUiFTmfdKIYArsCXMeajbQ/7/h2XzvJCj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 021/183] pvcalls-front: read all data before closing the connection
Date:   Mon, 25 Feb 2019 22:09:54 +0100
Message-Id: <20190225195058.313127482@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 77224d8f3e6fe..e5d95aab2cb80 100644
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



