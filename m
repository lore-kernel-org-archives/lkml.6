Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F33C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE4C20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE4C20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936038AbeFRIYI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:24:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936020AbeFRIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF660BAD;
        Mon, 18 Jun 2018 08:24:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH 4.16 172/279] smc: fix sendpage() call
Date:   Mon, 18 Jun 2018 10:12:37 +0200
Message-Id: <20180618080615.935334248@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Raspl <stefan.raspl@linux.ibm.com>

[ Upstream commit bda27ff5c4526f80a7620a94ecfe8dca153e3696 ]

The sendpage() call grabs the sock lock before calling the default
implementation - which tries to grab it once again.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com><
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1313,8 +1313,11 @@ static ssize_t smc_sendpage(struct socke
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
-	if (sk->sk_state != SMC_ACTIVE)
+	if (sk->sk_state != SMC_ACTIVE) {
+		release_sock(sk);
 		goto out;
+	}
+	release_sock(sk);
 	if (smc->use_fallback)
 		rc = kernel_sendpage(smc->clcsock, page, offset,
 				     size, flags);
@@ -1322,7 +1325,6 @@ static ssize_t smc_sendpage(struct socke
 		rc = sock_no_sendpage(sock, page, offset, size, flags);
 
 out:
-	release_sock(sk);
 	return rc;
 }
 


