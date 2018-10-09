Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1349C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D8620835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YhPv/39w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D8620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJISjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:39:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37952 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJISgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so1319665ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvFODKJ3lJ+nmAkzDQXfTYLKbkSs6KigO50/DmHYVto=;
        b=YhPv/39whzmviX6k/6sNm1+Wa8Rq1sKG9jyF6PDjUcp4BuDVjMB5Ds7ONgMMvXDKFu
         flUkCOf394zBH6zox3VaeL7gi63mH1j7nLdeFy3ZBQ8fuLBk5nKOQUtn8JsyUDk1ZJ3+
         o7L7T/sfCdgY4wsjuGsrxz1dQul/NJAMlhWB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvFODKJ3lJ+nmAkzDQXfTYLKbkSs6KigO50/DmHYVto=;
        b=SE9eGuH0izDb4RlBd1EmmpnHgmImWki2kk+PbCRP1xj1qfzCeTYEWRp1jTOBSU3ure
         nAfXHHa65FrjPXT514xt6LXPRhYcN5JxV+sp3xw6+lcMzNmo67iTkhhNUv982CxIn/GF
         8rQRUyCXbN27p2aFdpg82rw8Mv2StKZO9IBt4eWlsrmg6waTBuZ++utvBcdwKQOQlcL8
         K7QeEgDGXQA/VR3YSVDXx7W7QKXxdeQstaUNldzqR3nfKjnIe/6hA24+goMhF9DunQn5
         OqrmeZSA9XgyTz0BjTYp1xuafAFHqR9WGwTpnE9aMI704tSv5ks5cqM3TqVIKVUwlELQ
         Vf2w==
X-Gm-Message-State: ABuFfogtD/ShkcyM/Xo+7dWSfFwO5++RIzUA1BANYHFN1MTjNmhiPmJM
        aq6h3IEoyoMzNWz3BVEQJZsrog==
X-Google-Smtp-Source: ACcGV61+4ZX6mIBGYA0dZ7Ic2YCde6/xvm4SxBiISnuZeIZa4wKJXtzi0/J9fx9evf2scCo5AUEXAw==
X-Received: by 2002:a50:d9ca:: with SMTP id x10-v6mr34391337edj.103.1539084024328;
        Tue, 09 Oct 2018 04:20:24 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:23 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v2 04/23] linux/net.h: use unique identifier for each struct _ddebug
Date:   Tue,  9 Oct 2018 13:19:54 +0200
Message-Id: <20181009112013.14238-5-linux@rasmusvillemoes.dk>
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
that for net_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Cc: netdev@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 651fca72286c..397243a25f56 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -260,7 +260,7 @@ do {								\
 #define net_info_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_info, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
-#define net_dbg_ratelimited(fmt, ...)					\
+#define _net_dbg_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
 	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
@@ -268,6 +268,8 @@ do {									\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
 		                   ##__VA_ARGS__);			\
 } while (0)
+#define net_dbg_ratelimited(fmt, ...)					\
+	_net_dbg_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define net_dbg_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
-- 
2.19.1.3.g1d92a00e68

