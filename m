Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A16ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F525206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="K6YSSdux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F525206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeITDqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:46:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34035 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732893AbeITDow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so6188545eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8rvxkeg1oDAWlydjv//E8LWHw6C5aIOn5eLGuaD3b2s=;
        b=K6YSSduxlajtjwT2+FqRExRH7XJmfV9CcL+wIsLEvrtrAgkUO7OCEwgMyTF5Ej0g5u
         58M6GprpLDWDZbLc2XtoQ5RoJ3j89q0s6K3ps+aL2AXmwyXPAyV1EBzSQkocoeUoIHRe
         umiMQfqGQAU2RMOc3+iD3g1qV0z7UUDf8r2Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8rvxkeg1oDAWlydjv//E8LWHw6C5aIOn5eLGuaD3b2s=;
        b=X/r/J8o5jOns8hPvSICp4Cs851Mnv5bgF8ju3HunfDQOeBHIFwwa987WZSyPqUThv4
         Q8N16LQw92+HkX2prljj08hVj92S9x8hdJFTcIUhTP8Wo0u7YvvEFf5CiJHHI8PWpkRE
         yN2WTigFiN4D/YFBbHfhCkPzSfI7I0Q3KLAbg3Jj3cZJ0vQsnPvIYSukjIeEdRC+f/Jz
         J9L+C1F23YsjEbPKL9sMJJ5ZSg81GeywkBjhtmy8J1w+4A3Q0t9FolEPuS8m2EK8Ri16
         Xc0MvPciaNSph4hvqIAvXLPPzAs4Abcq4WMkINguFxKnoc5gHhPgPFPwDogSDNNgpxG9
         v/hg==
X-Gm-Message-State: APzg51A5nMUXpm4LPSqS48uKwG/yVFYCiF4TeXY5BDbyltA4EEDFGEUm
        35PNIc5HEeLGFjXlFy9BViizYQ==
X-Google-Smtp-Source: ANB0VdaVyJ9ZOCEnZ9RbQP/xZT8BNm8RPOC2sFjL8nkOW8D3+5S3lEQTzj95X6R1stIFzIL0vuhdqw==
X-Received: by 2002:a50:8f66:: with SMTP id 93-v6mr61772464edy.248.1537394694590;
        Wed, 19 Sep 2018 15:04:54 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:54 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH 03/22] linux/net.h: use DYNAMIC_DEBUG_BRANCH in net_dbg_ratelimited
Date:   Thu, 20 Sep 2018 00:04:25 +0200
Message-Id: <20180919220444.23190-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net_dbg_ratelimited tests the dynamic debug descriptor the old-fashioned
way, and doesn't utilize the static key/jump label implementation on
architectures that HAVE_JUMP_LABEL. Use the DYNAMIC_DEBUG_BRANCH which
is defined appropriately.

Cc: netdev@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index e0930678c8bf..651fca72286c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -263,7 +263,7 @@ do {								\
 #define net_dbg_ratelimited(fmt, ...)					\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    net_ratelimit())						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
 		                   ##__VA_ARGS__);			\
-- 
2.16.4

