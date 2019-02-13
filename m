Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C48207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027171;
	bh=Lt1+69nmdEZAXEvrcmqZJ8nB/oNvhF9tB2778vCUFgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CKJ9mYmagap/0C7wO+55PM08SWUaNuIM8sERrajq14FPzlU7b8hMC3ET40JhSeXEv
	 G6Zzk257U0MQtvzTwgB+yC9js0ETRuu1DU4Rz/39NveAFZgZ8OKOg4fs/zL1Gkujub
	 +HsyhPjUyHeVz0eZcHV8pWauD+acAl4jnOhyKbo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfBMCdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbfBMCdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D818222C2;
        Wed, 13 Feb 2019 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025223;
        bh=Lt1+69nmdEZAXEvrcmqZJ8nB/oNvhF9tB2778vCUFgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozNxsRuUdrHIsSGIeIBSfe2FAR40xagN8BCUvT62keVqJS7j7WwX2j0SfBC95XYd7
         /4V86D5A4qytpJ57Zh9SFc8/BH490H+oPy1kaN8ZcRaDCGZsKt/lUFMdqo34nQGz7I
         tvSEq4n2dX/vTbH0EkRN6swzheP6cNYGgeeSLZKE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 006/105] pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read
Date:   Tue, 12 Feb 2019 21:31:57 -0500
Message-Id: <20190213023336.19019-6-sashal@kernel.org>
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

[ Upstream commit e6587cdbd732eacb4c7ce592ed46f7bbcefb655f ]

When a connection is closing we receive on pvcalls_sk_state_change
notification. Instead of setting the connection as closed immediately
(-ENOTCONN), let's read one more time from it: pvcalls_conn_back_read
will set the connection as closed when necessary.

That way, we avoid races between pvcalls_sk_state_change and
pvcalls_back_ioworker.

Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-back.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 2e5d845b5091..71b628774c6f 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -160,9 +160,10 @@ static void pvcalls_conn_back_read(void *opaque)
 
 	/* write the data, then modify the indexes */
 	virt_wmb();
-	if (ret < 0)
+	if (ret < 0) {
+		atomic_set(&map->read, 0);
 		intf->in_error = ret;
-	else
+	} else
 		intf->in_prod = prod + ret;
 	/* update the indexes, then notify the other end */
 	virt_wmb();
@@ -288,7 +289,7 @@ static void pvcalls_sk_state_change(struct sock *sock)
 		return;
 
 	intf = map->ring;
-	intf->in_error = -ENOTCONN;
+	atomic_inc(&map->read);
 	notify_remote_via_irq(map->irq);
 }
 
-- 
2.19.1

