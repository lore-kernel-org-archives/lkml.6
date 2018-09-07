Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B36C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFECD20879
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KjudEoSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFECD20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIGM02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:26:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41613 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeIGM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:26:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so11490348ljy.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1RTPO9qIQEpQtoAwM1pLWp2VNLlW/F/d+npIJiW/qA=;
        b=KjudEoSU9bgyjraVpfMHrbGX930Fgzh+k5L7HSAEXgblNrp3p4fsVtsgAPomQHDtFl
         372/gck2EdCcJszZ/dd/SpOvFsJIgcq/aEDhCq6eVtW47+IXcSwswV0vAwYidpE1FUP4
         ZRuVNFoh98sbbV2xXRoKcGz2pzIVoCbNKF3zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a1RTPO9qIQEpQtoAwM1pLWp2VNLlW/F/d+npIJiW/qA=;
        b=Kd+RwA+mqVy9gJLGrfUPUDlSC5H8EDBFEVyacu3MDEAinpVhyNPuRWiaXdWz7NVipA
         W0F3L3JRVIGai8Gwoq31mMKc55fIsABSz4rGutxJul+A5U74v70c4hcuWahCL2ohQh04
         IJBv+9zk97zstoN4rGr3oVosuNj9vnTwOnKLuPKxU4YZ9l9ufgpZQqJuLNmXeT4T0hzO
         qAp2wZMfzOpVFVybT/zE4HqvX7V467Kpwo5F7kb2MGzrJsDxQD9Nuj+OocGbNegKsaeR
         RD8fPD10fSmPJPETmWDeq8lgsTUpADtkHbHsRToz49IL3QNPrso/b+5ynldKgPCKMe2d
         toEA==
X-Gm-Message-State: APzg51DtWbv8KjUF7zYXnDtjqBZ4sh8ZKC6KVIQlLCbJwvsuQT1K/M8D
        QUEcwIX1GpE3xgD1NYosiZL2dg==
X-Google-Smtp-Source: ANB0VdaHlNtneZ3jdIgGLpVTvHZEIeULs+PuAUZTth4nGABsYVsilsxIV5GgHtfmbE3IUkrl2aU63A==
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr3981045ljb.86.1536306405263;
        Fri, 07 Sep 2018 00:46:45 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 96-v6sm1183005lfu.40.2018.09.07.00.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 00:46:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/2] rxrpc: use kmemdup_nul in rxrpc_krb5_decode_principal
Date:   Fri,  7 Sep 2018 09:46:40 +0200
Message-Id: <20180907074640.27348-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180907074640.27348-1-linux@rasmusvillemoes.dk>
References: <20180907074640.27348-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
This depends on patch 1/2.

 net/rxrpc/key.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index e7f6b8823eb6..42f0ca9265c2 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -252,11 +252,9 @@ static int rxrpc_krb5_decode_principal(struct krb5_principal *princ,
 		paddedlen = (tmp + 3) & ~3;
 		if (paddedlen > toklen)
 			return -EINVAL;
-		princ->name_parts[loop] = kmalloc(tmp + 1, GFP_KERNEL);
+		princ->name_parts[loop] = kmemdup_nul(xdr, tmp, GFP_KERNEL);
 		if (!princ->name_parts[loop])
 			return -ENOMEM;
-		memcpy(princ->name_parts[loop], xdr, tmp);
-		princ->name_parts[loop][tmp] = 0;
 		toklen -= paddedlen;
 		xdr += paddedlen >> 2;
 	}
@@ -270,11 +268,9 @@ static int rxrpc_krb5_decode_principal(struct krb5_principal *princ,
 	paddedlen = (tmp + 3) & ~3;
 	if (paddedlen > toklen)
 		return -EINVAL;
-	princ->realm = kmalloc(tmp + 1, GFP_KERNEL);
+	princ->realm = kmemdup_nul(xdr, tmp, GFP_KERNEL);
 	if (!princ->realm)
 		return -ENOMEM;
-	memcpy(princ->realm, xdr, tmp);
-	princ->realm[tmp] = 0;
 	toklen -= paddedlen;
 	xdr += paddedlen >> 2;
 
-- 
2.16.4

