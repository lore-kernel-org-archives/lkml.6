Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE8FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0D82147A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckeHRf5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0D82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbeJYWxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730997AbeJYWxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:23 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA1F20848;
        Thu, 25 Oct 2018 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477225;
        bh=0sQ+f8bVoklB/YfLYu6NQqSR0Jjp1YogOt9E1kNBgAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckeHRf5CyWs8Ed86CeF1S+fKQvu5pYGiO7sFx4xO+fBECSqGs4m+cVzhMfp7/qHHw
         adDtYRjK+EFmZcinUO60k8rrQ2q5dVEB6gI2BYr3ONnC8T0IBHfXFkkMdNn1krc2WK
         /WEQmC8pQFNHWgUhwUnqPVsIhij2rWKu9aEy84sk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 60/98] dm: fix AB-BA deadlock in __dm_destroy()
Date:   Thu, 25 Oct 2018 10:18:15 -0400
Message-Id: <20181025141853.214051-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junichi Nomura <j-nomura@ce.jp.nec.com>

[ Upstream commit 2a708cff93f1845b9239bc7d6310aef54e716c6a ]

__dm_destroy() takes io_barrier SRCU lock (dm_get_live_table) and
suspend_lock in reverse order.  Doing so can cause AB-BA deadlock:

  __dm_destroy                    dm_swap_table
  ---------------------------------------------------
                                  mutex_lock(suspend_lock)
  dm_get_live_table()
    srcu_read_lock(io_barrier)
                                  dm_sync_table()
                                    synchronize_srcu(io_barrier)
                                      .. waiting for dm_put_live_table()
  mutex_lock(suspend_lock)
    .. waiting for suspend_lock

Fix this by taking the locks in proper order.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Fixes: ab7c7bb6f4ab ("dm: hold suspend_lock while suspending device during device deletion")
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1d08dc6fa0b5..00c86ff3c721 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2599,14 +2599,14 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
 	 * do not race with internal suspend.
 	 */
 	mutex_lock(&md->suspend_lock);
+	map = dm_get_live_table(md, &srcu_idx);
 	if (!dm_suspended_md(md)) {
 		dm_table_presuspend_targets(map);
 		dm_table_postsuspend_targets(map);
 	}
-	mutex_unlock(&md->suspend_lock);
-
 	/* dm_put_live_table must be before msleep, otherwise deadlock is possible */
 	dm_put_live_table(md, srcu_idx);
+	mutex_unlock(&md->suspend_lock);
 
 	/*
 	 * Rare, but there may be I/O requests still going to complete,
-- 
2.17.1

