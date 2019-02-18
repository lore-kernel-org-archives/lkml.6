Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44620C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1441E21902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498645;
	bh=UZI5IIupBkAGW+JDL690RohgpbngbwUXBdeSwDGG1as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHg1IxC3MfyQl0TsLKZPnF8diSfN5OpbTCfdcKUhP3uASOYnhd4qXIstK9xwltZUg
	 aZgXOnHGj/yGi3j6F36RKvkMoFS4ZBm3hEzcSUC5/fPeBIeeCV2Z41v81hg0CzR/6P
	 enTfTaLOUS9NiH6j72PzA8ruqk1WAjtF6LF652A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbfBROED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:04:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389765AbfBRODw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3353321902;
        Mon, 18 Feb 2019 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498631;
        bh=UZI5IIupBkAGW+JDL690RohgpbngbwUXBdeSwDGG1as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uun19XBeHD7ftLVSsKf8msAZ3fbq1hb1rCcifw/3WkUnrIkAzOiC5w6iYGOPSzkc3
         Kwxptp9x7FjuhtCR2KDRzr9KjVWWv3AX+2NmJchA6orjjoVbZ4dAtF72HbAceDFeZd
         6nvMuicvEutjHscAFaQryoH+1IvyhUjFnLcUxMww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 048/143] drbd: skip spurious timeout (ping-timeo) when failing promote
Date:   Mon, 18 Feb 2019 14:42:56 +0100
Message-Id: <20190218133530.888235816@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index e80cbefbc2b5..27e1abcf5710 100644
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



