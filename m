Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6829C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89597208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89597208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbeHWMcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:32:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732985AbeHWMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:32:15 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47ABCCA0;
        Thu, 23 Aug 2018 09:03:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 279/324] net/smc: reset recv timeout after clc handshake
Date:   Thu, 23 Aug 2018 09:55:45 +0200
Message-Id: <20180823075009.964777024@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit f6bdc42f021194ec095914b92c7a8b1a09789e6d ]

During clc handshake the receive timeout is set to CLC_WAIT_TIME.
Remember and reset the original timeout value after the receive calls,
and remove a duplicate assignment of CLC_WAIT_TIME.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_clc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -250,6 +250,7 @@ out:
 int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		     u8 expected_type)
 {
+	long rcvtimeo = smc->clcsock->sk->sk_rcvtimeo;
 	struct sock *clc_sk = smc->clcsock->sk;
 	struct smc_clc_msg_hdr *clcm = buf;
 	struct msghdr msg = {NULL, 0};
@@ -306,7 +307,6 @@ int smc_clc_wait_msg(struct smc_sock *sm
 	memset(&msg, 0, sizeof(struct msghdr));
 	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1, datlen);
 	krflags = MSG_WAITALL;
-	smc->clcsock->sk->sk_rcvtimeo = CLC_WAIT_TIME;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (len < datlen || !smc_clc_msg_hdr_valid(clcm)) {
 		smc->sk.sk_err = EPROTO;
@@ -322,6 +322,7 @@ int smc_clc_wait_msg(struct smc_sock *sm
 	}
 
 out:
+	smc->clcsock->sk->sk_rcvtimeo = rcvtimeo;
 	return reason_code;
 }
 


