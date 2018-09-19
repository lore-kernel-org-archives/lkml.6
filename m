Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E68C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A63221524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hv4u6BKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A63221524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbeITDo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46221 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeITDoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so6139927edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p9g4eJzimQ0/Ghn5ai01Ad1RrMdRuIdHVqAtK0/VBeY=;
        b=hv4u6BKj3TLvdfr8zHkljXTkq3IU34JHs//pEcoVqCxdLo+AF9lb77j2BtXv5sWDpq
         YiNqGHSUPLTITG3a3f1Dw8upMKBnmAqSFGxKEM/4HCBNH6T6otuH9YvUYqcpcJQvgn53
         EZ5hWpi4P6sj2a5XA3f30Rrchu0elD2Z3satg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p9g4eJzimQ0/Ghn5ai01Ad1RrMdRuIdHVqAtK0/VBeY=;
        b=pU+SBOUkJlPEuT9kXujF4PlBYtbE+BPTg457Jz0i37waahY7uYrYgE4ljseY9bRy+x
         9S1YUUcEz28cvCnjm5dXk4dk36icxCiHHy8iMX1aoho7Q/jam6PDxlecrLMHj7NoczmZ
         s7owLR8FivfOLaR6OzCKG0XuJVVloem4ksBfseJFSg+/dD4/hrG2y5HVq5rV9yyELGOL
         LekeUmNodv066gkximKM1ISA1zY814Mb++y7cd5+hhwUXJqV6zZ/QVeGDlc0bNh/YOaF
         2IND9qMpDfN62HpbShcxkmkv7mFA2nv8spAiNwThNGvx28FKxnp35URgj9lVjLMFgyrj
         K5XQ==
X-Gm-Message-State: APzg51C5XAbFtSBo1+Ib75CIRd1QC21bbicEYJayZe4GicEVM2Hmgc82
        mwioYngndhVmXYQQOLNnf5AvQw==
X-Google-Smtp-Source: ANB0VdZKzAm1EIjh0ZmNXTJmAZS3YafYS0tENjog8AdhVyZyJvMAXxhb03lxPp2n7JDVlHp4Z/2qAQ==
X-Received: by 2002:aa7:c584:: with SMTP id g4-v6mr14168630edq.124.1537394696600;
        Wed, 19 Sep 2018 15:04:56 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 05/22] linux/printk.h: use DYNAMIC_DEBUG_BRANCH in pr_debug_ratelimited
Date:   Thu, 20 Sep 2018 00:04:27 +0200
Message-Id: <20180919220444.23190-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_debug_ratelimited tests the dynamic debug descriptor the old-fashioned
way, and doesn't utilize the static key/jump label implementation on
architectures that HAVE_JUMP_LABEL. Use the DYNAMIC_DEBUG_BRANCH which
is defined appropriately.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/printk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccfe1543..d3ba3245531d 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -466,7 +466,7 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
-- 
2.16.4

