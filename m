Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B77BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D867420672
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TEjgjcZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D867420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeKURbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:31:31 -0500
Received: from m12-13.163.com ([220.181.12.13]:56706 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbeKURbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=C4Cqs7+nPKIA7Im3WO
        hFRZa6bT9WDXG8Zm6HdetDyKg=; b=TEjgjcZqbPA3pmiNGDDK6VnhKEw5N2Uu2s
        r+lLST2AnbXREc0GdFWHwyuCIjocJrMNAMgiKLyBSJ/zkjG+yD61WgYNFJujeaZr
        q7vyEl+dd1JRP+djHziHJaQ5z0oYQSHhCU11T8lbDMLK937mIYMfKuTHCxotxi3m
        25T0zvk60=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowAAnl9PpAfVbi1RpBA--.5975S3;
        Wed, 21 Nov 2018 14:57:49 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2013@163.com>
Subject: [net] xfrm_user: use xfrm_state_put to free xfrm_state_alloc return value
Date:   Wed, 21 Nov 2018 14:57:48 +0800
Message-Id: <1542783468-67482-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcCowAAnl9PpAfVbi1RpBA--.5975S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr18WrWDWw1xCF1DKF43GFg_yoWxCwc_Ww
        4xXFn7AFZxtF1Syw48Jr45Xwn3Wrn5Z3Z5Was7tFyfZry0qrZ3J34Iqrn5Xr47urWUuryU
        t3WDuasayryDZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnrWrtUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZw0GcletsEXtLgAAsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2013@163.com>

The memory chunk allocated by xfrm_state_alloc() should be released with
xfrm_state_put(), not kfree.

Signed-off-by: Pan Bian <bianpan2013@163.com>
---
 net/xfrm/xfrm_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c9a84e2..267922c 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2288,13 +2288,13 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	}
 
-	kfree(x);
+	xfrm_state_put(x);
 	kfree(xp);
 
 	return 0;
 
 free_state:
-	kfree(x);
+	xfrm_state_put(x);
 nomem:
 	return err;
 }
-- 
2.7.4


