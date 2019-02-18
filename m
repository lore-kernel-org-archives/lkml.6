Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E822C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A6217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498971;
	bh=soa05H1rZ/slBsDhvNJTCX+9+oFpyEpLU01TRSsaPMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VfiCb1Wmv0Iiq32lz0Wz1DnpN1Bd61C/mDLuyj/nmoqkwEA/QiANssTXas2RxxC90
	 MOK86zdCM4RLaHOtrdLsWQ5WkGJ5mj/pYKE8cowxYD7KlK8KZENex0bYpUG1dRtMcz
	 ++GByxfsYMikAF7xGtfUu3wqa02IySNs7pka1DTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391219AbfBROJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391183AbfBROJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF34217D7;
        Mon, 18 Feb 2019 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498965;
        bh=soa05H1rZ/slBsDhvNJTCX+9+oFpyEpLU01TRSsaPMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLsw70Ob7ojGJNvEgUDbkKn1+ulpTLHUYNTa6gj3ox+f0OJj+mO9bHs12cw5pnIuv
         dRRdIkj+ZLFKLTOAf6gFA9YYzNz1Tl49QpksaiUU5GDWX+rXlBtv/HN2LGNEkGCoQt
         Gv54enoKEjLZHqccM3NHwrZ6kFfz6BaUgatkr/8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 034/108] drbd: skip spurious timeout (ping-timeo) when failing promote
Date:   Mon, 18 Feb 2019 14:43:30 +0100
Message-Id: <20190218133521.112058847@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
index 1cd47df44bda..591d309b005e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -632,14 +632,15 @@ drbd_set_role(struct drbd_device *const device, enum drbd_role new_role, int for
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



