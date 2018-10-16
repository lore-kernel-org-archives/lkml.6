Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B748C21479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBn6aApD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B748C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeJPMBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbeJPMBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B611D21470;
        Tue, 16 Oct 2018 04:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663198;
        bh=g7BajnWw4EnvU7fm4a7Hhu+wnAnOrHuS3slSk5mhOmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBn6aApDOh79iv4a5oa7dIWgS4OQIFGs6RSUBaS+XGnH8SXdA7cWaVHBZ3hEhThvm
         cPqgls1tKg6njyQtM0BBJ8ZWJOoQIK9/RBqX4e8Ix5iUjdjMBtHM7MRAoxFfH6X52s
         IpoZrUJljVQ981RWTOo5yA5jxyV2XWdHB5j5i6js=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 062/100] tun: remove unused parameters
Date:   Tue, 16 Oct 2018 00:11:43 -0400
Message-Id: <20181016041221.135528-62-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 06e55addd3f40b5294e448c2cb7605ca4f28c2e3 ]

tun_napi_disable() and tun_napi_del() do not need
a pointer to the tun_struct

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f5727baac84a..dc2fcddb625d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -323,13 +323,13 @@ static void tun_napi_init(struct tun_struct *tun, struct tun_file *tfile,
 	}
 }
 
-static void tun_napi_disable(struct tun_struct *tun, struct tun_file *tfile)
+static void tun_napi_disable(struct tun_file *tfile)
 {
 	if (tfile->napi_enabled)
 		napi_disable(&tfile->napi);
 }
 
-static void tun_napi_del(struct tun_struct *tun, struct tun_file *tfile)
+static void tun_napi_del(struct tun_file *tfile)
 {
 	if (tfile->napi_enabled)
 		netif_napi_del(&tfile->napi);
@@ -688,8 +688,8 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 	tun = rtnl_dereference(tfile->tun);
 
 	if (tun && clean) {
-		tun_napi_disable(tun, tfile);
-		tun_napi_del(tun, tfile);
+		tun_napi_disable(tfile);
+		tun_napi_del(tfile);
 	}
 
 	if (tun && !tfile->detached) {
@@ -756,7 +756,7 @@ static void tun_detach_all(struct net_device *dev)
 	for (i = 0; i < n; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		BUG_ON(!tfile);
-		tun_napi_disable(tun, tfile);
+		tun_napi_disable(tfile);
 		tfile->socket.sk->sk_shutdown = RCV_SHUTDOWN;
 		tfile->socket.sk->sk_data_ready(tfile->socket.sk);
 		RCU_INIT_POINTER(tfile->tun, NULL);
@@ -772,7 +772,7 @@ static void tun_detach_all(struct net_device *dev)
 	synchronize_net();
 	for (i = 0; i < n; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
-		tun_napi_del(tun, tfile);
+		tun_napi_del(tfile);
 		/* Drop read queue */
 		tun_queue_purge(tfile);
 		xdp_rxq_info_unreg(&tfile->xdp_rxq);
-- 
2.17.1

