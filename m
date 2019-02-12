Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34685C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EC2222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fFKri0CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfBLVmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46895 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfBLVl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:41:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so133699edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lY/rybTOp94ch0enIcsJZn3nSYytTdfR3B5zeA2FxJY=;
        b=fFKri0CL3Kv9kWGf+ZtJJZnN5IeUjaj4TU8Y8JMiLnsfBrWUAdpY0JTttALx5TU6Kn
         rVC7jXSh9wJNLM7tbSQevj+vQU+hpNr3/LY4JzTJEFIgI7pKdzozkw9HYJo4HsZlP8qK
         3vm3RIx6dCjj1+pc34nuJjBNSs8xPBz+cyqSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY/rybTOp94ch0enIcsJZn3nSYytTdfR3B5zeA2FxJY=;
        b=GKEj6DsAu2DMWk8iKR0LGl0a2fcsOFSAM7nRjPvVAQHmK9sW/Hn8ziGC1Bn/FEgVo3
         a6Q75aEOJqWtVYEkiiolYx9ZJ8jAs33bxHuK1MS3LqK4yfG9CN8pY6ygNd4RmMu/oieA
         QforGbhhvk73FdifTcGhkKp7Rdz1a+31RGclFVm78soM+Ls8nkSdzL6E6yBx/6VDti1c
         KiPw05DktgoN/TxAg5nC7Fiq0PW1oVOqE/1WfeuYNU60yE69UmAl1fr4B71oxP0eOH8a
         Vn1QPVJrEYtnU4Gx2uR33PChpT7sH9HTZuU+4w5baOMvR2vsK0euVRwaCv3UnZ9lSXAn
         jALw==
X-Gm-Message-State: AHQUAuan8HgsxmpYtYAAzu9bYsghalyF1GMxm7oXcljSp+2zSewV12al
        DeYcx5HlDkcohtzACK7exPfmVw==
X-Google-Smtp-Source: AHgI3IaOp0nYDxCbu0XDBhKdgDMX+kP7NAewkkW+2pCcYQ945HvoARVTgc/ZfjFS+kWvqi1ktn39RQ==
X-Received: by 2002:a50:be05:: with SMTP id a5mr4746295edi.243.1550007717264;
        Tue, 12 Feb 2019 13:41:57 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:41:56 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 01/14] linux/device.h: use DYNAMIC_DEBUG_BRANCH in dev_dbg_ratelimited
Date:   Tue, 12 Feb 2019 22:41:37 +0100
Message-Id: <20190212214150.4807-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_dbg_ratelimited tests the dynamic debug descriptor the
old-fashioned way, and doesn't utilize the static key/jump label
implementation when CONFIG_JUMP_LABEL is set. Use the
DYNAMIC_DEBUG_BRANCH which is defined appropriately.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..b49b142c5d6a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1548,7 +1548,7 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
-- 
2.20.1

