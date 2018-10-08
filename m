Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFD020652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wrx3uomt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFD020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJHWsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbeJHWiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4323B214FA;
        Mon,  8 Oct 2018 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012356;
        bh=322mZ2DJbQyK2ZQOB1qJyTphP12wA6q/XVuZ8ZPpUuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrx3uomttNYy5TJM7P5AIX0XvNBCiUqTMHdEFD1F7vDJ793lGjJWxOt/hQqzZBEc9
         2hL4oHWYqSjuDVp5hYdxwo74mgFJabfuJ5OP9DmkItWTOM6eqyM0keai7uO3nfhS8m
         Wye7bcs5ohkCGzUabPl5ZRD1E35CA091qXhC8/kU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 31/58] net/smc: fix sizeof to int comparison
Date:   Mon,  8 Oct 2018 11:24:56 -0400
Message-Id: <20181008152523.70705-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 381897798a94065ffcad0772eecdc6b04a7ff23d ]

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result. kernel_sendmsg can return a negative
error code.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/smc/smc_clc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index ae5d168653ce..086157555ac3 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -405,14 +405,12 @@ int smc_clc_send_proposal(struct smc_sock *smc,
 	vec[i++].iov_len = sizeof(trl);
 	/* due to the few bytes needed for clc-handshake this cannot block */
 	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
-	if (len < sizeof(pclc)) {
-		if (len >= 0) {
-			reason_code = -ENETUNREACH;
-			smc->sk.sk_err = -reason_code;
-		} else {
-			smc->sk.sk_err = smc->clcsock->sk->sk_err;
-			reason_code = -smc->sk.sk_err;
-		}
+	if (len < 0) {
+		smc->sk.sk_err = smc->clcsock->sk->sk_err;
+		reason_code = -smc->sk.sk_err;
+	} else if (len < (int)sizeof(pclc)) {
+		reason_code = -ENETUNREACH;
+		smc->sk.sk_err = -reason_code;
 	}
 
 	return reason_code;
-- 
2.17.1

