Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AB1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411F52145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxg0QxCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411F52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeJSB7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeJSB7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2195204FD;
        Thu, 18 Oct 2018 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885437;
        bh=OIEbDd7aqEb1QF43vSqSUrjSxkiexFEfXe5gzvK4QcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxg0QxCj4+00pu480Px1ke5RHfy7VTfPjcZwkNxscY7/Cr5OuipaflRkaTpB4iWfd
         btwsTLDz8VhB0eS5Sa+u5vAKT1f4c7seKqvMv8eF5yFWuUZgfo2DfY0uDoLunmm0uH
         VxSJy0f3Loi5Ai76xJvZMjRc+ZXdeNh1En/jfDcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 26/53] net/smc: fix non-blocking connect problem
Date:   Thu, 18 Oct 2018 19:54:19 +0200
Message-Id: <20181018175421.524799261@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -612,7 +612,10 @@ static void smc_connect_work(struct work
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
@@ -1345,7 +1348,7 @@ static __poll_t smc_poll(struct file *fi
 		return EPOLLNVAL;
 
 	smc = smc_sk(sock->sk);
-	if ((sk->sk_state == SMC_INIT) || smc->use_fallback) {
+	if (smc->use_fallback) {
 		/* delegate to CLC child sock */
 		mask = smc->clcsock->ops->poll(file, smc->clcsock, wait);
 		sk->sk_err = smc->clcsock->sk->sk_err;


