Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B04222AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897664;
	bh=ZhEtCFp3ZlY9UL1o/SMRzpF6HPBaJ4i7IpmV6qgesq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEIsSMHd65Luqgv/XK8Yle8eMtG3KGBXNWEfoVX3HvAxVMuWo2aLeHaRKH2vQ3zNF
	 sPjBSVhjrLH0sAOe5Q+NnjKjBNWmJibnH44e5R+2SkDHsgPJlKFFWqNEQpOa2BajNw
	 Qh8+pOF6Hirc4BGLLqIGzOD4btG1WTDXIdEqc9pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391409AbfBKPHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391382AbfBKPHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C27F222A7;
        Mon, 11 Feb 2019 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897655;
        bh=ZhEtCFp3ZlY9UL1o/SMRzpF6HPBaJ4i7IpmV6qgesq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvGpC6z6FK9lr0U3EB31rIRAM0Z4vDP+9qXn5Mg8jhrhQUOnms73aMtwcFFggBuwh
         E8iyTxB0k6c9Cfl/96xFXo5zWcqzpwX4B0bC9WCtMYJvZJ0PGL2sCDO5M/sHd2NVh2
         hFjcAAVG6aJ2rVZnOjMJ0+qhLwR6Syk0lH33Xr8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 070/137] drbd: skip spurious timeout (ping-timeo) when failing promote
Date:   Mon, 11 Feb 2019 15:19:11 +0100
Message-Id: <20190211141818.501833123@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

[ Upstream commit 9848b6ddd8c92305252f94592c5e278574e7a6ac ]

If you try to promote a Secondary while connected to a Primary
and allow-two-primaries is NOT set, we will wait for "ping-timeout"
to give this node a chance to detect a dead primary,
in case the cluster manager noticed faster than we did.

But if we then are *still* connected to a Primary,
we fail (after an additional timeout of ping-timout).

This change skips the spurious second timeout.

Most people won't notice really,
since "ping-timeout" by default is half a second.

But in some installations, ping-timeout may be 10 or 20 seconds or more,
and spuriously delaying the error return becomes annoying.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_nl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f35db29cac76..abee91940a36 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -668,14 +668,15 @@ drbd_set_role(struct drbd_device *const device, enum drbd_role new_role, int for
 		if (rv == SS_TWO_PRIMARIES) {
 			/* Maybe the peer is detected as dead very soon...
 			   retry at most once more in this case. */
-			int timeo;
-			rcu_read_lock();
-			nc = rcu_dereference(connection->net_conf);
-			timeo = nc ? (nc->ping_timeo + 1) * HZ / 10 : 1;
-			rcu_read_unlock();
-			schedule_timeout_interruptible(timeo);
-			if (try < max_tries)
+			if (try < max_tries) {
+				int timeo;
 				try = max_tries - 1;
+				rcu_read_lock();
+				nc = rcu_dereference(connection->net_conf);
+				timeo = nc ? (nc->ping_timeo + 1) * HZ / 10 : 1;
+				rcu_read_unlock();
+				schedule_timeout_interruptible(timeo);
+			}
 			continue;
 		}
 		if (rv < SS_SUCCESS) {
-- 
2.19.1



