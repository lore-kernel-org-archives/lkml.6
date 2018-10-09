Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EDC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9591A20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VzvcHkfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9591A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJISg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:36:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46094 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeJISg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id g32-v6so1301182edg.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCRqEoXGmJJB0s9epSpdcb+zk52CuivvQj9Vs+LgLAk=;
        b=VzvcHkfPPzU4FoJ3am6Ft8P0U6a6sykjvvvX+6PAU69srJGdm7HrvEz5MmFAy1srDK
         4QSl4/L7eCYUWb+hE0atJfolOUIZzVZCQgi5rhYoVd9n6fqOQN65bS4p4GtTsnnXvLKI
         Ozg9erPtY35VNsBWsoRq/SB4LcZMbA4D7H/Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCRqEoXGmJJB0s9epSpdcb+zk52CuivvQj9Vs+LgLAk=;
        b=CJ/aoqA0m+hSPjSfoZ02kK8yytJSyqEYZCiIPSJJKTbFEtl344h52J6sSXszcrUjLn
         RLB9oTs4CJxhvgmmBIeOtHATaMPEwqdPlEeUIBMSZlSfbcZIxwiGD1fK358k+AFKwFql
         ENNwR1tokKvXuUfaheN2Au8pcdBNwcKNX0oJEGJUQnPqQjgTu5SFc5MS5V4B1e/1Kfju
         5E+dwi0y6eykkJmI2qaDz9pqxK0KUMnw5RsdwXzrSevWLh2lqIhr0EHJQcAfr/nFuXvL
         /x7yBi40ATKsGMJOkGhE/zkZSMxNWv8nCm2+UjR2isI+Fyfcjhcku/BPsULx0wetXbQt
         o0bA==
X-Gm-Message-State: ABuFfojDSbOzYDxBwPUDEg0DZ8PtX/bqvEvtbp6ovy970tz0k3pjK+PS
        d9OWshfGCgGcIz0uJbqhXoWTaA==
X-Google-Smtp-Source: ACcGV62UcuZlooM7GU+uQJ0j228aSniMozaODU+3oJhPaNehj97es1o74G8kwlPOGmel7FaY7jSNFg==
X-Received: by 2002:a50:cf0a:: with SMTP id c10-v6mr34371193edk.242.1539084026408;
        Tue, 09 Oct 2018 04:20:26 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:25 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 06/23] linux/printk.h: use unique identifier for each struct _ddebug
Date:   Tue,  9 Oct 2018 13:19:56 +0200
Message-Id: <20181009112013.14238-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for pr_debug_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/printk.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index d3ba3245531d..70df2c578d40 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -460,7 +460,7 @@ extern int kptr_restrict;
 /* If you are writing a driver, please use dev_dbg instead */
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define pr_debug_ratelimited(fmt, ...)					\
+#define _pr_debug_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -470,6 +470,8 @@ do {									\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
+#define pr_debug_ratelimited(fmt, ...)		\
+	_pr_debug_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define pr_debug_ratelimited(fmt, ...)					\
 	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-- 
2.19.1.3.g1d92a00e68

