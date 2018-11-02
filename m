Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A4C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7F2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMb4nU93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC7F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeKCDqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:30 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1543C2082E;
        Fri,  2 Nov 2018 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183899;
        bh=hIqrV87r5iPV8Y5kHBf9wrvKt4vrSQPTRzBP39xV94E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMb4nU93kwHZqeQ5GOD9tFBS7+uG2LlGGPqwxPlyOUiD/X3pqQVEyOjV4ocH6qxGG
         E45rjuSWXNanktOxTV23kbfp3XpH9nPhQ66puzuK9W3/bW6M5qQyY08WgVUry1CPCN
         2gXZ7Sg4sm+tfVLn9k6yXjOba8pd1oAE66Hlvq+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 014/150] drm/i2c: tda9950: fix timeout counter check
Date:   Fri,  2 Nov 2018 19:32:56 +0100
Message-Id: <20181102182903.738283675@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

[ Upstream commit d98627d1360d55e3b28f702caca8b6342c4a4e45 ]

Currently the check to see if the timeout has reached zero is incorrect
and the check is instead checking if the timeout is non-zero and not
zero, hence it will break out of the loop on the first iteration and
the msleep is never executed.  Fix this by breaking from the loop when
timeout is zero.

Detected by CoverityScan, CID#1469404 ("Logically Dead Code")

Fixes: f0316f93897c ("drm/i2c: tda9950: add CEC driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i2c/tda9950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index 3f7396caad48..f2186409f0cf 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -307,7 +307,7 @@ static void tda9950_release(struct tda9950_priv *priv)
 	/* Wait up to .5s for it to signal non-busy */
 	do {
 		csr = tda9950_read(client, REG_CSR);
-		if (!(csr & CSR_BUSY) || --timeout)
+		if (!(csr & CSR_BUSY) || !--timeout)
 			break;
 		msleep(10);
 	} while (1);
-- 
2.17.1



