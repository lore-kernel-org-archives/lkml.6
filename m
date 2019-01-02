Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB31FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703462080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG1OLuO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfABAkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:40:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47025 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfABAkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:40:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so17119933qkf.13;
        Tue, 01 Jan 2019 16:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+wJqwJ4uqw7ips3uk9f1n0GwAIeGhNy9X1ImJZa/LJE=;
        b=HG1OLuO8zyo9mMEN44+WJJm5llioFdVcNY3zegxtJC4SrNKJCAW224Cx8PCMeSy+XY
         l3k2RfhcwUw4XGtFY7jn2nKeLr45ARv+YyxzHJnotv+2lBg9wKz5Czlp4o8O9DFvpo+9
         Ld4XEiYrpbfWpCIe6FGU68y8Ugy7K83h35CXviKAvQ3w+z+NDCd8BD3Mgl4QQeFo/hay
         zfpdlLs0GprIW8zHS0ERWmYumoPThML21/w9/L1kgA7ygKtEzireZhi1ryiwXE7sGXxr
         JjzmRg8/hsBcgg8qYOEHEb3lvQffu2JpgILqkRbR54YwGjGeo5hwWEbZeIxOGRpQQn0f
         DxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+wJqwJ4uqw7ips3uk9f1n0GwAIeGhNy9X1ImJZa/LJE=;
        b=CcT/1298/i7P3YAvtDewyx2zyhPjsoZKCtmvH8clQxedRcYQmTEJSoXOMKvGpkQBUU
         KdfCNdZjCuzjxVJAQtAXbhs3FJ7SGe0Ljh/PVSFLEllUZgaxtXYmXCIF74yCIIbKqhY2
         2/HIQsLquQM3pcg3YONCSSfUFglwbKKVL+Nmn9k3d6fuFYlE+4GkEvdYULqaDc4a01qM
         9g2dIfRG/6rMM8z0/S/Gai9h94In3YK4TAqu9lI8nFjHvnRkbZtOfHdxrDHLjGbhnLWb
         lo5ol7L+S33kKrINyBuqs3rUmriZPtHlu2IMZ9bQ2OwePFoY54W+o6KH+ELhjQ022F74
         /MEg==
X-Gm-Message-State: AJcUukeC0vchs1hnON2BGhyOnvSekmSaTESaeT3utMiiTgZN1Ky9dkXc
        5I7x+tFBaSxyo34F0BZx+snM+0hIlJ0=
X-Google-Smtp-Source: ALg8bN5Za+YJkXbLxOL+81D1Hp/QR7YdRvmurrQU3D0XDSdIHNduHsLzwz1HtxiwZ1+oDnh/YNYoCQ==
X-Received: by 2002:a37:9f92:: with SMTP id i140mr8402700qke.131.1546389609515;
        Tue, 01 Jan 2019 16:40:09 -0800 (PST)
Received: from localhost.localdomain ([186.212.93.174])
        by smtp.gmail.com with ESMTPSA id x202sm20386572qka.67.2019.01.01.16.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 16:40:08 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH] Docs/kernel-api.rst: Remove removed blk-tag.c reference
Date:   Tue,  1 Jan 2019 22:40:14 -0200
Message-Id: <20190102004015.47152-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 7ca01926463a, legacy rq tagging was removed, so block/blk-tag.c
does not exists anymore. When generating pdfdocs, sphinx complains about
this missing file:

Error: Cannot open file ./block/blk-tag.c
Error: Cannot open file ./block/blk-tag.c
Error: Cannot open file ./block/blk-tag.c
Error: Cannot open file ./block/blk-tag.c

So remove blk-tag.c traces from kernel-api.rst file to silence these
warnings.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Documentation/core-api/kernel-api.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 3431337ee4e6..cdd24943fbcc 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -291,12 +291,6 @@ Block Devices
 .. kernel-doc:: block/blk-lib.c
    :export:
 
-.. kernel-doc:: block/blk-tag.c
-   :export:
-
-.. kernel-doc:: block/blk-tag.c
-   :internal:
-
 .. kernel-doc:: block/blk-integrity.c
    :export:
 
-- 
2.16.4

