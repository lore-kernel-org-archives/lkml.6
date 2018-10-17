Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B944ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2247A2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UafyW8La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2247A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeJRCAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:00:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51394 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRCAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:00:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so2892787wmf.1;
        Wed, 17 Oct 2018 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qjy26oRjORMaIi9tFL1W7gCFftc8wwLhC9kN/N4k/6o=;
        b=UafyW8LaqETj9ZR6MHVQBftleFlrRGMPwIevRiQdzW/ahptL1X8xBzv8bVjD4KjPtm
         eq5kzh/BpCwazc07FxU+u7wYGfZjHJFzyKLK+anVyJdoSBV6YrN231NX+/4WAIV6vncK
         tdK9uQoz+w9OJuZf4xMD+aYs9CjbqzPZ5fJhBZIA0UdQxSOCEsWMaiMWxUwdf2VNcaxc
         zIDBMLqhk1yhrFS528YdzAvnxnVM8/8ZybV1zIWn01OX18BvFZKyFQt1me4B9sXvVCJp
         3pJp0ET2vvciZOZwfQoPQ1ePuwvlQKCjLVKRrgLX8BgCCguniaXKng+rvP0TRRxWHjJO
         7azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qjy26oRjORMaIi9tFL1W7gCFftc8wwLhC9kN/N4k/6o=;
        b=gDw3I1kZTcQNoT5kj9MC3iyMR/6/cXG6GT71kGo2Z1/+cPTM6NNGEBlGP4GTrBrLvH
         ZpLqc2FaDfeBva9nWRGL5fvyGQSGIFJmZRT+R/gd6E5xRK8RZQ8DimH2VW/k7tAkxjzA
         Pl++V+u4mt7DfNBEiGfbjwdetcNZi7JlK0oOhqrWgda/5yVhcKbm9wuAcAK5X+thykWt
         Pla/45DmFx0Hoi5970GLzxsI+EwbuLHv/0uI9PHNLYe3jcavKVRQnpRL0bZm02PKPzqz
         y/0nzXgvWxJwQfQ1rab0M4GvaG/vBwWAaK+sllK3wk3DMgWVlZO9adjAJJBXRjYzUVae
         su7w==
X-Gm-Message-State: ABuFfog/ZaEdqTcdvaOpY4iKLvs7t1HA9j6HDj4gTqGgDqUhfMnrxHiG
        LVQhokXgy/SNX0YVmHKDcWs=
X-Google-Smtp-Source: ACcGV63UI1ckhO9DCR41oT1MWON/LP9tEDbfLpN8RxRzigTWnc7w+GsQnZXbVzDvEectg8A40C8SLA==
X-Received: by 2002:a1c:41c5:: with SMTP id o188-v6mr4195544wma.34.1539799429558;
        Wed, 17 Oct 2018 11:03:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j203-v6sm3474879wmd.46.2018.10.17.11.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:03:48 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Chas Williams <3chas3@gmail.com>
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] atm: eni: Move semicolon to a new line after empty for loop
Date:   Wed, 17 Oct 2018 11:03:34 -0700
Message-Id: <20181017180334.8640-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/atm/eni.c:244:48: error: for loop has empty body
[-Werror,-Wempty-body]
        for (order = 0; (1 << order) < *size; order++);
                                                      ^
drivers/atm/eni.c:244:48: note: put the semicolon on a separate line to
silence this warning

In this case, that loop is expected to be empty so silence the warning
in the way that Clang suggests.

Link: https://github.com/ClangBuiltLinux/linux/issues/42
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/atm/eni.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 6470e3c4c990..f8c703426c90 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -241,7 +241,8 @@ static void __iomem *eni_alloc_mem(struct eni_dev *eni_dev, unsigned long *size)
 	len = eni_dev->free_len;
 	if (*size < MID_MIN_BUF_SIZE) *size = MID_MIN_BUF_SIZE;
 	if (*size > MID_MAX_BUF_SIZE) return NULL;
-	for (order = 0; (1 << order) < *size; order++);
+	for (order = 0; (1 << order) < *size; order++)
+		;
 	DPRINTK("trying: %ld->%d\n",*size,order);
 	best_order = 65; /* we don't have more than 2^64 of anything ... */
 	index = 0; /* silence GCC */
-- 
2.19.1

