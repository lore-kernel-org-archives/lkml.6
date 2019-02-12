Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9979C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F61222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FJrvOxse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfBLVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:42:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33705 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbfBLVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:42:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id a2so194433edi.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VH7lSmBj6zeOlg5GhOX4P/7TI8UfRVVdfzmtOXm3XWY=;
        b=FJrvOxse2T818m4tUqvtjGdTmpsQLMT9V8SUqNFWPGdgo/sD6nbKNtRP9PLGQE+WpG
         iYj2sc4h+vFJiIcO7A5bmylqqdItzRdKbDv2+6qzXLUmwRGRxo8i1DclQQAg5NGUg7Pu
         KAwRJ2s/P9yfNVTo4wZ4Ffapnai8DFGxCCgZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VH7lSmBj6zeOlg5GhOX4P/7TI8UfRVVdfzmtOXm3XWY=;
        b=dXk7nthLSAnn//Kv39q8jnoBrsuf+b3ENcqr37P1oiyHDxJktoZROGccNfBRoL+oqp
         GDxdaNa9yK5Stzcmn7W52sNNKU5ikPSJ2YFwbr2K5/UELqNXthsyfFW2BdK5JexLh9tR
         xSDuXqpEuT4R6diBdTwXefOJR9+ZwAmshZwYoSctueVUCAcNma02893BE10jq+zeuVUQ
         5eaM2n7Yn5c5NPVdaicr2F+t8/F+kcfZXc2d9f98A5ZvRIHJBQLOUMO4okDYqb0VYEPI
         65IFOR7+30ip9zFvmYeGhIC+4kEVN1JATcf7HfgnE7fT/e2D1Tbynv79DcPZeO1bk9Ls
         kU5w==
X-Gm-Message-State: AHQUAuZPWaZtSCOY7UYVNtYMcqVlWjBRJauZgSp3pDAVZgF4i6Ywj/dn
        RZy5mvgo71HzTWoMInw7qFb+qA==
X-Google-Smtp-Source: AHgI3IbEEvf4DqmkWbgiJ2/gr0E2nefAVNbEv+3fymC1/TFyAmauPjzivTMeHmjtDT6gr1bLxENglw==
X-Received: by 2002:a17:906:1641:: with SMTP id n1mr3713793ejd.0.1550007719468;
        Tue, 12 Feb 2019 13:41:59 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id v1sm3697607eds.47.2019.02.12.13.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:41:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v4 03/14] linux/printk.h: use DYNAMIC_DEBUG_BRANCH in pr_debug_ratelimited
Date:   Tue, 12 Feb 2019 22:41:39 +0100
Message-Id: <20190212214150.4807-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_debug_ratelimited tests the dynamic debug descriptor the
old-fashioned way, and doesn't utilize the static key/jump label
implementation when CONFIG_JUMP_LABEL is set. Use the
DYNAMIC_DEBUG_BRANCH which is defined appropriately.

Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/printk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a506ebb..02b5c115d89b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -461,7 +461,7 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
-- 
2.20.1

