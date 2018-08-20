Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E212C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A221536
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379A221536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeHTMKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:10:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38730 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:10:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so9721458wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vOAG9J8xNcAmcPq+gbmE7nnOc0++fGPWH3tYcBqm7Zg=;
        b=rvaOLmK4YXz1PPJw6Icu2ePeXEskd9ogq+ys9ITRaJDo7Y4rPRC9jjEv11dwstsuzz
         3Ma7NNdbscWRlEp9ahPhSvJA2fFYai9oIneI2iDfa3K3ZrjoJqqdTBitD46fjP32nBuL
         /9SEjtJjsZzfJsob6hxTr8U4UUmLmbL2eOuX+eaz2UoHZ5TCU0PjFSRmnYQHhYVHLkzy
         5K13SYHD+TqJ0luFfXRQIvTuyHHMmRChKNS4p8thIDWhjrdbLm/t/hLKCDoCr/Q/issQ
         7wOqpgshCuGvOhnv6VIwLaNM83cpO+fLzE6fxx2piluxYiE20YCkWb2hRyseGjk7v/7/
         b/kg==
X-Gm-Message-State: AOUpUlHSCGcAUZP/WAkkVzquzjII37W1dowZKPfjf5skEH3GAHFaTf5N
        NWU7qeqnUbMnlVgPnwOGfag=
X-Google-Smtp-Source: AA+uWPzXWxJSK+j+LOYTqMlgb82j7NdeBNLEu0LiwrXpemVRedjNjh8xP9bI8ZFzlwY5o8y7hXxdJg==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr27740008wrp.202.1534755333703;
        Mon, 20 Aug 2018 01:55:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e137-v6sm18222010wma.20.2018.08.20.01.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 01:55:33 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 4898412492D;
        Mon, 20 Aug 2018 10:55:32 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, joe@perches.com, arnd@arndb.de,
        mhocko@suse.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Date:   Mon, 20 Aug 2018 10:55:16 +0200
Message-Id: <20180820085516.9687-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, NODEMASK_ALLOC allocates a nodemask_t with kmalloc when
NODES_SHIFT is higher than 8, otherwise it declares it within the stack.

The comment says that the reasoning behind this, is that nodemask_t will be
256 bytes when NODES_SHIFT is higher than 8, but this is not true.
For example, NODES_SHIFT = 9 will give us a 64 bytes nodemask_t.
Let us fix up the comment for that.

Another thing is that it might make sense to let values lower than 128bytes
be allocated in the stack.
Although this all depends on the depth of the stack
(and this changes from function to function), I think that 64 bytes
is something we can easily afford.
So we could even bump the limit by 1 (from > 8 to > 9).

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/nodemask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 1fbde8a880d9..5a30ad594ccc 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -518,7 +518,7 @@ static inline int node_random(const nodemask_t *mask)
  * NODEMASK_ALLOC(type, name) allocates an object with a specified type and
  * name.
  */
-#if NODES_SHIFT > 8 /* nodemask_t > 256 bytes */
+#if NODES_SHIFT > 8 /* nodemask_t > 32 bytes */
 #define NODEMASK_ALLOC(type, name, gfp_flags)	\
 			type *name = kmalloc(sizeof(*name), gfp_flags)
 #define NODEMASK_FREE(m)			kfree(m)
-- 
2.13.6

