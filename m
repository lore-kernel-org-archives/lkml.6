Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1956220657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="F0U0tdM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1956220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbeITDpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43210 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbeITDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so6147710edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=loKi0hAOYQYVnH7Ulfxh8ug7JOSCbDwsR/x9j4oPl+I=;
        b=F0U0tdM0S5F+Nh1PbRLVQ/g+0iusj2ziGCHzCNx+KgLbPX0nODSrdnvViVwy2Vqdn/
         GGo4AgVvfw/GdvvnRxGZSy07MCYfjUT+3XvlOp8cjF7ET6Sts+YV6mRnJxZ1IaodRaUy
         GcdZ5+et9OhMcoFalIOqJFhWytIABUjye+coE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=loKi0hAOYQYVnH7Ulfxh8ug7JOSCbDwsR/x9j4oPl+I=;
        b=YuR1lynpWM96Mu9jzU05LjSKn2AsUZWwLNQtPs4r9AUcfHzIuecopzSG9mjBvzA6qg
         hUAl1CfvRrVV4pYPBcQtor2rZqaq94qnbBw5Y6VlU5xLL//AsF8a+zwjawCDFv/s/jqf
         L0egJlVW5+0RD+Mo8KopUD9tYLeo5w7bL//XaxHBe9hZUdV4veAXkJsmZ2P9Wj7b7T1a
         6cL28IhCpdx3ZFKQKtdtzU8ymxvGI9fECY9WLRKWpzTKuakEERTS/3p5SiOAU5vT0RBJ
         3aTq9clb+9kcYR992EFUXwHgSQ4YDiiStGCi0UO6SgtDMw7J68fdgKUNSk0t8DJ6rd57
         JO6w==
X-Gm-Message-State: APzg51CK15KRf7AQzYcQbAM7cTKh96LWvxr9nIcMzf9NS+JZd7ki6Ns2
        2lNxMLbWFUDR/ScsEPRTKRUV1w==
X-Google-Smtp-Source: ANB0VdZK3nRtB9HhDVKPc793xgSrcRHH4Pt96Mc13AeLXldIQFG0GGFC1YU9yvfa0zyPsoPjRaWK7Q==
X-Received: by 2002:a50:92ce:: with SMTP id l14-v6mr61997732eda.43.1537394711689;
        Wed, 19 Sep 2018 15:05:11 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 15/22] ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
Date:   Thu, 20 Sep 2018 00:04:37 +0200
Message-Id: <20180919220444.23190-16-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dynamic debug may be implemented via static keys, but ACPI is missing
out on that runtime benefit since it open-codes one possible definition
of DYNAMIC_DEBUG_BRANCH.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index de8d3d3fa651..21e03aa32aae 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -982,7 +982,7 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #define acpi_handle_debug(handle, fmt, ...)				\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))				\
 		__acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),	\
 				##__VA_ARGS__);				\
 } while (0)
-- 
2.16.4

