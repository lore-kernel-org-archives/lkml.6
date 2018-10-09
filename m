Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C1C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A9120835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cNxuHiI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A9120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJISjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:39:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36909 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJISgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id c22-v6so1325757edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbFCD2sUg6Y67iUc3t2m7N7icMrs0IJ4Cq4aNu8HyLE=;
        b=cNxuHiI9bLYl7otYsD4YcfBK6n5K1fCKCQySVrS/kya4iP1EtNqeIYJtC8wFO2eEDO
         rhPi3WYCmxbGPe+KNRuqk3AR4sLCTDpOtwzfv7JZweUfyD87NpyCPLJj+46TSsmaLPL8
         auoJd5rvhguzUhAqcLE2CQYYElGZXiola+nYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbFCD2sUg6Y67iUc3t2m7N7icMrs0IJ4Cq4aNu8HyLE=;
        b=jc2P06V15o43fHckGMvsFcpm1b55LTOZl9BJn5JKwDuaTVeAXRWYYUnnjEb1Pfm7TW
         K8c5Go8/+5gQLhBH/kWNMwXiwBLqjWlpFD4Ldn8Skn03hMIdQN1OJRvatriX360HCDjd
         McexgQpPUuS2h2C4Oydat+5OW/psOYQNtgiSr5ML4EjaZrB0cXUhwoMf2KRQwKeNZkzs
         3xdoi8Ek2xqmRS1NUJZb5W6wZXtzUbfwkWffHIpECYG/pNFbrOL3HMHFgicJfpCxUr9+
         +jxNv8UJsq7zyetILRTm4e/6L4+dayd9oXAGcY28jsB0FDO1OSn9WC1PsAExCPV8FGge
         92Ww==
X-Gm-Message-State: ABuFfogj0bYX2QF0SuUrqwr9UBXdL1pZJXy3N7kL5gTDcrhSMd3VruOa
        /q+K+ngCb6ynKUwuwHWsXIv6AQ==
X-Google-Smtp-Source: ACcGV63U0EHTkml604BqTJ1TUnZoSBISH9MiZN6aKKtIOlZmSKjXc1dgrlLM7H32IjtOqVk7fpuBCw==
X-Received: by 2002:a17:906:c446:: with SMTP id ck6-v6mr27327420ejb.215.1539084020837;
        Tue, 09 Oct 2018 04:20:20 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:20 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 01/23] linux/device.h: use DYNAMIC_DEBUG_BRANCH in dev_dbg_ratelimited
Date:   Tue,  9 Oct 2018 13:19:51 +0200
Message-Id: <20181009112013.14238-2-linux@rasmusvillemoes.dk>
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

dev_dbg_ratelimited tests the dynamic debug descriptor the old-fashioned
way, and doesn't utilize the static key/jump label implementation on
architectures that HAVE_JUMP_LABEL. Use the DYNAMIC_DEBUG_BRANCH which
is defined appropriately.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 8f882549edee..0d8ed2adfc73 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1503,7 +1503,7 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
-- 
2.19.1.3.g1d92a00e68

