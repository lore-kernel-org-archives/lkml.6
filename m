Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D309C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DED8222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899591;
	bh=320yiH5pvAsX3/b5iRpr3y7PAIhrwGo+QCAh2FucukI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yHyGFhjJUEXEkit/fN0yA1pHRxX7UVQrGtUXjGp6jLqSknshhiKuIxxNV/19Xx0h2
	 BYkxdOXvV/SAJPciN7IHMWt75ieARbciyjruJRriCzIr7497mis1LsJsqfnzpPyY5a
	 lMO8Y2eAhca9NIntliKCppOSFP5B8mI3LBhWjK/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbfBKOtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387796AbfBKOtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:49:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CEEE2081B;
        Mon, 11 Feb 2019 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896547;
        bh=320yiH5pvAsX3/b5iRpr3y7PAIhrwGo+QCAh2FucukI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQXfW+Zw6nFAl0KFJAlTFkUvrzlkhX9sjPFAJzNIrCqXb+nNWNm7BrnJhqNX6Ib3G
         TvdiRrmv1Bj2CXQRaWnzecLBGkuhXHcyQNWAcAQChR2CdvOyL0A9fgRI1J5j6TbEik
         ggXJqF6QONmqW1msjNs1JIsi2BoPS+sV5iUF2tAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 190/313] drbd: narrow rcu_read_lock in drbd_sync_handshake
Date:   Mon, 11 Feb 2019 15:17:50 +0100
Message-Id: <20190211141905.943630938@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit d29e89e34952a9ad02c77109c71a80043544296e ]

So far there was the possibility that we called
genlmsg_new(GFP_NOIO)/mutex_lock() while holding an rcu_read_lock().

This included cases like:

drbd_sync_handshake (acquire the RCU lock)
  drbd_asb_recover_1p
    drbd_khelper
      drbd_bcast_event
        genlmsg_new(GFP_NOIO) --> may sleep

drbd_sync_handshake (acquire the RCU lock)
  drbd_asb_recover_1p
    drbd_khelper
      notify_helper
        genlmsg_new(GFP_NOIO) --> may sleep

drbd_sync_handshake (acquire the RCU lock)
  drbd_asb_recover_1p
    drbd_khelper
      notify_helper
        mutex_lock --> may sleep

While using GFP_ATOMIC whould have been possible in the first two cases,
the real fix is to narrow the rcu_read_lock.

Reported-by: Jia-Ju Bai <baijiaju1990@163.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 75f6b47169e6..45ac5fe288e4 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3364,7 +3364,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	enum drbd_conns rv = C_MASK;
 	enum drbd_disk_state mydisk;
 	struct net_conf *nc;
-	int hg, rule_nr, rr_conflict, tentative;
+	int hg, rule_nr, rr_conflict, tentative, always_asbp;
 
 	mydisk = device->state.disk;
 	if (mydisk == D_NEGOTIATING)
@@ -3415,8 +3415,12 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 
 	rcu_read_lock();
 	nc = rcu_dereference(peer_device->connection->net_conf);
+	always_asbp = nc->always_asbp;
+	rr_conflict = nc->rr_conflict;
+	tentative = nc->tentative;
+	rcu_read_unlock();
 
-	if (hg == 100 || (hg == -100 && nc->always_asbp)) {
+	if (hg == 100 || (hg == -100 && always_asbp)) {
 		int pcount = (device->state.role == R_PRIMARY)
 			   + (peer_role == R_PRIMARY);
 		int forced = (hg == -100);
@@ -3455,9 +3459,6 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 			     "Sync from %s node\n",
 			     (hg < 0) ? "peer" : "this");
 	}
-	rr_conflict = nc->rr_conflict;
-	tentative = nc->tentative;
-	rcu_read_unlock();
 
 	if (hg == -100) {
 		/* FIXME this log message is not correct if we end up here
-- 
2.19.1



