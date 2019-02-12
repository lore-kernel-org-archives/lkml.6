Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD9D222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="W9CqhISl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfBLVmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35473 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfBLVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id b17so186566eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1ajbwFM2/cHMrtrC8SBFapOLKtmmpbqxTzxUukdDc0=;
        b=W9CqhISlgFAjnn8ydwLkvlcl4Pst0IwCsJ9yyo+RHykfgKUa+i2Q5yOfI3yLvYGuJZ
         0ko58RgH0degqe36QmCwDRlGs3GDyNKe0vz7Pstd9XAAu2B8gJrJe7krRf5eBMTOMLzX
         MOr2lrGX4gQUFcjmmtFo6OXw2Gfta7pzZMwtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1ajbwFM2/cHMrtrC8SBFapOLKtmmpbqxTzxUukdDc0=;
        b=Mr4NTWOcjqA0U6hTnRFiqeGb2kFss6f37bijXVi3Gbq5sXx7iygiBE5V88nPixKhju
         VLiAVtKRa2ZWyN10Y2cIbNZYZUeqfPbtVIFSpHREiD/ipBXjiKIP0HiENoYl8cCKzJsh
         ChH/irhmB7aZBcr9NL2qYjtZjQZcIDJ52+Sl8ErPzrWaOoTtkS0/tPr0ZkmUKSqKZYC/
         J9JJsbSLko+uP+vRvr2AGWMczBHmgvh3H8BlEHOZB0XsTNSoXitqRQbD6QdgZxgQYp1F
         YA0Lak6s3F/0QJTZ15l/du5fgy/bZ6s8sSW2s7WZ91RFZ8ECMt93bNSqdW5ig/uhcsrj
         PY6w==
X-Gm-Message-State: AHQUAubgP0S/OGdKuiZzhm2hsh4YgynGqq+uTcbESIj713EA099MTyCX
        2BkG3kNOEBIS+rxUG/ldmkjitQ==
X-Google-Smtp-Source: AHgI3IZXwk3m8/+8AvOn+Xj5xliy5TDN3X/TfvxQ/8H2I/fMtorH4BxY2t9FQqLUjGM/OXGf2QtsEA==
X-Received: by 2002:a50:d797:: with SMTP id w23mr4914465edi.19.1550007718433;
        Tue, 12 Feb 2019 13:41:58 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:41:57 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v4 02/14] linux/net.h: use DYNAMIC_DEBUG_BRANCH in net_dbg_ratelimited
Date:   Tue, 12 Feb 2019 22:41:38 +0100
Message-Id: <20190212214150.4807-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net_dbg_ratelimited tests the dynamic debug descriptor the
old-fashioned way, and doesn't utilize the static key/jump label
implementation when CONFIG_JUMP_LABEL is set. Use the
DYNAMIC_DEBUG_BRANCH which is defined appropriately.

Cc: netdev@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
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
2.20.1

