Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A53C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FBA20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnjTKVTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FBA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJHWiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeJHWiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA572089D;
        Mon,  8 Oct 2018 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012356;
        bh=GJh47ICuaA/uWlFrils0n+dj/JMqCigEt1OhCV2DPYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnjTKVTZeXvA3p/w6cm/jKIaQTEhgH2GQqiN5+QFgr4azy8KRkQ7PQQvmo3ZiDexL
         389ewfV4xX89wUtYpSVQPygHvnxowXcG8njLs0NDHT+J1LuCFZf29j87FtRCjzX15e
         F5xOXJr2TtLS26S+L3mqzbcGo3DfoiML87vqyodk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 30/58] net/smc: fix non-blocking connect problem
Date:   Mon,  8 Oct 2018 11:24:55 -0400
Message-Id: <20181008152523.70705-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit 648a5a7aed346c3b8fe7c32a835edfb0dfbf4451 ]

In state SMC_INIT smc_poll() delegates polling to the internal
CLC socket. This means, once the connect worker has finished
its kernel_connect() step, the poll wake-up may occur. This is not
intended. The wake-up should occur from the wake up call in
smc_connect_work() after __smc_connect() has finished.
Thus in state SMC_INIT this patch now calls sock_poll_wait() on the
main SMC socket.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/smc/af_smc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e7de5f282722..effa87858b21 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -612,7 +612,10 @@ static void smc_connect_work(struct work_struct *work)
 		smc->sk.sk_err = -rc;
 
 out:
-	smc->sk.sk_state_change(&smc->sk);
+	if (smc->sk.sk_err)
+		smc->sk.sk_state_change(&smc->sk);
+	else
+		smc->sk.sk_write_space(&smc->sk);
 	kfree(smc->connect_info);
 	smc->connect_info = NULL;
 	release_sock(&smc->sk);
@@ -1345,7 +1348,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 		return EPOLLNVAL;
 
 	smc = smc_sk(sock->sk);
-	if ((sk->sk_state == SMC_INIT) || smc->use_fallback) {
+	if (smc->use_fallback) {
 		/* delegate to CLC child sock */
 		mask = smc->clcsock->ops->poll(file, smc->clcsock, wait);
 		sk->sk_err = smc->clcsock->sk->sk_err;
-- 
2.17.1

